json.array!(@metadata) do |metadatum|
  json.extract! metadatum, :id, :medium_id, :key, :value
  json.url metadatum_url(metadatum, format: :json)
end
