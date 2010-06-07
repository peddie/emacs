;;;;;;; git configuration ;;;;;;;;;

; git
(add-to-list 'load-path "/usr/share/doc/git-core/contrib/emacs/")
(autoload 'git "git" "excellent version control system, emacs interface" t)
(autoload 'vc-git "vc-git" "version control interface for git repos" t)
(autoload 'git-blame "git-blame" "interface to git-blame" t)

; egit
(add-to-list 'load-path "/home/peddie/software/egit")
(autoload 'egit "egit" "Emacs git history" t)
(autoload 'egit-file "egit" "Emacs git history file" t)
(autoload 'egit-dir "egit" "Emacs git history directory" t)

; egg
(add-to-list 'load-path "/home/peddie/software/egg")
(autoload 'egg "egg" "Enhanced emacs git interface" t)
(autoload 'egg-grep "egg-grep" "Enhanced emacs git interface -- grep" t)

; magit
(autoload 'magit "magit" "Enhanced emacs git interface" t)

(global-set-key (kbd "C-c s") 'magit-status)