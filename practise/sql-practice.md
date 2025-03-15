# hospital.db
## Easy

### Example 1
Show first name, last name, and gender of patients whose gender is 'M'
```sql
SELECT
  first_name,
  last_name,
  gender
FROM patients
where gender = "M";
```

### Example 2
Show first name and last name of patients who does not have allergies. (null)
```sql
SELECT
  first_name,
  last_name
FROM patients
where allergies IS null;
```


### Example 3
Show first name of patients that start with the letter 'C'
```sql
SELECT first_name
FROM patients
where first_name LIKE 'C%';
```

### Example 4
Show first name and last name of patients that weight within the range of 100 to 120 (inclusive)
```sql
SELECT
  first_name,
  last_name
from patients
where weight >= 100 AND weight <= 120;
```

### Example 5
Update the patients table for the allergies column. If the patient's allergies is null then replace it with 'NKA'
```sql
update patients
SET allergies = 'NKA'
where allergies is null;
```

### Example 6
Show first name and last name concatinated into one column to show their full name.
```sql
select
  concat(first_name, ' ', last_name) AS full_name
FROM patients;
```

### Example 7
Show first name, last name, and the full province name of each patient.

Example: 'Ontario' instead of 'ON'
```sql
select
  first_name,
  last_name,
  province_name
FROM patients
  join province_names ON patients.province_id = province_names.province_id;
```

### Example 8
Show how many patients have a birth_date with 2010 as the birth year.
```sql
select count(*)
FROM patients
where year(birth_date) = 2010;
```

### Example 9
Show the first_name, last_name, and height of the patient with the greatest height.
```sql
select
  first_name,
  last_name,
  height
from patients
where height = (
    select max(height)
    from patients
  )
```

### Example 10
Show all columns for patients who have one of the following patient_ids: 1,45,534,879,1000
```sql
select *
from patients
where
  patient_id in (1, 45, 534, 879, 1000)
```

### Example 11
Show the total number of admissions
```sql
select count(*) from admissions;
```

### Example 12
Show all the columns from admissions where the patient was admitted and discharged on the same day.
```sql
select *
from admissions
where admission_date = discharge_date;
```

### Example 13
Show the patient id and the total number of admissions for patient_id 579.
```sql
select
  patient_id,
  count(*) as total_admission
from admissions
where patient_id = 579;
```

### Example 14
Based on the cities that our patients live in, show unique cities that are in province_id 'NS'.
```sql
select distinct city
from patients
where province_id = 'NS'
```


### Example 15
Write a query to find the first_name, last name and birth date of patients who has height greater than 160 and weight greater than 70

```sql
select
  first_name,
  last_name,
  birth_date
from patients
where height > 160 and weight > 70;
```

### Example 16
Write a query to find list of patients first_name, last_name, and allergies where allergies are not null and are from the city of 'Hamilton'
```sql
select
  first_name,
  last_name,
  allergies
from patients
where
  allergies is not null
  and city = 'Hamilton';
```

## Medium

### Example 17
Show unique birth years from patients and order them by ascending.
```sql
select distinct year(birth_date)
from patients
order by birth_date;
```

### Example 18
Show unique first names from the patients table which only occurs once in the list.

For example, if two or more people are named 'John' in the first_name column then don't include their name in the output list. If only 1 person is named 'Leo' then include them in the output.
```sql
SELECT first_name
from patients
group by first_name
having count(*) = 1
```

### Example 19
Show patient_id and first_name from patients where their first_name start and ends with 's' and is at least 6 characters long.
```sql
SELECT
  patient_id,
  first_name
from patients
where
  first_name like 's%s'
  and len(first_name) >= 6;
```


### Example 20
Show patient_id, first_name, last_name from patients whos diagnosis is 'Dementia'.

Primary diagnosis is stored in the admissions table.
```sql
SELECT
  p.patient_id,
  p.first_name,
  p.last_name
from patients p
  join admissions a ON p.patient_id = a.patient_id
where a.diagnosis = "Dementia"
```

### Example 21
Display every patient's first_name. Order the list by the length of each name and then by alphabetically.
```
SELECT first_name
from patients
order by
  len(first_name),
  first_name
```

