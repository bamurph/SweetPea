platform :ios, '9.0'
use_frameworks!

target 'SweetPea' do
    pod 'FeedKit', '~> 5.0'
    pod 'Lepton' , :git => 'https://github.com/younata/Lepton.git'
    pod 'RxSwift', '~> 3.0'
    pod 'RxCocoa', '~> 3.0'
    pod 'RxBlocking', '~> 3.0'

    abstract_target 'Tests' do
        inherit! :search_paths

        ## - Testing
        pod 'Quick'
        pod 'Nimble'

        target 'SweetPeaTests'

    end

end


