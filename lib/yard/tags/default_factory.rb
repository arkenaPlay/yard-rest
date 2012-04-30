module YARD
  module Tags
    class DefaultFactory
      def parse_tag_with_types_and_name_with_whitespace(tag_name, text)
        # Inject HTML entity whitespace for first match of single quoted string.
        # solves the case where you have:
        # (String) 'XBL2.0 — x' (required) Encrypted SAML from the device
        # when you expect this:
        # (String) 'XBL2.0 x' — (required) Encrypted SAML from the device
        text.sub!(/[\'].+(\s).+[\']/) { |x| x.gsub(/\s/, "&nbsp;") }
        parse_tag_with_types_and_name_without_whitespace(tag_name, text)
      end

      alias :parse_tag_with_types_and_name_without_whitespace :parse_tag_with_types_and_name
      alias :parse_tag_with_types_and_name :parse_tag_with_types_and_name_with_whitespace
    end
  end
end