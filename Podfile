platform :ios, '14.0'

use_frameworks!

target 'SpievajmeH' do
  pod 'Kingfisher'
  pod 'RealmSwift', '~> 5.5.0'
  pod 'PKHUD'
end

swift_version_overrides = {
  'RealmSwift' => '4.2'
}

pre_install do |installer|
  installer.analysis_result.specifications
    .select { |spec| swift_version_overrides.key? spec.name }
    .each do |spec|
      spec.swift_versions << swift_version_overrides[spec.name] if spec.swift_versions.empty?
    end
end

post_install do |installer|
    require 'fileutils'
    FileUtils.cp_r('Pods/Target Support Files/Pods-SpievajmeH/Pods-SpievajmeH-acknowledgements.plist',
                   'SpievajmeH/Resources/Settings.bundle/Pods-SpievajmeH-acknowledgements.plist',
                   :remove_destination => true)

    puts 'Updated Acknowledgements 👌'
end

