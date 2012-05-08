;;;;;;;;; ido-mode ;;;;;;;;;;;

;; mostly from http://www.djcbsoftware.nl/dot-emacs.html

(require 'ido) 
(setq 
 ido-save-directory-list-file (concat emacs-root "cache/ido.last")
 ido-ignore-buffers ;; ignore these guys
 '("\\` " "^\*Mess" "^\*Back" ".*Completion" "^\*Ido" "^\*trace"
   "^\*compilation" "^\*GTAGS" "^session\.*" "^\*")
 ido-work-directory-list '("~/" "~/programming" "~/writing" "~/math" "~/swiftnav")
 ido-case-fold  t ; be case-insensitive
 ido-enable-last-directory-history t ; remember last used dirs
 ido-max-work-directory-list 30 ; should be enough
 ido-max-work-file-list      50 ; remember many
 ido-use-filename-at-point nil ; don't use filename at point (annoying)
 ido-use-url-at-point nil ; don't use url at point (annoying)
 ido-enable-flex-matching t ; don't try to be too smart
 ido-max-prospects 10 ; don't spam my minibuffer
 ido-ignore-extensions t ; ignore object files
 ido-confirm-unique-completion t) ; wait for RET, even with unique completion

;; when using ido, the confirmation is rather annoying...
(setq confirm-nonexistent-file-or-buffer nil)

;; increase minibuffer size when ido completion is active
(add-hook 'ido-minibuffer-setup-hook 
  (function
    (lambda ()
      (make-local-variable 'resize-minibuffer-window-max-height)
      (setq resize-minibuffer-window-max-height 1))))

(ido-mode 'both) ;; for buffers and files
