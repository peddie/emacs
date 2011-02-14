;;;;;;;;;;;; octave ;;;;;;;;;;

(add-to-list 'load-path "/home/peddie/.emacs.d/site-lisp/octave")
(require 'octave-mod)

(setq auto-mode-alist
      (append '(("\\.m$" . octave-mode)) auto-mode-alist))

(add-to-list 'octave-end-keywords "end[[:space:]]*\\([%#].*\\|$\\)")
(setq octave-block-end-regexp
      (concat "\\<\\("
	      (mapconcat 'identity octave-end-keywords "\\|")
	      "\\)\\>"))

(defun my-inferior-octave-listening-p ()
  "True if inferior octave is running and ready to receive input.
    Required for eldoc and other functions that try to get
    information from the running Octave, so they don't freeze emacs
    when Octave is busy doing something else."
  (and (boundp 'inferior-octave-process)
       inferior-octave-process
       (not inferior-octave-receive-in-progress)
       (eq (process-status inferior-octave-process) 'run)))

(defun my-octave-complete-symbol ()
  "Perform completion on Octave symbol preceding point.
    Compare that symbol against Octave's reserved words and builtin
    variables.  This is like the default Octave completer function,
    except that it also completes on structure fields."
  (interactive)
  ;; This code taken from lisp-complete-symbol
  (let* ((end (point))
	 (beg (save-excursion (backward-sexp 1) (point)))
	 (string (buffer-substring-no-properties beg end))
	 (completion (try-completion string octave-completion-alist)))
    (if completion
	(setq completion-list octave-completion-alist)
      (when (my-inferior-octave-listening-p)
	(setq completion-list
	      (save-excursion
		(inferior-octave-send-list-and-digest
		 (list (format "completion_matches(\"%s\");\n" string)))
		inferior-octave-output-list))
	(when completion-list
	  (setq completion
		(try-completion string inferior-octave-output-list)))))
    
    (cond ((eq completion t))           ; ???
	  ((null completion)
	   (message "Can't find completion for \"%s\"" string))
	  ((not (string= string completion))
	   (delete-region beg end)
	   (goto-char beg)
	   (insert completion))
	  (t
	   (let ((list (all-completions string completion-list))
		 (conf (current-window-configuration)))
	     ;; Taken from comint.el
	     (message "Making completion list...")
	     (with-output-to-temp-buffer "*Completions*"
	       (display-completion-list list))
	     (message "Hit space to flush")
	     (let (key first)
	       (if (save-excursion
		     (set-buffer (get-buffer "*Completions*"))
		     (setq key (read-key-sequence nil)
			   first (aref key 0))
		     (and (consp first) (consp (event-start first))
			  (eq (window-buffer (posn-window (event-start
							   first)))
			      (get-buffer "*Completions*"))
			  (eq (key-binding key) 'mouse-choose-completion)))
		   (progn
		     (mouse-choose-completion first)
		     (set-window-configuration conf))
		 (if (eq first ?\ )
		     (set-window-configuration conf)
		   (setq unread-command-events
			 (listify-key-sequence key))))))))))


