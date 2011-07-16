;;;;;;;; Qi ;;;;;;;;

(require 'my-lisps)

(require 'qi-mode)

(add-to-list 'auto-mode-alist '("\\.qi$" . qi-mode))

(defun qi-init-cmd (port-filename coding-system)
  (format "%S\n\n"
          `(PROGN
            (FUNCALL (READ-FROM-STRING "SWANK:START-SERVER")
                     ,port-filename
                     :CODING-SYSTEM , (slime-coding-system-cl-name
coding-system)))))

(defun qi ()
  (interactive)
  ;; the below should be the path to your command (script) to start Qi
  (slime-start :program (concat my-bin "qi") 
               :init 'qi-init-cmd ))
