# frozen_string_literal: true

# Custom Jekyll plugin to render \todo{...} as [TODO: ...] comments
# Usage in markdown: \todo{This needs to be fixed}
# Renders as: <span class="todo-comment">[TODO: This needs to be fixed]</span>

module Jekyll
  module TodoFilter
    # Pattern matches \todo{...} - the backslash may be escaped in HTML as &#92; or kept as \
    # Also matches when kramdown escapes it
    TODO_PATTERNS = [
      /\\todo\{([^{}]*(?:\{[^{}]*\}[^{}]*)*)\}/,           # Raw: \todo{...}
      /&#92;todo\{([^{}]*(?:\{[^{}]*\}[^{}]*)*)\}/,        # HTML escaped: &#92;todo{...}
    ].freeze

    def self.process_todos(content)
      return content if content.nil?
      
      result = content.to_s
      TODO_PATTERNS.each do |pattern|
        result = result.gsub(pattern) do |_match|
          todo_text = Regexp.last_match(1)
          %(<span class="todo-comment">[TODO: #{todo_text}]</span>)
        end
      end
      result
    end

    def render_todos(content)
      TodoFilter.process_todos(content)
    end
  end
end

Liquid::Template.register_filter(Jekyll::TodoFilter)

# Hook into Jekyll's rendering to process todos in page/post content
Jekyll::Hooks.register [:pages, :posts], :post_render do |doc|
  next if doc.output.nil?
  doc.output = Jekyll::TodoFilter.process_todos(doc.output)
end
