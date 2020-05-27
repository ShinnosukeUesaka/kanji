class Settings < Settingslogic
  #https://qiita.com/hilotter/items/45616c83704a15532987
  #https://github.com/binarylogic/settingslogic
  source "#{Rails.root}/config/settings.yml"
  namespace Rails.env
end