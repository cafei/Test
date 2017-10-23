Pod::Spec.new do |s|

s.name         = "CafeiSDKBitcode"
s.version      = "1.1.4"
s.summary      = "CafeiSDK for Cocoapods convenience."
s.homepage     = "http://magicwindow.cn/"
s.license      = "MIT"
s.author       = { "MagicWindow" => "jiafei.liu@magicwindow.cn" }
s.source       = { :git => "https://github.com/cafei/Test.git", :tag => "#{s.version}" }
 
s.platform     = :ios, "7.0"
s.requires_arc = true
s.source_files = "MagicWindowSDK/MagicWindowSDKBitcode/*.{h,m}"
s.public_header_files = "MagicWindowSDK/MagicWindowSDKBitcode/*.h"
s.resource     = "MagicWindowSDK/MagicWindowSDKBitcode/MagicWindow.bundle"
s.preserve_paths = "MagicWindowSDK/MagicWindowSDKBitcode/libMagicWindowSDK.a"
s.vendored_libraries = "MagicWindowSDK/MagicWindowSDKBitcode/libMagicWindowSDK.a"
s.xcconfig = {
'LIBRARY_SEARCH_PATHS' => '"$(PODS_ROOT)/MagicWindowSDK/MagicWindowSDKBitcode"',
'HEADER_SEARCH_PATHS' => '"$(PODS_ROOT)/MagicWindowSDK/MagicWindowSDKBitcode"'
}
s.dependency "CafeiSDK"
s.dependency "WechatOpenSDK"
s.dependency "MJRefresh"
s.dependency "SDWebImage"

end
