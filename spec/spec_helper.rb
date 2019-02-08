require 'rspec-puppet'

fixture_path = File.join(File.dirname(File.expand_path(__FILE__)), 'fixtures')

RSpec.configure do |c|
  c.module_path     = File.join(fixture_path, 'modules')
#  c.classes_dir     = File.join(fixture_path, 'classes')
#  c.classes         = File.join(fixture_path, 'manifests', 'init_spec.rb')
  c.environmentpath = File.join(Dir.pwd, 'spec')
end
