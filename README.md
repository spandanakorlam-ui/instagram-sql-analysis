# instagram-sql-analysis
SQL analysis project using Instagram-like database (users, photos, likes, comments, tags)

# 📊 Instagram SQL Data Analysis Project

## 📌 Overview
This project simulates an Instagram-like database and performs SQL analysis to extract meaningful business insights.

The database includes users, photos, likes, comments, and tags, allowing analysis of user engagement and content performance.

---

## 🛠️ Tech Stack
- Microsoft SQL Server
- SQL (T-SQL)

---

## 🗂️ Project Structure

instagram-sql-analysis/
│
├── schema/        # Database creation scripts
├── data/          # Data insertion scripts
├── queries/       # Business analysis queries

---

## 🧱 Database Schema
The project consists of the following tables:
- Users
- Photos
- Likes
- Comments
- Follows
- Tags
- Photo_Tags

---

## 📊 Key Analysis Performed

- Identify oldest users on the platform  
- Find most active users  
- Detect inactive users (no posts)  
- Determine most liked photos  
- Analyze trending hashtags  
- Calculate average user activity  
- Detect bot-like users (liked all photos)  
- Analyze user engagement patterns  

---

## 🔍 Sample Query

SELECT TOP 5 * 
FROM users 
ORDER BY created_at;

---

## 📈 Key Insights

- Identified high-engagement users and content  
- Found inactive users for re-engagement campaigns  
- Detected suspicious user behavior (bots)  
- Analyzed popular hashtags for marketing  

---

## 🎯 Outcome

This project demonstrates:
- SQL joins and aggregations  
- Subqueries and filtering  
- Real-world business problem solving  
- Data analysis using SQL  

---

## 🚀 How to Run

1. Run schema scripts to create tables  
2. Insert data using data scripts  
3. Execute queries in the queries folder  

---

## 📬 Author
Spandana Korlam
