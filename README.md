# Leg 1: Wireframe and Model

### Design
After reviewing the information provided to us from Tina, we've decided to design the data schema for the application using four tables: Users, Incidents, Categories, and Departments.

### Users
The users in the system will be created by a simple authentication system, where one would input their universal PIN and password for the research institution to create an account. The rest of the information for the user (first name, last name, role, department, email) would be pulled from the universal account.

### Incidents
Incidents represent the filed incident reports submitted by users. Various data fields that are a part of the incident table will be populated by data filled out by the user in the report form (description, location, category, severity). Other fields, such as user, department and datetime, would be populated automatically. The 'status' and 'comments' are initially blank fields that are to be filled out by an administrator.

### Categories
These represent the various types of incidents that we expect to be most common (fire, fallen tree, flooding, etc). On incident forms, there will be an option for 'other' if one does not match. Each of these categories is mapped to a specific department (represented by it's ID in the table).

### Departments
These are simply the departments that comprise Operations Services. The members of these departments will have access to view and take action on various incidents. Each department also has a number of categories mapped to them. When an incident is filed with a category that maps to their department, they can view it on their timeline and respond accordingly.



#Leg 2: MVP

### Setup and installation instructions
Clone our master branch, Go into IncidentTracker folder, bundle install, rake db:create, rake db:migrate

ruby version 2.3.0, rails version 4.2.1



### Architecture and Tools
We used Ruby on Rails for the implementation of the MVP.  This was primarily because of the inbuilt RESTful design, strict to adherence to MVC design structure, object Relational Mapping, the fact that Rails is very well established platform in the professional developement scene, and Rails has a very elementary learning curve
    
    
We decided to use used Postgres as our database.  This was because we are building for 'n' users, postgres is well known for reliability and stability, it has solid cross platform support, and finally generally has a reputation for good performance
    
We used only the default gems packages with Rails

No additional APIs or dependencies were used

### Group Work/Effort Estimation
Average hours per person learning ruby : 4hr

Average hours per person developing/testing/designing/researching/etc MVP: 24hr

We faced quite a few challenges during development of this mvp. With respect to installation and setup configuration and version control - We have 2 windows users, one mac user, and one linux user so getting everyone on the same page was difficult.  Learning github was also difficult because only one of our members had used github before, and we had to learn learning branching, merging, and all other features.  We also had some difficulty deciding which if any gems to use - we looked into bootstrap, jquery mobile, datatables among other gems/packages and spent a lot of time testing features before deciding to add our own styles. With respect to design/architecture -we spent a lot of time trying to create a simple design theme that would be appropriate for our diverse user base.  We also spent a lot of time discussing the scope of the mvp and what functionality/data we thought was really necessary for the MVP

# Leg 3: Production and Testing

### URL: http://blooming-ravine-67304.herokuapp.com/

### Production
We decided to push our application to heroku for this leg of the project.  The main reason we choose heroku was the integration with git and understandable layer of abstraction it provides on the cloud/aws.  

### Testing
Framework: rspec

How to run our tests: clone, bundle install, rake:db create, rake:db migrate, rake:db seed, rspec spec

Since we decided to use rspec, our tests are in the 'spec' folder under Incident tracker rather than the 'test' folder (which contains the default unit tests that came with the scaffold)

We decided to use rspec as our testing framework mainly because of the community support and documentation.  Rspec is very widely used and we found a lot of tutorials and community threads to help us understand and implement our tests.  Another aspect of rspec we liked was the readability.  The 'describe' and 'context' syntax are very easy to understand when running tests and sharing with other members of the group.    

Because we utilized the scaffold feature, many of the unit tests were created for us.  We wrote some view tests, model tests, and controller tests trying to focus on the the coding/functionality we added. 

### Future performance/optimizations for 'many' users
We have many plans with respect to optimization and performance for higher volumes of users.  Our first priority is to research and add a CDN.  Since our app is on heroku if it started recieving a lot of traffic we would probably have to add more dynos/use some performance dynos.  This would of course cost some $$.  We are also looking into simply using AWS ourselves as a possible alternative.
We have additionally added the datatables plugin for simple pagination on our incident index page.  This way when the number of incidents increases with many users it will not look clunky. 


### Other Notes
We added the test and development frameworks/databases and various design changes based on the feedback we have recieved


    
    


