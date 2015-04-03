require 'test_helper'

describe Cells::Dashboard::Widget do
  describe '.name_for_widget' do
    it 'handles Class values' do
      class Cells::Dashboard::ExampleCell; end
      Cells::Dashboard::Widget.name_for_cell(Cells::Dashboard::ExampleCell).must_equal 'cells/dashboard/example'
    end
    it 'handles Array values' do
      Cells::Dashboard::Widget.name_for_cell(['a', :b, 'C']).must_equal ['a', :b, 'C']
    end
    it 'handles String parameters' do
      Cells::Dashboard::Widget.name_for_cell('my_widgets/example_widget_cell').must_equal 'my_widgets/example_widget'
    end
  end

  describe '#display?' do
    it 'returns true with no block value' do
      widget = Cells::Dashboard::Widget.new('example_widget')
      widget.display?.must_equal true
    end
    it 'returns the value from the block' do
      return_value = [true, false].sample
      widget = Cells::Dashboard::Widget.new('example_widget') do
        return_value
      end
      widget.display?.must_equal return_value
    end
    it 'passes all arguments to the block value' do
      received_value_a = received_value_b = nil
      widget = Cells::Dashboard::Widget.new('example_widget') do |argument_value_a, argument_value_b|
        received_value_a = argument_value_a
        received_value_b = argument_value_b
      end
      widget.display? 'value a', 'value b'
      received_value_a.must_equal 'value a'
      received_value_b.must_equal 'value b'
    end
  end
end
