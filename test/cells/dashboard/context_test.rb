require 'test_helper'

describe Cells::Dashboard::Context do

  describe '#freeze' do
    it 'should prevent the user from adding widgets' do
      context = Cells::Dashboard::Context.new
      context.freeze
      begin
        context.add_widget 'enabled_widget'
        fail 'error should have been raised'
      rescue RuntimeError
        # Pass!
      end
    end
    it 'should prevent the user from adding a fallback' do
      context = Cells::Dashboard::Context.new
      context.freeze
      begin
        context.fallback 'enabled_widget'
        fail 'error should have been raised'
      rescue RuntimeError
        # Pass!
      end
    end
  end

  describe '#widgets_for_arguments' do
    it 'should return all widgets where display returns to true' do
      context = Cells::Dashboard::Context.new
      context.add_widget 'enabled_widget' do
        true
      end
      context.add_widget 'disabled_widget' do
        false
      end
      result = context.widgets_for_arguments
      result.size.must_equal 1
      result[0].cell_name.must_equal 'enabled_widget'
    end
    it 'should pass all arguments to the display methods on each widget' do
      received_value = nil
      context = Cells::Dashboard::Context.new
      context.add_widget 'enabled_widget' do |argument_value|
        received_value = argument_value
      end
      context.widgets_for_arguments 'example_argument'
      received_value.must_equal 'example_argument'
    end
    it 'should return the fallback value if no widgets are enabled' do
      context = Cells::Dashboard::Context.new
      context.add_widget 'enabled_widget' do |argument_value|
        false
      end
      context.fallback 'fallback_widget'
      result = context.widgets_for_arguments
      result.size.must_equal 1
      result[0].cell_name.must_equal 'fallback_widget'
    end
  end
end
