json.array!(@transcodes) do |transcode|
  json.extract! transcode, :id, :title, :general_option, :infile_option, :outfile_option, :extention
  json.url transcode_url(transcode, format: :json)
end
