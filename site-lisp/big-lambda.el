
(defvar big-lambda-image
  (create-image
   (base64-decode-string
    "/9j/4AAQSkZJRgABAQEASABIAAD/2wBDAAsICAoIBwsKCQoNDAsNERwSEQ8PESIZGhQcKSQrKigk
  JyctMkA3LTA9MCcnOEw5PUNFSElIKzZPVU5GVEBHSEX/2wBDAQwNDREPESESEiFFLicuRUVFRUVF
  RUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUVFRUX/wAARCAAwAEADASIA
  AhEBAxEB/8QAGgABAQEBAAMAAAAAAAAAAAAAAAUEAwIGB//EACgQAAEEAQIEBgMAAAAAAAAAAAEA
  AgMEERIhBTFhcQYUIjJBgRVRkf/EABcBAQEBAQAAAAAAAAAAAAAAAAABAwL/xAAcEQEBAQACAwEA
  AAAAAAAAAAAAAQIRIQMxQVH/2gAMAwEAAhEDEQA/APriIiAThZqvEKd5zxUtQzmP3CN4dj+Lyu1G
  XqklaRzmxyDDtJwSM7jsRsehWHiUbKlrh1qJgYWTCu7TtmN/p09g7QfpaYznXX1FVERZqIiICIiA
  ofiK6IvJV2t1vdZhkfv7I2yNy4/ZAHforM80deCSaZ4ZHG0uc48gBuSoTqE13g1+1Kwi5dj1MYec
  bW7xs+uZ6krfwyTU1r0lewIuNOyy5ThsR+yZgeOxGV2WNnF4qiIigIiIJd+N/EL8NIsd5WPE87iN
  n4PoZ13GT0AHyqiIurrmSfgixT/gpJa9hjxRc4vgmYwuEeTksdgbYJJB5YOPjffQuOvNllETo4Ne
  InPBaZG4GXYO4Gc4/eMrWi61ua7s7QREWav/2Q==")
   'jpeg t))

(defvar big-lambda-font-lock-keywords
  '((".+" (0 (prog1 nil
	       (big-lambda-remove-region
		(match-beginning 0) (match-end 0)))))
    ("(\\(lambda\\)\\>"
     (0 (prog1 nil
	  (big-lambda-region (match-beginning 1) (match-end 1)))))))

(defun big-lambda-remove-region (beg end)
  "Remove big lambda property in region between BEG and END."
  (let (pos)
    (while (setq pos (text-property-any beg end 'display big-lambda-image))
      (remove-text-properties
       pos
       (or (next-single-property-change pos 'display) end)
       '(display)))))

(defun big-lambda-region (beg end)
  "Add big lambda property in region between BEG and END."
  (put-text-property beg end 'display big-lambda-image))

(define-minor-mode big-lambda-mode
  "Display big lambda."
  :lighter " Lambda"
  (if big-lambda-mode
      (progn
	(save-restriction
	  (widen)
	  (let ((font-lock-keywords big-lambda-font-lock-keywords))
	    (font-lock-fontify-buffer)))
	(font-lock-add-keywords nil big-lambda-font-lock-keywords))
    (font-lock-remove-keywords nil big-lambda-font-lock-keywords)
    (save-restriction
      (widen)
      (let ((modified-p (buffer-modified-p)))
	(big-lambda-remove-region (point-min) (point-max))
	(set-buffer-modified-p modified-p)))))

(defun big-lambda-mode-turn-on ()
  "Turn on `big-lambda-mode'."
  (interactive)
  (big-lambda-mode 1))

(provide 'big-lambda)
