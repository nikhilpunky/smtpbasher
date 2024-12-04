#!/bin/bash

# Prompt user for inputs
read -p "Enter email ID (From): " email_id
read -sp "Enter password: " password
echo
read -p "Enter hostname: " hostname
read -p "Enter recipient email ID (To): " recipient_email

# Define the PHP code template
php_code_template="<?php
require_once ('Mail.php');

\$from = '$email_id'; //change this to your email address
\$to = '$recipient_email'; // change to address
\$subject = 'Checking mail with SMTP PHP'; // subject of mail
\$body = \"Hello your mail function is working fine\"; //content of mail

\$headers = array(
'From' => \$from,
'To' => \$to,
'Subject' => \$subject
);

\$smtp = Mail::factory('smtp', array(
'host' => '$hostname',
'port' => '587',
#'auth' => true,
'username' => '$email_id', //your email account
'password' => '$password' // your password
));

// Send the mail
\$mail = \$smtp->send(\$to, \$headers, \$body);

//check mail sent or not
if (PEAR::isError(\$mail)) {
    echo '<p>'.\$mail->getMessage().'</p>';
} else {
    echo '<p>Message successfully sent!</p>';
}
?>"

# Write the modified PHP code to a file
output_file="smtpmail.php"
echo "$php_code_template" > "$output_file"

echo "PHP script has been generated and saved to $output_file"

# Execute the PHP script
echo "Executing $output_file..."
php "$output_file"
