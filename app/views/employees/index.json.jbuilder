json.array!(@employees) do |employee|
  json.extract! employee, :id, :name, :empno
  json.url employee_url(employee, format: :json)
end
