from flask import Flask, request, jsonify
import mysql.connector
from datetime import datetime

app = Flask(__name__)

def get_db_connection():
    return mysql.connector.connect(
        host="localhost",
        user="root",          # CHANGE THIS to your MySQL user
        password="",          # CHANGE THIS to your MySQL password
        database="social_media_app"
    )

@app.route('/api/login', methods=['POST'])
def login():
    data = request.json
    email = data.get('email')
    password = data.get('password')

    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    # Check user credentials
    cursor.execute("SELECT * FROM users WHERE email = %s AND password = %s", (email, password))
    user = cursor.fetchone()

    if user:
        # Update last_login
        now = datetime.now()
        cursor.execute("UPDATE users SET last_login = %s WHERE id = %s", (now, user['id']))
        conn.commit()
        
        cursor.close()
        conn.close()
        return jsonify({"status": "success", "message": "Login successful", "user": user['name']}), 200
    else:
        cursor.close()
        conn.close()
        return jsonify({"status": "error", "message": "Invalid credentials"}), 401
    
@app.route('/api/register', methods=['POST'])
def register():
    data = request.json
    name = data.get('name')
    email = data.get('email')
    password = data.get('password')

    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    # 1. Cek apakah email sudah terdaftar sebelumnya?
    cursor.execute("SELECT * FROM users WHERE email = %s", (email,))
    existing_user = cursor.fetchone()

    if existing_user:
        cursor.close()
        conn.close()
        return jsonify({"status": "error", "message": "Email already registered!"}), 400

    # 2. Jika belum ada, masukkan data baru ke database
    try:
        insert_query = "INSERT INTO users (name, email, password) VALUES (%s, %s, %s)"
        cursor.execute(insert_query, (name, email, password))
        conn.commit()
        
        cursor.close()
        conn.close()
        return jsonify({"status": "success", "message": "Registration successful!"}), 201
    except Exception as e:
        return jsonify({"status": "error", "message": str(e)}), 500

if __name__ == '__main__':
    # host='0.0.0.0' makes the server accessible to other devices on the network
    app.run(host='0.0.0.0', port=5000, debug=True)