require_relative "../lib/knife_cookbook_readme/metadata"

module KnifeCookbookReadme
  describe "Metadata.from_file" do
    let(:fixtures_path) { File.expand_path("../fixtures", __FILE__) }

    it "reads metadata.rb of apache2 cookbook" do
      file = File.join(fixtures_path, "apache2-metadata.rb")
      metadata = Metadata.from_file(file)
      metadata.name.should == "apache2"
      metadata.platforms.should include "redhat"
    end

    it "reads metadata.rb of git cookbook" do
      file = File.join(fixtures_path, "git-metadata.rb")
      metadata = Metadata.from_file(file)
      metadata.name.should == "git"
      metadata.dependencies.should include "build-essential"
    end

    it "reads metadata.rb of mysql cookbook" do
      file = File.join(fixtures_path, "mysql-metadata.rb")
      metadata = Metadata.from_file(file)
      metadata.name.should == "mysql"
      metadata.attributes["mysql/data_dir"][:default].should == "/var/lib/mysql"
    end
  end
end
