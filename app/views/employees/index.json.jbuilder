json.array!(@employees) do |employee|
  json.extract! employee, :first_name, :middle_name, :last_name, :chair_id, :post_id, :degree_id, :academic_title_id, :head
  json.url employee_url(employee, format: :json)
end