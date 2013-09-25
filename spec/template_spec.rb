require_relative "../lib/knife_cookbook_readme/template"

module KnifeCookbookReadme
  describe "Template.render" do
    it "renders ERB template" do
      template = "Hello, <%= title %>."
      binding = { :title => "Mr. President" }
      output = Template.render(template, binding)
      output.should == "Hello, Mr. President."
    end
  end
end
