(add-to-list 'load-path "/home/peddie/.cabal/share/Agda-2.2.6/emacs-mode/")

(require 'agda2-mode "agda2-mode.el")
(unless (assoc "\\.agda" auto-mode-alist)
  (setq auto-mode-alist
        (nconc '(("\\.agda" . agda2-mode)
                 ("\\.alfa" . agda2-mode)) auto-mode-alist)))
