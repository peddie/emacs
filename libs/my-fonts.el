;;;;;; font configuration ;;;;;;;;

(setq my-font "DejaVu Sans Mono-13:weight=book")

(add-to-list 'default-frame-alist `(font . ,my-font))

(defun fontify-frame (frame)
; (set-frame-parameter frame 'font "DejaVu Sans Mono-11:weight=book")
  (set-frame-parameter frame 'font my-font))


;; X fonts now
;; (add-hook 'window-setup-hook
;; 	  (lambda nil 
;; 	    (if (display-graphic-p)
;; 		;; Fontify current frame
;; 		(fontify-frame nil)
;; 	      ;; Fontify any future frames
;; 	      (push 'fontify-frame after-make-frame-functions)
;; 	      (set-fontset-font (frame-parameter nil 'font)
;; 		  'han '("cwTeXHeiBold" . "unicode-bmp"))
;; 	      (set-frame-font my-font))))
