#
# Be sure to run `pod lib lint IconFactory.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'IconFactory'
  s.version          = '0.1.0'
  s.summary          = 'simple icon generator'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
A simple icon generator to use with specific icon style.
                       DESC

  s.homepage         = 'https://github.com/sergeysivak/IconFactory'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Sergey Sivak' => 'sergey.sivak@icloud.com' }
  s.source           = { :git => 'https://github.com/sergeysivak/IconFactory.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'Pod/Classes/*'
  
  # s.resource_bundles = {
  #   'IconFactory' => ['IconFactory/Assets/*.png']
  # }

  s.public_header_files = 'Pod/Classes/*.h'
  s.frameworks = 'UIKit'
  s.dependency 'FontAwesome.swift', '~> 0.8'
end
