iTunes Sync Android
===================
iTunes Sync Android is a command line utility to sync one of your iTunes playlists to any Android cell phone mounted as a disk volume on your Mac. 

## Requisites
* [MacRuby](http://www.macruby.org/) 0.9 or later
* Mac OS X 10.6 or later
* iTunes

## Usage

```bash
$ macruby itunes_sync_android.rb <destination folder> <playlist name>
```

For example, if you want to copy your song files from your iTunes playlist **Nexus One Sync** to your Android phone mounted via USB on **/Volumes/NO NAME/Music**

```bash
$ macruby itunes_sync_android.rb "/Volumnes/NO NAME/Music" "Nexus One Sync"
```