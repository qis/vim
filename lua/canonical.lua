return function(path)
  if path == nil then
    return ""
  end
  return string.gsub(path, '[\\]', { ['\\'] = '/' })
end
