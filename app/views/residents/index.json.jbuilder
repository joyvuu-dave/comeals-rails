json.array!(@residents) do |resident|
  json.extract! resident, :id, :name, :multiplier, :unit_id
  json.url resident_url(resident, format: :json)
end
