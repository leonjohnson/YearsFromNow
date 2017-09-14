platform :ios, '11.0'
use_frameworks!

target 'YearsFromNow' do
    pod ‘RealmSwift’
    pod 'UnderKeyboard', git: 'https://github.com/marketplacer/UnderKeyboard.git', branch: 'swift-4.0'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '4.0'
    end
  end
end
