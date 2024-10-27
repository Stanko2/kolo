import nodemailer from 'nodemailer';

// Define email sender and receiver
const emailSender = 'kolo.mailtest@gmail.com';
const emailPassword = 'xheb zmwk rkxv crml';
const emailReceiver = 'webnodesk3@gmail.com';

// Email subject and HTML body
const subject = 'Inovujte';
const body = `
<html>
  <body>
        Test <b>email</b> from <b>Node.js</b> using <b>Nodemailer</b>.
        <img src="https://picsum.photos/200" alt="Girl in a jacket">
  </body>
</html>
`;

async function sendEmail() {
    // Create a transporter using Gmail's SMTP server
    const transporter = nodemailer.createTransport({
        service: 'gmail',
        auth: {
            user: emailSender,
            pass: emailPassword,
        },
    });

    // Set up email options
    const mailOptions = {
        from: emailSender,
        to: emailReceiver,
        subject: subject,
        html: body,
    };

    try {
        // Send the email
        const info = await transporter.sendMail(mailOptions);
        console.log('Email sent:', info.messageId);
    } catch (error) {
        console.error('Error sending email:', error);
    }
}

// Execute the sendEmail function
sendEmail();
