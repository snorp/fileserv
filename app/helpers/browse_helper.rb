module BrowseHelper
  def browse_link options={}
    item = options[:path]
    if item !~ /^\//
      item = "#{@path}/#{item}"
    end

    name = options[:name]
    if not name
      name = File.basename(item)
    end

    if options[:directory]
      link_to name, url_for(:controller => 'browse', :path => item), { :class => 'browsedir' }
    else
      link_to name, url_for(:controller => 'browse', :path => item)
    end
  end

  def browse_icon mime
    if mime == "inode/directory"
      image_tag("directory.png")
    elsif mime =~ /^audio/
      image_tag("audio.png")
    elsif mime =~ /^video/
      image_tag("video.png")
    elsif mime =~ /^image/
      image_tag("image.png")
    elsif mime =~ /^text/
      image_tag("text.png")
    else
      image_tag("other.png")
    end
  end
end
