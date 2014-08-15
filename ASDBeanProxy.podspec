Pod::Spec.new do |s|
  s.name         = "ASDBeanProxy"
  s.version      = "0.0.4"
  s.summary      = "A Wrapper for LightBlue Bean (www.punchthrough.com/bean) functionality ."
  s.homepage     = "https://github.com/mwhagedorn/ASDBeanProxy"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Mike Hagedorn" => "mike@silverchairsolutions.com" }
  s.source       = { :git => "https://github.com/mwhagedorn/ASDBeanProxy.git" , :tag => "0.0.3" }
  s.osx.deployment_target = '10.9'
  s.source_files = 'ASDBeanProxy/**/*.{h,m}'
  s.requires_arc = true
  s.dependency 'Bean-iOS-OSX-SDK'
end