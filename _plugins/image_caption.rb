# frozen_string_literal: true

# Converts images followed by italic text into figure/figcaption elements
# Usage (same line):
#   ![alt text](/path/to/image.png){: style="..." } *Caption with [links](url)*
#
# Usage (separate lines):
#   ![alt text](/path/to/image.png){: style="..." }
#   *Caption with [links](url)*
#
# The italic text becomes the figcaption (with full markdown support)

module Jekyll
  module ImageCaption
    def self.process_images(content)
      return content if content.nil?

      result = content.to_s
      
      # Case 1: Image and caption on same line (in same <p>)
      # <p><img ...> <em>caption</em></p>
      result = result.gsub(
        %r{<p>\s*(<img[^>]+>)\s*<em>(.+?)</em>\s*</p>}im
      ) do |_match|
        img_tag = Regexp.last_match(1)
        caption_content = Regexp.last_match(2)
        
        <<~HTML.strip
          <figure>
            #{img_tag}
            <figcaption>#{caption_content}</figcaption>
          </figure>
        HTML
      end
      
      # Case 2: Image and caption on separate lines (separate <p> tags)
      # <p><img ...></p>\n<p><em>caption</em></p>
      result = result.gsub(
        %r{<p>\s*(<img[^>]+>)\s*</p>\s*<p>\s*<em>(.+?)</em>\s*</p>}im
      ) do |_match|
        img_tag = Regexp.last_match(1)
        caption_content = Regexp.last_match(2)
        
        <<~HTML.strip
          <figure>
            #{img_tag}
            <figcaption>#{caption_content}</figcaption>
          </figure>
        HTML
      end
      
      result
    end
  end
end

# Hook into Jekyll's rendering to process images in page/post content
Jekyll::Hooks.register [:pages, :posts, :documents], :post_render do |doc|
  next if doc.output.nil?
  doc.output = Jekyll::ImageCaption.process_images(doc.output)
end
