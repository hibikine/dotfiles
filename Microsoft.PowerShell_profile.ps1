Set-Alias ll Get-ChildItem
Set-Alias lll Get-ChildItem
Set-Alias g git

function gd { 
  git diff
} 

function gg { 
  git grep $args
} 

function gcom {
  git commit -m $args
}

function gco {
  git commit $args
}

function gc {
  git checkout $args
}

function gp {
  git push $args
}

function gs {
  git status
}

function youtube-dl-best() {
  youtube-dl -f bestvideo+bestaudio --merge-output-format mp4 $args[0]
}