json.array!(@communities) do |community|
  json.extract! community, :id, :name, :cap
  json.url community_url(community, format: :json)
end
