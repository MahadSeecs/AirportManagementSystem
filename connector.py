import mysql.connector
connection = mysql.connector.connect(host = "localhost", database = "university", password = "drone", user = "root")
cursor = connection.cursor()
cursor.execute("select sname from student where snum in (select snum from enrolled where cname in (select cname from class where fid = (select fid from faculty where fname = 'Ivana Teach')))")

result = cursor.fetchall()

for x in result:
    print(x[0])
