Pod::Spec.new do |s|
s.name = 'CBBlockKit'
s.version = '0.0.4'
s.license = 'MIT'
s.summary = 'Big blocks, get everything done.'
s.homepage = 'https://github.com/cbangchen/CBBlockKit'
s.authors = { 'cbangchen' => 'cbangchen007@gmail.com' }
s.source = { :git => 'https://github.com/cbangchen/CBBlockKit.git', :tag => s.version.to_s }
s.requires_arc = true
s.ios.deployment_target = '7.0'
s.source_files = "CBBlockKit/Category", "CBBlockKit/Controller", "CBBlockKit/Macros", "CBBlockKit/Protocol"
s.dependency "Masonry"
end