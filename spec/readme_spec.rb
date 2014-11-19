require_relative "../lib/knife_cookbook_readme"

module KnifeCookbookReadme
  describe Readme do
    it "generates title from cookbook name" do
      cookbook_name = "cats"
      metadata = double(:metadata, :name => cookbook_name)
      readme = Readme.new(metadata)
      readme.title.should == "Cats Cookbook"
    end

    it "generates description" do
      description = double
      metadata = double(:metadata, :description => description)
      readme = Readme.new(metadata)
      readme.description.should == description
    end

    it "generates supported platforms" do
      platforms = { "debian" => "= 7", "ubuntu" => ">= 10.04" }
      metadata = double(:metadata, :platforms => platforms)
      readme = Readme.new(metadata)
      readme.platforms.should == ["Debian (= 7)", "Ubuntu (>= 10.04)"]
    end

    it "generates cookbook dependencies" do
      dependencies = { "cats" => "< 1.0", "dogs" => DEFAULT_CONSTRAINT }
      metadata = double(:metadata, :dependencies => dependencies)
      readme = Readme.new(metadata)
      readme.dependencies.should == ["cats (< 1.0)", "dogs"]
    end

    it "generates cookbook attributes" do
      attributes = {
        "pets/cat/name" => {
          "description" => "The name of your cat",
          "default"     => "Kitty",
        },
        "pets/dog/name" => {
          "description" => "The name of your dog",
          "default"     => "Barf",
        }
      }
      metadata = double(:metadata, :attributes => attributes)
      readme = Readme.new(metadata)
      readme.attributes.should == [
        ["node['pets']['cat']['name']", "The name of your cat", "Kitty"],
        ["node['pets']['dog']['name']", "The name of your dog", "Barf"],
      ]
    end

    it "generates recipes" do
      recipes = double
      metadata = double(:metadata, :recipes => recipes)
      readme = Readme.new(metadata)
      readme.recipes.should == recipes
    end

    it "generates author from maintainer name" do
      maintainer = double
      metadata = double(:metadata, :maintainer => maintainer)
      readme = Readme.new(metadata)
      readme.author.should == maintainer
    end

    it "generates author email from maintainer email" do
      maintainer_email = double
      metadata = double(:metadata, :maintainer_email => maintainer_email)
      readme = Readme.new(metadata)
      readme.author_email.should == maintainer_email
    end

    it "generates copyright year from current year" do
      time_now = Time.mktime(2013, 1, 1)
      Time.stub(:now).and_return(time_now)
      metadata = double
      readme = Readme.new(metadata)
      readme.copyright_year.should == time_now.year
    end

    it "generates license name" do
      license = double
      metadata = double(:metadata, :license => license)
      readme = Readme.new(metadata)
      readme.license.should == license
    end

    context "#render" do
      let(:template_file) { File.expand_path("../../template/README.md.erb", __FILE__) }
      let(:template)      { File.read(template_file) }
      let(:fixtures_path) { File.expand_path("../fixtures", __FILE__) }

      before(:each) do
        Time.stub(:now).and_return(Time.new(2013, 6, 1))
      end

      it "renders README.md for apache2 cookbook" do
        metadata_file = File.join(fixtures_path, "apache2-metadata.rb")
        readme_file   = File.join(fixtures_path, "apache2-README.md")

        metadata = Metadata.from_file(metadata_file)
        output = Readme.new(metadata).render(template)
        output.should == File.read(readme_file)
      end

      it "renders README.md for git cookbook" do
        metadata_file = File.join(fixtures_path, "git-metadata.rb")
        readme_file   = File.join(fixtures_path, "git-README.md")

        metadata = Metadata.from_file(metadata_file)
        output = Readme.new(metadata).render(template)
        output.should == File.read(readme_file)
      end

      it "renders README.md for mysql cookbook" do
        metadata_file = File.join(fixtures_path, "mysql-metadata.rb")
        readme_file   = File.join(fixtures_path, "mysql-README.md")

        metadata = Metadata.from_file(metadata_file)
        output = Readme.new(metadata).render(template)
        output.should == File.read(readme_file)
      end
    end
  end
end
