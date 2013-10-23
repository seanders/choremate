object @household
attributes :name

child :users do
  attributes :id, :email, :display_name, :first_name, :last_name
end
