#!/bin/bash

##Script to setuo both Web and App server

##Color Code
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
BU="\e[1;4m"
App_user=student
App_home=/home/$App_user
Tomcat_version=$(curl -s "https://archive.apache.org/dist/tomcat/tomcat-8/?C=M;O=A" | tail -4 | grep 8.5 | awk '{print $5}' | awk -F '"' '{print $2}' | sed -e 's/v//' -e 's/\///')
Tomcat_URL="https://archive.apache.org/dist/tomcat/tomcat-8/v$Tomcat_version/bin/apache-tomcat-$Tomcat_version.tar.gz)"
    
Tomcat_DIR=$App_home/apache-tomcat-${Tomcat_version}


LOG=/tmp/stack.log
rm -f /tmp/stack.log

Error() {
    echo -e "\n${R}$1${N}\n"
}

Head() {
    echo -e "\n\t\t>>>>${Y}${BU}$1${N}<<<<\n"
            
}

Print() {
    echo -n -e "\n\t$1\t -- "
}

Stat() {
    if [ $? -eq 0 ]; then
        echo -e "${G}SUCCESS${N}"
    else
        echo -e "${R}FAILURE${N}"
        echo -e "Refer the log file for more details -- $LOG"
        exit 1
    fi
}
##Check for root user
USER_ID=$(id -u)
if [ $USER_ID -ne 0 ]; then
    Error "You should be root or sudo user to execute this command"
    exit 2
fi

#Web server setup
Head "Web-Sever Setup"
Print "Install HTTPD server"

yum install httpd -y &>>$LOG
Stat $?

Print "Setup Proxy Config"
echo 'ProxyPass "/student" "http://APP-SERVER-IPADDRESS:8080/student"
ProxyPassReverse "/student"  "http://APP-SERVER-IPADDRESS:8080/student"
' >/etc/httpd/conf.d/app-proxy.conf
Stat $?

Print "Setup Default Index Page"
curl -s https://s3-us-west-2.amazonaws.com/studentapi-cit/index.html -o /var/www/html/index.html &>>$LOG
Stat $?

Print "Start HTTPD WebServer"
systemctl enable httpd &>>$LOG
systemctl restart httpd &>>$LOG
Stat $?

Head "App-Server Setup"

Print "Install Java"
yum install java -y &>>$LOG
Stat $?

Print "Creating User"
id $App_user &>>LOG
if [ $? == 0 ]; then
    Stat 0
else
    useradd $App_user &>>LOG
    Stat $?
fi

cd $App_home
Print "Download tomcat service"
wget -qO- $Tomcat_URL &>>$LOG
tar -xf apache-tomcat-$Tomcat_version.tar.gz
Stat $?

cd $Tomcat_DIR
Print "Download Student Admission application"
wget https://s3-us-west-2.amazonaws.com/studentapi-cit/student.war -O webapps/student.war &>>$LOG
Stat $?

cd $Tomcat_DIR
Print "Downloading JDBC driver of DB"
wget https://s3-us-west-2.amazonaws.com/studentapi-cit/mysql-connector.jar -O lib/mysql-connector.jar &>>$LOG
Stat $?

Print "Fix Permissions\t"
chown $App_user:$App_user $Tomcat_DIR -R &>>$LOG
Stat $?




