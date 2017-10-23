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
s.source_files = "MWContentSDKBitcode/*.{h,m}"
s.public_header_files = "MWContentSDKBitcode/*.h"
s.resource     = "MWContentSDKBitcode/*.png"
s.preserve_paths = "MWContentSDKBitcode/libMWContentSDK.a"
s.vendored_libraries = "MWContentSDKBitcode/libMWContentSDK.a"
s.xcconfig = {
'LIBRARY_SEARCH_PATHS' => '"$(PODS_ROOT)/CafeiCSDKBitcode/MWContentSDKBitcode"',
'HEADER_SEARCH_PATHS' => '"$(PODS_ROOT)/CafeiCSDKBitcode/MWContentSDKBitcode"'
}
s.frameworks = "AdSupport","CoreTelephony","CoreGraphics","CoreFoundation","SystemConfiguration","CoreLocation"
s.dependency "MJRefresh"
s.dependency "SDWebImage"
s.dependency "MagicWindowSDKBitcode"
s.dependency "WechatOpenSDK"

end
