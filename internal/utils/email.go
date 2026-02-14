package utils

import (
	"net/smtp"
	"os"
)
func SendResetEmail(toEmail, resetLink string) error {

	from := os.Getenv("SMTP_EMAIL")
	password := os.Getenv("SMTP_PASSWORD")
	host := os.Getenv("SMTP_HOST")
	port := os.Getenv("SMTP_PORT")

	auth := smtp.PlainAuth("", from, password, host)

	message := []byte(
		"From: " + from + "\r\n" +
			"To: " + toEmail + "\r\n" +
			"Subject: Password Reset\r\n" +
			"\r\n" +
			"Click the link to reset your password:\r\n" +
			resetLink + "\r\n\r\n" +
			"This link expires in 15 minutes.\r\n",
	)

	return smtp.SendMail(
		host+":"+port,
		auth,
		from,
		[]string{toEmail},
		message,
	)
}
