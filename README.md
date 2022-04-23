Original App Design Project - README Template
===

# CovidPass

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)
3. [Sprint 1](#Sprint-1)

## Overview
### Description
Covid app to keep track of a person's covid status, vaccinations, etc. Uses QR code to keep track of what location/building they have entered. The QR code is assigned to each locations. The app user has to scan the QR code to signal that they were at the location.

### App Evaluation
[Evaluation of your app across the following attributes]
- **Category:** Health, Social Networking
- **Mobile:** This app is mostly viable for mobile, since the app uses QR code(more applicable to phone cameras). However on the server side, viewing data, generating QR code, etc could be viable on computers
- **Story:** Buildings can each generate their own QR code to identify the location. User scans the QR code when they enter the location.
- **Market:** It's good for big organization that uses a lot of buildings/areas (i.e. universities, big tech companies).
- **Habit:** Used when entering buildings and also checking who have entered the building at what time.
- **Scope:** First, we would create a login and saving the accounts info into a server (parse server). Separate into 2 types of accounts. 1: areas(QR generator). 2: user(QR scanners).

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* User can create a new account
* User can login
* User can upload Covid-19 Vaccination Record Card
* User can upload their Covid-19 testing
* User can scan QR code to check-in
* User can view last chick-in pass and information(time and location)
* User can check-out by themselves 
* User can refresh data 
* User can see history records 
* User can add frequented places to favorites
* 

**Optional Nice-to-have Stories**

* User can see posible exposures 
* User can change language
* User can use "hey Siri", or tap the back of your phone to add shortcuts
* User can manage family members 

### 2. Screen Archetypes

* Login Screen
   * User can login
* Registration Screen
   * User can create a new account (person or location)
* Stream Screen (person)
   * User can scan QR code to check-in
   * User can check-out by themselves
   * User can see history of locations they have entered
   * User can see their vacination card
   * User can see their covid testing results
* Stream Screen (location)
   * User can generate/re-generate QR code
   * User can see history of people who accessed the location
* Setting/Profile Screen (person)
   * User can manage account
   * User can change language (Optional)
   * User can manage family members (Optional)
   * User can add shortcuts (Optional)
* Setting Screen (location)
   * 

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Home 
* Scan QR Code
* Settings

**Flow Navigation** (Screen to Screen)

* Forced Login Screen
   * if no log in is available => Registration screen
   * if successfully logged in => Home 
* Registration Screen
   * => Home 
* Home (person)
   * => scan QR code(camera)
   * => Setting Screen
   * => upload vaccination card (camera)
   * => upload covid test results
   * view history of locations (maybe different screen)
* Home (location)
   * => Setting Screen
   * view QR code/re-generate QR code
   * view history of people (maybe different screen)
* Setting Screen

## Wireframes
[Add picture of your hand sketched wireframes in this section]
<img src="https://i.imgur.com/56HV0Cm.jpg" width=600>
<img src="https://i.imgur.com/2A5wTma.jpg" width=600>


### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype

## Schema 
[This section will be completed in Unit 9]
### Models

   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | username      | String   | user' name |
   | password      | String   | user's password |
   | email address | String   | user's email address|
   | gender        | String   | user's gender |
   | DOB           | DateTime | user's DOB  |
   | phone number  | Number   | user's phone number |
   | address       | String   | user's address |
   | user image    | File     | user's image |
   | QR Code       | File     | QR Code for endering building |
   | vaccination card | File  | user's vaccination card |
   | test date     | DateTime | vaccinate date  |

### Networking
- Home Feed Screen
    - (Read/GET) Query vaccination card information where user is author
- Scan QR Code Screen
    - (Create/POST) Scan new QR code
- History Screen
    - (Read/GET) Query pass history 
- Profile Screen
    - (Read/GET) Query logged in user object
    - (Update/PUT) Update user profile image
- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]

## Sprint 1

### What we achieved
- Designed logo/Icon of App
- Launchscreen design
- Login/Signup functionality
    - User stays signed in
    - User can log out
    - User can choose type of account when signing up (user/location)
    - Login segues to different set of screens depending on the type account
- Home screen for user/location
    - Apply wireframes into UI in Xcode (non-functional)

### Video Walkthrough

Here's a walkthrough of implemented user stories:

Launchscreen shows when opening app. User signs up as a user type account.

<img src='https://media1.giphy.com/media/VFcJSEUmV0Qqf5DlAb/giphy.gif?cid=790b76115075d8c552ece741280a86563c0b18a60945939f&rid=giphy.gif&ct=g' title='Launch Screen and Sign Up' width='' alt='Video Walkthrough' />

User can logout of account and sign back in. User can see their unable password security.

