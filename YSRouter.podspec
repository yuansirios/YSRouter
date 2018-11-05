#
# Be sure to run `pod lib lint YSRouter.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'YSRouter'
  s.version          = '0.0.1'
  s.summary          = '自己YY的组件路由器，简单实现功能，供参考交流'

  s.homepage         = 'https://github.com/yuansirios/YSRouter'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'yuansirios' => 'yuansir_ios@163.com' }
  s.source           = { :git => 'https://github.com/yuansirios/YSRouter.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'YSRouter/Classes/**/*'

  s.requires_arc = true

  non_arc_files = 'YSRouter/Classes/NSObject+YSRouter.{h,m}'

  s.exclude_files = non_arc_files

  s.subspec 'no-arc' do |sp|
    sp.source_files = non_arc_files
    sp.requires_arc = false
  end

end
