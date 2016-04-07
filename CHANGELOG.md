v0.3.0 (Apr 7 2016)
--------------------

* Add support slash in attribute

v0.2.1 (Sep 25 2013)
--------------------

* Change specs for `Metadata.from_file` and `Readme#render` to run against test
  fixtures.
* Remove `--constraints` option. If a version constraint is specified in
  metadata.rb, it should always be reflected in README.md.
* Remove support for Ruby 1.8.7, which has reached end of life.
* Use `require_relative`.
* Add `lib/knife_cookbook_readme.rb`, which requires all lib files.

v0.2.0 (Sep 22 2013)
--------------------

* Split up logic into `Metadata`, `Readme`, and `Template` classes. Add specs.
* Make `DEFAULT_CONSTRAINT` a module variable.

v0.1.3 (Sep 15 2013)
--------------------

* Add RSpec tests, including Rake task and Travis CI config.

README updates:

* Link to Opscode's metadata docs.
* Say that knife-cookbook-doc is based on knife-cookbook-readme.
* Add contributing guidelines.

v0.1.2 (Jul 17 2013)
--------------------

* Add title to generated README and decrease level of headings.
* Rename "templates" directory to "template".
* Add alternative Chef documentation tools to README.
* Remove Gemfile.lock.

v0.1.1 (Feb 20 2013)
--------------------

* Convert plugin into a gem that can be installed via RubyGems.
* Update README.
* Add this CHANGELOG file.

v0.1.0 (Dec 5 2012)
-------------------

* First tagged version.
