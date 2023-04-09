import datetime

today = datetime.date.today()
future = datetime.date(2031,4,4)
diff = future - today
print (f"Days remaining: {diff.days}")
