# Normalization
Normalization is the process of normalizing redundancy and dependency by organizing fields and tables of a database. The
main aim of Normalizing is to add, delete or modify field that can be made in a single table.

# Types of normalization
## First Normal Form(1NF)
This should remove all the duplicate columns from the table. Creation of tables for the related data and identification 
of unique columns.

* Every column must have atomic (single value)
* To Remove duplicate columns from the same table
* Create separate tables for each group of related data and identify each row with a unique column(no repeating groups)

## Second Normal Form(2NF)
Meeting all requirements of first normal form. Placing the subsets of data in separate tables and creation of 
relationships between tables using primary keys.

Every non-prime attribute is fully functionally dependent on the primary key, i.e., every non-key attribute should be
dependent on the primary key in such a way that if any key element is deleted, then even the non_key element will still 
be saved in the database.

## Third Normal Form(3NF)
This should meet all requirements of 2NF. Removing the columns which are not dependent on primary key constraints.

Each non-prime attribute of a table is said to be non-transitively dependent on every key of the table.

## Fourth Normal Form(4NF)
Meeting all requirement of third normal form, and it should not have multivalued dependency.





## Database Normalization Example: Courses and Students

Let's walk through normalizing a database table named `CourseEnrollments` from unnormalized to Third Normal Form (3NF).

**1. Unnormalized Table (Not even in 1NF):**

This table stores student information, course details, and instructor information within a single table.  It violates 
1NF because the `Course` field contains multiple courses for a single student.

| StudentID | StudentName | Courses               | InstructorID | InstructorName | InstructorOffice |
|-----------|-------------|-----------------------|--------------|----------------|------------------|
| 1         | Alice Smith | Math 101, Chem 101    | 100          | Dr. Jones      | Room 201         |
| 2         | Bob Johnson | Physics 201           | 200          | Prof. Brown    | Room 305         |
| 3         | Carol Davis | Math 101, History 101 | 100          | Dr. Jones      | Room 201         |
| 4         | David Lee   | Chem 101              | 300          | Dr. Wilson     | Room 410         |
| 1         | Alice Smith | Physics 201           | 200          | Prof. Brown    | Room 305         |

**Issues:**

*   **Not 1NF:** The `Courses` column contains multiple values (Math 101, Chem 101) in a single cell.
*   **Redundancy:** Student information, instructor information, and course information are repeated.
*   **Update Anomalies:** Changing an instructor's office requires updating multiple rows.
*   **Insertion Anomalies:** Cannot add a new instructor without a student enrolled in their course.
*   **Deletion Anomalies:** Deleting a student enrollment might also delete instructor information if no other students are enrolled in that instructor's course.

**2. First Normal Form (1NF):**

1NF eliminates repeating groups of columns. Each column contains only atomic values (indivisible values). This is 
achieved by breaking the courses into multiple rows - one for each course a student is enrolled in.

| StudentID | StudentName | Course      | InstructorID | InstructorName | InstructorOffice |
|-----------|-------------|-------------|--------------|----------------|------------------|
| 1         | Alice Smith | Math 101    | 100          | Dr. Jones      | Room 201         |
| 1         | Alice Smith | Chem 101    | 300          | Dr. Wilson     | Room 410         |
| 2         | Bob Johnson | Physics 201 | 200          | Prof. Brown    | Room 305         |
| 3         | Carol Davis | Math 101    | 100          | Dr. Jones      | Room 201         |
| 3         | Carol Davis | History 101 | 400          | Prof. White    | Room 220         |
| 4         | David Lee   | Chem 101    | 300          | Dr. Wilson     | Room 410         |
| 1         | Alice Smith | Physics 201 | 200          | Prof. Brown    | Room 305         |

This a first normal form because  <br/>
✅ **Atomicity:** Every column contains atomic values. No column contains multiple values within a single cell. <br/>
✅ **Uniqueness of Columns:** Each column represents a single type of information (e.g., StudentID, StudentName, Course,
  etc.). <br/>
✅ **Uniqueness of Rows:** There is no explicit primary key, but each row represents a unique combination of StudentID,
  Course, and InstructorID. <br/>
✅ **No Repeating Groups:** There are no repeated groups within a single row. <br/>

**Primary Key:** The primary key is now a composite key (StudentID, Course).  (This assumes a student can only enroll in 
a specific course once.)

**Issues Remaining:**

* Redundancy: Student and instructor information are repeated.
* Update/Insertion/Deletion Anomalies: Still present.  Changing student name or instructor office requires multiple
  updates.  Adding a new student or instructor without a course enrollment is not possible.

**3. Second Normal Form (2NF):**

