Original App Design Project - README Template
===

# CovidPass

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

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
