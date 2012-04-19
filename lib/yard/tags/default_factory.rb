module YARD
  module Tags
    class DefaultFactory
      def parse_tag_with_types_and_name_with_whitespace(tag_name, text)
        # Inject HTML entity whitespace for first match of single or double quoted string
        text.sub!(/[\'|\"].+(\s).+[\'|\"]/) { |x| x.gsub(/\s/, "&nbsp;") }
        parse_tag_with_types_and_name_without_whitespace(tag_name, text)
      end

      alias :parse_tag_with_types_and_name_without_whitespace :parse_tag_with_types_and_name
      alias :parse_tag_with_types_and_name :parse_tag_with_types_and_name_with_whitespace
    end
  end
end