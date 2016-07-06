
Pod::Spec.new do |s|

  s.name         = "NJBannerView"
  s.version      = "1.0.4"
  s.summary      = "design bannerView for iOS"
 # s.description  = <<-DESC
  #                 DESC

  s.homepage     = "https://github.com/Hijin/NJBannerView"
  s.license      = "MIT"
  s.author             = { "Hijin" => "1553877174@qq.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/Hijin/NJBannerView.git", :tag => "1.0.4" }

  s.source_files  = "NJBannerViewDemo/NJBannerViewDemo/NJBannerView/*.{h,m}"
  s.frameworks = "ImageIO", "Foundation"
  s.requires_arc = true
  s.dependency "SDWebImage","~>3.8"

end
