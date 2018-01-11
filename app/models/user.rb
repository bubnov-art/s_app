class User < ApplicationRecord
  after_create  :broadcast_users

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:vkontakte]

  enum state: [:registered_confirmed, :registered_social, :request, :request_rejected, :ban]

  has_attached_file :pass_file,
                    default_url: '/assets/default_img.jpg',
                    url: '/pass/:id/:filename.:extension',
                    path: ':rails_root/public/pass/:id/:filename.:extension'
  validates_attachment_size :pass_file,  :less_than => 2.megabytes  
  validates_attachment :pass_file, content_type: { content_type: ["application/pdf", "image/jpeg", "image/jpg" , "image/png"] }

  scope :admins,   ->{ where(admin: true) }
  scope :customers,   ->{ where(admin: false) }

  def name
  	"#{last_name} #{first_name} #{second_name}" 
  end

  def self.find_for_vkontakte_oauth(access_token)
    if user = User.find_by_vk_id(access_token.extra.raw_info.id)
      user
    else 
      city = access_token.extra.raw_info.city
      users_city = city ? city.title : ""
      User.create(
      	provider: access_token.provider, 
        vk_id: access_token.extra.raw_info.id, 
        first_name: access_token.extra.raw_info.first_name,
        last_name: access_token.extra.raw_info.last_name,
        city: users_city,
        email: access_token.extra.raw_info.screen_name + "@vk.com", 
        password:  Devise.friendly_token[0,20],
        state: 1
      ) 
    end
  end

  def broadcast_users
    if !self.admin?
        div_class = self.state == 1 ? 'success' : 'info'
        btn_show = I18n.t 'activerecord.buttons.show_user'
        state = I18n.t "activerecord.attributes.user.state.#{self.state}"
        ActionCable.server.broadcast 'users_channel',
          id: id,
          name: name,
          city: city,
          email: email,
          phone: phone,
          state: state,
          div_class: div_class,
          btn_show: btn_show
    end
  end 
end
