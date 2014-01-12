Pod::Spec.new do |s|
  s.name        = 'RETableViewManager'
  s.version     = '1.5.7'
  s.authors     = { 'Roman Efimov' => 'romefimov@gmail.com' }
  s.homepage    = 'https://github.com/romaonthego/RETableViewManager'
  s.summary     = 'Powerful data driven content manager for UITableView.'
  s.source      = { :git => 'https://github.com/romaonthego/RETableViewManager.git',
                    :tag => '1.5.7' }
  s.license     = { :type => "MIT", :file => "LICENSE" }

  s.platform = :ios, '6.0'
  s.requires_arc = true
  s.source_files = 'RETableViewManager/Cells', 'RETableViewManager/Items', 'RETableViewManager'
  s.public_header_files = 'RETableViewManager/Cells/*.h', 'RETableViewManager/*.h', 'RETableViewManager/Items/*.h'
  
  s.pre_install do |pod, target_definition|
    Dir.chdir(pod.root) do
      command = "xcodebuild -project RETableViewManager/RETableViewManager.xcodeproj -target Resources CONFIGURATION_BUILD_DIR=../RETableViewManager.bundle"
      unless system(command)
        raise ::Pod::Informative, "Failed to generate RETableViewManager resources bundle"
      end
    end
  end
  s.resources = 'RETableViewManager/RETableViewManager.bundle'

  s.ios.deployment_target = '6.0'

  s.dependency 'REFormattedNumberField', '~> 1.1.1'
  s.dependency 'REValidation', '~> 0.1.4'
end
