import json, gspread,sys
from oauth2client.service_account import ServiceAccountCredentials

args = sys.argv[1:]
print(args)

def log():
    scope = ['https://spreadsheets.google.com/feeds','https://www.googleapis.com/auth/drive']
    creds = ServiceAccountCredentials.from_json_keyfile_name('creds.json', scope)
    client = gspread.authorize(creds)
    sheet = client.open('test log sheet').sheet1
    i = 2
    row = sheet.row_values(i)
    while (row):
        i += 1
        row = sheet.row_values(i)
    sheet.insert_row(args, i)
log()

