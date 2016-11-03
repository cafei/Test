Pod::Spec.new do |s|

  s.name         = "CafeiSDK"
  s.version      = "1.0"
  s.summary      = "MagicWindowSDK for Cocoapods convenience."
  s.homepage     = "http://magicwindow.cn/"
  s.license      = "MIT"
  s.author       = { "Cafei" => "jiafei.liu@magicwindow.cn" }
  s.source       = { :git => "https://github.com/cafei/Test.git", :tag => "#{s.version}" }
  s.platform     = :ios, "7.0"
  s.requires_arc = true
  s.frameworks = "AdSupport","CoreTelephony","CoreGraphics","CoreFoundation","SystemConfiguration","CoreLocation"

  s.default_subspec = 'Cafei'

  s.subspec 'Cafei' do |c|
    c.source_files = "MagicWindowSDK/MagicWindowSDK/*.{h,m}"
    c.public_header_files = "MagicWindowSDK/MagicWindowSDK/*.h"
    c.resource     = "MagicWindowSDK/MagicWindowSDK/MagicWindow.bundle"
    c.preserve_paths = "MagicWindowSDK/MagicWindowSDK/libMagicWindowSDK.a"
    c.vendored_libraries = "MagicWindowSDK/MagicWindowSDK/libMagicWindowSDK.a"
    c.xcconfig = {
        'LIBRARY_SEARCH_PATHS' => '$(PODS_ROOT)/MagicWindowSDK/MagicWindowSDK',
        'HEADER_SEARCH_PATHS' => '$(PODS_ROOT)/MagicWindowSDK/MagicWindowSDK'
    }
    c.libraries = "z","sqlite3.0"
  end

  # WeChat
  s.subspec 'WeChat' do |sp|
  sp.vendored_libraries = "MagicWindowSDK/WeChat/*.a"
  sp.source_files = "MagicWindowSDK/WeChat/*.{h,m}"
  sp.public_header_files = "MagicWindowSDK/WeChat/*.h"
  sp.libraries = "sqlite3","c++"
  sp.dependency 'CafeiSDK/Cafei'
  end

end
