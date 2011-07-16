;;;;;;;;;;;;; OCaml ;;;;;;;;

(site-lisp-path "tuareg-mode")
; (add-to-list 'load-path "/usr/share/emacs/site-lisp/ocaml-mode")
(require 'tuareg)
(autoload 'camldebug "camldebug" "Run the Caml debugger" t)
(autoload 'tuareg-imenu-set-imenu "tuareg-imenu" 
  "Configuration of imenu for tuareg" t) ; (require 'camldebug-tuareg)
; (require 'tuareg-imenu-set-imenu) 

(add-hook 'tuareg-mode-hook 'tuareg-imenu-set-imenu)

(setq auto-mode-alist 
      (append '(("\\.ml[ily]?$" . tuareg-mode)
		("\\.topml$" . tuareg-mode))
	      auto-mode-alist))

(defun flymake-ocaml-init ()
  (flymake-simple-make-init-impl
   'flymake-create-temp-with-folder-structure nil nil
   (file-name-nondirectory buffer-file-name)
   'flymake-get-ocaml-cmdline))
(defun flymake-get-ocaml-cmdline (source base-dir)
  (list "ocaml_flycheck.pl"
	(list source base-dir)))

(push '(".+\\.ml[yilp]?$" flymake-ocaml-init flymake-simple-java-cleanup)
      flymake-allowed-file-name-masks)
(push
 '("^\\(\.+\.ml[yilp]?\\|\.lhs\\):\\([0-9]+\\):\\([0-9]+\\):\\(.+\\)"
   1 2 3 4) flymake-err-line-patterns)

;; optional setting
;; if you want to use flymake always, then add the following hook.
;; (add-hook
;;  'tuareg-mode-hook
;;  '(lambda ()
;;     (if (not (null buffer-file-name)) (flymake-mode))))
