# Project Management API Endpoints

## Authentication Endpoints

### Register User
- **POST** `/api/v1/auth/register`
- **Body:**
```json
{
  "user": {
    "email": "user@example.com",
    "password": "password123",
    "password_confirmation": "password123",
    "first_name": "John",
    "last_name": "Doe",
    "role": "user"
  }
}
```

### Login
- **POST** `/api/v1/auth/login`
- **Body:**
```json
{
  "email": "user@example.com",
  "password": "password123"
}
```

### Get Current User
- **GET** `/api/v1/auth/me`
- **Headers:** `Authorization: Bearer <token>`

### Logout
- **POST** `/api/v1/auth/logout`
- **Headers:** `Authorization: Bearer <token>`

### Forgot Password
- **POST** `/api/v1/auth/forgot_password`
- **Body:**
```json
{
  "email": "user@example.com"
}
```

### Reset Password
- **POST** `/api/v1/auth/reset_password`
- **Body:**
```json
{
  "token": "reset_token",
  "password": "new_password",
  "password_confirmation": "new_password"
}
```

## User Endpoints

### Get All Users (Admin only)
- **GET** `/api/v1/users`
- **Headers:** `Authorization: Bearer <token>`

### Get User
- **GET** `/api/v1/users/:id`
- **Headers:** `Authorization: Bearer <token>`

### Update User
- **PATCH/PUT** `/api/v1/users/:id`
- **Headers:** `Authorization: Bearer <token>`
- **Body:**
```json
{
  "user": {
    "first_name": "Jane",
    "last_name": "Smith",
    "email": "jane@example.com"
  }
}
```

### Delete User
- **DELETE** `/api/v1/users/:id`
- **Headers:** `Authorization: Bearer <token>`

## Project Endpoints

### Get All Projects
- **GET** `/api/v1/projects`
- **Headers:** `Authorization: Bearer <token>`

### Get Project
- **GET** `/api/v1/projects/:id`
- **Headers:** `Authorization: Bearer <token>`

### Create Project
- **POST** `/api/v1/projects`
- **Headers:** `Authorization: Bearer <token>`
- **Body:**
```json
{
  "project": {
    "name": "My Project",
    "description": "Project description"
  }
}
```

### Update Project
- **PATCH/PUT** `/api/v1/projects/:id`
- **Headers:** `Authorization: Bearer <token>`
- **Body:**
```json
{
  "project": {
    "name": "Updated Project Name",
    "description": "Updated description"
  }
}
```

### Delete Project
- **DELETE** `/api/v1/projects/:id`
- **Headers:** `Authorization: Bearer <token>`

## Task Endpoints

### Get All Tasks
- **GET** `/api/v1/tasks`
- **Headers:** `Authorization: Bearer <token>`
- **Query Parameters:**
  - `status`: Filter by status (todo, in_progress, completed)
  - `overdue`: Filter overdue tasks (true/false)
  - `due_soon`: Filter tasks due soon (true/false)
  - `project_id`: Filter by project

### Get Tasks for Project
- **GET** `/api/v1/projects/:project_id/tasks`
- **Headers:** `Authorization: Bearer <token>`

### Get Task
- **GET** `/api/v1/tasks/:id`
- **Headers:** `Authorization: Bearer <token>`

### Create Task
- **POST** `/api/v1/tasks`
- **Headers:** `Authorization: Bearer <token>`
- **Body:**
```json
{
  "task": {
    "title": "Task Title",
    "description": "Task description",
    "due_date": "2024-12-31T23:59:59Z",
    "project_id": 1
  }
}
```

### Create Task in Project
- **POST** `/api/v1/projects/:project_id/tasks`
- **Headers:** `Authorization: Bearer <token>`
- **Body:**
```json
{
  "task": {
    "title": "Task Title",
    "description": "Task description",
    "due_date": "2024-12-31T23:59:59Z"
  }
}
```

### Update Task
- **PATCH/PUT** `/api/v1/tasks/:id`
- **Headers:** `Authorization: Bearer <token>`
- **Body:**
```json
{
  "task": {
    "title": "Updated Task Title",
    "description": "Updated description",
    "status": "in_progress",
    "due_date": "2024-12-31T23:59:59Z"
  }
}
```

### Update Task Status
- **PATCH** `/api/v1/tasks/:id/status`
- **Headers:** `Authorization: Bearer <token>`
- **Body:**
```json
{
  "status": "completed"
}
```

### Delete Task
- **DELETE** `/api/v1/tasks/:id`
- **Headers:** `Authorization: Bearer <token>`

## Response Format

All responses follow this format:

### Success Response
```json
{
  "message": "Success message",
  "data": { ... }
}
```

### Error Response
```json
{
  "error": "Error message",
  "errors": ["Detailed error messages"]
}
```

## Authentication

All protected endpoints require a Bearer token in the Authorization header:
```
Authorization: Bearer <jwt_token>
```

The JWT token is obtained from the login or register endpoints and expires after 24 hours.


