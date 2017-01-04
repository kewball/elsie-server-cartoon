# Upload Server for Elsie

## Elsie is the BoxiiiCam app

### 

Elsie the Android app uses Cordova, specifically the Camera and Media Capture modules. 

The photographer is taking pictures of Things. Each Thing will have one ore more associated photos. Things will be in Boxes; there's also a special "UnBox" box.

### Using the app (simplified)

1. Tap "New Box" button - Camera app appears, returns control to Elsie
1. Tap "New Thing" button - Camera app appears, allows for multiple images, returns control to Elsie
1. Repeat from #2 or #1 as needed
1. Tap the "Upload" button (currently #2 on Home screen drop-down)
    * each image to be uploaded appears on screen
    * as each one completes, it is removed from screen
1. After verifying the success of uploads (are the images on the server?)
    * delete `/files` in `cordova.file.externalDataDirectory` which seems to be `/storage/emulated/0/Android/data/com.ionicframework.elsie967658` for Elsie version `0.0.1` (_I really should re-name this to something sensible_)
    * tap the "trash" button on the Home screen drop-down to empty the workspace storage system.

### At the server

The uploader does pretty much what you'd expect: accpets incoming files. In addition, it expects presence of a manifest (json) file from Elsie.app. When this file is received, the server creates a new, sequentially numbered "roll" for this batch of pictures.


### dev env

- There's a Vagrant called "Doctor Crook" Find the good doctor on Solomon, in `~/dvags/drcrook`

- Code working directory is, of course, `~/cod15/elsie-sinatra-server`

- It's wired up to participate in my usual private non-Github "github" push cycle -- see `~/github` on Solomon the dev workstation. (Yes, I'm already seeing the downside to that unfortunate "github" internal naming scheme I adopted up years ago.)

- There is an `nginx` config that one needs to activate. On DrCrook.

- The Vagrant box exposes `192.168.1.11` on the LAN; that's hard-wired into the Elsie app, for now.


### Reminder: about that github mirror

http://stackoverflow.com/questions/11370239/creating-an-official-github-mirror

Apparently there's no automatic technique that doesn't involve git post-hooks and a much deeper understanding of git plumbing that I care to know. Thus, a repeatable, one-off technique that will do the job:

- Makes a bare clone of the external repository in a local directory  
`$ git clone --bare https://githost.org/extuser/repo.git`

- Pushes the mirror to the new GitHub repository
`$ cd *repo.git*`
`$ git push --mirror https://github.com/ghuser/repo.git`

- Remove the temporary local repository.
`$ cd ..`
`$ rm -rf repo.git`


### And tags. Always messing up the tags.

http://stackoverflow.com/questions/8044583/how-can-i-move-a-tag-on-a-git-branch-to-a-different-commit

- Delete the tag on any remote before you push
`git push origin :refs/tags/<tagname>`

- Replace the tag to reference the most recent commit
`git tag -fa <tagname>`

- Push the tag to the remote origin
`git push origin master --tags`

