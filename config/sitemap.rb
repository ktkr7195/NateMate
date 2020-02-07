# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://natemate.com"

SitemapGenerator::Sitemap.create do

  add root_path
  add microposts_path, :priority => 0.7, :changefreq => 'daily'

  Micropost.all.find_each do |micropost|
    add miropost_path(micropost), lastmod: micropost.updated_at
  end

end
