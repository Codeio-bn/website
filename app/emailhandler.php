<?php

//Initial response is NULL
$response = null;

$name = $_POST["name"];
$email = $_POST["email"];
$subject = $_POST["subject"];
$message = $_POST["message"];


SendEmail($message, $subject, $email, 'info@codeio.nl');


function SendEmail($message, $subject, $from, $to) {
    $headers = 'MIME-Version: 1.0' . "\r\n";
    $headers .= 'Content-type: text/html; charset=iso-8859-1' . "\r\n";
    // Additional headers
    // $headers .= 'To: ' . $to . "\r\n";
    $headers .= 'From: ' . $from . "\r\n";

    mail($to, $subject, $message, $headers);
    header('Location: ../#contact');
} 


// $to = 'jelle@codeio.nl';
// $subject = "Beautiful HTML Email using PHP by semicolonworld";

// $htmlContent = '
//     <html>
//     <head>
//         <title>Welcome to semicolonworld</title>
//     </head>
//     <body>
//         <h1>Thanks you for joining with us!</h1>
//         <table cellspacing="0" style="border: 2px dashed #FB4314; width: 300px; height: 200px;">
//             <tr>
//                 <th>Name:</th><td>semicolonworld</td>
//             </tr>
//             <tr style="background-color: #e0e0e0;">
//                 <th>Email:</th><td>contact@semicolonworld.com</td>
//             </tr>
//             <tr>
//                 <th>Website:</th><td><a href="http://www.semicolonworld.com">www.semicolonworld.com</a></td>
//             </tr>
//         </table>
//         <img src="https://codeio.nl/img/Logo-transparent.png">
//     </body>
//     </html>';

// // Set content-type header for sending HTML email
// $headers = "MIME-Version: 1.0" . "\r\n";
// $headers .= "Content-type:text/html;charset=UTF-8" . "\r\n";

// // Additional headers
// $headers .= 'From: semicolonworld<sender@example.com>' . "\r\n";
// $headers .= 'Cc: welcome@example.com' . "\r\n";
// $headers .= 'Bcc: welcome2@example.com' . "\r\n";

// // Send email
// if(mail($to,$subject,$htmlContent,$headers)):
//     $successMsg = 'Email has sent successfully.';
// else:
//     $errorMsg = 'Email sending fail.';
// endif;