#!/usr/bin/env python
# coding: utf-8

# In[1]:


import mysql.connector


# In[ ]:


# If you need to change to the data, you must write connection.commit() to submit the action.


# In[2]:


connection = mysql.connector.connect(host = "localhost",
                                    port = "3306",
                                    user= "root", 
                                    password = "...",
                                    database = "sql_1")


# In[3]:


cursor = connection.cursor()


# In[4]:


# add
cursor.execute("INSERT INTO `branch` VALUES(5,'HR', NULL)")
connection.commit()


# In[8]:


# revise
cursor.execute("UPDATE `branch` SET `manager_id` = 206 WHERE `branch_id`= 4;")
connection.commit()


# In[13]:


# delete
cursor.execute("DELETE FROM `branch` WHERE `branch_id` = 5;")
connection.commit()


# In[15]:


# close
cursor.close()
connection.commit()
connection.close()

