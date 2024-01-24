#!/bin/bash
sudo su
apt update -y
apt install nginx -y
apt install awscli -y

aws s3 cp s3://shradha-agarwal-terraform-project/hello.jpg /var/www/html/hello.jpg

chmod +x /var/www/html/hello.jpg

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
  <p>Hello from EC2 - 1</p>
  <img src="/hello.jpg" alt="Hello Image">
</body>
</html>
EOF

systemctl start nginx
systemctl enable nginx