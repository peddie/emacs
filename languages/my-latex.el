;;; AucTEX

(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq TeX-save-query nil)
(setq TeX-PDF-mode t)

(set-variable (quote latex-run-command) "pdflatex")
(set-variable (quote tex-dvi-view-command) "evince")
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)

(provide 'my-latex)
