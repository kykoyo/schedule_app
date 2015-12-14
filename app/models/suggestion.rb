class Suggestion < ActiveRecord::Base
    has_many :user_suggestions, dependent: :destroy
    has_many :users, through: :user_suggestions

    belongs_to :determine_event, class_name: 'Event', foreign_key: :determine_date_id

    def suggestion_hash
        count_hash={0=>0, 1=>0, 2=>0, 3=>0}
        user_hash={0=>[], 1=>[], 2=>[], 3=>[]}
        user_suggestions.each do |us|
            count_hash[us.tag]+=1
            user_hash[us.tag]<<us.user
        end
        for i in [0, 1, 2, 3]
            user_hash[i].flatten!
        end
        return count_hash, user_hash
    end


end
