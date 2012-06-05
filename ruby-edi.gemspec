Gem::Specification.new do |s|
  s.name        = 'ruby-edi'
  s.version     = '0.0.1'
  s.date        = '2012-04-24'
  s.summary     = "A gem to build simple EDI files"
  s.description = 'A gem to build simple EDI files, for now only handling X12, but hey, if you want to add to it please be my guest'
  s.authors     = ['Daniel LaBare']
  s.email       = 'dlabare@gmail.com'
  s.files       = Dir.glob("{config,lib}/**/*") + %w(LICENSE.txt README.rdoc Rakefile)
  s.homepage    = 'https://github.com/dlabare/ruby-edi'
end