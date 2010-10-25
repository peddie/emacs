;; Mutt

(add-to-list 'auto-mode-alist '("/mutt" . mail-mode))
(autoload 'post-mode "post" "mode for e-mail" t)
(add-to-list 'auto-mode-alist 
             '("\\.*mutt-*\\|.article\\|\\.followup" 
	       . post-mode))

(add-hook 'post-mode-hook 
  (lambda()
    (auto-fill-mode t)    
    (setq fill-column 72)    ; rfc 1855 for usenet messages
    (require 'footnote-mode) 
    ;     (footmode-mode t)
    (require 'boxquote)))

(add-hook 'server-switch-hook 
	  (lambda ()
	    (when (current-local-map)
	      (use-local-map (copy-keymap (current-local-map))))
	    (local-set-key (kbd "C-x k") 'server-edit)))
