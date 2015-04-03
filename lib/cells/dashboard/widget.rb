require 'active_support/core_ext/string/inflections'

module Cells::Dashboard
  class Widget
    attr_reader :cell_name

    def self.name_for_cell(cell_name)
      case cell_name
      when Class
        # Accept Cell classes
        name_for_cell(cell_name.name)
      when Array
        # Accept arrays of values
        cell_name
      else
        # Accept the name of cells (safely removing cell suffix)
        cell_name.to_s.underscore.sub(/_cell\z/, '')
      end
    end

    # Creates a new widget that:
    # - renders the #display method of a cell found using `cell_name`
    # - renders only if `block` evaluates to true
    def initialize(cell_name, &block)
      @cell_name = Widget.name_for_cell(cell_name).freeze
      @block = block if block_given?
    end

    # Returns true if the cell should be displayed
    def display?(*args)
      @block.nil? || !!@block.call(*args)
    end
  end
end
