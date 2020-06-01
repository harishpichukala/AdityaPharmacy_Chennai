import sys
import os
from flask import Flask
from flask_restful import reqparse, Api, Resource
import json
import pyodbc
# Initialize Flask
app = Flask(__name__)

# Setup Flask Restful framework
api = Api(app)
parser = reqparse.RequestParser()
parser.add_argument('customer')

conn = pyodbc.connect(driver='{SQL Server}', server='ADI', database='master',               
               trusted_connection='yes')
# Customer Class
class Customer(Resource):
    def get(self, customer_id):     
        customer = {"id": customer_id}
        cursor = conn.cursor()    
        cursor.execute("EXEC web.get_customer ?", json.dumps(customer))
        result = json.loads(cursor.fetchone()[0])        
        cursor.close()
        return result, 200

#Customers Class
class CustomerResult(Resource):
    def get(self):
        cursor = conn.cursor()    
        cursor.execute("EXEC web.get_customers")
        result = json.loads(cursor.fetchone()[0])        
        cursor.close()
        return result, 200
    
# Create API route to defined Customer class
api.add_resource(Customer, '/customer', '/customer/<customer_id>')
api.add_resource(CustomerResult, '/CustomerResult')
# Start App
if __name__ == '__main__':
    app.run()
