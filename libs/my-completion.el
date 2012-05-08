;;;;;;; autocompletion is great ;;;;;;;;

; basic auto completion
;; (autoload 'complete "complete" "Completion mode, hopefully")
;; (partial-completion-mode t)

; abbreviations
(require 'dabbrev)
(setq dabbrev-always-check-other-buffers t)
(setq dabbrev-abbrev-char-regexp "\\sw\\|\\s_")
