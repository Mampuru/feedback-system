# Feedback System [INCOMPLETE]

[![My Skills](https://skillicons.dev/icons?i=dotnet,cs,flutter,dart)](https://skillicons.dev)

Simple cross-platform that allows a user to submit feedback 

 ## Features
- Allows admin user to login into the system.
- Allows admin user to view all feedback.
- Allows user to submit feedback.
- Allows super admin user to perform CRUD operations on admin users.

### Outstanding features
- View feedback in real-time on the dashbaord.
- Integrate webhooks to notify admins everytime a feedbackis submit.
- Add unit test

## Approach
- The chosen architecture style is Client-Server Architecture-> I have decide to divide the application into two separate parts client side (front-end) and the server (back-end) 

### Motiavtion
- Interoperability: Client-server architecture supports interoperability between different clients (e.g., web browsers, mobile devices, desktop applications) and servers, allowing clients to access and consume services from multiple servers and platforms.
- Modular and Reusable Components: The separation of client and server components promotes modularity and reusability of components, making it easier to develop, deploy, and maintain the software application.
- Mobility and Cross-Platform Compatibility: Clients can be developed and deployed on different platforms and devices (e.g., web browsers, mobile devices, desktop applications), providing flexibility, mobility, and cross-platform compatibility.
- Access Control and Authentication: Client-server architecture allows for centralized access control and authentication mechanisms to secure and protect the data and resources.

### Backend implementation Approach

**Running backend** 

1. Add the .env file to the root of the project
2. Make sure that you have populated all fields in the .env 

```
ISSUER= " " 
AUDIENCE= " "
SECURITY_KEY= "" 
DB_CONNECTION_STRING= " "
```
3. Run migrations to generate the database
    
*Package Manager Console*

`add-migration [name]`

`update-database`

**OR**

*Command Line*

`dotnet ef migrations add [name]`

`dotnet ef database update`

### Frontend implementation Approach

**Running front-end**

On broswer : `flutter run -d [brower name]`

On mobile device : `flutter run`
