require "pry"
require "dotenv"
Dotenv.load

Time.zone = "Pacific Time (US & Canada)"

###
# Compass
###

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy pages (https://middlemanapp.com/advanced/dynamic_pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", :locals => {
#  :which_fake_page => "Rendering a fake page with a local variable" }

activate :directory_indexes

activate :blog do |blog|
  blog.prefix = "articles"
  blog.sources = "{category}/{title}.html"
  blog.publish_future_dated = true
end

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload
end

# Methods defined in the helpers block are available in templates
helpers do
  def event_articles
    blog.articles.select do |a|
      a.metadata[:page]['category'] == 'events'
    end
  end

  def travel_articles
    blog.articles.select do |a|
      a.metadata[:page]['category'] == 'travel'
    end
  end

  def google_map_url(event)
    search_query = "#{event.data[:address]} #{event.data[:city]} BC Canada"
    "https://www.google.com/maps/place/#{search_query}"
  end

  def slug(title)
    title.downcase.strip.gsub(" ", "-").gsub(/[^\w-]/, "").gsub(/-+/, "-")
  end

  def tel_href(phone_string)
    "tel:+1#{phone_string.gsub(/[^0-9]/, '')}"
  end

  def event_time_readable(event)
    return event.date.strftime("%l:%M %p") unless event.data[:end_date]
    end_time = event.data[:end_date].to_time
    if event.date.strftime('%p') == end_time.strftime('%p')
      "#{event.date.strftime("%l:%M")} - #{end_time.strftime("%l:%M %p")}"
    else
      "#{event.date.strftime("%l:%M %p")} - #{end_time.strftime("%l:%M %p")}"
    end
  end

  def loader
    content_tag :div, class: 'loading' do
      'loading'.reverse.split('').map { |l| content_tag(:div, l, class: 'letter') }.join()
    end
  end
end

set :css_dir, "stylesheets"

set :js_dir, "javascripts"

set :images_dir, "images"

activate :google_analytics do |ga|
  ga.tracking_id = ENV['GA_TRACKING_ID']
end

# Build-specific configuration
configure :build do
  # middleman gets confused and thinks that email.coffee.erb should be a page
  ignore 'javascripts/email.coffee.erb'
  # For example, change the Compass output style for deployment
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript

  # Enable cache buster
  # activate :asset_hash

  # Use relative URLs
  # activate :relative_assets

  # Or use a different image path
  # set :http_prefix, "/Content/images/"
end

activate :s3_sync do |s3_sync|
  s3_sync.bucket                     = ENV['AWS_BUCKET']
  s3_sync.region                     = ENV['AWS_REGION']
  s3_sync.aws_access_key_id          = ENV['AWS_ACCESS_KEY_ID']
  s3_sync.aws_secret_access_key      = ENV['AWS_SECRET_ACCESS_KEY']
end
