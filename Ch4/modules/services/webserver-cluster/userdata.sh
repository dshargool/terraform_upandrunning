#!bin/bash
yum -y update
yum -y install httpd
systemctl enable httpd
systemctl start httpd
echo '<h1>Hello world!</h1>' > /var/www/html/index.html 
echo '<p>DB address: ${db_address}</p>' >> /var/www/html/index.html
echo '<p>DB port: ${db_port}</p>' >> /var/www/html/index.html
