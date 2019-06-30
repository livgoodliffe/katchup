json.array! @appointments do |appointment|
  json.extract! appointment, :id, :title, :body
end
