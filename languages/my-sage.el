;;;;;;;;; SAGE mathematics ;;;;;;;;

(add-to-list 'load-path (expand-file-name "$SAGE_DATA/emacs"))
;(require 'sage "sage")
;(setq sage-command "$SAGE_ROOT/sage")

;; If you want sage-view to typeset all your output and have plot()
;; commands inline, uncomment the following line and configure sage-view:
;; (require 'sage-view "sage-view")
;; (add-hook 'sage-startup-hook 'sage-view)
;; You can use commands like
;; (add-hook 'sage-startup-hook 'sage-view
;; 'sage-view-disable-inline-output 'sage-view-disable-inline-plots)
;; to have some combination of features.  In future, the customize interface
;; will make this simpler... hint, hint!
