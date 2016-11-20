# Uncomment this line to define a global platform for your project
# platform :ios, '8.0'
# Uncomment this line if you're using Swift
use_frameworks!

target 'ShoeBox' do
    pod 'RxSwift'
    pod 'RxCocoa'
    pod 'Firebase/Database'
    pod 'ActionSheetPicker-3.0'
    pod 'SLExpandableTableView'
    pod 'WTGlyphFontSet'

end

target 'ShoeBoxTests' do

end

target 'ShoeBoxUITests' do

end

#Some libraries don't support the Swift 3.0 syntax.
#We make sure to enable legacy mode (Swift 2.3) until libraries are updated.
post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end
