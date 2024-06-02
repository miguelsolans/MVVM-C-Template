# MVVM-C iOS Template

The present application is a template for a MVVM-C oriented architecture. 
This template offers a couple of core functionalities which can be easily incorporated/adapted as per project requirements. In the below sections, we cover these features and how can a developer incorporate them.

## CoreKit

### AppCoordinator 

TBD 

### Coordinator

TBD 

### ViewModel

TBD

### Client

TBD

## Session Manager

### Google Sign-in

Although the template provides Google Authentication feature out of the box, app client setup is required, such can be configured at a project. 
As a requisite, one must create a Google Developer console and obtain App client identifier key's. 

These key's can be injected upon App build in the Xcode Configuration files. Look for properties `GID_CLIENT_ID` and `GID_REVERSED_ID`


```
// Google Sign-in client identifier
GID_CLIENT_ID=Client ID provided by Google console

// Google Sign-in client reversed identifier
GID_REVERSED_ID=Reverse Client ID provided by Google console
```

For Google console creation and set-up, please follow the Google tutorial in [this link](https://developers.google.com/identity/sign-in/ios/start-integrating)

## Requirements

- iOS 16.0
- Xcode 15.0
