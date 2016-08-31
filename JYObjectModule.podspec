Pod::Spec.new do |s|

  s.name         = "JYObjectModule"
  s.version      = "0.0.12"
  s.summary      = "A module of models definition."
  s.description  = <<-DESC
                    A module of models definition on iOS platform for jiangyou tec. only.
                   DESC

  s.homepage     = "https://github.com/jiangtour/JYObjectModule"
  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author             = { "aiXing" => "862099730@qq.com" }
  s.platform     = :ios, "7.0"

  s.source       = { :git => "https://github.com/jiangtour/JYObjectModule.git", :tag => "0.0.12" }
  s.source_files  = "JYObjectModule/Models/*.{h,m}", "JYObjectModule/Models/Normal/*.{h,m}", "JYObjectModule/Models/Storage/*.{h,m}"

  s.frameworks = "Foundation"

  s.requires_arc = true
  s.dependency "Realm"
  s.dependency "MJExtension"
  s.dependency "SDWebImage"
  s.dependency "CocoaSecurity"
  s.dependency "UICKeyChainStore"

end