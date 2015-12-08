module EventHelper
  def action_link(type, event)
    case(type)
      when :determined
        link_to t('ビュー'), user_event_path(current_user, event), :class => 'btn btn-default btn-xs'
        link_to t('日付を変更'), determine_cancel_path(current_user, event), :method => :patch, :class => 'btn btn-default btn-xs'
      when :created
        link_to t('ビュー'), user_event_path(current_user, event), :class => 'btn btn-default btn-xs'
        link_to t('日付を変更'), determine_cancel_path(current_user, event), :method => :patch, :class => 'btn btn-default btn-xs'
=begin
        <%= link_to t('編集'),
                      edit_user_event_path(current_user, event), :class => 'btn btn-default btn-xs' %>
        <%= link_to t('削除'),
                      user_event_path(current_user, event),
                      :method => :delete,
          :data => { :confirm => t('.confirm', :default => t("helpers.links.confirm", :default => 'Are you sure?')) },
          :class => 'btn btn-xs btn-danger' %>
        <%= link_to t('日付を確定'),
                      determine_date_path(current_user, event), :class => 'btn btn-default btn-xs' %>
=end

    end
  end

  def user_label(type)
    case(type)
      when :determined then 'A'
      when :created then 'B'
      when :invited then 'C'
    end
  end
end