<img src='https://media4.giphy.com/media/N53dMY6aJxNLTVOYEL/giphy.gif?cid=790b76115efb5c8dfcaef717b4c2325b09731160d06a3782&rid=giphy.gif&ct=g' title='Log Out and Password Security' width='' alt='Video Walkthrough' />

User stays signed in upon restarting app.

<img src='https://media4.giphy.com/media/P1H1hz2lw5UkPmXudx/giphy.gif?cid=790b7611c93c8b900ab536072bbd78783b4ef1de5c81b2df&rid=giphy.gif&ct=g' title='Stay Signed In' width='' alt='Video Walkthrough' />

User signs up as a location type account.

<img src='https://media1.giphy.com/media/9wryFVOgrIf3k8iqgd/giphy.gif?cid=790b7611b2defc4af512a8b0001180ccfbd1f104fe515d26&rid=giphy.gif&ct=g' title='Location Account' width='' alt='Video Walkthrough' />

## Sprint 2

### What we achieved
- location type account can regenerate/generate QR code
- location type account can access settings 
- user can not create an existing username 
- user can not create a username lower than 5 characters
- user can not create a password lower than 6 characters

### Video Walkthrough

Location type account can navigate through navigation bar to access settings.

<img src='http://g.recordit.co/YpzDPmkCQw.gif' title='Location Settings' width='' alt='Video Walkthrough' />

Location type account can generate/regenerate a unique QR code.

<img src='https://media3.giphy.com/media/L82JW1BgYkSOofDI2U/giphy.gif?cid=790b76111cf5b6c8100cb655c22f13fc7bf53d09f540ca21&rid=giphy.gif&ct=g' title='QR code generating' width='' alt='Video Walkthrough' />

User can not create a username with an already existing username.

<img src='https://media4.giphy.com/media/bqv7gmrW4ZD1WajmIT/giphy.gif?cid=790b7611d17da0b65db70eddb1d3a82b3d2e3648c2da393c&rid=giphy.gif&ct=g' title='no repeat username' width='' alt='Video Walkthrough' />

User can not create a username that is less than 5 characters long.

<img src='https://media3.giphy.com/media/5v1BeRxOLr1srIlq7U/giphy.gif?cid=790b76111310b5e44679fb9af2ae289af53aa9a304093198&rid=giphy.gif&ct=g' title='create username requirement' width='' alt='Video Walkthrough' />

User can not create a password that is less than 6 characters long.

<img src='https://media3.giphy.com/media/tyHt3HcF3Gmn7mAkZG/giphy.gif?cid=790b761169a32ac0ef1f4a0acbe402d4d72472f5a4bbeb4a&rid=giphy.gif&ct=g' title='create password requirement' width='' alt='Video Walkthrough' />

## Sprint 3

### What we achieved
- user type account can upload an image from photo library for their vaccination card.
- user type account can scan QR code.
- user type account can view history of locations they have accessed
- location type account can save the QR code into photo library.
- location type account can view history of users that accessed the location
- location/user type account can view FAQ to understand how to use the app

### Video Walkthrough

User type account can upload an image from photo library for their vaccination card.

<img src='https://media4.giphy.com/media/qfCcHCVEkCc09y0u5E/giphy.gif?cid=790b761177a6711acc12b9002135e63286827b69b2f4f852&rid=giphy.gif&ct=g' title='upload vac card' width='' alt='Video Walkthrough' />

User type account can scan QR code to check in to a location. User type account can view history of locations they have accessed and the last checked in location.

<img src='https://media1.giphy.com/media/0lSnqTiMNGR1Ck0MZJ/giphy.gif?cid=790b761198d4a39f6215c22fa31e27fb0d0a4c4e5794203d&rid=giphy.gif&ct=g' title='scan QR code to check in' width='' alt='Video Walkthrough' />

Location type account can view history of users that accessed the location

<img src='https://media3.giphy.com/media/ay73X5uA9Oyswy4v1a/giphy.gif?cid=790b7611f486d36c80ab1964b185f2074cbf20e59ac2479c&rid=giphy.gif&ct=g' title='Location view history' width='' alt='Video Walkthrough' />

Location/user type account can view FAQ to understand how to use the app.

<img src='https://media4.giphy.com/media/da1za8hFV6iTrEtNm5/giphy.gif?cid=790b76119c4c80d2abeef48e28e9502476730b31180dc968&rid=giphy.gif&ct=g' title='FAQ' width='' alt='Video Walkthrough' />

Location type account can save the QR code into photo library.

<img src='https://media2.giphy.com/media/tq92opMIS5DBHmLcQD/giphy.gif?cid=790b761153eeef3d1b1b065ff4c93da320a5d14286b91b77&rid=giphy.gif&ct=g' title='savinging qr code' width='' alt='Video Walkthrough' />
