platform :ios, '9.0'
use_frameworks!
inhibit_all_warnings!

target 'SweetPea' do
    pod 'RealmSwift'
    pod 'FeedKit', '~> 5.0'
    pod 'Lepton' , :git => 'https://github.com/younata/Lepton.git'
    pod 'RxSwift', '~> 3.0'
    pod 'RxCocoa', '~> 3.0'
    pod 'RxBlocking', '~> 3.0'

    target 'SweetPeaTests' do
        inherit! :search_paths
        pod 'Quick'
        pod 'Nimble'
    end
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0.2'
        end
    end
end


