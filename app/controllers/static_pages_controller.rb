class StaticPagesController < ApplicationController
  def fb2
  end

  def fb1
  end

  def directory_listing
    path = "." if params[:path] = ""
    hash_dir = directory_hash path
    @lines = [""]
    travelsal @lines, hash_dir, " "
    render :directory_listing
  end

  def index
    render :directory_listing
  end

  private

  def directory_hash(path, name=nil)
    data = {:data => (name || path)}
    data[:children] = children = []
    Dir.foreach(path) do |entry|
      next if (entry == '..' || entry == '.')      
      full_path = File.join(path, entry)
      next unless File.readable?(full_path)
      if File.directory?(full_path)
        children << directory_hash(full_path, entry)
      else
        children << entry
      end
    end
    return data
  end

  def travelsal lines, hash_dir, space
    lines.last << hash_dir[:data]
    ordered = hash_dir[:children].sort_by {|obj| obj.class.name}
    ordered = ordered.reverse
    ordered.each do |item|
      lines << (space + "└")
      if item.class == String
        lines[lines.size - 1] << item
      else
        space << "  "      
        travelsal lines, item, space
      end
    end
  end
end
