require 'find'
require 'shared-mime-info'

class BrowseController < ApplicationController

  def index
    if @real_path
      if File.directory? @real_path
        create_listing
      else
        handle_download
      end
    else
      create_share_listing
    end
  end

  def listing
    if @real_path
      create_listing
    else
      create_share_listing
    end
    render :partial => 'listing'
  end

  private

  def handle_download
    x_send_file(@real_path, :heder => 'X-SENDFILE')
    render :nothing => true
  end

  def create_share_listing
    @listing = []
    SHARES.keys.each do |share|
      dict = {
        :path => share,
        :stat => File.stat(SHARES[share]),
        :mime => "inode/directory"
      }
      @listing.push(dict)
    end
  end

  def create_listing
    @listing = []

    d = Dir.open(@real_path)

    d.each do |item|
      next if item == '..' or item == '.'
        
      full_path = "#{@real_path}/#{item}"
      dict = {
        :path => item,
        :stat => File.stat(full_path),
        :mime => MIME.check(full_path).type
      }
      @listing.push(dict)
    end
    d.close

    @listing.sort! do |a,b|
      if a[:stat].directory? == b[:stat].directory?
        a[:path] <=> b[:path]
      elsif a[:stat].directory?
        -1
      else
        1
      end
    end
  end
end
