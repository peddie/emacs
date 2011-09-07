;;; ediff mode for diff/merge

(require 'ediff)

(setq ediff-window-setup-function 'ediff-setup-windows-plain)
(setq ediff-split-window-function 'split-window-vertically)

(provide 'my-ediff)