2NF requires the table to be in 1NF and eliminates partial dependencies. This means that all non-key attributes must be
fully dependent on the *entire* primary key. In this case, `StudentName`, `InstructorID`, `InstructorName`, and 
`InstructorOffice` are *not* fully dependent on the composite key (StudentID, Course). `StudentName` only depends on 
`StudentID`, and `InstructorName` and `InstructorOffice` only depend on `InstructorID`.

We'll split the table into three tables: `Students`, `CoursesInstructors`, and `Instructors`.

**Students Table:**

| StudentID | StudentName |
|-----------|-------------|
| 1         | Alice Smith |
| 2         | Bob Johnson |
| 3         | Carol Davis |
| 4         | David Lee   |

**CoursesInstructors Table (Enrollments):**

| StudentID | Course      | InstructorID |
|-----------|-------------|--------------|
| 1         | Math 101    | 100          |
| 1         | Chem 101    | 300          |
| 2         | Physics 201 | 200          |
| 3         | Math 101    | 100          |
| 3         | History 101 | 400          |
| 4         | Chem 101    | 300          |
| 1         | Physics 201 | 200          |

**Instructors Table:**

| InstructorID | InstructorName | InstructorOffice |
|--------------|----------------|------------------|
| 100          | Dr. Jones      | Room 201         |
| 200          | Prof. Brown    | Room 305         |
| 300          | Dr. Wilson     | Room 410         |
| 400          | Prof. White    | Room 220         |

**Primary Keys:**

*   `Students`: StudentID
*   `CoursesInstructors`: (StudentID, Course) (composite key)
*   `Instructors`: InstructorID

**Foreign Keys:**

*   `CoursesInstructors`.StudentID references `Students`.StudentID
*   `CoursesInstructors`.InstructorID references `Instructors`.InstructorID

**Why is this 2NF?**

* `Students` only depends on `StudentID`.
* `Instructors` only depends on `InstructorID`.
* `CoursesInstructors` depends on both `StudentID` and `Course`. The instructor ID depends on *both* a specific student 
  taking a particular course.

**Issues Remaining:**

* Transitive Dependency in `CoursesInstructors`. The assumption is made that the InstructorID is the same for the 
  given Course. If a course is taught by different Instructors this will have to be handled differently.

**4. Third Normal Form (3NF):**

3NF requires the table to be in 2NF and eliminates transitive dependencies. A transitive dependency occurs when a 
non-key attribute depends on another non-key attribute.

`Students` and `Instructors` are already in 3NF.

We will refactor `CoursesInstructors` into 2 tables `Courses` and `StudentCourses`

**Courses Table:**

| Course      | InstructorID |
|-------------|--------------|
| Math 101    | 100          |
| Chem 101    | 300          |
| Physics 201 | 200          |
| History 101 | 400          |

**StudentCourses Table:**

| StudentID | Course      |
|-----------|-------------|
| 1         | Math 101    |
| 1         | Chem 101    |
| 2         | Physics 201 |
| 3         | Math 101    |
| 3         | History 101 |
| 4         | Chem 101    |
| 1         | Physics 201 |

**Primary Keys:**

*   `Students`: StudentID
*   `Courses`: Course
*   `StudentCourses`: (StudentID, Course) (composite key)
*   `Instructors`: InstructorID

**Foreign Keys:**

*   `StudentCourses`.StudentID references `Students`.StudentID
*   `StudentCourses`.Course references `Courses`.Course
*   `Courses`.InstructorID references `Instructors`.InstructorID

**Resulting Schema (in 3NF):**

*   **Students Table:**
    *   `StudentID` (PK)
    *   `StudentName`

*   **Courses Table:**
    *   `Course` (PK)
    *   `InstructorID` (FK to `Instructors`.`InstructorID`)

*   **StudentCourses Table:**
    *   `StudentID` (PK, FK to `Students`.`StudentID`)
    *   `Course` (PK, FK to `Courses`.`Course`)

*   **Instructors Table:**
    *   `InstructorID` (PK)
    *   `InstructorName`
    *   `InstructorOffice`

**Benefits of 3NF:**

*   **Reduced Redundancy:** Data is stored only once.
*   **Improved Data Integrity:** Less chance of inconsistencies.
*   **Simplified Updates:** Changing a student's name only requires updating one row in the `Students` table. Changing
  an instructor's office only requires updating one row in the `Instructors` table.  Updating what professor teaches the 
  course requires updating only one row in the `Courses` table.
*   **Easier Queries:** Relational databases are optimized for querying normalized data.
*   **Reduced Storage Space:** Less duplicated data.














# Denormalization
Denormalization is the inverse process of normalization, where the normalized schema is converted into a schema which has 
redundant information. The performance is improved by using redundancy and keeping the redundant data consistent. The 
reason for performing denormalization is the overheads produced in query processor by an over-normalized structure.


Sources:
* https://www.javatpoint.com/dbms-interview-questions