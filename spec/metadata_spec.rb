require File.expand_path("../../lib/knife_cookbook_readme/metadata", __FILE__)

module KnifeCookbookReadme
  describe Metadata do
    context ".from_file" do
      it "calls Chef::Cookbook::Metadata#from_file to read metadata.rb" do
        file = double
        Chef::Cookbook::Metadata.any_instance.should_receive(:from_file).with(file)
        Metadata.from_file(file)
      end
    end
  end
end
