Gem::Specification.new do |s|
  s.name = %q{localized_country_select}
  s.version = "0.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Chris McGrath", "LIM SAS", "Damien MATHIEU", "Julien SANCHEZ", "Herv\303\251 GAUCHER"]
  s.date = %q{2011-01-18}
  s.description = %q{Where are you from ?}
  s.email = %q{chris@octopod.info}
  s.extra_rdoc_files = [
    "README.rdoc"
  ]
  s.files = [
    ".gitignore",
     "MIT-LICENSE",
     "README.rdoc",
     "Rakefile",
     "init.rb",
     "install.rb",
     "lib/localized_country_select.rb",
     "lib/tasks/localized_country_select_tasks.rake",
     "test/localized_country_select_test.rb",
     "uninstall.rb"
  ]
  s.homepage = %q{http://github.com/chrismcg/localized_country_select}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Localized country select list}
  s.test_files = [
    "test/localized_country_select_test.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end

