# AC-iOS Final - Practical

## Objective

Build an Instagram-like app for posting images with comments.

## Summary

The app comprises three view controllers: a feed, an upload page and a login page. The designs to follow
will illustrate and specify the design and relationship of these view controllers.  The backend will be powered by Firebase.

## Login

Users are required to log in before they can access the rest of the app.

![Login Flow](readme_assets/Login/login_flow.png)


## Main View: Feed

Each post in the feed has two elements: a picture and a comment. The picture is a fixed square the width
of the device and the text is variable height below it, resulting in non-uniform cell heights.
Therefore use Auto Layout to drive automatic cell heights.

![Main Feed Flow](readme_assets/Main Feed/feed_flow_full.png)


## Upload View

![Uploads](readme_assets/Uploads/upload_flow_full.png)

## Backend

### Authentication

Use Email/Password authentication to you can register and log users in.

### Database

The simple schema is illustrated by this diagram.  This will probably make the most sense for your app.

![Database Schema](readme_assets/database.png)

### Storage

The file structure of the storage is illustrated here:

![Database Schema](readme_assets/storage.png)

Note the relationship between image names and objects in the database.  You can use the same UID for both.

#### Uploading Images

Be sure to render your images into compressed JPEG format as we did in the review.
Here's a line of code that takes a ```UIImage``` and generates a ```Data``` object
with JPEG data.

```swift
let image: UIImage = ...obtain uiimage somehow...
let data = UIImageJPEGRepresentation(image, 0.5)
```

# Rubric 

Criteria | Points
:---|:---
App uses AutoLayout correctly for all iPhones in portrait | 8 Points
Variable Naming and Readability | 4 Points
App uses MVC Design Patterns | 4 Points
Login screen works as expected | 4 Points
App uses Firebase's Auth appropriately | 4 Points
Users can create a post and upload it to Firebase | 4 Points
App uses Firebase's Storage appropriately | 4 Points
Users can see well-formatted posts in their feed | 4 Points
App uses Firebase's Database appropriately | 4 Points

A total of 40 points



# Individual Screen Details

### Login
---
![Login](readme_assets/Login/Login.png)

<table>
	<thead>
		<tr>
			<td>Login Success</td>
			<td>Login Failure</td>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td width="400"><img src="./readme_assets/Login/Login%20-%20Success.png" width="380" alt="Login Successful Screen"></td>
			<td width="400"><img src="./readme_assets/Login/Login%20-%20Failed.png" width="380" alt="Login Failure Screen"></td>
		</tr>
	</tbody>
</table>

---

### Feed

![Main Feed](readme_assets/Main%20Feed/Main%20Feed.png)

<table>
	<thead>
		<tr>
			<td>Main Feed Extended</td>
			<td>Main Feed Extended Scaling</td>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td width="400"><img src="./readme_assets/Main%20Feed/Main%20Feed%20-%20Extended%201.png" width="380" alt="Main Feed Extended 1"></td>
			<td width="400"><img src="./readme_assets/Main%20Feed/Main%20Feed%20-%20Extended%20Scaling.png" width="380" alt="Main Feed Extended Scaling"></td>
		</tr>
	</tbody>
</table>

---
### Upload

![Uploads Upload](readme_assets/Uploads/Upload.png)
---

<table>
	<thead>
		<tr>
			<td>Showing Roll: Beginning Modal</td>
			<td>Showing Roll: Mid Model</td>
			<td>Showing Roll: Finished Modal, Album View</td>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td width="280"><img src="./readme_assets/Uploads/Upload%20-%20Show%20Roll.png" width="240" alt="Beginning to show modally"></td>
			<td width="280"><img src="./readme_assets/Uploads/Upload%20-%20Show%20Roll%20-%202.png" width="240" alt="Mid of modal show"></td>
			<td width="280"><img src="./readme_assets/Uploads/Albums.png" width="240" alt="Ending modal show animation"></td>
		</tr>
	</tbody>
</table>

<table>
	<thead>
		<tr>
			<td>Uploads Selected</td>
			<td>Uploads Success</td>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td width="400"><img src="./readme_assets/Uploads/Upload%20-%20Selected.png" width="380" alt="Uploads Selected"></td>
			<td width="400"><img src="./readme_assets/Uploads/Upload%20-%20Success.png" width="380" alt="Uploads Successful"></td>
		</tr>
	</tbody>
</table>

<table>
	<thead>
		<tr>
			<td>Main Feed - After Upload</td>
			<td>Uploads Failure</td>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td width="400"><img src="./readme_assets/Uploads/Main%20Feed.png" width="380" alt="Main Feed - After Upload"></td>
			<td width="400"><img src="./readme_assets/Uploads/Upload%20-%20Failed.png" width="380" alt="Uploads Failure"></td>
		</tr>
	</tbody>
</table>