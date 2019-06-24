# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'AFEiOS' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for AFEiOS

  target 'AFEiOSTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'AFEiOSUITests' do
    inherit! :search_paths
    # Pods for testing
  end

    flutter_application_path = '/Users/nirav/AndroidStudioProjects/FlutterModuleDemo/afe_flutter/'
    eval(File.read(File.join(flutter_application_path, '.ios', 'Flutter', 'podhelper.rb')), binding)


end
