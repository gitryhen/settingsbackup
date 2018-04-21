(prefer-coding-system 'utf-8)
(show-paren-mode t)
(global-set-key (kbd "C-x s") 'save-buffer)
;;
;; package init
;;
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)
;;
;; ido-mode
;;
(require 'ido-vertical-mode)
(ido-mode 1)
(ido-vertical-mode 1)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
;; open recent files faster (from mastering emacs 
(require 'recentf)
 
;; get rid of `find-file-read-only' and replace it with something
;; more useful.
(global-set-key (kbd "C-x C-r") 'ido-recentf-open)
 
;; enable recent files mode.
(recentf-mode t)
;; 50 files ought to be enough.
(setq recentf-max-saved-items 20)
(defun ido-recentf-open ()
  "Use `ido-completing-read' to \\[find-file] a recent file"
  (interactive)
  (if (find-file (ido-completing-read "Find recent file: " recentf-list))
      (message "Opening file...")
    (message "Aborting")))

;; evil-mode

;; (require 'evil)
;; ;; (require 'evil-leader)
;; ;; (global-evil-leader-mode)
;; ;; (evil-leader/set-leader "<SPC>")
;; ;; (evil-leader/set-key
;; ;;  "xr" 'helm-recentf
;; ;;  "xf" 'helm-find-files
;; ;;  "xb" 'helm-buffers-list
;; ;;  "w" 'save-buffer
;; ;;  "xs" 'save-buffer
;; ;;  "g" 'keyboard-quit
;; ;;  "xo" 'other-window
;; ;;  "x0" 'delete-window
;; ;;  "x1" 'delete-other-windows
;; ;;  "xk" 'kill-buffer)
;; (evil-mode t)
;; (global-set-key (kbd "<f1>") 'evil-mode)
;; (evil-set-initial-state 'ibuffer-mode 'normal)
;; (evil-set-initial-state 'bookmark-bmenu-mode 'normal)
;; (evil-set-initial-state 'dired-mode 'emacs)
;; (evil-set-initial-state 'sunrise-mode 'emacs)
;; (evil-set-initial-state 'org-mode 'emacs)
;; (require 'evil-surround)
;; (global-evil-surround-mode 1)
;; ;;(add-hook 'emacs-lisp-mode-hook 'evil-paredit-mode)

;; company
(require 'company)
(define-key company-active-map (kbd "C-n") 'company-select-next)
(define-key company-active-map (kbd "C-p") 'company-select-previous)

;; ;; helm
;; (require 'helm)
;; (require 'helm-config)
;; (helm-mode 1) ;; nodig voor tab regel hieronder
;; ;;(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)

;; (global-set-key (kbd "M-i") 'helm-swoop)
;; (global-set-key (kbd "C-x b") 'helm-buffers-list)
;; (global-set-key (kbd "C-x r b") 'helm-bookmarks)
;; (global-set-key (kbd "C-x m") 'helm-M-x)
;; (global-set-key (kbd "C-x C-f") 'helm-find-files)
;; (global-set-key (kbd "C-x C-r") 'helm-recentf)


;; show matching parens
(show-paren-mode t)

;;
;; no welcome
;;
(setq inhibit-startup-message t)
;;
;; no beep
;;
(setq visible-bell nil)
;;
;; org mode
;;
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(global-set-key (kbd "C-x s") 'save-buffer)

(fset 'yes-or-no-p 'y-or-n-p)
	
(setq confirm-nonexistent-file-or-buffer nil)

;; kill buffer with live buffer attached to it
(setq kill-buffer-query-functions
  (remq 'process-kill-buffer-query-function
         kill-buffer-query-functions))

(setq inferior-lisp-program "sbcl")	; your Lisp system
(require 'slime)
(slime-setup '(slime-fancy))
(require 'ac-slime)
(add-hook 'slime-mode-hook 'set-up-slime-ac)
(add-hook 'slime-repl-mode-hook 'set-up-slime-ac)
;;
;; discover
;;
(require 'discover)
(global-discover-mode 1)

;; (add-hook 'c++-mode-hook (lambda () (setq flycheck-gcc-language-standard "c++11")))
;; (add-hook 'c++-mode-hook (lambda () (setq flycheck-clang-languange-standard "c++11")))
(add-hook 'after-init-hook #'global-flycheck-mode)

;; ess
(require 'ess-site)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#3F3F3F" "#CC9393" "#7F9F7F" "#F0DFAF" "#8CD0D3" "#DC8CC3" "#93E0E3" "#DCDCCC"])
 '(custom-enabled-themes nil)
 '(custom-safe-themes
   (quote
    ("5e52ce58f51827619d27131be3e3936593c9c7f9f9f9d6b33227be6331bf9881" "cdfc5c44f19211cfff5994221078d7d5549eeb9feda4f595a2fd8ca40467776c" default)))
 '(fci-rule-color "#383838")
 '(nrepl-message-colors
   (quote
    ("#CC9393" "#DFAF8F" "#F0DFAF" "#7F9F7F" "#BFEBBF" "#93E0E3" "#94BFF3" "#DC8CC3")))
 '(org-agenda-files (quote ("~/Dropbox/org/gtd.org")))
 '(package-selected-packages
   (quote
    (ess zenburn-theme paredit ox-tufte ox-reveal ox-pandoc ox-html5slide ox-asciidoc monitor ido-vertical-mode github-theme flycheck-irony epc discover company-rtags company-irony-c-headers company-irony cmake-ide borland-blue-theme auctex adoc-mode ac-slime)))
 '(pdf-view-midnight-colors (quote ("#DCDCCC" . "#383838")))
 '(show-paren-mode t)
 '(vc-annotate-background "#2B2B2B")
 '(vc-annotate-color-map
   (quote
    ((20 . "#BC8383")
     (40 . "#CC9393")
     (60 . "#DFAF8F")
     (80 . "#D0BF8F")
     (100 . "#E0CF9F")
     (120 . "#F0DFAF")
     (140 . "#5F7F5F")
     (160 . "#7F9F7F")
     (180 . "#8FB28F")
     (200 . "#9FC59F")
     (220 . "#AFD8AF")
     (240 . "#BFEBBF")
     (260 . "#93E0E3")
     (280 . "#6CA0A3")
     (300 . "#7CB8BB")
     (320 . "#8CD0D3")
     (340 . "#94BFF3")
     (360 . "#DC8CC3"))))
 '(vc-annotate-very-old-color "#DC8CC3"))
;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(default ((t (:family "DejaVu Sans Mono" :foundry "unknown" :slant normal :weight normal :height 98 :width normal)))))
;; (put 'downcase-region 'disabled nil)
;; ;; (custom-set-faces
;; ;;  ;; custom-set-faces was added by Custom.
;; ;;  ;; If you edit it by hand, you could mess it up, so be careful.
;; ;;  ;; Your init file should contain only one such instance.
;; ;;  ;; If there is more than one, they won't work right.
;; ;;  )
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Fira Code" :foundry "unknown" :slant normal :weight normal :height 113 :width normal))))
 '(font-lock-builtin-face ((t nil)))
 '(font-lock-comment-face ((t (:foreground "gray58"))))
 '(font-lock-constant-face ((t nil)))
 '(font-lock-function-name-face ((t (:inherit bold))))
 '(font-lock-keyword-face ((t (:inherit underline))))
 '(font-lock-preprocessor-face ((t nil)))
 '(font-lock-regexp-grouping-backslash ((t (:inherit bold))))
 '(font-lock-string-face ((t (:inherit italic))))
 '(font-lock-type-face ((t nil)))
 '(font-lock-warning-face ((t (:inherit italic)))))
(put 'downcase-region 'disabled nil)

