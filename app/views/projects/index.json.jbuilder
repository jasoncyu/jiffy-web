json.array!(@projects) do |project|
  json.extract! project, :id, :name
end
