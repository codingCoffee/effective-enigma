#!/usr/bin/python 

import sys, json

try:
	import requests
except:
	print ('Requests install kar be')
	sys.exit()

print ("Hello, Vishal! You lazy a*****e")

try:
   input = raw_input
except NameError:
   print ("Good you're using python 3. Python 2 was gonna get deprecated anyways")

price = input("Input the price you paid (in dollars) for the laptop, pendrive and ssd: ")
conversion_cost = input("Input the conversion rate (from dollar to rupees): ")
account_no = input("Input the account number you want the money to be transfered to: ")

print ('Ameya owes Vishal Rs.{}'.format(int(price)*int(conversion_cost)))
print ('Now copy paste the above 2 lines and send it to Ameya :)')
print ('Was the so f*****g difficult!?')
