json.array!(@bills) do |bill|
  json.extract! bill, :id, :meal_id, :resident_id, :amount
  json.url bill_url(bill, format: :json)
end
