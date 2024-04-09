import psycopg2
import os
#config file
from config import config

def connect():
    connection = None
    try:
        print('Connecting to the database...')
        connection = psycopg2.connect(
            host="localhost",
            database="moviesearch",
            user="postgres",
            password="Harley69?!" #edit to match your password
        )
        print("Connected")

        #create a cursor
        cur = connection.cursor()
        print('PostgreSQL database version: ')
        cur.execute('SELECT version()')
        db_version = cur.fetchone()
        print(db_version)

        sql_files = ['create.sql', 'populate.sql']

        for filename in sql_files:
            with open(filename, 'r') as databasefile:
                commands = databasefile.read().split(';')

                for command in commands:
                    try:
                        if not command.strip() or command.strip().startswith('--'):
                            continue
                        cur.execute(command)
                    except Exception as E:
                        print("Error executing command: ", command)
                        print("Error message: ", E)
                        connection.rollback()
                        break

                connection.commit()

                # cur.close()
                # connection.close()
    except(Exception, psycopg2.DatabaseError) as dberror:
        print(dberror)
    finally:
        if cur is not None:
            cur.close()

        if connection is not None:
            connection.close()
            print('Database connection terminated')

if __name__ == "__main__":
    connect()