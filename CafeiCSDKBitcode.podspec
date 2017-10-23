Pod::Spec.new do |s|

s.name         = "CafeiCSDKBitcode"
s.version      = "1.1.4"
s.summary      = "CafeiCSDKBitcode for Cocoapods convenience."
s.homepage     = "http://magicwindow.cn/"
s.license      = "MIT"
s.author       = { "MagicWindow" => "jiafei.liu@magicwindow.cn" }
s.source       = { :git => "https://github.com/cafei/Test.git", :tag => "#{s.version}" }
 
s.platform     = :ios, "7.0"
s.requires_arc = true
s.source_files = "MWContentSDK/MWContentSDKBitcode/*.{h,m}"
s.public_header_files = "MWContentSDK/MWContentSDKBitcode/*.h"
s.resource     = "MWContentSDK/MWContentSDKBitcode/*.png"
s.preserve_paths = "MWContentSDK/MWContentSDKBitcode/libMWContentSDK.a"
s.vendored_libraries = "MWContentSDK/MWContentSDKBitcode/libMWContentSDK.a"
s.xcconfig = {
'LIBRARY_SEARCH_PATHS' => '"$(PODS_ROOT)/MWContentSDK/MWContentSDKBitcode"',
'HEADER_SEARCH_PATHS' => '"$(PODS_ROOT)/MWContentSDK/MWContentSDKBitcode"'
}
s.dependency "WechatOpenSDK"
s.dependency "MJRefresh"
s.dependency "SDWebImage"

end
