### Architecture prototype

1. Prerequisites
    - [XcodeGen](https://github.com/yonaskolb/XcodeGen)
    	`brew install xcodegen`
    - [Carthage](https://github.com/Carthage/Carthage)
    	`brew install carthage`    	
    - [Module Generator](https://github.com/1is10/lr-module-gen)
    	`npm i -g lr-module-gen` (requires npm, to install -> `brew install node`)
	- [Fastlane](https://docs.fastlane.tools/getting-started/ios/setup/)
		Will be installed from Gemfile
    - [Sourcery](https://github.com/krzysztofzablocki/Sourcery)
    	Will be installed with Cocoapods		  	

2. Installation and setup
    - Run command to install required gems
    	`bundle install`
    - Run command to create project
    	`bundle exec fastlane generate_workspace`
    - Run command to update project after adding new files
        `bundle exec fastlane update_workspace`        
