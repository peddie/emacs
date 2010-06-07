;;;;;; scilab ;;;;;;;

(load "scilab")
(setq auto-mode-alist (cons '("\\(\\.sci$\\|\\.sce$\\)" . scilab-mode) auto-mode-alist))
(setq scilab-mode-hook '(lambda () (setq fill-column 74)))
