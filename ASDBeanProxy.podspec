Pod::Spec.new do |s|
  s.name         = "ASDBeanProxy"
  s.version      = "0.0.1"
  s.summary      = "A Wrapper for Light Blue Bean functionality ."
  s.homepage     = "https://github.com/hpcloud/HPCSMist"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Mike Hagedorn" => "mike@silverchairsolutions.com" }
  s.source       = { :git => "https://github.com/hpcloud/HPCSMist.git", :tag => "0.3.2"  }
  s.ios.deployment_target = '6.0'
  s.osx.deployment_target = '10.7'
  s.source_files = 'ASDBeanProxy/**/*.{h,m}'
  s.requires_arc = true
end