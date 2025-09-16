# UltraEcommerce 🛍️🍁
UltraEcommerce is a PL/SQL system engineered for seamless order fulfillment. It unifies customers, orders, payments, and shipments in a structured schema, validates payments through dedicated logic, and generates shipment tracking numbers with precision. Automatic triggers keep order status aligned with every successful transaction.

---

## Features

* **Relational schema** with four entities: `Customers`, `Orders`, `Payments`, and `Shipments`.
* **PL/SQL package** containing:

  * `Validate_Payment` function to confirm payments and update status.
  * `Generate_Shipment` procedure to create tracking numbers and mark shipments.
* **Trigger** that updates an order’s status to *PAID* when payment succeeds.
* **Sample dataset** of customers, orders, and payments.
* **End-to-end test script** covering payment validation, order update, and shipment creation.

---

## Project Structure

```
UltraEcommerce/
├── sql/
│   ├── tables.sql        # Schema definitions
│   ├── package.sql       # Package with function and procedure
│   ├── triggers.sql      # Automatic order status update
│   ├── seed.sql          # Sample data
│   └── test.sql          # End-to-end validation
├── LICENSE               # MIT License
└── README.md             # Project documentation
```

---

## Quick Start

### 1. Create Schema

Run the schema definition script in [Oracle Live SQL](https://livesql.oracle.com/) or an Oracle XE instance:

```sql
@sql/tables.sql
```

### 2. Load Package and Triggers

```sql
@sql/package.sql
@sql/triggers.sql
```

### 3. Insert Sample Data

```sql
@sql/seed.sql
```

### 4. Execute Tests

Run the validation workflow:

```sql
@sql/test.sql
```

---

## Example Output

```
Payment validation result for order 1001: SUCCESS
Shipment generated for order 1001
Invalid payment test: FAILED: Order not found
```

---

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

## Author
Created by Rico Aprilla Nanda


