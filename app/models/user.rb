class User < ActiveRecord::Base
    before_save { self.email = email.downcase } #emailをすべて小文字に変換して代入
    
    # ユーザ名は必須で、50文字以内
    validates :name, presence: true, length: { maximum: 50 }
    
    # メールアドレスは必須、正規表現でチェック
    # case_sensitive：false => 大文字小文字を区別しない
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
                      format: { with: VALID_EMAIL_REGEX },
                      uniqueness: { case_sensitive: false }
    
    has_secure_password
end
