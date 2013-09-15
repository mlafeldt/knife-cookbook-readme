require "erubis"

module KnifeCookbookReadme
  class Template
    def self.render(template, binding)
      eruby = Erubis::Eruby.new(template)
      output = eruby.result(binding)
      output
    end
  end
end
