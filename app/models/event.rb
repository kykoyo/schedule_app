class Event < ActiveRecord::Base
    has_many :user_events
    has_many :users, through: :user_events

    belongs_to :owner, class_name: 'User'

    has_many :suggestions, dependent: :destroy

    has_one :determine_date, class_name: 'Suggestion'

    validates :title, presence: true
end
