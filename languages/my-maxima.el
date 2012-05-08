

;;;;; imaxima and imath from http://sites.google.com/site/imaximaimath/download-and-install ;;;;

(push "/usr/local/share/maxima/5.26.0/emacs" load-path)
(autoload 'maxima-mode "maxima" "Maxima editing mode" t)
(autoload 'maxima "maxima" "Running Maxima interactively" t) 
(autoload 'imaxima "imaxima" "Maxima frontend" t)
(autoload 'imath "imath" "Interactive Math mode" t)
(autoload 'imath-mode "imath" "Interactive Math mode" t)

; (setq maxima-info-dir "/usr/local/lib/maxima-5.5/info") 

(setq imaxima-tex-program "pdflatex")
(setq imaxima-latex-preamble "\\usepackage{color}")
(setq imaxima-use-maxima-mode-flag t)
(setq imaxima-fnt-size "Large")
(setq imaxima-pt-size 12)
(setq imaxima-print-tex-command "pdflatex %s; evince %s &")