### Example 22
Show the total amount of male patients and the total amount of female patients in the patients table. Display the two
results in the same row.
```sql
select (
           select count(*)
           from patients
           where gender = 'M'
       ) as male_count, (
           select count(*)
           from patients
           where gender = 'F'
       ) as female_count;
```

### Example 23
Show first and last name, allergies from patients which have allergies to either 'Penicillin' or 'Morphine'. Show 
results ordered ascending by allergies then by first_name then by last_name.

```sql
select
    first_name,
    last_name,
    allergies
from patients
where
    allergies = 'Penicillin'
   OR allergies = 'Morphine'
order by
    allergies,
    first_name,
    last_name
```

### Example 24

Show patient_id, diagnosis from admissions. Find patients admitted multiple times for the same diagnosis.
```sql
select
  patient_id,
  diagnosis
from admissions
group by
  patient_id,
  diagnosis
having count(*) > 1
```


### Example 25 
Show the city and the total number of patients in the city. Order from most to least patients and then by city name 
ascending.
```sql
select
  city,
  count(*) as num_patients
FROM patients
group by city
order by
  num_patients desc,
  city asc
```

### Example 26 ////Tricky
Show first name, last name and role of every person that is either patient or doctor. The roles are either "Patient" or 
"Doctor"
```sql
SELECT
  first_name,
  last_name,
  'Patient' as role
from patients
union all
select
  first_name,
  last_name,
  'Doctor' as role
from doctors
```

### Example 27
Show all allergies ordered by popularity. Remove NULL values from query.
```sql
select
  allergies,
  count(*) as total_diagnosis
from patients
where allergies is not null
group by allergies
order by total_diagnosis desc
```


### Example 28
Show all patient's first_name, last_name, and birth_date who were born in the 1970s decade. Sort the list starting from the earliest birth_date.
```sql
select
  first_name,
  last_name,
  birth_date
from patients
where
  year(birth_date) between 1970 and 1979
order by birth_date
```


### Example 29
We want to display each patient's full name in a single column. Their last_name in all upper letters must appear first, 
then first_name in all lower case letters. Separate the last_name and first_name with a comma. Order the list by the 
first_name in decending order EX: SMITH,jane
```sql
select
  concat(upper(last_name), ',', lower(first_name))
from patients
order by first_name desc
```

### Example 30
Show the province_id(s), sum of height; where the total sum of its patient's height is greater than or equal to 7,000.
```sql
select
  province_id,
  sum(height) as sum_height
from patients
group by province_id
having sum(height) >= 7000
```

### Example 31
Show the difference between the largest weight and smallest weight for patients with the last name 'Maroni'
```sql
select
    max(weight) - min(weight) as weight_data
from patients
where last_name = "Maroni"
```

### Example 32
Show all of the days of the month (1-31) and how many admission_dates occurred on that day. Sort by the day with most admissions to least admissions.
```sql
select
  day(admission_date) as day_number,
  count(*) as number_of_admissions
from admissions
group by day(admission_date)
order by count(*) desc
```

### Example 33 ////Tricky
Show all columns for patient_id 542's most recent admission_date.
```sql
select *
from admissions
where patient_id = 542
group by patient_id
having
  admission_date = max(admission_date)
```

### Example 34
Show patient_id, attending_doctor_id, and diagnosis for admissions that match one of the two criteria:
1. patient_id is an odd number and attending_doctor_id is either 1, 5, or 19.
2. attending_doctor_id contains a 2 and the length of patient_id is 3 characters.

```sql
select
  patient_id,
  attending_doctor_id,
  diagnosis
from admissions
where
  (
    patient_id % 2 != 0
    and attending_doctor_id IN (1, 5, 19)
  )
  or (
    attending_doctor_id like '%2%'
    and len(patient_id) = 3
  )
```

### Example 35
Show first_name, last_name, and the total number of admissions attended for each doctor.

Every admission has been attended by a doctor.
```sql
select
  d.first_name,
  d.last_name,
  count(*) as admissions_total
from admissions a
  join doctors d on a.attending_doctor_id = d.doctor_id
group by d.doctor_id
```

