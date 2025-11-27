# frozen_string_literal: true

# Fix jekyll-katex compatibility with Liquid 4.0
# The issue: Liquid 4.0 changed initialize(tag_name, markup, tokens) 
# to initialize(tag_name, markup, parse_context)
# jekyll-katex stores @tokens which causes "no implicit conversion of Hash into Integer"

require 'jekyll-katex/configuration'
require 'jekyll-katex/katex_js'

module Jekyll
  module Tags
    # Redefine Katex tag for Liquid 4.0 compatibility
    class Katex < Liquid::Block
      KATEX ||= Jekyll::Katex::KATEX_JS

      def initialize(tag_name, markup, parse_context)
        super
        @markup = markup
        @display = markup.include? 'display'
      end

      def render(context)
        latex_source = super
        rendering_options = Jekyll::Katex::Configuration.global_rendering_options.merge(displayMode: @display)
        KATEX.call('katex.renderToString', latex_source, rendering_options)
      end
    end

    # Redefine KatexMathMode tag for Liquid 4.0 compatibility
    class KatexMathMode < Liquid::Block
      LOG_TOPIC ||= 'KatexMathMode:'
      KATEX ||= Jekyll::Katex::KATEX_JS
      LATEX_TOKEN_PATTERN ||= /(?<!\\)([$]{2}|[$]{1})(.+?)(?<!\\)\1/m.freeze

      def initialize(tag_name, markup, parse_context)
        super
        @markup = markup
        @display_mode_rendering = Jekyll::Katex::Configuration.global_rendering_options.merge(displayMode: true)
        @inline_mode_rendering = Jekyll::Katex::Configuration.global_rendering_options.merge(displayMode: false)
      end

      def render(context)
        enclosed_block = super
        rendered_str = enclosed_block.to_s.gsub(LATEX_TOKEN_PATTERN) do |match|
          display_mode = match.to_s.start_with? '$$'
          rendering_options = display_mode ? @display_mode_rendering : @inline_mode_rendering
          Jekyll.logger.debug LOG_TOPIC, "Rendering matched block - #{match}"
          KATEX.call('katex.renderToString', Regexp.last_match(2), rendering_options)
        end
        rendered_str.to_s.gsub(/\\[$]/, '$').to_s
      end
    end
  end
end

# Register the fixed tags
Liquid::Template.register_tag('katex', Jekyll::Tags::Katex)
Liquid::Template.register_tag('katexmm', Jekyll::Tags::KatexMathMode)

