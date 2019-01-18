#!/usr/bin/python
import pyrqlite.dbapi2 as dbapi2

# Connect to the database
connection = dbapi2.connect(
    host='127.0.20.1',
    port=8080,
)

try:
    with connection.cursor() as cursor:
        cursor.execute('CREATE TABLE IF NOT EXISTS foo(id integer not null primary key, name text)')
        cursor.executemany('INSERT INTO foo(name) VALUES(?)', seq_of_parameters=(('a',), ('b',)))

    with connection.cursor() as cursor:
        # Read a single record with qmark parameter style
        sql = "SELECT `id`, `name` FROM `foo` WHERE `name`=?"
        cursor.execute(sql, ('a',))
        result = cursor.fetchone()
        print(result)
        # Read a single record with named parameter style
        sql = "SELECT `id`, `name` FROM `foo` WHERE `name`=:name"
        cursor.execute(sql, {'name': 'b'})
        result = cursor.fetchone()
        print(result)
finally:
    connection.close()
