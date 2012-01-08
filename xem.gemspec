# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "xem"
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Vilius Luneckas"]
  s.date = "2012-01-08"
  s.description = "Simple 3D engine based on Glfw"
  s.email = "vilius.luneckas@gmail.com"
  s.extra_rdoc_files = ["LICENSE.txt", "README", "README.rdoc", "lib/ext/array.rb", "lib/ext/ext.rb", "lib/ext/extendings.rb", "lib/ext/symbol.rb", "lib/xem.rb", "lib/xem/cache.rb", "lib/xem/camera.rb", "lib/xem/console.rb", "lib/xem/constants.rb", "lib/xem/font_manager.rb", "lib/xem/helpers.rb", "lib/xem/keyboard.rb", "lib/xem/metrics.rb", "lib/xem/mouse.rb", "lib/xem/point.rb", "lib/xem/settings.rb", "lib/xem/simple_draw.rb", "lib/xem/sky_box.rb", "lib/xem/version.rb", "lib/xem/xem.rb"]
  s.files = ["LICENSE.txt", "README", "README.rdoc", "Rakefile", "examples/data/fonts/simple.tga", "examples/data/images/interstellar.tga", "examples/movement.rb", "examples/simple.rb", "examples/sky_box.rb", "examples/using_cache.rb", "examples/using_integrated_console.rb", "lib/ext/array.rb", "lib/ext/ext.rb", "lib/ext/extendings.rb", "lib/ext/symbol.rb", "lib/xem.rb", "lib/xem/cache.rb", "lib/xem/camera.rb", "lib/xem/console.rb", "lib/xem/constants.rb", "lib/xem/font_manager.rb", "lib/xem/helpers.rb", "lib/xem/keyboard.rb", "lib/xem/metrics.rb", "lib/xem/mouse.rb", "lib/xem/point.rb", "lib/xem/settings.rb", "lib/xem/simple_draw.rb", "lib/xem/sky_box.rb", "lib/xem/version.rb", "lib/xem/xem.rb", "spec/ext/array_spec.rb", "spec/ext/symbol_spec.rb", "spec/spec_helper.rb", "spec/xem/helpers_spec.rb", "xem.gemspec", "xem.komodoproject", "Manifest"]
  s.homepage = "https://github.com/ViliusLuneckas/xem/"
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Xem", "--main", "README"]
  s.require_paths = ["lib"]
  s.rubyforge_project = "xem"
  s.rubygems_version = "1.8.10"
  s.summary = "Simple 3D engine based on Glfw"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<ruby-opengl>, [">= 0"])
      s.add_runtime_dependency(%q<ruby-glfw>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<mocha>, [">= 0"])
    else
      s.add_dependency(%q<ruby-opengl>, [">= 0"])
      s.add_dependency(%q<ruby-glfw>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<mocha>, [">= 0"])
    end
  else
    s.add_dependency(%q<ruby-opengl>, [">= 0"])
    s.add_dependency(%q<ruby-glfw>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<mocha>, [">= 0"])
  end
end