### Example 36
For each doctor, display their id, full name, and the first and last admission date they attended.
```sql
select
  d.doctor_id,
  concat(d.first_name, " ", d.last_name) as full_name,
  min(a.admission_date) as first_admission_date,
  max(a.admission_date) as last_admission_date
from admissions a
  join doctors d on a.attending_doctor_id = d.doctor_id
group by d.doctor_id
```

### Example 37
Display the total amount of patients for each province. Order by descending.
```sql
select
  province_names.province_name,
  count(*) as patient_count
from province_names
  join patients on patients.province_id = province_names.province_id
group by province_names.province_id
order by patient_count desc
```

### Example 38
For every admission, display the patient's full name, their admission diagnosis, and their doctor's full name who diagnosed their problem.
```sql
select
  concat(p.first_name, " ", p.last_name) as patient_name,
  a.diagnosis,
  concat(d.first_name, " ", d.last_name) as doctor_name
from admissions a
  join patients p on a.patient_id = p.patient_id
  join doctors d on a.attending_doctor_id = d.doctor_id
```

### Example 39
display the first name, last name and number of duplicate patients based on their first name and last name.

Ex: A patient with an identical name can be considered a duplicate.
```sql
**select
  first_name,
  last_name,
  count(*) num_of_duplicates
from patients
group by
  first_name,
  last_name
having count(*) > 1
```

### Example 40
Display patient's full name,
height in the units feet rounded to 1 decimal,
weight in the unit pounds rounded to 0 decimals,
birth_date,
gender non abbreviated.

Convert CM to feet by dividing by 30.48.
Convert KG to pounds by multiplying by 2.205.

```sql
select
  concat(first_name, ' ', last_name),
  round (height / 30.48, 1) as height_Feet,
  round (weight * 2.205, 0) as weight_Pounds,
  birth_date,
  case
    when gender = 'M' then 'Male'
    else 'female'
  end as gender_type
FROM patients
```

### Example 41
Show patient_id, first_name, last_name from patients whose does not have any records in the admissions table. (Their patient_id does not exist in any admissions.patient_id rows.)
```sql
select
  patient_id,
  first_name,
  last_name
from patients
where patient_id not in (
    select patient_id
    from admissions
  )
```

### Example 42
Display a single row with max_visits, min_visits, average_visits where the maximum, minimum and average number of 
admissions per day is calculated. Average is rounded to 2 decimal places.
```sql
select
  max(number_of_admissions) as max_visits,
  min(number_of_admissions) as min_visits,
  round(avg(number_of_admissions), 2) as average_visits
from (
    SELECT
      count(*) as number_of_admissions
    FROM admissions
    group by admission_date
  )
```


## Hard
### Example 43
Show all of the patients grouped into weight groups. Show the total amount of patients in each weight group. Order the
list by the weight group decending.

For example, if they weight 100 to 109 they are placed in the 100 weight group, 110-119 = 110 weight group, etc.
```sql
select
  count(*) as patients_in_group,
  floor(weight / 10) * 10 as weight_group
FROM patients
group by weight_group
order by weight_group desc
```

### Example 44
Show patient_id, weight, height, isObese from the patients table.

Display isObese as a boolean 0 or 1.

Obese is defined as weight(kg)/(height(m)2) >= 30.

weight is in units kg.

height is in units cm.

```sql
SELECT
  patient_id,
  weight,
  height,
  (
    CASE
      WHEN (weight / POWER((height / 100.0), 2)) >= 30 THEN 1
      ELSE 0
    END
  ) AS isObese
FROM patients;
```

### Example 45
Show patient_id, first_name, last_name, and attending doctor's specialty.
Show only the patients who has a diagnosis as 'Epilepsy' and the doctor's first name is 'Lisa'

Check patients, admissions, and doctors tables for required information.

```sql
select
  p.patient_id,
  p.first_name as patient_first_name,
  p.last_name as patients_last_name,
  d.specialty as attending_doctor_specialty
from patients p
  join admissions a on p.patient_id = a.patient_id
  join doctors d on d.doctor_id = a.attending_doctor_id
where
  a.diagnosis = 'Epilepsy'
  and d.first_name = 'Lisa'
```

