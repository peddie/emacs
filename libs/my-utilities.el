;;;;;;; utility functions ;;;;;;;;

;; most of this stuff is just swiped from the emacs wiki or from
;; random usenet posts.  

(defun unfill-paragraph ()
  (interactive)
  (let ((fill-column (point-max)))
    (fill-paragraph nil)))

(defun my-tab (&optional pre-arg)
  "If preceeding character is part of a word then dabbrev-expand,
else if right of non whitespace on line then tab-to-tab-stop or
indent-relative, else if last command was a tab or return then dedent
one step, else indent 'correctly'"
  (interactive "*P")
  (cond ((= (char-syntax (preceding-char)) ?w)
         (let ((case-fold-search t)) (dabbrev-expand pre-arg)))
        ((> (current-column) (current-indentation))
         (indent-relative))
        (t (indent-according-to-mode)))
  (setq this-command 'my-tab))

(defadvice kill-ring-save (before slick-copy activate compile) "When called
  interactively with no active region, copy a single line instead."
  (interactive (if mark-active (list (region-beginning) (region-end)) (message
								       "Copied line") (list (line-beginning-position) (line-beginning-position
														       2)))))

(defadvice kill-region (before slick-cut activate compile)
  "When called interactively with no active region, kill a single line instead."
  (interactive
   (if mark-active (list (region-beginning) (region-end))
       (list (line-beginning-position)
	     (line-beginning-position 2)))))

;;; fullscreen for GNOME
(defun fullscreen ()
  (interactive)
  (set-frame-parameter nil 'fullscreen
		       (if (frame-parameter nil 'fullscreen) nil 'fullboth)))

(global-set-key [f11] 'fullscreen)

(defun cur-file ()
  "Return the filename (without directory) of the current buffer"
  (file-name-nondirectory (buffer-file-name (current-buffer))))

(defun autocompile nil
  "compile self if elisp file"
  (interactive)
  (require 'bytecomp)
  (if (or (string= (file-name-extension (cur-file)) "el")
	  (string= (file-name-extension (cur-file)) "elisp")
	  (string= (cur-file) ".emacs"))
      (byte-compile-file (cur-file)
			 )))

(add-hook 'after-save-hook 'autocompile)

					; Thanks to Steve Yegge's page
(defun rename-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME." (interactive "sNew name: ")
  (let ((name (buffer-name))
	(filename (buffer-file-name)))
    (if (not filename)
	(message "Buffer '%s' is not visiting a file!" name)
	(if (get-buffer new-name)
	    (message "A buffer named '%s' already exists!" new-name)
	    (progn 	 (rename-file name new-name 1) 	 (rename-buffer new-name) 	 (set-visited-file-name new-name) 	 (set-buffer-modified-p nil)))))) ;;
(defun move-buffer-file (dir)
  "Moves both current buffer and file it's visiting to DIR." (interactive "DNew directory: ")
  (let* ((name (buffer-name))
	 (filename (buffer-file-name))
	 (dir
	  (if (string-match dir "\\(?:/\\|\\\\)$")
	      (substring dir 0 -1) dir))
	 (newname (concat dir "/" name)))

    (if (not filename)
	(message "Buffer '%s' is not visiting a file!" name)
	(progn 	(copy-file filename newname 1) 	(delete-file filename) 	(set-visited-file-name newname) 	(set-buffer-modified-p nil) 	t)))) 



(defun client-save-kill-emacs(&optional display)
  " This is a function that can bu used to shutdown save buffers and 
shutdown the emacs daemon. It should be called using 
emacsclient -e '(client-save-kill-emacs)'.  This function will
check to see if there are any modified buffers or active clients
or frame.  If so an x window will be opened and the user will
be prompted."

  (let (new-frame modified-buffers active-clients-or-frames)

					; Check if there are modified buffers or active clients or frames.
    (setq modified-buffers (modified-buffers-exist))
    (setq active-clients-or-frames ( or (> (length server-clients) 1)
					(> (length (frame-list)) 1)
					))  

					; Create a new frame if prompts are needed.
    (when (or modified-buffers active-clients-or-frames)
      (when (not (eq window-system 'x))
	(message "Initializing x windows system.")
	(x-initialize-window-system))
      (when (not display) (setq display (getenv "DISPLAY")))
      (message "Opening frame on display: %s" display)
      (select-frame (make-frame-on-display display '((window-system . x)))))

					; Save the current frame.  
    (setq new-frame (selected-frame))


					; When displaying the number of clients and frames: 
					; subtract 1 from the clients for this client.
					; subtract 2 from the frames this frame (that we just created) and the default frame.
    (when ( or (not active-clients-or-frames)
	       (yes-or-no-p (format "There are currently %d clients and %d frames. Exit anyway?" (- (length server-clients) 1) (- (length (frame-list)) 2)))) 
      
					; If the user quits during the save dialog then don't exit emacs.
					; Still close the terminal though.
      (let((inhibit-quit t))
					; Save buffers
	(with-local-quit
	 (save-some-buffers)) 
	
	(if quit-flag
	    (setq quit-flag nil)  
					; Kill all remaining clients
	    (progn
	     (dolist (client server-clients)
		     (server-delete-client client))
					; Exit emacs
	     (kill-emacs))) 
	))

					; If we made a frame then kill it.
    (when (or modified-buffers active-clients-or-frames) (delete-frame new-frame))
    )
  )


(defun modified-buffers-exist() 
  "This function will check to see if there are any buffers
that have been modified.  It will return true if there are
and nil otherwise. Buffers that have buffer-offer-save set to
nil are ignored."
  (let (modified-found)
    (dolist (buffer (buffer-list))
	    (when (and (buffer-live-p buffer)
		       (buffer-modified-p buffer)
		       (not (buffer-base-buffer buffer))
		       (or
			(buffer-file-name buffer)
			(progn
			 (set-buffer buffer)
			 (and buffer-offer-save (> (buffer-size) 0))))
		       )
	      (setq modified-found t)
	      )
	    )
    modified-found
    )
  )

(defun new-frame-settings ()
  (load-library "my-options")
  (load-library "my-utilities"))

;; from http://www.xach.com/lisp/scratch-lisp-file.el

(defun scratch-lisp-file ()
  "Insert a template (with DEFPACKAGE and IN-PACKAGE forms) into
  the current buffer."
  (interactive)
  (goto-char 0)
  (let* ((file (file-name-nondirectory (buffer-file-name)))
         (package (file-name-sans-extension file)))
    (insert ";;;; " file "\n")
    (insert "\n(defpackage #:" package "\n  (:use #:cl))\n\n")
    (insert "(in-package #:" package ")\n\n")))

(defun my-insert-timeofday ()
  "function to insert time of day at point . format: DayOfWeek, Date Month Year	24hrTime"
  (interactive)
  (let (localstring mytime)
    (setq localstring (current-time-string))
					; example:  Mon, 17 Jun 96  12:52
    (setq mytime (concat (substring localstring 0 3)  ;day-of-week
			 ", " 
			 (substring localstring 8 10) ;day number
			 " "
			 (substring localstring 4 7)  ;month 
			 " "
			 (substring localstring 22 24 ) ;2-digit year
			 "  "
			 (substring localstring 11 16 ) ;24-hr time
			 "\n"
			 ))
    (insert mytime))
  ) 


(defun increment-number-at-point ()
  (interactive)
  (skip-chars-backward "0123456789")
  (or (looking-at "[0123456789]+")
      (error "No number at point"))
  (replace-match (number-to-string (1+ (string-to-number (match-string 0))))))

(defun my-increment-number-decimal (&optional arg)
  "Increment the number forward from point by 'arg'."
  (interactive "p*")
  (save-excursion
   (save-match-data
    (let (inc-by field-width answer)
      (setq inc-by (if arg arg 1))
      (skip-chars-backward "0123456789")
      (when (re-search-forward "[0-9]+" nil t)
	(setq field-width (- (match-end 0) (match-beginning 0)))
	(setq answer (+ (string-to-number (match-string 0) 10) inc-by))
	(when (< answer 0)
	  (setq answer (+ (expt 10 field-width) answer)))
	(replace-match (format (concat "%0" (int-to-string field-width) "d")
			       answer)))))))

(defun my-decrement-number-decimal (&optional arg)
  (interactive "p*")
  (my-increment-number-decimal (if arg (- arg) -1)))


(defface register-marker-face '((t (:background "grey")))
  "Used to mark register positions in a buffer."
  :group 'faces)

(defun set-register (register value)
  "Set Emacs register named REGISTER to VALUE.  Returns VALUE.
    See the documentation of `register-alist' for possible VALUE."
  (let ((aelt (assq register register-alist))
	(sovl (intern (concat "point-register-overlay-"
			      (single-key-description register))))
	)
    (when (not (boundp sovl))
      (set sovl (make-overlay (point)(point)))
      (overlay-put (symbol-value sovl) 'face 'register-marker-face)
      (overlay-put (symbol-value sovl) 'help-echo
		   (concat "Register: `"
			   (single-key-description register) "'")))
    (delete-overlay (symbol-value sovl))
    (if (markerp value)
	;; I'm trying to avoid putting overlay on newline char
	(if (and (looking-at "$")(not (looking-back "^")))
	    (move-overlay (symbol-value sovl) (1- value) value)
	    (move-overlay (symbol-value sovl) value (1+ value))))
    (if aelt
	(setcdr aelt value)
	(push (cons register value) register-alist))
    value))

(defun dec-to-hex (&optional decnum)
  (kill-new 
   (format "%X" 
	   (string-to-number 
	    (if decnum 
		decnum 
		(word-at-point))))))


(fset 'git-resolve-conflict-mine
      [?\C-s ?< ?< ?< ?< ?\C-m ?\C-a ?\C-  ?\C-s ?= ?= ?= ?\C-m ?\C-n ?\C-a ?\C-w ?\C-s ?> ?> ?> ?> ?\C-a ?\C-k ?\C-k])

;;; This has functions meant for quickly taking test values from
;;; Octave and putting them in the current buffer.  

(defun test-copy (name &optional octname)
  "Copy a test value by name from the Octave buffer into the
  current buffer as an initialization value.

Returns no value.  The current buffer is assumed to contain a C
or C++ file.  It allocates a const double at the point in the
current buffer by name NAME and populates it with the value of
name OCTNAME in the octave buffer.  If OCTNAME is omitted, the
names are assumed to be the same."
  (interactive "sName:")
  (let ((str (if (stringp name) name (symbol-name name)))
	(cur (buffer-name))
        (octstr (if octname 
                    (if (stringp octname) 
                        octname 
                        (symbol-name octname)) 
                    str))
	p1 p2)
    (insert "const Vec" (number-to-string size) " " str " = {  };")
    (backward-char 3)
    (switch-to-buffer "*Inferior Octave*")
    (goto-char (point-max))
    (insert str)
    (comint-send-input)
    (goto-char (point-max))
    (previous-line (+ size 2))
    (move-beginning-of-line 'nil)
    (setq p1 (point))
    (next-line size)
    (move-end-of-line 'nil)
    (setq p2 (point))
    (kill-ring-save p1 p2)
    (switch-to-buffer cur)
    (yank)
    (previous-line size)
    (move-end-of-line 'nil)
    (insert ",")
    (search-backward "{")
    (forward-char 1)
    (backward-delete-char (- (skip-chars-forward " ") 1))
    (dotimes (lineno (- size 1) 'nil)
    	     (next-line 1)
    	     (move-end-of-line 'nil)
    	     (insert ","))
    (delete-backward-char 1)
    (delete-forward-char 1)
    (previous-line (- size 1))
    (move-beginning-of-line 'nil)
    (setq p1 (point))
    (next-line (- size 1))
    (move-end-of-line 'nil)
    (setq p2 (point))
    (indent-region p1 p2)))

(defun test-vector-copy (name size &optional octname)
  "Copy a test vector by name from the Octave buffer into the
  current buffer as a struct initialization value.  

Returns no value.  The current buffer is assumed to contain a C
or C++ file.  It allocates a const Vec<SIZE> vector at the point
in the current buffer by name NAME and populates it with the
elements of the vector of name OCTNAME in the octave buffer.  If
OCTNAME is omitted, the names are assumed to be the same."
  (interactive "sName: \nnSize: ")
  (let* ((str (if (stringp name) name (symbol-name name)))
	 (cur (buffer-name))
	 (octstr (if octname 
		     (if (stringp octname) 
			 octname 
			 (symbol-name octname)) 
		     str))
	 p1 p2)
    (if (< size 5)
	(insert "const Vec" (number-to-string size) " " str " = {  };")
	(insert "const double d" str "[" (number-to-string size) "] = {  };"))
    (backward-char 3)
    (switch-to-buffer "*Inferior Octave*")
    (goto-char (point-max))
    (insert str)
    (comint-send-input)
    (sleep-for 0.5)
    (goto-char (point-max))
    (previous-line (+ size 1))
    (move-beginning-of-line 'nil)
    (setq p1 (point))
    (next-line size)
    (move-end-of-line 'nil)
    (setq p2 (point))
    (kill-ring-save p1 p2)
    (switch-to-buffer cur)
    (yank)
    (previous-line size)
    (move-end-of-line 'nil)
    (insert ",")
    (search-backward "{")
    (forward-char 1)
    (backward-delete-char (- (skip-chars-forward " ") 1))
    (dotimes (lineno (- size 1) 'nil)
    	     (next-line 1)
    	     (move-end-of-line 'nil)
    	     (insert ","))
    (delete-backward-char 1)
    (delete-forward-char 1)
    (previous-line (- size 1))
    (move-beginning-of-line 'nil)
    (setq p1 (point))
    (next-line (- size 1))
    (move-end-of-line 'nil)
    (setq p2 (point))
    (indent-region p1 p2)
    (if (< size 5)
	'nil
	(progn
	 (newline-and-indent)
	 (insert "const VecN " str " = { length = " (number-to-string size) ", d = &d" str "[0] };")))
    (newline-and-indent)))


(defun format-matrix-line ()
  (insert "{")
  (skip-chars-forward "-.0-9")
  (backward-delete-char 2)
  (insert ",")
  (dotimes (lineno (- size 2) 'nil)
	   (skip-chars-forward "-.0-9")
	   (backward-delete-char 2)
	   (insert ","))
  (skip-chars-forward " ")
  (skip-chars-forward "-.0-9")
  (insert "}"))

(defun test-matrix-copy (name size &optional octname)
  "Copy a test matrix by name from the Octave buffer into the
  current buffer as a struct initialization value.  

Returns no value.  The current buffer is assumed to contain a C
or C++ file.  It allocates a const Mat<SIZE> matrix at the point
in the current buffer by name NAME and populates it with the
elements of the matrix of name OCTNAME in the octave buffer.  If
OCTNAME is omitted, the names are assumed to be the same."
  (interactive "sName: \nnSize: ")
  (let* ((str (if (stringp name) name (symbol-name name)))
	 (cur (buffer-name))
	 (octstr (if octname 
		     (if (stringp octname) 
			 octname 
			 (symbol-name octname)) 
		     str))
	 p1 p2)
    (insert "const Mat" (number-to-string size) " " str " = {  };")
    (backward-char 3)
    (switch-to-buffer "*Inferior Octave*")
    (goto-char (point-max))
    (insert str)
    (comint-send-input)
    (sleep-for 0.5)
    (goto-char (point-max))
    (previous-line (+ size 1))
    (move-beginning-of-line 'nil)
    (setq p1 (point))
    (next-line size)
    (move-end-of-line 'nil)
    (setq p2 (point))
    (kill-ring-save p1 p2)
    (switch-to-buffer cur)
    (yank)
    (next-line 1)
    (move-end-of-line 'nil)
    (setq p2 (point))
    (search-backward "const")
    (move-beginning-of-line 'nil)
    (setq p1 (point))
    (move-end-of-line 'nil)
    (insert "},")
    (search-backward "{")
    (insert "{{")
    (replace-regexp "\\([0-9]\\)[ ]+\\(-?[0-9]\\)" "\\1, \\2" 'nil p1 p2)
    (replace-regexp "{[ ]+\\(-?[0-9]\\)" "{\\1" 'nil p1 p2)
    (replace-regexp "^\\([ ]+\\)\\(-?[0-9].*\\)[ ]*$" "\\1{\\2}," 'nil p1 p2)
    (delete-backward-char 1)
    (delete-forward-char 1)
    (indent-region p1 p2)
    (insert "}")
    (skip-chars-forward ";")
    (move-end-of-line 'nil)
    (newline-and-indent)))

(defalias 'tc 'test-copy)
(defalias 'tvc 'test-vector-copy)
(defalias 'tmc 'test-matrix-copy)

(defun reformat-file ()
  (interactive)
  (untabify (point-min) (point-max))
  (replace-regexp "^\\([ ]+\\)?\\([^\\(//\\)\n].*[^ \n]\\)?\\([ ]+\\)//\\([ ]+\\)?\\(.*\\)$" "\\2  // \\5" 'nil (point-min) (point-max))
  (replace-regexp "[ ]+$" "" 'nil (point-min) (point-max))
  (indent-region (point-min) (point-max)))

(defun open-code-and-reformat-file ()
  (interactive)
  (ido-find-file)
  (reformat-file)
  (save-buffer)
  (kill-buffer))

