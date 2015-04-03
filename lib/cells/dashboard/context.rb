module Cells::Dashboard
  class Context
    # Adds a widget to a list of possible widgets
    # @param [&block] should return true when displayed within a view context
    def add_widget(cell_name, &block)
      widgets << Widget.new(cell_name, &block)
    end

    # Adds a fallback widget in the event no widgets are displayed
    def fallback(cell_name)
      fallback_widgets << Widget.new(cell_name)
    end

    def freeze
      fallback_widgets.freeze
      widgets.freeze
      super
    end

    # Only displays widgets that evaluate to true for `args`
    def widgets_for_arguments(*args)
      context_widgets = widgets.select { |widget| widget.display? *args }
      context_widgets.any? ? context_widgets : fallback_widgets
    end

    protected

    # Widgets that are conditionally tested for display
    def widgets
      @widgets ||= []
    end

    # Widgets that are returned when no widgets are to be displayed
    def fallback_widgets
      @fallback_widgets ||= []
    end
  end
end
