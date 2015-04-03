require 'test_helper'

describe Cells::Dashboard do
  after(:each) do
    Cells::Dashboard.instance_variable_set '@dashboards', nil
  end

  describe '.create' do
    it 'should provide a dsl based off a Context object' do
      Cells::Dashboard.create :example do
        add_widget 'example_widget'
        fallback 'fallback_widget'
      end
    end
  end

  describe '.dashboard_widgets' do
    it 'should return displayed widgets with a matching dashboard name' do
      Cells::Dashboard.create :matching_name do
        add_widget('matching_widget') { true }
      end
      Cells::Dashboard.create :other_name do
        add_widget('other_widget') { true }
      end
      result = Cells::Dashboard.dashboard_widgets(:matching_name)
      result.size.must_equal 1
      result[0].cell_name.must_equal 'matching_widget'
    end
    it 'should return all widgets that evaluate for true in a given context' do
      Cells::Dashboard.create :example do
        add_widget('enabled_widget') { true }
        add_widget('disabled_widget') { false }
      end
      result = Cells::Dashboard.dashboard_widgets(:example)
      result.size.must_equal 1
      result[0].cell_name.must_equal 'enabled_widget'
    end
  end
end
