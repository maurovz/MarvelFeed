# Marvel Feed App

## Targets

App is divided in two targets:

1.  **FeedFeature:** Contains User model, network client for downloading data and JSON Parsing. 
2.  **MarvelFeedi:** Contains ViewModels, Controller and View. 

![](/targets.png)

## Tests

![](/tests.png)

## External libraries

- SnapshotTesting for testing UI

https://github.com/pointfreeco/swift-snapshot-testing

## Snapahot tests

Snapshots were recorded using **Xcode Version 13** and **iPhone 12** simulator. Tests will fail when running them with different simulator or different Xcode version.

Light Mode             |  Dark Mode
:-------------------------:|:-------------------------:
![](/light.png)  |  ![](/dark.png)
## Marvel Feed App Architecture

![imagen](/architecture.png)