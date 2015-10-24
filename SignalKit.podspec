Pod::Spec.new do |s|

  s.name         = "SignalKit"
  s.version      = "2.0.0"
  s.summary      = "SignalKit is a type safe event and binding framework"

  s.description  = <<-DESC
                   SignalKit is a type safe event and binding Swift framework with great focus on clean and readable API
                   DESC

  s.homepage     = "https://github.com/yankodimitrov/SignalKit"
  s.license      = { :type => "MIT", :file => "LICENSE.txt" }
  s.author       = { "Yanko Dimitrov" => "yanko@yankodimitrov.com" }
  s.social_media_url   = "https://twitter.com/_yankodimitrov"

  s.ios.platform = :ios, "8.0"
  s.ios.deployment_target = "8.0"

  s.osx.platform = :osx, "10.10"
  s.osx.deployment_target = "10.10"

  s.source       = { :git => "https://github.com/yankodimitrov/SignalKit.git", :tag => "v#{s.version}" }
  s.ios.source_files  = ["SignalKit", "SignalKit/Observables", "SignalKit/Observables/UIKit", "SignalKit/Observables/ArrayEventStrategies", "SignalKit/Protocols", "SignalKit/Utilities", "SignalKit/Extensions", "SignalKit/Extensions/UIKit"]
  s.osx.source_files  = ["SignalKit", "SignalKit/Observables", "SignalKit/Observables/ArrayEventStrategies", "SignalKit/Protocols", "SignalKit/Utilities", "SignalKit/Extensions", "SignalKit/Extensions/AppKit"]

  s.requires_arc = true

end
