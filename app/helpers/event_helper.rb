module EventHelper
    def event_column(event, type)
        case type
        when :determined
            user_hash=event.determine_date.suggestion_hash[1]
            list1=user_hash[1].map(&:username).join(', ')
            if user_hash[2].empty?
                list2=""
            else
                list2=', ('.concat(user_hash[2].map(&:username).join('), (')).concat(')')
            end
            list1.concat(list2)
        else
            event.users.map(&:username).join(', ')
        end
    end

    def table_column(event, type)
        case(type)
        when :determined
            list=link_to t('ビュー'), show_determine_path(current_user, event), :class => 'btn btn-default btn-xs'
            if current_user==event.owner
                list.concat(link_to t('日付をキャンセル'), determine_cancel_path(current_user, event), :method => :patch, :class => 'btn btn-default btn-xs')
            end
            return list
        when :created
            list=link_to t('編集'), edit_user_event_path(current_user, event), :class => 'btn btn-default btn-xs'
            list.concat(link_to t('削除'), user_event_path(current_user, event), :method => :delete, :data => { :confirm => t('.confirm', :default => t("helpers.links.confirm", :default => 'Are you sure?')) }, :class => 'btn btn-xs btn-danger')
            list.concat(link_to t('日付を確定'), determine_date_path(current_user, event), :class => 'btn btn-default btn-xs')
        when :invited
            link_to t('出欠を入力'), edit_user_event_user_suggestion_path(current_user, event), :class => 'btn btn-default btn-xs'
        end
    end
end
