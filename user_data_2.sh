#!/bin/bash
sudo su
apt update -y
apt install nginx -y
apt install awscli -y

aws s3 cp s3://shradha-agarwal-terraform-project/welcome.jpg /var/www/html/welcome.jpg

chmod +x /var/www/html/welcome.jpg

cat <<EOF > /var/www/html/index.nginx-debian.html
<!DOCTYPE html>
<html>
<head>
  <title>My Website</title>
  <style>
    body {
      background-color: red;
    }
  </style>
</head>
<body>
  <h1>Welcome to My  Website!</h1>
  <p>Welcome to EC2 - 2</p>
  <img src="/welcome.jpg" alt="Welcome Image">
</body>
</html>
EOF

systemctl start nginx
systemctl enable nginx