(require 'package) 

(setq package-archives
      '(("elpy" . "http://jorgenschaefer.github.io/packages/")
        ("melpa" . "https://melpa.org/packages/")
        ("gnu" . "http://elpa.gnu.org/packages/")
        ("melpa-stable" . "https://stable.melpa.org/packages/")))

(package-initialize)

(eval-after-load 'company
  '(add-to-list 'company-backends 'company-irony))

;; Vertical line
(add-hook 'prog-mode-hook #'display-fill-column-indicator-mode)

(setq column-number-mode t)

;; Show line containing opening parenthesis
(show-paren-mode 1)
(setq show-paren-delay 0)

;; Line numbers
(setq display-line-numbers-type 'absolute) 
(global-display-line-numbers-mode)

;; Indentation
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq c-basic-offset 4)

(defun my-indent-setup ()
  (c-set-offset 'arglist-intro '+))
(add-hook 'c-mode-hook 'my-indent-setup)

(c-set-offset 'case-label '+)

(add-to-list 'c-offsets-alist '(arglist-close . c-lineup-close-paren))
(setq cperl-indent-parens-as-block t)
(setq perl-indent-parens-as-block t)

(setq indent-line-function 'insert-tab)

(defvar match-paren--idle-timer nil)
(defvar match-paren--delay 0.5)
(setq match-paren--idle-timer 
     (run-with-idle-timer match-paren--delay t #'blink-matching-open))

(add-to-list 'custom-theme-load-path "~/vscode-dark-plus.el")
(load-theme 'vscode-dark-plus t)

(defun my-set-margins ()
  "Set margins in current buffer."
  (setq left-margin-width 24)
  (setq right-margin-width 24))

(add-hook 'text-mode-hook 'my-set-margins)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t)
 '(package-selected-packages
   '(company-irony tabbar session pod-mode muttrc-mode mutt-alias markdown-mode initsplit htmlize graphviz-dot-mode folding eproject diminish csv-mode company color-theme-modern browse-kill-ring boxquote bm bar-cursor apache-mode vscode-dark-plus-theme auto-complete)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(defun open-cheat-sheet ()
  "Open the Emacs cheat sheet buffer in a side window."
  (let ((cheat-sheet-file (expand-file-name "~/emacs_cheat_sheet.md"))
        (main-buffer (current-buffer)))
    (when (file-exists-p cheat-sheet-file)
      (split-window-right)          ; Split the window vertically
      (other-window 1)              ; Switch to the new window
      (find-file cheat-sheet-file)  ; Open the cheat sheet file
      (setq buffer-read-only t)     ; Make the buffer read-only
      (other-window -1)             ; Switch back to the main window
      (select-window (get-buffer-window main-buffer))))) ; Focus back on the main buffer

;; Open the cheat sheet in a side window on startup
(add-hook 'emacs-startup-hook 'open-cheat-sheet)
