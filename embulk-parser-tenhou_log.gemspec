
Gem::Specification.new do |spec|
  spec.name          = "embulk-parser-tenhou_log"
  spec.version       = "0.1.0"
  spec.authors       = ["flada-auxv"]
  spec.summary       = "Tenhou Log parser plugin for Embulk"
  spec.description   = "Parses Tenhou Log files read by other file input plugins."
  spec.email         = ["aseknock@gmail.com"]
  spec.licenses      = ["MIT"]
  # TODO set this: spec.homepage      = "https://github.com/aseknock/embulk-parser-tenhou_log"

  spec.files         = `git ls-files`.split("\n") + Dir["classpath/*.jar"]
  spec.test_files    = spec.files.grep(%r{^(test|spec)/})
  spec.require_paths = ["lib"]

  #spec.add_dependency 'YOUR_GEM_DEPENDENCY', ['~> YOUR_GEM_DEPENDENCY_VERSION']
  spec.add_development_dependency 'embulk', ['>= 0.8.11']
  spec.add_development_dependency 'bundler', ['>= 1.10.6']
  spec.add_development_dependency 'rake', ['>= 10.0']
end
