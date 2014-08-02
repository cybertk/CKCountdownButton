Pod::Spec.new do |s|
  s.name             = "CKCountdownButton"
  s.version          = "0.2.0"
  s.summary          = "Display a countdown timer on UIButton"
  s.homepage         = "https://github.com/cybertk/CKCountdownButton"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.authors          = { "Quanlong He" => "kyan.ql.he@gmail.com",
                         "Tomasz Szulc" => "mail@szulctomasz.com"
                       }
  s.source           = { :git => "https://github.com/cybertk/CKCountdownButton.git", :tag => s.version.to_s }
  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes'

  s.public_header_files = 'Pod/Classes/**/*.h'
end
