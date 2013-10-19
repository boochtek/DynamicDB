# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
DynamicDB::Application.config.secret_key_base = 'cbd8a36458f7d83c033bc1d4347ca36d1f3e16a621929b4bca48e039b9669cc85d2dec3595bdff0aa1861278a5243bd06860ce533ce8c5eeac7032e38bcf940c'
