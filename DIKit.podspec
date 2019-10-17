Pod::Spec.new do |s|
  s.name = "DIKit"
  s.version = "1.2.0"
  s.license = { :type => "MIT", :file => "LICENSE" }

  s.summary = "Dependency Injection Framework for Swift."
  s.homepage = "https://github.com/Liftric/DIKit"

  s.authors = { "Ben John" => "github@benjohn.de" }
  s.social_media_url = "http://twitter.com/benjohnde"

  s.platform         = :ios, "9.0"
  s.swift_version    = "5.1"

  s.source           = { :git => "https://github.com/benjohnde/DIKit.git", :tag => "#{s.version}" }

  s.source_files      = "DIKit/Sources/**/*.{swift}"
  s.requires_arc = true
end
