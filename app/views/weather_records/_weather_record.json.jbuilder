json.extract! weather_record, :id, :created_at, :updated_at
json.url weather_record_url(weather_record, format: :json)
