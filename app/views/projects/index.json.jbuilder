json.array!(@projects) do |project|
  json.extract! project, :id, :project_name
  json.url project_url(project, format: :json)
end
