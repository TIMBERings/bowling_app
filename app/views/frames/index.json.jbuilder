json.array!(@frames) do |frame|
  json.extract! frame, :id, :frame, :first, :second, :third, :score
  json.url frame_url(frame, format: :json)
end