### Example 46
All patients who have gone through admissions, can see their medical documents on our site. Those patients are given a 
temporary password after their first admission. Show the patient_id and temp_password.

The password must be the following, in order:
1. patient_id
2. the numerical length of patient's last_name
3. year of patient's birth_date

```sql
select
  p.patient_id,
  concat(
    p.patient_id,
    len(p.last_name),
    year(p.birth_date)
  ) as temp_password
from patients p
  join admissions a on p.patient_id = a.patient_id
group by p.patient_id
```

### Example 47
Each admission costs $50 for patients without insurance, and $10 for patients with insurance. All patients with an even patient_id have insurance.

Give each patient a 'Yes' if they have insurance, and a 'No' if they don't have insurance. Add up the admission_total cost for each has_insurance group.

```sql
select
  (
    case
      when p.patient_id % 2 = 0 then 'YES'
      else 'No'
    end
  ) as has_insurance,
  sum(
    case
      when p.patient_id % 2 = 0 then 10
      else 50
    end
  ) as cost_after_insurance
from patients p
  join admissions a on p.patient_id = a.patient_id
group by has_insurance
```

### Example 48
Show the provinces that has more patients identified as 'M' than 'F'. Must only show full province_name
```sql
select
  pn.province_name
from patients p
  join province_names pn on p.province_id = pn.province_id
group by pn.province_name
having
   count(
    case
      when p.gender = 'M' then 1
    end
  ) > count(
    case
      when p.gender = 'F' then 1
    end
  )
```

### Example 49
We are looking for a specific patient. Pull all columns for the patient who matches the following criteria:
- First_name contains an 'r' after the first two letters.
- Identifies their gender as 'F'
- Born in February, May, or December
- Their weight would be between 60kg and 80kg
- Their patient_id is an odd number
- They are from the city 'Kingston'
```sql
SELECT *
FROM patients
WHERE 
  first_name LIKE '__r%'  
  AND gender = 'F'
  AND MONTH(birth_date) IN (2, 5, 12)
  AND weight BETWEEN 60 AND 80
  AND patient_id % 2 != 0  
  AND city = 'Kingston';
```

### Example 50
Show the percent of patients that have 'M' as their gender. Round the answer to the nearest hundreth number and in 
percent form.
```sql
SELECT CONCAT(
    ROUND(
      (
        SELECT COUNT(*)
        FROM patients
        WHERE
          gender = 'M'
      ) / CAST(COUNT(*) AS float),
      4
    ) * 100,
    '%'
  ) AS male_percent
FROM patients;
```

### Example 51 ////Tricky
For each day display the total amount of admissions on that day. Display the amount changed from the previous date.
```sql
select admission_date, 
count(*) as admission_day,
count(admission_date) - lag(count(admission_date)) over(order by admission_date) as change
from admissions group by admission_date
```

### Example 52
Sort the province names in ascending order in such a way that the province 'Ontario' is always on top.
```sql
select province_name
from province_names
order by
    case
        when province_name = 'Ontario' then 4
        else province_name
        end
```

### Example 53
We need a breakdown for the total amount of admissions each doctor has started each year. Show the doctor_id, 
doctor_full_name, specialty, year, total_admissions for that year.
```sql
SELECT
    d.doctor_id,
    CONCAT(d.first_name, ' ', d.last_name) AS doctor_name,
    d.specialty,
    YEAR(a.admission_date) AS selected_year,
    COUNT(*) AS total_admissions
FROM doctors d
    JOIN admissions a ON d.doctor_id = a.attending_doctor_id
GROUP BY
    selected_year,
    d.doctor_id
```

# northwind.db
## Easy

### Example 54
Show the category_name and description from the categories table sorted by category_name.
```sql
SELECT
  category_name,
  description
from categories
order by category_name
```

### Example 55
Show all the contact_name, address, city of all customers which are not from 'Germany', 'Mexico', 'Spain'
```sql
SELECT
  contact_name,
  address,
  city
from customers
where
  country not in ('Germany', 'Mexico', 'Spain')
```

