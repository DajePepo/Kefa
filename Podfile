# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'kefa' do
  
  use_frameworks!

  # Pods for kefa
  pod 'RealmSwift'
  pod 'ReactiveCocoa', '~> 5.0.0'
  pod 'ReactiveSwift', '~> 1.0.0'

  # Pods for testing
  target 'kefaTests' do
    inherit! :search_paths
  end

  # Pods for UI testing
  target 'kefaUITests' do
    inherit! :search_paths
  end

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end
