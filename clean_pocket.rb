require 'pry'
require 'pocket-ruby'

client = Pocket.client(consumer_key: '', access_token: '')
info = client.retrieve(:detailType => :simple, state: :all, :count => 10000)
things_to_delete = info["list"].map do |list|
  list.map do |list_items|
    list_items["item_id"]
  end
end.flatten.compact

things_to_delete = things_to_delete.map do |thing|
  { action: :delete, item_id: thing }
end

puts things_to_delete

puts client.modify(things_to_delete)
