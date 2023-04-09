import datetime
from dateutil import relativedelta

today = datetime.date.today()
breach = datetime.date(2022,10,8)
diff = relativedelta.relativedelta(today, breach)

print (f"Days from breach: {diff.days}\nMonths from breach: {diff.months}\nYears from breach: {diff.years}")