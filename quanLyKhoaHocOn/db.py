import mysql.connector


def connect_db():
    try:
        conn = mysql.connector.connect(
            host="localhost",
            user="root",
            password="",   # nếu có mật khẩu thì nhập
            database="dataqlykhoahoc"
        )

        print("Kết nối database thành công!")
        return conn

    except mysql.connector.Error as e:
        print("Lỗi kết nối:", e)
        return None


if __name__ == "__main__":
    conn = connect_db()

    if conn:
        cursor = conn.cursor()

        cursor.execute("SELECT DATABASE()")
        print("Database:", cursor.fetchone())

        cursor.execute("SHOW TABLES")
        print("Tables:")
        for table in cursor.fetchall():
            print(table)

        cursor.close()
        conn.close()
        print("Đã đóng kết nối")