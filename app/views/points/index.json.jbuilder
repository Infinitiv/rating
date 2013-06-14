json.array!(@points) do |point|
  json.extract! point, :qualification, :learning, :science, :clinic, :social, :year, :employee_id
  json.url point_url(point, format: :json)
end