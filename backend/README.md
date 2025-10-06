# Project Management API

A Rails 8.0.3 API backend for a project management system with JWT authentication.

## Features

- **JWT Authentication** with user registration, login, and password reset
- **User Management** with role-based authorization (user/admin)
- **Project Management** with CRUD operations
- **Task Management** with status tracking and due dates
- **Real-time Updates** via ActionCable
- **RESTful API** with comprehensive endpoints

## Quick Start

### Option 1: Use the setup script (Windows)
```bash
setup_server.bat
```

### Option 2: Manual setup
```bash
# Install dependencies
bundle install

# Create and setup database
rails db:create
rails db:migrate

# Start the server
rails server -p 3000
```

## API Endpoints

The API is available at `http://localhost:3000/api/v1/`

### Authentication
- `POST /api/v1/auth/register` - Register new user
- `POST /api/v1/auth/login` - Login user
- `GET /api/v1/auth/me` - Get current user
- `POST /api/v1/auth/logout` - Logout user
- `POST /api/v1/auth/forgot_password` - Request password reset
- `POST /api/v1/auth/reset_password` - Reset password

### Resources
- `GET /api/v1/users` - List users (admin only)
- `GET /api/v1/projects` - List user's projects
- `POST /api/v1/projects` - Create project
- `GET /api/v1/tasks` - List tasks
- `POST /api/v1/tasks` - Create task

See `API_ENDPOINTS.md` for complete documentation.

## Database

- **Development**: SQLite3
- **Production**: PostgreSQL

## Authentication

All protected endpoints require a Bearer token:
```
Authorization: Bearer <jwt_token>
```

## CORS

Configured for frontend integration on:
- `http://localhost:3000`
- `http://localhost:5173`
- `http://127.0.0.1:3000`
- `http://127.0.0.1:5173`
