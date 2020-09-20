class CardIdEncryption
  def initialize
    @encryption_salt = SecureRandom.hex(key_len)
    @_decryptor = {}
  end

  def encrypt(plaintext)
    encrypted = encryptor.encrypt_and_sign(plaintext)
    "#{encryption_salt}$$#{encrypted}"
  end

  def decrypt(data)
    salt, encrypted = data.split("$$")
    decryptor(salt).decrypt_and_verify(encrypted)
  end

  private

  attr_reader :encryption_salt

  def encryptor
    @_encryptor ||= ActiveSupport::MessageEncryptor.new(key)
  end

  def decryptor(salt)
    @_decryptor[salt] ||= ActiveSupport::MessageEncryptor.new(key(salt))
  end

  def key_len
    ActiveSupport::MessageEncryptor.key_len
  end

  def key(salt = encryption_salt)
    ActiveSupport::KeyGenerator.new(
      Rails.application.secret_key_base,
    ).generate_key(salt, key_len)
  end
end
