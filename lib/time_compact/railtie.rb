module TimeCompact
  class Railtie < ::Rails::Railtie
    initializer 'time_compact' do
      ActiveSupport.on_load(:action_view) do
        ActionView::Base.send :include, ::TimeCompact
      end
    end
  end
end
