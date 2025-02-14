module ApplicationHelper
  def truncate_url(url, length = 40)
    url.length > length ? "#{url[0...length]}..." : url
  end
end
