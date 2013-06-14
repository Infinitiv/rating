json.array!(@chairs) do |chair|
  json.extract! chair, :name, :faculty_id
  json.url chair_url(chair, format: :json)
end