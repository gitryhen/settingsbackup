(prefer-coding-system 'utf-8)
;; (global-set-key (kbd "C-x s") 'save-buffer)

;; yes-or-no
(fset 'yes-or-no-p 'y-or-n-p)

;; ;;
;; ;; ido
;; ;;
;; (require 'ido)
;; (ido-vertical-mode t)
;; (setq ido-enable-flex-matching t)
;; (setq ido-everywhere t) 
;; (ido-mode 1)
;; (setq inhibit-startup-message t
;;       inhibit-startup-echo-area-message t)
;; ;; open recent files faster (from mastering emacs 
(require 'recentf)
(add-hook 'find-file-hook 'recentf-save-list) 
(run-at-time nil (* 5 60) 'recentf-save-list)
;; ;; get rid of `find-file-read-only' and replace it with something
;; ;; more useful.
;; (global-set-key (kbd "C-x C-r") 'ido-recentf-open)
;; (recentf-mode t)
;; 50 files ought to be enough.
;; (setq recentf-max-saved-items 30)
;; (defun ido-recentf-open ()
;;   "Use `ido-completing-read' to \\[find-file] a recent file"
;;   (interactive)
;;   (if (find-file (ido-completing-read "Find recent file: " recentf-list))
;;       (message "Opening file...")
;;     (message "Aborting")))

(require 'package)
(package-initialize)
;; company
(require 'company)
(define-key company-active-map (kbd "C-n") 'company-select-next)
(define-key company-active-map (kbd "C-p") 'company-select-previous)
(add-to-list 'company-backends 'company-c-headers)
;; elpy
(setq indent-tabs-mode nil)
(elpy-enable)
(setq python-shell-interpreter "python"
      python-shell-interpreter-args "-i")
;; (setq python-shell-interpreter "jupyter"
;;       python-shell-interpreter-args "console --simple-prompt"
;;       python-shell-prompt-detect-failure-warning nil)
;; (add-to-list 'python-shell-completion-native-disabled-interpreters
;;              "jupyter")
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")))
(add-to-list 'package-archives
'("melpa" . "http://melpa.org/packages/") t)
;;
;; slime
;;
(setq inferior-lisp-program "/usr/bin/clisp") ; your Lisp system
(add-to-list 'load-path "~/.emacs.d/slime/")  ; your SLIME directory
(require 'slime)
(slime-setup '(slime-fancy))
(require 'ac-slime)
(add-hook 'slime-mode-hook 'set-up-slime-ac)
(add-hook 'slime-repl-mode-hook 'set-up-slime-ac)
(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes 'slime-repl-mode))
(add-hook 'lisp 'paredit-mode)
(add-hook 'slime #'rainbow-delimiters-mode)
;; kill buffer with live buffer attached to it
(setq kill-buffer-query-functions
  (remq 'process-kill-buffer-query-function
         kill-buffer-query-functions))
;; open recent files faster (from mastering emacs 
 
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

;;
;; evil
;;
(require 'evil)
(evil-mode t)
(global-set-key (kbd "<f1>") 'evil-mode)
(evil-set-initial-state 'ibuffer-mode 'normal)
(evil-set-initial-state 'bookmark-bmenu-mode 'normal)
(evil-set-initial-state 'dired-mode 'emacs)
(evil-set-initial-state 'sunrise-mode 'emacs)
(require 'evil-surround)
(global-evil-surround-mode 1)
(evil-rsi-mode)
(setq evil-move-cursor-back nil)	;sets the cursor after the last character, this is essential for editing/executing lisp code.
;;
;; nlinum
;; (setq nlinum-format "%d ")
;; (global-nlinum-mode t)

;; printing
;; ;; when ... after and: (string= (window-system) "w64")
;; (when (and (file-exists-p "c:/Program Files/Ghostgum/gsview/gsprint.exe"))
;;   (progn
;;     ;;  Windows printer
;;     (setq-default ps-lpr-command (expand-file-name "c:/Program Files/Ghostgum/gsview/gsprint.exe"))
;;     (setq-default ps-printer-name t)
;;     (setq-default ps-printer-name-option nil)
;;     (setq ps-lpr-switches '("-query")) ; show printer dialog
;;     (setq ps-right-header '("/pagenumberstring load" ps-time-stamp-mon-dd-yyyy))))
;; (if (eq window-system 'x)
;;     (setq ps-lpr-command "gtklp"))
;; ;; reveal.js
;; (setq org-reveal-root "file:///d:/Users/hkelderman/reveal.js-3.0.0/reveal.js")


;;
;; ivy (29-2-2020)
;;
;; (ivy-mode 1)
;; (setq ivy-use-virtual-buffers t)
;; (setq ivy-count-format "(%d/%d) ")
;; (global-set-key (kbd "C-s") 'swiper-isearch)
;; (global-set-key (kbd "M-x") 'counsel-M-x)
;; (global-set-key (kbd "C-x C-f") 'counsel-find-file)
;; (global-set-key (kbd "M-y") 'counsel-yank-pop)
;; ;; (global-set-key (kbd "<f1> f") 'counsel-describe-function)
;; ;; (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
;; ;; (global-set-key (kbd "<f1> l") 'counsel-find-library)
;; (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
;; (global-set-key (kbd "<f2> u") 'counsel-unicode-char)
;; (global-set-key (kbd "<f2> j") 'counsel-set-variable)
;; (global-set-key (kbd "C-x b") 'ivy-switch-buffer)
;; (global-set-key (kbd "C-c v") 'ivy-push-view)
;; (global-set-key (kbd "C-c V") 'ivy-pop-view)

;; (global-set-key (kbd "C-c c") 'counsel-compile)
;; ;; (global-set-key (kbd "C-c g") 'counsel-git)
;; ;; (global-set-key (kbd "C-c j") 'counsel-git-grep)
;; ;; (global-set-key (kbd "C-c L") 'counsel-git-log)
;; (global-set-key (kbd "C-c k") 'counsel-rg)
;; ;; (global-set-key (kbd "C-c m") 'counsel-linux-app)
;; (global-set-key (kbd "C-c n") 'counsel-fzf)
;; ;; (global-set-key (kbd "C-x l") 'counsel-locate)
;; (global-set-key (kbd "C-c J") 'counsel-file-jump)
;; ;; (global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
;; (global-set-key (kbd "C-c w") 'counsel-wmctrl)
;; (global-set-key (kbd "C-x C-r") 'counsel-recentf)
;; (global-set-key (kbd "C-x s") 'save-buffer)
;; (eval-after-load 'evil-ex
;;   '(evil-ex-define-cmd ":wq" 'save-buffer))
;; ;; show matching parens
(show-paren-mode t)

;;
;; no welcome
;;
(setq inhibit-startup-message t)
;;
;; no beep
;;
(setq visible-bell nil)
(setq ring-bell-function 'ignore)
;;
;; org mode
;;
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

(fset 'yes-or-no-p 'y-or-n-p)
	
(setq confirm-nonexistent-file-or-buffer nil)

;; kill buffer with live buffer attached to it
(setq kill-buffer-query-functions
  (remq 'process-kill-buffer-query-function
         kill-buffer-query-functions))

;; (setq inferior-lisp-program "sbcl")	; your Lisp system
;; (require 'slime)
;; (slime-setup '(slime-fancy))
;; (require 'ac-slime)
;; (add-hook 'slime-mode-hook 'set-up-slime-ac)
;; (add-hook 'slime-repl-mode-hook 'set-up-slime-ac)
;; ;
					;
;; discover
;;
(require 'discover)
(global-discover-mode 1)
(require 'company-auctex)
(company-auctex-init)

;; (add-hook 'c++-mode-hook (lambda () (setq flycheck-gcc-language-standard "c++11")))
;; (add-hook 'c++-mode-hook (lambda () (setq flycheck-clang-languange-standard "c++11")))
;; (add-hook 'after-init-hook #'global-flycheck-mode)

;; ess
;;;(require 'ess-site)

;; (require 'rtags)
;; (cmake-ide-setup)
(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#e090d7" "#8cc4ff" "#eeeeec"])
 '(custom-enabled-themes (quote (solarized-gruvbox-dark)))
 '(custom-safe-themes
   (quote
    ("830877f4aab227556548dc0a28bf395d0abe0e3a0ab95455731c9ea5ab5fe4e1" "aded61687237d1dff6325edb492bde536f40b048eab7246c61d5c6643c696b7f" "4cf9ed30ea575fb0ca3cff6ef34b1b87192965245776afa9e9e20c17d115f3fb" default)))
 '(package-selected-packages
   (quote
    (solarized-theme gruvbox-theme matlab-mode markdown-mode evil-paredit rainbow-delimiters company-auctex counsel-pydoc counsel ivy fzf gnuplot gnuplot-mode evil-magit magit evil-rsi evil-surround paredit-everywhere nlinum yasnippet-snippets paredit ido-vertical-mode flx elpy treemacs ac-slime)))
 '(pdf-view-midnight-colors (quote ("#fdf4c1" . "#1d2021")))
 '(recentf-auto-cleanup (quote never))
 '(show-paren-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Fira Code" :foundry "CTDB" :slant normal :weight normal :height 113 :width normal))))
 '(region ((t (:background "light steel blue" :distant-foreground "red")))))
