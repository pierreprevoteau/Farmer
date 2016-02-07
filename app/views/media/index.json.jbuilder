json.array!(@media) do |medium|
  json.extract! medium, :id, :title, :state, :workflow_id
  json.url medium_url(medium, format: :json)
end
