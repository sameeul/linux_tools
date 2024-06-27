;;
;;
;;     Visual and other configuration
;;
;;
;; Start server if not started yet
(require 'server)
(unless (server-running-p)
  (server-start))
;; distraction free mode
(scroll-bar-mode 0)    ; Turn off scrollbars.
(tool-bar-mode 0)      ; Turn off toolbars.
(fringe-mode 0)        ; Turn off left and right fringe cols.
(menu-bar-mode 0)      ; Turn off menus.
; Change yes/no questions to y/n type.
(fset 'yes-or-no-p 'y-or-n-p)       
;; Set location for external packages.
;;(add-to-list 'load-path "C:/users/samee/.emacs.d/lisp")
;; view line and column number
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(line-number-mode t)
 ;;'(org-agenda-files (quote ("d:/Scratch/NXN12_ToDo.org")
  )
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;; set up default font
(when (member "Droid Sans Mono" (font-family-list))
    (add-to-list 'initial-frame-alist '(font . "Droid Sans Mono-10"))
    (add-to-list 'default-frame-alist '(font . "Droid Sans Mono-10")))
(setq inhibit-startup-screen t)
;; check before quit
(setq confirm-kill-emacs 'yes-or-no-p)
(setq ps-print-header nil)
;; store all backup and autosave files in the tmp dir
(setq backup-directory-alist
`((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
`((".*" ,temporary-file-directory t)))
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
;;stop auto indenting
(add-hook 'after-change-major-mode-hook (lambda() (electric-indent-mode -1)))
;;setting black background and white foreground
(add-to-list 'default-frame-alist '(foreground-color . "black"))
(add-to-list 'default-frame-alist '(background-color . "grey"))
;; C-x k for both server edit and kill buffer
;;https://snarfed.org/dotfiles/.emacs
(defun server-edit-or-close ()
  "Saves and calls `server-edit', if opened by server, or kills buffer."
  (interactive)
;;  (save-buffer)
  (if server-buffer-clients
      (server-edit)
    (kill-this-buffer)))
(global-set-key (kbd "C-x k") 'server-edit-or-close)
;; key binding for window resize
(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>") 'shrink-window)
(global-set-key (kbd "S-C-<up>") 'enlarge-window)
;; closing all the buffers
(defun close-all-buffers ()
  (interactive)
  (mapc 'kill-buffer (buffer-list)))
(global-set-key (kbd "C-x a") 'close-all-buffers)
;; closing all but current buffer
(defun close-all-but-curr-buffers()
  (interactive)
  (mapc 'kill-buffer (delq (current-buffer) (buffer-list))))
(global-set-key (kbd "C-x q") 'close-all-but-curr-buffers)
;; move around windows
(global-set-key (kbd "C-x C-<up>") 'windmove-up)
(global-set-key (kbd "C-x C-<down>") 'windmove-down)
(global-set-key (kbd "C-x C-<right>") 'windmove-right)
(global-set-key (kbd "C-x C-<left>") 'windmove-left)
;; display time
(setq display-time-default-load-average nil)
(display-time-mode 1)
;; no tab
(setq indent-tabs-mode nil)
(add-hook 'python-mode-hook '(lambda () 
 (setq python-indent 4)))
;; Reload file with M-x load-flie after making change
;;
