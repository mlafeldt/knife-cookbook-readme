require "chef/cookbook/metadata"

module KnifeCookbookReadme
  class Metadata
    def self.from_file(filename)
      metadata = Chef::Cookbook::Metadata.new
      metadata.from_file(filename)
      metadata
    end
  end
end
