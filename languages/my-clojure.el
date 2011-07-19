;;;;;; clojure setup ;;;;;;;;

(require 'my-lisps)

(defvar my-clojure (concat my-home "software/clojure/"))
(add-to-list 'load-path (concat my-clojure "clojure-mode"))
(require 'clojure-mode)

(add-to-list 'load-path (concat emacs-root "site-lisp/swank-clojure"))
(require 'swank-clojure)
(setq swank-clojure-jar-path (concat my-clojure "clojure.jar"))
(setf swank-clojure-binary (concat my-bin "clojure"))

(setq auto-mode-alist
      (append '(("\\.clj$" . clojure-mode)) auto-mode-alist))

;; Create ~/bin/clojure script which starts clojure repl and adds clojure-contrib src dir and swank-clojure src dir to classpath. I used clj-env helper from clojure-contrib

(require 'slime-autoloads)
(setf slime-use-autodoc-mode nil) ;; swank-clojure doesn't support autodoc-mode
(slime-setup '(slime-banner slime-repl slime-fancy slime-scratch slime-editing-commands slime-scratch slime-asdf))

(setf slime-net-coding-system 'utf-8-unix)

(defun run-clojure ()
  "Runs clojure lisp REPL"
  (interactive)
  (slime 'clojure))

(defun run-ccl ()
  "Runs ccl lisp REPL"
  (interactive)
  (slime 'ccl))

;(require 'clojure-auto)
;(require 'swank-clojure-autoload)
;(setq swank-clojure-extra-classpaths (list "/home/peddie/.clojure.d/")))
