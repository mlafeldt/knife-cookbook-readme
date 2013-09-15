require File.expand_path("../../lib/knife_cookbook_readme/readme_model", __FILE__)
require "erubis"

module KnifeCookbookReadme
  describe ReadmeModel do
    it "generates title from cookbook name" do
      cookbook_name = "cats"
      metadata = double(:metadata, :name => cookbook_name)
      model = ReadmeModel.new(metadata)
      model.title.should == "Cats Cookbook"
    end

    it "generates description" do
      description = double
      metadata = double(:metadata, :description => description)
      model = ReadmeModel.new(metadata)
      model.description.should == description
    end

    it "generates recipes" do
      recipes = double
      metadata = double(:metadata, :recipes => recipes)
      model = ReadmeModel.new(metadata)
      model.recipes.should == recipes
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
      model = ReadmeModel.new(metadata)
      model.attributes.sort.should == [
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
        model = ReadmeModel.new(metadata, constraints)
        model.platforms.sort.should == ["Debian (= 7)", "Ubuntu (>= 10.04)"]
      end

      it "generates platforms without version constraints" do
        constraints = false
        model = ReadmeModel.new(metadata, constraints)
        model.platforms.sort.should == ["Debian", "Ubuntu"]
      end
    end

    context "cookbook dependencies" do
      let(:metadata) do
        dependencies = {
          "cats" => "< 1.0",
          "dogs" => ReadmeModel::DEFAULT_CONSTRAINT,
        }
        double(:metadata, :dependencies => dependencies)
      end

      it "generates dependencies with version constraints" do
        constraints = true
        model = ReadmeModel.new(metadata, constraints)
        model.dependencies.sort.should == ["cats (< 1.0)", "dogs"]
      end

      it "generates dependencies without version constraints" do
        constraints = false
        model = ReadmeModel.new(metadata, constraints)
        model.dependencies.sort.should == ["cats", "dogs"]
      end
    end

    context "license and author" do
      it "generates author from maintainer name" do
        maintainer = double
        metadata = double(:metadata, :maintainer => maintainer)
        model = ReadmeModel.new(metadata)
        model.author.should == maintainer
      end

      it "generates author email from maintainer email" do
        maintainer_email = double
        metadata = double(:metadata, :maintainer_email => maintainer_email)
        model = ReadmeModel.new(metadata)
        model.author_email.should == maintainer_email
      end

      it "generates copyright year from current year" do
        time_now = Time.mktime(2013, 1, 1)
        Time.stub(:now).and_return(time_now)
        metadata = double
        model = ReadmeModel.new(metadata)
        model.copyright_year.should == time_now.year
      end
      
      it "generates license name" do
        license = double
        metadata = double(:metadata, :license => license)
        model = ReadmeModel.new(metadata)
        model.license.should == license
      end
    end

    # TODO: implement ReadmeModel#render
    context "template rendering" do
      it "can be rendered with erubis" do
        metadata = double(:metadata,
                          :name => "cats",
                          :description => "Manages a herd of cats!")
        model = ReadmeModel.new(metadata)
        template = <<EOS
<%= title %>
<%= '=' * title.length %>

<%= description %>
EOS
        eruby = Erubis::Eruby.new(template)
        result = eruby.result(model.get_binding)
        result.should == <<EOS
Cats Cookbook
=============

Manages a herd of cats!
EOS
      end
    end
  end
end
