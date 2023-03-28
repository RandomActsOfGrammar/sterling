
(provide 'sos-ext-conc-mode)


;;automatically enter this mode for *.conc
(setq auto-mode-alist (cons '("\\.conc\\'" . sos-ext-conc-mode) auto-mode-alist))


;;hook for modifying the mode without modifying the mode
(defvar sos-ext-conc-mode-hook '()
  "*Hook for customizing SOS-Ext-Conc mode")


(defun sos-ext-conc-mode ()
  "Mode for editing SOS concrete modules."
  (interactive)
  (kill-all-local-variables)
  (setq major-mode `sos-ext-conc-mode)
  (setq mode-name "Sos-Ext Concrete Files")
  ;;syntax highlighting
  (set-syntax-table sos-ext-conc-syntax-table)
  (set (make-local-variable 'font-lock-defaults)
       '(sos-ext-conc-font-lock-keywords))
  (turn-on-font-lock)
  ;;hook for user changes
  (run-hooks 'sos-ext-conc-mode-hook))



(setq sos-ext-conc-keywords-list '("Module" "ignore"))
(setq sos-ext-conc-built-in-list '("$to_int"))

(defvar sos-ext-conc-font-lock-keywords
  (list
   ;;Keywords
   (cons
    (regexp-opt sos-ext-conc-keywords-list 'words)
    font-lock-keyword-face)
   (cons ; '...'  |  '~~>'
    "\\(\\.\\.\\.\\)\\|\\(~~>\\)"
    font-lock-keyword-face)
   ;;Built-in
   (cons
    (regexp-opt sos-ext-conc-built-in-list 'words)
    font-lock-builtin-face)
   ;;Regular /regex/
   (cons
    "/\\([^/\n]\\|\\(\\\\/\\)\\)+/"
    font-lock-string-face)
   ;;Types
   '("<\\([a-zA-Z0-9_-]+\\)>" (1 font-lock-type-face)) ;AST type
   '("\\([a-zA-Z0-9_-]+\\) *<" (1 font-lock-type-face)) ;concrete NT
   '("\\([a-zA-Z0-9_-]+\\) *::=" (1 font-lock-type-face)) ;concrete NT
   '("\[A-Z][a-zA-Z0-9_]*[ \n\t\r]*::[ \n\t\r]*\\([a-z][a-zA-Z0-9_]*\\)"
     (1 font-lock-type-face)) ;type for a production member
   ;;Terminal name
   '("\\(ignore\\) */.*/" (1 font-lock-keyword-face))
   '("\\([a-zA-Z0-9_-]+\\) */.*/" (1 font-lock-variable-name-face))
   ;;Production members
   '("[ \n\r\t(]\\(\[A-Z][a-zA-Z0-9_]*\\)"
     (1 font-lock-variable-name-face))
   '("\[A-Z][a-zA-Z0-9_]*[ \n\t\r]*::[ \n\t\r]*\\([a-z][a-zA-Z0-9_]*\\)"
     (1 font-lock-type-face)) ;type for a production member
   )
  )


(defvar sos-ext-conc-syntax-table
  (let ((table (make-syntax-table (standard-syntax-table))))
    (modify-syntax-entry ?/ ". 124" table)
    (modify-syntax-entry ?* ". 23bn" table)
    (modify-syntax-entry ?. ">" table)
    table))

