json.array!(@meals) do |meal|
  json.extract! meal, :id, :date, :cap
  json.url meal_url(meal, format: :json)
end
