;;;;;;;;; SAGE mathematics ;;;;;;;;

(add-to-list 'load-path (expand-file-name (concat my-home "software/sage/data/emacs")))
(require 'sage "sage")
(setq sage-command (concat local-bin "sage"))

;; If you want sage-view to typeset all your output and have plot()
;; commands inline, uncomment the following line and configure sage-view:
(require 'sage-view "sage-view")
(add-hook 'sage-startup-hook 'sage-view-always 'sage-view-enable-inline-plots 'sage-view-enable-inline-output)

;; You can use commands like
;; (add-hook 'sage-startup-hook 'sage-view
;; 'sage-view-disable-inline-output 'sage-view-disable-inline-plots)
;; to have some combination of features.  In future, the customize interface
;; will make this simpler... hint, hint!

(add-hook 'sage-mode-hook
      '(lambda () ; taken from http://www.cs.caltech.edu/courses/cs11/material/python/misc/python_style_guide.html#TABS
         (set-variable 'py-indent-offset 4)
         (set-variable 'py-smart-indentation nil)
         (set-variable 'indent-tabs-mode nil) ))
