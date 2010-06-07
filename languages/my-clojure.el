;;;;;; clojure setup ;;;;;;;;

(require 'my-lisps)

(add-to-list 'load-path "/home/peddie/software/clojure/clojure-mode")
(require 'clojure-mode)
(setq auto-mode-alist
      (append '(("\\.clj$" . clojure-mode)) auto-mode-alist))


;; Create ~/bin/clojure script which starts clojure repl and adds clojure-contrib src dir and swank-clojure src dir to classpath. I used clj-env helper from clojure-contrib

;;;; Slime configuration stuff
(setf slime-lisp-implementations
'((sbcl ("sbcl"))
  (clojure ("~/bin/clojure") :init swank-clojure-init)))

(require 'slime-autoloads)
(setf slime-use-autodoc-mode nil) ;; swank-clojure doesn't support autodoc-mode
(slime-setup '(slime-banner slime-repl slime-fancy slime-scratch slime-editing-commands slime-scratch slime-asdf))

(setf slime-net-coding-system 'utf-8-unix)

(add-to-list 'load-path "/home/peddie/software/clojure/swank-clojure")
(require 'swank-clojure)
(setq swank-clojure-jar-path "/home/peddie/software/clojure/clojure.jar")
(setf swank-clojure-binary "/home/username/bin/clojure")

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
