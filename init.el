;;; .emacs

;;; path setup
(defconst my-home "/home/peddie/")
(defconst my-bin (concat my-home "bin/"))
(defconst local-bin "/usr/local/bin/")
(defconst emacs-root (concat my-home ".emacs.d/"))
(defconst emacs-site-lisp "/usr/share/emacs/site-lisp/")

(let ((default-directory emacs-root))
  (setq load-path (cons emacs-root load-path))
  (normal-top-level-add-subdirs-to-load-path))

;; ;; add all the elisp directories under ~/.emacs.d to my load path
(defun local-path (p) 
  (add-to-list 'load-path (concat emacs-root p)))
(defun site-lisp-path (p) 
  (add-to-list 'load-path (concat emacs-site-lisp p)))

(local-path "libs") ;; Personal elisp setup stuff
(local-path "languages") ;; Language-specific configs
(local-path "site-lisp") ;; elisp stuff I find on the tubes

;; central Debian site-lisp paths
(add-to-list 'load-path "/usr/local/share/emacs/site-lisp")
(add-to-list 'load-path "/usr/share/emacs23/site-lisp")

(setq warning-suppress-types nil) 

;;;;;;; basic customizations ;;;;;;;

(load-library "my-utilities")
(load-library "my-options")
(load-library "my-fonts")
(load-library "my-keys")
(load-library "my-completion")

;;;;;; languages ;;;;;;;

(load-library "my-lisps")
(load-library "my-common-lisp")
(load-library "my-qi")
(load-library "my-haskell")
(load-library "my-agda")
(load-library "my-c")
(load-library "my-c++")
(load-library "my-scheme")
(load-library "my-latex")
(load-library "my-python")
(load-library "my-maxima")
(ignore-errors (load-library "my-sage"))
(load-library "my-clojure")
(load-library "my-ruby")
(load-library "my-ocaml")
(load-library "my-octave")
(load-library "my-scala")
(load-library "my-matlab")

;(load-library "my-gnuplot")
;(load-library "my-objc")
;(load-library "my-erlang")
;(load-library "my-scilab")

;;;;;;;; applications ;;;;;;;;
(load-library "my-browser")
(load-library "my-jabber")
(load-library "my-mail")
;; (load-library "my-gnus")

;;;;;;; handy tools ;;;;;;;;

(load-library "my-ido")
(load-library "my-git")
(load-library "my-flymake")
(load-library "my-tramp")
(load-library "my-mmm")
(load-library "my-ediff")
(load-library "my-cscope")
(load-library "my-predictive")
(load-library "my-lambdas")
(load-library "my-autocomplete")
(load-library "my-org")
(load-library "my-drela")
(load-library "my-packages")

;(load-library "my-yasnippet")

;;;;;;;;; frame-specific ;;;;;;;;;;

(add-hook 'server-visit-hook 'new-frame-settings)

