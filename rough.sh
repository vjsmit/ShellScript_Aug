#!/bin/bash 

## Script to setup web and app components 
LOG=/tmp/stack.log 
rm -f /tmp/stack.log 
APPUSER=student
APPHOME=/home/$APPUSER
## Fetch the latest available version 
TOMCAT_VERSION=$(curl -s 'https://archive.apache.org/dist/tomcat/tomcat-9/?C=M;O=A' | grep 9.0 | tail -1 | awk '{print $5}' | a   -F '"' '{print $2}' | sed -e 's/v//' -e 's/\///')
TOMCAT_URL="https://archive.apache.org/dist/tomcat/tomcat-8/v$TOMCAT_VERSION/bin/apache-tomcat-$TOMCAT_VERSION.tar.gz"
TOMCAT_DIR=$APPHOME/apache-tomcat-$TOMCAT_VERSION

## COLOR CODES 
R="\e[31m"
G="\e[32m"
B="\e[34m"
Y="\e[33m"
C="\e[36m"
N="\e[0m"
BU="\e[1;4m"

### Functions 

## Error function 
Error() {
    echo -e "\n${R}$1${N}\n"
}

## Heading function \
Head() {
    echo -e "\n\t\t>>>${C}${BU}$1${N}<<<\n"
}

## Print function for task heading print 
Print () {
    echo -n -e "    $1 \t -- "
}

## Status of command executed 
Stat() {
    if [ $1 -eq 0 ]; then 
        echo -e "${G}SUCCESS${N}"
    else
        echo -e "${R}FAILURE${N}"
        echo -e " Refer the log file for more details -- File Path = $LOG"
        exit 1
    fi 
}


## Check root user or not 
USER_ID=$(id -u)
if [ $USER_ID -ne 0 ]; then 
    #Error "🙀 You Should be root user or sudo user to execute this command"
    Error "✘ You Should be root user or sudo user to execute this command"
    exit 2
fi


### Web Server Installation & Configuration 

Head "WEBSERVER SETUP"

Print "Install HTTPD Server\t"
yum install httpd -y &>>$LOG 
Stat $?

Print "Setup Reverse Proxy Config\t"
echo 'ProxyPass "/student" "http://localhost:8080/student"
ProxyPassReverse "/student"  "http://localhost:8080/student"
' >/etc/httpd/conf.d/app-proxy.conf
Stat $?

Print "Setup Default Index Page\t"
curl -s https://s3-us-west-2.amazonaws.com/studentapi-cit/index.html -o /var/www/html/index.html &>>$LOG 
Stat $? 

Print "Start HTTPD Web Server\t"
systemctl enable httpd  &>>$LOG 
systemctl start httpd   &>>$LOG 
Stat $?


### App Server Installation & Configuration 
Head "APPSERVER SETUP"

Print "Install JAVA\t\t"
yum install java -y &>>$LOG 
Stat $? 

Print "Creating App User\t\t"
id $APPUSER &>>$LOG 
if [ $? -eq 0 ]; then 
    Stat 0
else 
    useradd $APPUSER &>>$LOG 
    Stat $?
fi

cd $APPHOME 
Print "Download Tomcat Service\t"
wget -qO- $TOMCAT_URL
tar -xf $TOMCAT_VERSION.tar.gz
Stat $? 

cd $TOMCAT_DIR
Print "Download Student Application"
wget https://s3-us-west-2.amazonaws.com/studentapi-cit/student.war -O webapps/student.war &>>$LOG 
Stat $? 

cd $TOMCAT_DIR
Print "Download MySQL JDBC Driver\t"
wget https://s3-us-west-2.amazonaws.com/studentapi-cit/mysql-connector.jar -O lib/mysql-connector.jar &>>$LOG 
Stat $? 

Print "Fix Permissions\t\t"
chown $APPUSER:$APPUSER $TOMCAT_DIR -R &>>$LOG 
Stat $?