#!/usr/local/bin/macruby
# http://merbist.com/2010/01/17/controlling-itunes-with-macruby/
# http://stackoverflow.com/questions/1968794/create-itunes-playlist-with-scripting-bridge

require 'fileutils'

framework 'Foundation'
framework 'ScriptingBridge'

destination_path = ARGV[0]

itunes = SBApplication.applicationWithBundleIdentifier("com.apple.iTunes")
# playlist = itunes.sources["Library"].userPlaylists["*Nexus One Sync"]

itunes.sources.each do |source|
  library = source 
  if source.name == "Library"
    library.userPlaylists.each do |play_list|
      if play_list.name == "*Nexus One Sync"
        play_list.fileTracks.each do |fileTrack|
          path = fileTrack.location.path.to_s
          filename = fileTrack.location.lastPathComponent.to_s
          FileUtils.cp(path, "#{destination_path}/#{filename}")
        end
      end
    end
  end
end
