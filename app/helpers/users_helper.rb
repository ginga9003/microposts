module UsersHelper
  
  #--------------
  # Gravatorサービスを利用してimgtタグを出力する
  #
  # @param user Userオブジェクト
  # @param options オプション（画像サイズ）
  #--------------
  def gravatar_for(user, options = { size: 80 })
    
    # emailを小文字に変換して暗号化
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    
    # URL生成
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    
    # imgタグの出力
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end
end