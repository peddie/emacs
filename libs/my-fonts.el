;;;;;; font configuration ;;;;;;;;

;; Old emacs fonts
;(set-default-font "-bitstream-bitstream vera serif-medium-r-normal--17-120-100-100-p-0-iso8859-1")
;(set-default-font "-adobe-courier-medium-r-normal--14-140-75-75-m-90-iso8859-1")

(defun fontify-frame (frame)
; (set-frame-parameter frame 'font "DejaVu Sans Mono-11:weight=book")
  (set-frame-parameter frame 'font "Monospace-12"))


;; X fonts now
(add-hook 'window-setup-hook
	  (lambda nil 
	    (if (display-graphic-p)
		;; Fontify current frame
		(fontify-frame nil)
	      ;; Fontify any future frames
	      (push 'fontify-frame after-make-frame-functions)
	      (set-frame-font "DejaVu Sans Mono-12:weight=book")
	      (set-fontset-font (frame-parameter nil 'font)
				'han '("cwTeXHeiBold" . "unicode-bmp")))))
