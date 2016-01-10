if @error
  json.error @error.to_s
else
  json.(@parrot, :id, :name, :age, :color_id, :sex, :tribal, :color_hex)
end