# ArieoMeals

## Prerequisites

Ensure you have the following installed before setting up the project:

### Ruby Version
- `Ruby 3.2.4` (Specify the exact version you are using)

### Rails Version
- `Rails 8.0.1` (Specify the exact version you are using)

### PostgreSQL Version
- `PostgreSQL 17.0` (Specify the exact version you are using)

### pgAdmin Version
- `pgAdmin 8.12` (Specify the exact version you are using)

## Installation Guide

### Installing PostgreSQL and pgAdmin

#### Windows
Download and install PostgreSQL from the official website: [PostgreSQL Download](https://www.postgresql.org/download/windows/)

pgAdmin is included in the PostgreSQL installer.

## Cloning the Repository

To clone the repository, use the following command:
```sh
git clone https://github.com/ShantanuK24/ArieoMeals.git
```

Navigate into the project directory:
```sh
cd project-directory
```

## Required Git Commands

### Initializing a Git Repository
```sh
git init
```

### Adding Files to Staging
```sh
git add .
```

### Committing Changes
```sh
git commit -m "Initial commit"
```

### Pushing to Remote Repository
```sh
git push origin main
```

### Pulling the Latest Changes
```sh
git pull origin main
```

### Checking the Current Status
```sh
git status
```

### Checking the Git Log
```sh
git log --oneline --graph
```

-------------------------------------------------------------------------------------------

## Application Setup

Create a `.env` file and add database configurations to it.
Refer to the following example `.env.example` file and replace it with your credentials.


### Running the Application

```sh
bundle install
rails db:create
rails db:migrate
rails s
```

