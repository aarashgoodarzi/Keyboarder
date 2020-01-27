

Pod::Spec.new do |spec|


  spec.name         = "Keyboarder"
  spec.version      = "0.0.5"
  spec.summary      = "Handy Keyboard handling in swift"
  spec.description  = "Keyboard handling with many features by just a line of code!"
  spec.homepage     = "https://github.com/aarashgoodarzi/Keyboarder"
  # spec.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"
  spec.license      = "MIT"
  spec.author       = { "Arash Goodarzi" => "aarash.goodarzi@gmail.com" }
  spec.platform     = :ios, "11.0"
  spec.source       = { :git => "https://github.com/aarashgoodarzi/Keyboarder.git", :tag => "#{spec.version}" }
  spec.source_files = "Keyboarder/Source/*.{swift}"
  #spec.public_header_files = "Keyboarder/*.h"
  #spec.resource  = "icon.png"
  #spec.resources = "Resources/*.png"
  spec.framework = "UIKit"
  #spec.resources = "Resources/*.{plist,png,jpeg,jpg,storyboard,xib,xcassets}"
  spec.swift_version = ["4.2","5.0","5.1"]

end
