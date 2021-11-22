#
# Be sure to run `pod lib lint YYRouter.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'YYRouter'
  s.version          = '0.0.2'
  s.summary          = 'YYRouter路由组件.'

  s.description      = <<-DESC
  YYRouter一个简单好用的swift路由组件.
                       DESC

  s.homepage         = 'https://github.com/yxh265/YYRouter'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'yxh265' => 'yxh265@qq.com' }
  s.source           = { :git => 'https://github.com/yxh265/YYRouter.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'
  s.swift_version = '5.0'
  s.subspec 'YYRouter' do |a|
      a.source_files = 'YYRouter/Classes/YYRouter/*'
  end
end
