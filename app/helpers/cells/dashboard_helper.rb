module Cells
  module DashboardHelper
    def render_dashboard(dashboard_name, *args)
      widgets = Cells::Dashboard.dashboard_widgets(dashboard_name, *args)
      widgets.each do |widget|
        concat cell(widget.cell_name).call(:display, *args)
      end
    end
  end
end
