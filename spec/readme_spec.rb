require File.expand_path("../../lib/knife_cookbook_readme/readme", __FILE__)

class Template; end

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

    it "generates recipes" do
      recipes = double
      metadata = double(:metadata, :recipes => recipes)
      readme = Readme.new(metadata)
      readme.recipes.should == recipes
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

    context "supported platforms" do
      let(:metadata) do
        platforms = { "debian" => "= 7", "ubuntu" => ">= 10.04" }
        double(:metadata, :platforms => platforms)
      end

      it "generates platforms with version constraints" do
        constraints = true
        readme = Readme.new(metadata, constraints)
        readme.platforms.should == ["Debian (= 7)", "Ubuntu (>= 10.04)"]
      end

      it "generates platforms without version constraints" do
        constraints = false
        readme = Readme.new(metadata, constraints)
        readme.platforms.should == ["Debian", "Ubuntu"]
      end
    end

    context "cookbook dependencies" do
      let(:metadata) do
        dependencies = { "cats" => "< 1.0", "dogs" => DEFAULT_CONSTRAINT }
        double(:metadata, :dependencies => dependencies)
      end

      it "generates dependencies with version constraints" do
        constraints = true
        readme = Readme.new(metadata, constraints)
        readme.dependencies.should == ["cats (< 1.0)", "dogs"]
      end

      it "generates dependencies without version constraints" do
        constraints = false
        readme = Readme.new(metadata, constraints)
        readme.dependencies.should == ["cats", "dogs"]
      end
    end

    context "license and author" do
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
    end

    context "#render" do
      it "knows how to render a README.md file" do
        template = double
        Template.should_receive(:render).with(template, kind_of(Binding))
        metadata = double
        readme = Readme.new(metadata)
        readme.render(template)
      end
    end
  end
end
