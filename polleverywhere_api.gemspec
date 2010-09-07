# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{polleverywhere_api}
  s.version = "0.0.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ryan Wilcox"]
  s.date = %q{2010-09-06}
  s.description = %q{A Ruby wrapper for the PollEverywhere API}
  s.email = ["rwilcox@wilcoxd.com"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "PostInstall.txt"]
  s.files = ["History.txt", "Manifest.txt", "PostInstall.txt", "README.rdoc", "Rakefile", "lib/gem_dependancies.rb", "lib/polleverywhere_api.rb", "lib/polleverywhere_api/connection_mixin.rb", "lib/polleverywhere_api/poll.rb", "lib/polleverywhere_api/user.rb", "polleverywhere_api.gemspec", "script/console", "script/destroy", "script/generate", "test/test_helper.rb", "test/test_poll.rb", "test/test_polleverywhere_api.rb", "test/test_user.rb"]
  s.homepage = %q{http://github.com/rwilcox/polleverywhere_api}
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{polleverywhere_api}
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{A Ruby wrapper for the PollEverywhere API}
  s.test_files = ["test/test_helper.rb", "test/test_poll.rb", "test/test_polleverywhere_api.rb", "test/test_user.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<json_pure>, [">= 1.4.6"])
      s.add_runtime_dependency(%q<required>, [">= 0.1.3"])
      s.add_development_dependency(%q<rubyforge>, [">= 2.0.4"])
      s.add_development_dependency(%q<hoe>, [">= 2.6.2"])
    else
      s.add_dependency(%q<json_pure>, [">= 1.4.6"])
      s.add_dependency(%q<required>, [">= 0.1.3"])
      s.add_dependency(%q<rubyforge>, [">= 2.0.4"])
      s.add_dependency(%q<hoe>, [">= 2.6.2"])
    end
  else
    s.add_dependency(%q<json_pure>, [">= 1.4.6"])
    s.add_dependency(%q<required>, [">= 0.1.3"])
    s.add_dependency(%q<rubyforge>, [">= 2.0.4"])
    s.add_dependency(%q<hoe>, [">= 2.6.2"])
  end
end
