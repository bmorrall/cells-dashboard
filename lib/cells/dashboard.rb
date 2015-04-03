require "cells/dashboard/version"

module Cells
  module Dashboard
    require "cells/dashboard/context"
    require "cells/dashboard/widget"

    class << self
      # Adds a newly defined dashboard
      def create(dashboard_name, &block)
        context = dashboard(dashboard_name)
        context.instance_eval(&block)
        context.freeze
      end

      # Returns all widgets to be rendered for a dashboard
      def dashboard_widgets(dashboard_name, *args)
        dashboard(dashboard_name).widgets_for_arguments(*args)
      end

      protected

      def dashboard(dashboard_name)
        @dashboards ||= {}
        @dashboards[dashboard_name.to_sym] ||= Context.new
      end
    end
  end
end

if defined?(ActionController)
  require File.join(File.dirname(__FILE__), '..', '..', 'app', 'helpers', 'cells', 'dashboard_helper')
  ActionController::Base.helper(Cells::DashboardHelper)
end

