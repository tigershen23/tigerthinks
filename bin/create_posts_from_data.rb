# Parses data from data/posts_{date}.json
# For each entry:
#   Create a post file with the correct frontmatter
#   Add "notes" heading to post file
require 'date'
require 'json'

# POSTS_FILE = "data/podcasts_2019-01-30.json"
POSTS_FILE = "data/articles_2019-02-01.json"

def create_podcast_post(post_data)
end

def create_article_post(post_data)
end

posts_json = JSON.parse(File.read(POSTS_FILE), symbolize_names: true)

posts_json.each do |post_data|
  post_date = DateTime.parse(post_data[:date])
  date_str = post_date.to_date.to_s
  post_filename = "#{date_str}-#{post_data[:slug]}.md"
  post_path = "_posts/#{post_filename}"
  if File.exist?(post_path)
    puts "#{post_filename} already exists, skipping..."
    # File.delete(post_path)
    next
  end

  puts "Creating #{post_filename}..."

  File.open(post_path, "w") do |f|
    f << <<-EOS.gsub(/^    /, '')
    ---
    layout: article_post
    title: "#{post_data[:title]}"
    date: "#{post_data[:date]}"
    categories:
    tags: #{post_data[:tags]}
    author: #{post_data[:author]}
    rating: #{post_data[:rating]}
    article_url: #{post_data[:article_url]}
    reading_time: #{post_data[:reading_time]}
    date_published: #{post_data[:date_published]}
    summary: "#{post_data[:summary]}"
    ---

    ## Notes
    EOS
  end

  # File.open(post_path, "w") do |f|
  #   f << <<-EOS.gsub(/^    /, '')
  #   ---
  #   layout: podcast_post
  #   title: "#{post_data[:title]}"
  #   date: "#{post_data[:date]}"
  #   categories:
  #   tags: #{post_data[:tags]}
  #   author: #{post_data[:author]}
  #   rating: #{post_data[:rating]}
  #   play_time: #{post_data[:play_time]}
  #   date_published: #{post_data[:date_published]}
  #   summary: "#{post_data[:summary]}"
  #   ---

  #   ## Notes
  #   EOS
  # end

  puts "Created #{post_filename}."
end
