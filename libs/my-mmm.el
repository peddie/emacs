;;;;; multiple major modes ;;;;;;

(add-to-list 'load-path "/home/peddie/.emacs.d/site-lisp/mmm-mode")
(autoload 'mmm-mode "mmm-mode" "multiple major modes for emacs")


(defun my-mmm-mode ()
 ;; go into mmm minor mode when class is given
 (make-local-variable 'mmm-global-mode)
 (setq mmm-global-mode 'true))

(setq mmm-submode-decoration-level 0)
