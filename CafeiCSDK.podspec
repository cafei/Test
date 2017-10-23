Pod::Spec.new do |s|

s.name         = "CafeiCSDK"
s.version      = "1.1.4"
s.summary      = "CafeiCSDK for Cocoapods convenience."
s.homepage     = "http://magicwindow.cn/"
s.license      = "MIT"
s.author       = { "MagicWindow" => "jiafei.liu@magicwindow.cn" }
s.source       = { :git => "https://github.com/cafei/Test.git", :tag => "#{s.version}" }
s.platform     = :ios, "7.0"
s.requires_arc = true
s.source_files = "MWContentSDK/MWContentSDK/*.{h,m}"
s.public_header_files = "MWContentSDK/MWContentSDK/*.h"
s.resource     = "MWContentSDK/MWContentSDK/*.png"
s.preserve_paths = "MWContentSDK/MWContentSDK/libMWContentSDK.a"
s.vendored_libraries = "MWContentSDK/MWContentSDK/libMWContentSDK.a"
s.xcconfig = {
'LIBRARY_SEARCH_PATHS' => '"$(PODS_ROOT)/CafeiCSDK/MWContentSDK/MWContentSDK"',
'HEADER_SEARCH_PATHS' => '"$(PODS_ROOT)/MWContentSDK/MWContentSDK"'
}
s.dependency "WechatOpenSDK"
s.dependency "MJRefresh"
s.dependency "SDWebImage"


end
