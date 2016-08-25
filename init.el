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
(add-to-list 'load-path "C:/users/samee/.emacs.d/lisp")
;; view line and column number
(custom-set-variables
 '(column-number-mode t)
 '(line-number-mode t))
(custom-set-faces
 )
(setq inhibit-startup-screen t)
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
;;
;;
;;     NXN Develeopment, Fortran Workflow stuffs
;;
;;
;;
;; Global Key bindings
;;
;; Setting tags-file for NXN source browsing
(setq tags-file-name
  (concat (getenv "NXN_TOOLS_BASE") "/nastran1/TAGS"))
;; perforce nxn_put command 
(defun my-nxn-put()
    (interactive)
      (shell-command (concat "nxn_put " (file-name-nondirectory buffer-file-name))))
;; fortran comment key binding and other settings
;; fortran compile command
(defun my-fortran-compile()
    (interactive)
      (shell-command (concat "nxn_compile -d " (file-name-nondirectory buffer-file-name))))
;; fortran link command
(defun my-fortran-link()
    (interactive)
      (shell-command (concat "nxn_link -d *.obj")))
;;
;; Fortran mode Key bindings
;;
(defun my-fortran-mode-config ()
  "For use in `fortran-mode-hook'."
  (local-set-key (kbd "C-x /") 'comment-region) 
  (local-set-key (kbd "C-x \\") 'uncomment-region)
  (local-set-key (kbd "C-x c") 'my-fortran-compile)
  (local-set-key (kbd "C-x j") 'my-fortran-link)
  (local-set-key (kbd "C-x p") 'my-nxn-put)
  (setq fortran-comment-region "C ")
;; more here
  )
;; add to hook
(add-hook 'fortran-mode-hook 'my-fortran-mode-config)
;; Custom mode for dmap and nastran input deck
(require 'dmap-mode)
(add-to-list 'auto-mode-alist '("\\.ddl\\'" . dmap-mode))
(add-to-list 'auto-mode-alist '("\\.dat\\'" . dmap-mode))
;; DMAP mode key binding
(defun my-dmap-mode-config ()
  "For use in `dmap-mode-hook'."
  (local-set-key (kbd "C-x /") 'comment-region) 
  (local-set-key (kbd "C-x \\") 'uncomment-region)
  (local-set-key (kbd "C-x p") 'my-nxn-put)
;; more here
  )
(defun test-hook ()
  (message "Testing hook"))
;; add to hook
(add-hook 'dmap-mode-hook 'my-dmap-mode-config)
;; Reload file with M-x load-flie after making change
;;
