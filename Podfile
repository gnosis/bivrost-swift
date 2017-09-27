target 'Bivrost' do
  use_frameworks!

  # Pods for Bivrost

end

target 'BivrostFramework' do
  use_frameworks!

  pod 'CryptoSwift', :git => 'https://github.com/zweigraf/CryptoSwift.git'
  pod 'BigInt', '~> 3.0'
  
  target 'BivrostFrameworkTests' do
    inherit! :search_paths
    
    pod 'Quick', :git => 'https://github.com/Quick/Quick.git'
    pod 'Nimble', :git => 'https://github.com/Quick/Nimble.git'
  end

end
