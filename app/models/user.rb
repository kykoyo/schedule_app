class User < ActiveRecord::Base
    has_many :user_events, dependent: :destroy
    has_many :events, through: :user_events

    has_many :user_suggestions, dependent: :destroy
    has_many :suggestions, through: :user_suggestions

    #幹事がいなくなったらイベントが消えるように設定
    has_many :created_events, class_name: 'Event', foreign_key: :owner_id, dependent: :destroy
    
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :trackable, :validatable

    validates :username, presence: true, uniqueness: true
end
