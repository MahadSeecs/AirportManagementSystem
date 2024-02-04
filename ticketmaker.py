#pip install fpdf
# pip install qrcode[pil]
#pip install opencv-python


import qrcode
from PIL import Image
from fpdf import FPDF

#Ticket Info
pdf_airline = "Emirates"
pdf_ticketnumber = "3551"
pdf_flightID = "113445"
pdf_passport_numb = "3213434"
pdf_username = "Aniqa Tufail"
pdf_class = "Buisness Class"
pdf_seatNumber = "5"
pdf_departure = "RWP"
pdf_arrival = "MUX"
pdf_name = pdf_ticketnumber +"-"+ pdf_username + ".pdf"

#Making Data Variable for QRcode
data = "Airline: " + pdf_airline + "\n"
data = data + "Ticket Number: " + pdf_ticketnumber + "\n"
data = data + "Flight ID: " + pdf_flightID + "\n"
data = data + "Name: " + pdf_username + "\n"
data = data + "Passport Number: " + pdf_passport_numb + "\n"
data = data + "Seat Number: " + pdf_seatNumber + "\n"
data = data + "Flight ID: " + pdf_flightID + "\n"
data = data + "From: " + pdf_departure + "\n"
data = data + "To: " + pdf_arrival + "\n"


#Make QrCode
qr = qrcode.QRCode(
    version=1,
    error_correction=qrcode.constants.ERROR_CORRECT_H,
    box_size=10,
    border=4,
)
qr.add_data(data)
qr.make(fit=True)
img = qr.make_image(fill_color="black", back_color="white").convert('RGB')

img.save("QRcode.png")

#PDF
pdf_w=210
pdf_h=297

#Load MainBackGroundImage
pic = "ticket-bg.png"

#PDF MAKER
pdf = FPDF(orientation='L')
pdf.add_page()
pdf.image("ticket-bg.png",0,0,w = 297)
pdf.image("QRcode.png",190,60, w = 80)
##pdf.set_line_width(1.0)
##pdf.rect(5,5,287,200)
pdf.set_font("Courier",size = 45)
pdf.text(30, 32,txt = pdf_airline)
pdf.set_font("Courier",size = 20)
pdf.text(30,60,txt = "Ticket Number: " + pdf_ticketnumber)
pdf.text(30,75,txt = "Flight ID: " + pdf_flightID)
pdf.text(30,90,txt = "Name: " + pdf_username)
pdf.text(30,105,txt = "Passport Number: " + pdf_passport_numb)
pdf.text(30,120,txt = "Class: " + pdf_class)
pdf.text(30,135,txt = "Seat Number: " + pdf_seatNumber)
pdf.text(30,150,txt = "From: " + pdf_departure)
pdf.text(30,165,txt = "To: " + pdf_arrival)


pdf.output(pdf_name,'F')
