;;; ratpoison-mode --- A summary

;;; Commentary:

;;; Code:

(defvar ratpoison-constants
  '("delete"
    "exec"
    "font"
    "focusleft"
    "focusright"
    "framesels"
    "meta"
    "other"
    "root"
    "select"
    "top"))

(defvar ratpoison-keywords
  '("bind" "definekey" "help" "newkmap" "readkey" "set" "unbind"))

(defvar ratpoison-tab-width nil "Width of a tab for ratpoison mode.")

;; Two small edits.
;; First is to put an extra set of parens () around the list
;; which is the format that font-lock-defaults wants
;; Second, you used ' (quote) at the outermost level where you wanted ` (backquote)
;; you were very close
(defvar ratpoison-font-lock-defaults
  `((
     ;; stuff between double quotes
     ("\"\\.\\*\\?" . font-lock-string-face)
     ;; ; : , ; { } =>  @ $ = are all special elements
     (":\\|,\\|;\\|{\\|}\\|=>\\|@\\|$\\|=" . font-lock-keyword-face)
     ( ,(regexp-opt ratpoison-keywords 'words) . font-lock-builtin-face)
     ( ,(regexp-opt ratpoison-constants 'words) . font-lock-constant-face)
     )))

(define-derived-mode ratpoison-mode text-mode "ratpoison rc file"
  "RATPOISON mode is a major mode for editing RATPOISON files"
  ;; you again used quote when you had '((ratpoison-hilite))
  ;; I just updated the variable to have the proper nesting (as noted above)
  ;; and use the value directly here
  (setq font-lock-defaults ratpoison-font-lock-defaults)

  ;; when there's an override, use it
  ;; otherwise it gets the default value
  (when ratpoison-tab-width
    (setq tab-width ratpoison-tab-width))

  ;; for comments
  ;; overriding these vars gets you what (I think) you want
  ;; they're made buffer local when you set them
  (setq comment-start "#")
  (setq comment-end "")

  (modify-syntax-entry ?# "< b" ratpoison-mode-syntax-table)
  (modify-syntax-entry ?\n "> b" ratpoison-mode-syntax-table)

  ;; Note that there's no need to manually call `ratpoison-mode-hook'; `define-derived-mode'
  ;; will define `ratpoison-mode' to call it properly right before it exits
  )

(add-to-list 'auto-mode-alist '("ratpoisonrc" . ratpoison-mode))

(provide 'ratpoison-mode)

;;; ratpoison-mode.el ends here
