# Design Document

Breadcrumbs by Mihir Girishbhai Gajjar

Video overview: [Click Here](https://youtu.be/_xROidsfBJU)


## Scope

### What is the purpose of your database?

The purpose of Breadcrumbs is to serve as a maps application for food and drink establishments, similar to Google Maps. A key feature of the app is its ability to show how busy a place is in near real-time, much like Google Maps' "Popular Times." While Google Maps uses searches made from a location to estimate how busy a place is, this method breaks down when there are restrictions on the number of people inside a venue (e.g., during COVID-19). Breadcrumbs instead uses transaction data from the establishment's till to measure busyness.

### Which people, places, things, etc. are you including in the scope of your database?

The database focuses on food and drink establishments as users. It collects and processes data from these establishments to fulfill its primary function.

### Which people, places, things, etc. are *outside* the scope of your database?
  
While a full-scale app would include both businesses and customers as users, this project only includes businesses. Incorporating customer functionality would require a much more complex database design, so the focus remains on solving the "Popular Times" feature for businesses alone.

## Functional Requirements

### What should a user be able to do with your database?

Users (businesses) should be able to view how busy their venue is in near real-time based on transactional data. A simple Python program demonstrates this functionality.

### What's beyond the scope of what a user should be able to do with your database?

This version does not support user interactions such as leaving reviews or uploading photos, as the current focus is on showcasing the "Popular Times" feature using transactional data.

## Representation

### Entities

### Which entities are represented in your database, why?

Users: Includes id (primary key), name (not null), username (not null + unique), and password (not null). Since this table stores login information, the username must be unique and not null.

Categories: Contains id and category. Categories are limited to 'Restaurant,' 'Cafe,' or 'Bar' to fit the database's focus on food and drink venues.

Type: Links categories to the users table.

Locations: Contains user_id (foreign key), door_no, address_line, level, postcode, lat (not null), and long (not null). Since the app relies on maps, latitude and longitude are essential. Ideally, these would be stored as a POINT data type (lat, long) in MySQL, but for simplicity, they are kept as separate attributes.

Transactions: Stores user_id (foreign key), transaction_id (primary key), day, date, and time. This table records transaction data to track busyness by day of the week and time of day.

Info: Holds additional business details like contact_no and email.

### Relationships

![Breadcrumbs Entity Relationship Diagram](https://github.com/code50/119708204/blob/main/03cs50sql/project/Breadcrumbs%20ER%20Diagram.png)

## Optimizations

### Which optimizations (e.g., indexes, views) did you create? Why?

Two views were created to streamline the user experience:

Profile View: Displays basic information about a business, such as name, category, address, and contact details. This view consolidates data from multiple tables that a customer would see when searching for a place on the app.

Traffic View: The core of the "Popular Times" feature, this view averages transaction data by day of the week and hour of the day. When a user searches for a business, the system compares the current number of transactions with the average from the previous hour on the same day. For example, if it’s 11 a.m. on a Monday, the system will compare transactions at 10 a.m. with the average for that time.

## Limitations

### What are the limitations of your design?

Limited User Base: The current design only accommodates businesses, while a full-fledged app would require functionality for customers as well. Expanding the database to include customer interactions (e.g., reviews, photos) would significantly increase its complexity.

Limited Business Features: Businesses using this app might also expect additional features like inventory management, employee shifts, and profit tracking. These functionalities are excluded for simplicity.

Timing Precision: The "Popular Times" feature uses hourly transaction data, meaning the app can only estimate how busy a place was during the previous hour. For more precise data, the system could reduce the time intervals (e.g., to 30 or 5 minutes), but this would result in much larger tables. An hourly split strikes a balance between table size and accuracy.
