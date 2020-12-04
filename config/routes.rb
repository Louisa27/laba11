Rails.application.routes.draw do
  root 'home#input'
  get 'home/input' => 'home#input', :as => 'input'
  get 'home/output' => 'home#output', :as => 'output'
  get 'home/serialize' => 'home#serialize_db', :as => 'serialize'
  get 'home/last_record' => 'home#last_rec', :as => 'lastrec'
end

