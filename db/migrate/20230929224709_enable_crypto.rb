class EnableCrypto < ActiveRecord::Migration[7.0]
  enable_extension "pgcrypto"
end
