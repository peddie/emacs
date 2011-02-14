;;; .emacs
(defvar emacs-root "/home/peddie/.emacs.d/"
 "My home directory — the root of my personal emacs load-path.")

(let ((default-directory emacs-root))
  (setq load-path (cons emacs-root load-path))
  (normal-top-level-add-subdirs-to-load-path))

;; ;; add all the elisp directories under ~/.emacs.d to my load path
(labels ((add-path (p)
 	 (add-to-list 'load-path
 			(concat emacs-root p))))
  (add-path "libs") ;; Personal elisp setup stuff
  (add-path "languages") ;; Language-specific configs
  (add-path "site-lisp")) ;; elisp stuff I find on the tubes

;; central Debian site-lisp paths
(add-to-list 'load-path "/usr/local/share/emacs/site-lisp")
(add-to-list 'load-path "/usr/share/emacs23/site-lisp")

;;;;;;; basic customizations ;;;;;;;

(load-library "my-utilities")
(load-library "my-options")
(load-library "my-fonts")
(load-library "my-keys")
(load-library "my-completion")

;;;;;; languages ;;;;;;;

(load-library "my-lisps")
(load-library "my-common-lisp")
(load-library "my-haskell")
(load-library "my-agda")
(load-library "my-c")
(load-library "my-c++")
(load-library "my-scheme")
(load-library "my-clojure")
(load-library "my-python")
(load-library "my-maxima")
;(load-library "my-matlab")
;(load-library "my-scilab")
(load-library "my-sage")
(load-library "my-ruby")
;(load-library "my-erlang")
(load-library "my-ocaml")
(load-library "my-octave")
;(load-library "my-gnuplot")
;(load-library "my-objc")

;;;;;;;; applications ;;;;;;;;
(load-library "my-browser")
(load-library "my-jabber")
(load-library "my-mail")

;;;;;;; handy tools ;;;;;;;;

(load-library "my-ido")
(load-library "my-tramp")
(load-library "my-mmm")
(load-library "my-flymake")
(load-library "my-cscope")
(load-library "my-git")
(load-library "my-yasnippet")
(load-library "my-predictive")
(load-library "my-lambdas")
(load-library "my-autocomplete")
(load-library "my-org")
(load-library "my-drela")

;;;;;;;;; frame-specific ;;;;;;;;;;

(add-hook 'server-visit-hook 'new-frame-settings)

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(quack-programs (quote ("mit-scheme-native" "bigloo" "csi" "csi -hygienic" "gsi" "gsi -:d-" "gsi ~~/syntax-case.scm -" "guile" "kawa" "mit-scheme" "rs" "scheme" "scheme48" "scmutils"))))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )
