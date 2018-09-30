# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'marvelproj' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  plugin 'cocoapods-keys', {
      :project => "marvelproj",
      :target => "marvelproj",
      :keys => [
      "marvelprojAPIClientPublic",
      "marvelprojAPIClientPrivate",
      ]}
  # Pods for marvelproj
  pod 'R.swift'
  pod 'SwiftyJSON', '~> 4.0'
  pod 'RxAlamofire'
  pod 'Kingfisher', '~> 4.0'

  target 'marvelprojTests' do
    inherit! :search_paths
    # Pods for testing
     pod 'KIF', :configurations => ['Debug']
  end


end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '4.0'
        end
    end
end
