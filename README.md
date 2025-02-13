Screens: 
1.login page-
  feauture:
  1. email and password mandatory("email": "eve.holt@reqres.in",
    "password": "cityslicka") use this credentails -> login api used ->https://reqres.in/api/login
2.register page
  feature:
  1. name email and password are manditory("email": "eve.holt@reqres.in",
    "password": "pistol"( use this credentails for login -> register api-> https://reqres.in/api/register
Note: Once login or register next time directly navigate to home page, using hive data base to store the token and keep the value
3.home page with task list
  feature
  task list is avaiable(using drift db)-> available on offline
  task list have a two option
    edit and delete
    when you tap the edit icon navigate to form page with prefilled values (update api is used)
     when you tap the delete button the item will be deleted
  add task option is avaiable
    navigate to form page with empty values
    create api used
    after successful navigate to home page and show added successfully message.
  logout option is there
    navigate to login page
  
4.form page (create and update)
  title ,description ,due date, priority ,user list, task status are mandatory
  validation is there

Approch :
1. BLOC architucture
2. state changes are done by BLOC architecture
3. Each things will wriiten as seprate file like UI will be seperate ,event handler handled seperatly , state changes handled individually, logics are implemented indivudually
4. BLOC is clean architecture
![image](https://github.com/user-attachments/assets/5ccab00c-1743-4f51-aec2-f72ffc51e247)
![image](https://github.com/user-attachments/assets/69f73cb7-08d4-4e46-bda9-dbfe9823dbb1)
![image](https://github.com/user-attachments/assets/76f4fd5c-cd6b-487e-9e60-0c939545003c)
![image](https://github.com/user-attachments/assets/d5992a48-162c-4bd9-aa6d-a9f38634b1d2)
![image](https://github.com/user-attachments/assets/48adb019-cd85-4f3d-b92c-be17175f8137)
![image](https://github.com/user-attachments/assets/d036fe2d-f913-4cf4-b021-8adb489020a8)








