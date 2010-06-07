;;;;;;;;;;; Erlang ;;;;;;;;;;

(add-to-list 'load-path "/usr/share/emacs/site-lisp/erlang")
(setq erlang-root-dir "/usr/lib/erlang")
(add-to-list 'exec-path "/usr/bin")
(autoload 'erlang-start "erlang" "mode for writing erlang")

; setup distel
(add-to-list 'load-path "/usr/local/share/distel/elisp")
(require 'distel)
(eval-after-load "distel" (distel-setup))
(add-hook 'erlang-mode-hook
	  (lambda ()
	    ;; when starting an Erlang shell in Emacs, default in the node name
	    (setq inferior-erlang-machine-options '("-sname" "emacs"))
	    ;; add Erlang functions to an imenu menu
	    (imenu-add-to-menubar "imenu")))

;; A number of the erlang-extended-mode key bindings are useful in the shell too
(defconst distel-shell-keys
  '(("\C-\M-i"   erl-complete)
    ("\M-?"      erl-complete)	
    ("\M-."      erl-find-source-under-point)
    ("\M-,"      erl-find-source-unwind) 
    ("\M-*"      erl-find-source-unwind) 
    )
  "Additional keys to bind when in Erlang shell.")

(add-hook 'erlang-shell-mode-hook
	  (lambda ()
	    ;; add some Distel bindings to the Erlang shell
	    (dolist (spec distel-shell-keys)
	      (define-key erlang-shell-mode-map (car spec) (cadr spec)))))
