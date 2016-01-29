#!/usr/bin/python

import smtplib
import os
import sys
from email.MIMEMultipart import MIMEMultipart
from email.MIMEBase import MIMEBase
from email.MIMEText import MIMEText
from email.Utils import COMMASPACE, formatdate
from email import Encoders

result = sys.argv[1]
file   = sys.argv[2]

send_from="nemesis@nemesis-linux.garant.ru"

send_to = []
send_to.append ("nemesis@garant.ru")

subject = result
text    = "see attached file for details."
server  = "smtp.garant.ru"

files = []
files.append (file)




def send_mail(send_from, send_to, subject, text, files=[], server="localhost"):
  assert type(send_to)==list
  assert type(files)==list

  msg = MIMEMultipart()
  msg['From'] = send_from
  msg['To'] = COMMASPACE.join(send_to)
  msg['Date'] = formatdate(localtime=True)
  msg['Subject'] = subject

  msg.attach( MIMEText(text) )

  for f in files:
    part = MIMEBase ('application', "octet-stream")
    part.set_payload (open(f,"rb").read())
    Encoders.encode_base64(part)
    part.add_header ('Content-Disposition', 'attachment; filename="%s"' % os.path.basename(f))
    msg.attach (part)

  smtp = smtplib.SMTP (server)
  smtp.sendmail (send_from, send_to, msg.as_string())
  smtp.close ()


send_mail (send_from, send_to, subject, text, files, server)

