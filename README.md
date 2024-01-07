
# Perpustakaan

This Library App is designed to streamline the process of managing books within a library. Users can explore the extensive book catalog, check book availability, while administrators have access to advanced features such as loan creation, updates, and a comprehensive loan history dashboard.


## Features

- Book Catalog: Explore a vast collection of books with details on authors, overviews, and titles.
- Loan Management Dashboard: Get an overview of current loans, track statuses, and manage lending operations.
- Loan Creation: Easily create new loans, input borrower details, book information, and due dates.
- Loan Updates (Return Books): Update loan statuses when books are returned to maintain an organized library system.
- Loan History: Access a comprehensive history to analyze trends and optimize library operations.


## Tech Stack

**Front End:** SwiftUI

**Back End:** Laravel


## Documentation

[Documentation](https://github.com/feliciagraciella/Perpustakaan/tree/main/Perpustakaan-New/Perpustakaan-New.doccarchive)


## API Reference

### Get book list

```http
  GET /api/books
```

### Get book detail

```http
  GET /api/books/{id}
```

| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `id`      | `Int` | **Required**. Id of item to fetch |

### Get loan list

```http
  GET /api/loans
```

### Get loan detail

```http
  GET /api/loans/{id}
```

| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `id`      | `Int` | **Required**. Id of item to fetch |

### Create new loan

```http
  POST /api/newloan
```

#### Request Body
Accept: application/json


| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `details`      | `array` | **Required**. An array of loan details (array of bookID) |
| `bookID`      | `integer` | **Required**. The ID of the book to be loaned. |
| `memberID`      | `integer` | **Required**. The ID of the member taking the loan. |

Example

```
{
  "details": [
    {"bookID": 1},
    {"bookID": 2}
  ],
  "memberID": 123
}
```

### Update Loan (Book Return)

```
PUT /api/books/return/{loanID}/{bookID}
```
| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `loanID`      | `integer` | **Required**. The ID of the loan |
| `bookID`      | `integer` | **Required**. The ID of the book to be returned |

### Get member list
```
PUT /api/members
```


### Create new member
```
POST /api/members/create
```
#### Request Body
Accept: application/json


| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `memberName`      | `string` | **Required**. Name of the new member |

Example

```
{
  "memberName": "John Doe"
}
```




