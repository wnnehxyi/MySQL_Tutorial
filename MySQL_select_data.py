#!/usr/bin/env python
# coding: utf-8

# In[1]:


import mysql.connector


# In[2]:


# directly use the database 
connection = mysql.connector.connect(host = "localhost",
                                    port = "3306",
                                    user= "root", 
                                    password = "...",
                                    database = "sql_1")


# In[3]:


cursor = connection.cursor()


# In[4]:


# get all the information of the `branch` table
cursor.execute("SELECT * FROM `branch`;")

records = cursor.fetchall()  

for i in records:
    print(i)


# In[5]:


# 記得cursor和connection要關閉
cursor.close()
connection.close()

