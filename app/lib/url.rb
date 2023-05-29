module URL
  def self.valid(input)
    url = URI.parse(input.strip)
    unless url.scheme
      url = URI.parse("https://#{input.strip}")
    end
    unless url.host
      url.host = url.path.prepend('//') if url.path
    end
    url.to_s
  rescue URI::InvalidURIError
    nil
  end
end