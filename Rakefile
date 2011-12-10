# encoding: utf-8

require 'rubygems'
require 'rake'
require 'echoe'
require './lib/xem/version.rb'
Echoe.new('xem', Xem::VERSION) do |gem|
  gem.description = "Simple 3D engine based on Glfw"
  gem.url = "https://github.com/ViliusLuneckas/xem/"
  gem.email = "vilius.luneckas@gmail.com"
  gem.author = "Vilius Luneckas"
  gem.ignore_pattern = ["tmp/*", "script/*"]
  gem.development_dependencies = ['rspec', 'mocha']
  gem.runtime_dependencies = ['ruby-opengl', 'ruby-glfw']
end
