(add-to-list 'load-path (concat my-cabal "share/Agda-2.2.10/emacs-mode/"))

(eval-after-load 'agda2-mode 
  (unless (assoc "\\.agda" auto-mode-alist)
    (setq auto-mode-alist
	  (nconc '(("\\.agda" . agda2-mode)
		   ("\\.alfa" . agda2-mode)) auto-mode-alist))))

