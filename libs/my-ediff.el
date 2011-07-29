;;; ediff mode for diff/merge

(require 'ediff)

(add-hook 'ediff-before-setup-hook 'new-frame)
(add-hook 'ediff-quit-hook 'delete-frame)
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

(provide 'my-ediff)
