json.array!(@attendances) do |attendance|
  json.extract! attendance, :id, :name, :multiplier, :is_guest, :resident_id, :meal_id
  json.url attendance_url(attendance, format: :json)
end
