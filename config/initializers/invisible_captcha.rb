# frozen_string_literal: true

InvisibleCaptcha.setup do |config|
  # config.honeypots           << ['more', 'fake', 'attribute', 'names']
  # config.visual_honeypots    = false
  config.timestamp_threshold = 4
  # config.timestamp_enabled   = true
  # config.injectable_styles   = true
  # config.spinner_enabled     = true

  # Leave these unset if you want to use I18n (see below)
  config.sentence_for_humans     = "Si vous êtes un humain, ignorez ce champ"
  config.timestamp_error_message = "Désolé, une érreur s'est produit avec le Captcha! S'il vous plaîs, veuillez ré-essayer dans 2 secondes, Merci."
end