### Example 56
Show order_date, shipped_date, customer_id, Freight of all orders placed on 2018 Feb 26
```sql
SELECT
  order_date,
  shipped_date,
  customer_id,
  freight
from orders
where order_date = "2018-02-26"
```

### Example 57
Show the employee_id, order_id, customer_id, required_date, shipped_date from all orders shipped later than the required
date

```sql
SELECT
  employee_id,
  order_id,
  customer_id,
  required_date,
  shipped_date
from orders
where shipped_date > required_date
```

### Example 58
Show all the even numbered Order_id from the orders table
```sql
SELECT order_id
from orders
where order_id % 2 = 0
```

### Example 59
Show the city, company_name, contact_name of all customers from cities which contains the letter 'L' in the city name, 
sorted by contact_name
```sql
select
  city,
  company_name,
  contact_name
from customers
where city like '%L%'
order by contact_name
```

### Example 60
Show the company_name, contact_name, fax number of all customers that has a fax number. (not null)
```sql
select
  company_name,
  contact_name,
  fax
from customers
where fax is not null
```


### Example 61
Show the first_name, last_name. hire_date of the most recently hired employee.
```sql
select
  first_name,
  last_name,
  hire_date
from employees
order by hire_date desc
limit 1
```

### Example 62
Show the average unit price rounded to 2 decimal places, the total units in stock, total discontinued products from the 
products table.
```sql
select
    round(avg(unit_price), 2) as average_price,
    sum(units_in_stock) as total_stock,
    count(
            case
                when discontinued = true then 1
                end
    ) as total_discontinued
from products
```

### Example 63
Show the ProductName, CompanyName, CategoryName from the products, suppliers, and categories table
```sql
select
  p.product_name,
  s.company_name,
  c.category_name
from products p
  join suppliers s on p.supplier_id = s.supplier_id
  join categories c on c.category_id = p.category_id
```

### Example 64
Show the category_name and the average product unit price for each category rounded to 2 decimal places.
```sql
select
  c.category_name,
  round(avg(p.unit_price), 2) as average_unit_price
  from products p
  join categories c on p.category_id = c.category_id
  group by c.category_name
```


### Example 65 ////Tricky
Show the city, company_name, contact_name from the customers and suppliers table merged together. Create a column which
contains 'customers' or 'suppliers' depending on the table it came from.
```sql
select
  city,
  company_name,
  contact_name,
  'customers' as relationship
from customers
union
select
  city,
  company_name,
  contact_name,
  'suppliers' as relationship
from suppliers
```

### Example 66
Show the total amount of orders for each year/month.
```sql
select
  year(order_date) as order_year,
  month(order_date) as order_month,
  count(*) no_of_others
from orders
group by
  Year(order_date),
  month(order_date);
```

### Example 67 ////tricky
Show the employee's first_name and last_name, a "num_orders" column with a count of the orders taken, and a column
called "Shipped" that displays "On Time" if the order shipped_date is less or equal to the required_date, "Late" if the
order shipped late, "Not Shipped" if shipped_date is null.

Order by employee last_name, then by first_name, and then descending by number of orders.

```sql
select
  e.first_name,
  e.last_name,
  count(o.order_id) as num_orders,
  (
    case
      when o.shipped_date <= required_date then 'On Time'
      when o.shipped_date > o.required_date then 'Late'
      when o.shipped_date is null then 'Not Shipped'
    END
  ) as shipped
from employees e
  join orders o on e.employee_id = o.employee_id
group by
  e.first_name,
  e.last_name,
  shipped
order by
  e.last_name,
  e.first_name,
  num_orders desc
```

### Example 68 ////Tricky
Show how much money the company lost due to giving discounts each year, order the years from most recent to least
recent. Round to 2 decimal places
```sql
SELECT year(o.order_date) as order_year,
round(sum(p.unit_price * od.quantity * od.discount), 2) as discount
from orders o join 
order_details od on o.order_id = od.order_id
join products p on od.product_id = p.product_id
group by year(o.order_date)
order by order_year desc
```


## References
- https://www.sql-practice.com/
- [Solve 70 SQL Questions in 3 hrs | Ultimate SQL Practice | Master SQL](https://www.youtube.com/watch?v=nYmoQ4r0DVw)
