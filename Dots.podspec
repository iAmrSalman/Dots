Pod::Spec.new do |s|
  s.name         = "Dots"
  s.version      = "0.5.0"
  s.summary      = "Lightweight iOS Concurrent Networking Framework"
  s.description  = <<-DESC
    Lightweight iOS Concurrent Networking Framework that will make developing your Apps easire and faster
  DESC
  s.homepage     = "https://github.com/iAmrSalman/Dots"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Amr Salman" => "iamrsalman@gmail.com" }
  s.social_media_url   = "https://twitter.com/@iAmrSalman"
  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.9"
  s.watchos.deployment_target = "2.0"
  s.tvos.deployment_target = "9.0"
  s.source       = { :git => "https://github.com/iAmrSalman/Dots.git", :tag => s.version.to_s }
  s.source_files  = "Sources/**/*"
  s.frameworks  = "Foundation"
end
