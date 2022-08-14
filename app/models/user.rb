class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many:books,dependent: :destroy
has_one_attached :profile_image
#nameが空白でなく、、一意性を持たせ、２〜２０文字の範囲内
validates:name,presence:true,length:{in: 2..20},uniqueness:true

validates:introduction,length:{maximum:50}
end