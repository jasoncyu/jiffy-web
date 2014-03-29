json.array! @weeks do |week|
    json.start_day week.start_day
    json.project_data week.project_data
end