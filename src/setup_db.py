import sqlite3
import pandas as pd
import numpy as np
from datetime import datetime, timedelta

def setup_intelligence_db():
    print("Initializing Database...")
    conn = sqlite3.connect('../data/customer_intelligence.db')
    cursor = conn.cursor()

    # Create tables
    cursor.execute('''
    CREATE TABLE IF NOT EXISTS orders (
        order_id INTEGER PRIMARY KEY,
        customer_id INTEGER,
        order_date TEXT,
        order_amount REAL,
        category TEXT
    )
    ''')

    # Generate dummy data
    print("Generating sample customer data...")
    np.random.seed(42)
    rows = 2000
    start_date = datetime(2023, 1, 1)
    
    data = []
    for i in range(rows):
        cust_id = np.random.randint(1, 150) # 150 unique customers
        days_offset = np.random.randint(0, 400)
        curr_date = (start_date + timedelta(days=days_offset)).strftime('%Y-%m-%d')
        amount = np.random.normal(250, 100)
        data.append((i, cust_id, curr_date, max(20, amount), 'General'))

    cursor.executemany('INSERT INTO orders VALUES (?,?,?,?,?)', data)
    conn.commit()
    print(f"Success! {rows} orders inserted.")

    # Show a sample result
    print("\nRunning Top Customers Query...")
    top_cust_query = """
    SELECT customer_id, SUM(order_amount) as spend 
    FROM orders GROUP BY 1 ORDER BY 2 DESC LIMIT 5
    """
    results = pd.read_sql_query(top_cust_query, conn)
    print(results)
    
    conn.close()

if __name__ == "__main__":
    import os
    os.makedirs('../data', exist_ok=True)
    setup_intelligence_db()
