require File.expand_path("../../lib/knife_cookbook_readme/template", __FILE__)

module KnifeCookbookReadme
  describe Template do
    context ".render" do
      it "renders ERB template" do
        template = "Hello, <%= title %>."
        binding = { :title => "Mr. President" }
        output = Template.render(template, binding)
        output.should == "Hello, Mr. President."
      end
    end
  end
end
