#
# Be sure to run `pod lib lint Bivrost.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Bivrost'
  s.version          = '0.1.0'
  s.summary          = '🔥 🌈 Bridge between Solidity Contracts and Swift'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Bivrost generates Swift classes to interact with Solidity contracts.
You supply the contract interface as a `.json` file and Bivrost generates Swift
files from it.
                       DESC

  s.homepage         = 'https://github.com/gnosis/bivrost-swift'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Luis Reisewitz' => 'https://twitter.com/zweigraf' }
  s.source           = { :git => 'https://github.com/gnosis/bivrost-swift.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/zweigraf'

  s.ios.deployment_target = '8.0'

  s.source_files = 'Bivrost/Classes/**/*'
  
  # s.resource_bundles = {
  #   'Bivrost' => ['Bivrost/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'CryptoSwift'
  s.dependency 'BigInt', '~> 3.0'
end
