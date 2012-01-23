#!/usr/local/bin/macruby
# http://merbist.com/2010/01/17/controlling-itunes-with-macruby/
# http://stackoverflow.com/questions/1968794/create-itunes-playlist-with-scripting-bridge

require 'fileutils'
framework 'Foundation'
framework 'ScriptingBridge'

SOURCE = "Library"
DEFAULT_PLAYLIST = "Nexus One Sync"

if ARGV[0].nil?
  destination_path = "#{Dir.home}/Desktop/#{itunes_playlist}-#{Time.now.strftime("%Y%m%d%H%M%S")}"
  FileUtils.mkdir_p destination_path
else
  destination_path = ARGV[0]
end
itunes_playlist  = ARGV[1] || DEFAULT_PLAYLIST

M3U_filename = "#{itunes_playlist}.m3u"
m3u_string = ""

itunes = SBApplication.applicationWithBundleIdentifier("com.apple.iTunes")
# playlist = itunes.sources["Library"].userPlaylists["*Nexus One Sync"]

puts "Copying files from playlist \"#{itunes_playlist}\" to path: #{destination_path}"

itunes.sources.each do |source|
  library = source 
  if source.name == SOURCE
    library.userPlaylists.each do |play_list|
      if play_list.name == itunes_playlist
        play_list.fileTracks.each do |fileTrack|
          path = fileTrack.location.path.to_s
          filename = fileTrack.location.lastPathComponent.to_s
          m3u_string = filename + "\n" + m3u_string
          FileUtils.cp(path, "#{destination_path}/#{filename}")
          puts "Song file... #{filename}"
        end
      end
    end
  end
end
File.open("#{destination_path}/#{M3U_filename}", "w" ).write(m3u_string)
puts "Done!"