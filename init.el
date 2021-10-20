(prefer-coding-system 'utf-8)
;; (global-set-key (kbd "C-x s") 'save-buffer)

;; yes-or-no
(fset 'yes-or-no-p 'y-or-n-p)

(setq inhibit-startup-message t
      inhibit-startup-echo-area-message t)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")))
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/") t)
;;(global-display-line-numbers-mode)
(require 'package)
(package-initialize)

(require 'mu4e)
(setq mu4e-maildir       "~/Mail/gmail")   ;; top-level Maildir
(setq mu4e-drafts-folder "/[Gmail]/Drafts")
(setq mu4e-sent-folder   "/[Gmail]/Verzonden berichten")
(setq mu4e-trash-folder  "/[Gmail]/Prullenbak")
;;(setq mu4e-drafts-folder "/Concepten")
;;(setq mu4e-sent-folder   "/Verzonden")

;; company
(require 'company)
(define-key company-active-map (kbd "C-n") 'company-select-next)
(define-key company-active-map (kbd "C-p") 'company-select-previous)
(add-to-list 'company-backends 'company-c-headers 'company-plsense)
(add-hook 'perl-mode-hook 'company-mode)
(add-hook 'cperl-mode-hook 'company-mode)
;;(require 'use-package)

;; cperl-mode
(defalias 'perl-mode 'cperl-mode)
(mapc
 (lambda (pair)
   (if (eq (cdr pair) 'perl-mode)
       (setcdr pair 'cperl-mode)))
 (append auto-mode-alist interpreter-mode-alist))

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
;; (global-set-key (kbd "<f1> f") 'counsel-describe-function)
;; (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
;; (global-set-key (kbd "<f1> l") 'counsel-find-library)
;; (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
;; (global-set-key (kbd "<f2> u") 'counsel-unicode-char)
;; (global-set-key (kbd "<f2> j") 'counsel-set-variable)
;; (global-set-key (kbd "C-x b") 'ivy-switch-buffer)
;; (global-set-key (kbd "C-c v") 'ivy-push-view)
;; (global-set-key (kbd "C-c V") 'ivy-pop-view)

;; ;; (global-set-key (kbd "C-c c") 'counsel-compile)
;; ;; ;; (global-set-key (kbd "C-c g") 'counsel-git)
;; ;; ;; (global-set-key (kbd "C-c j") 'counsel-git-grep)
;; ;; ;; (global-set-key (kbd "C-c L") 'counsel-git-log)
;; ;; (global-set-key (kbd "C-c k") 'counsel-rg)
;; ;; ;; (global-set-key (kbd "C-c m") 'counsel-linux-app)
;; (global-set-key (kbd "C-c n") 'counsel-fzf)
;; (global-set-key (kbd "C-x l") 'counsel-locate)
;; ;; (global-set-key (kbd "C-c J") 'counsel-file-jump)
;; ;; ;; (global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
;; ;; (global-set-key (kbd "C-c w") 'counsel-wmctrl)
;; (global-set-key (kbd "C-x C-r") 'counsel-recentf)
;; (global-set-key (kbd "C-x s") 'save-buffer)

;; ido
;; ido in helm is used as a setting in group:
;; helm completing read handlers alist
;; symbol find file. do not activate ido and helm
;; (require 'ido)
(ido-vertical-mode t)
;; (setq ido-enable-flex-matching t)
;; (setq ido-everywhere t) 
;; (ido-mode 1)

;; helm
(require 'helm)
(require 'helm-config)
(global-set-key (kbd "M-x") 'helm-M-x)

;; (helm-mode 1) ;; nodig voor tab regel hieronder
;; ;;(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)

(global-set-key (kbd "M-i") 'helm-swoop)
(global-set-key (kbd "C-x b") 'helm-buffers-list)
(global-set-key (kbd "C-x r b") 'helm-bookmarks)
(global-set-key (kbd "C-x m") 'helm-M-x)
;; (global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-x C-r") 'helm-recentf)
(helm-mode 1)
(helm-flx-mode 1)


;; ;; (add-hook 'after-init-hook #'global-flycheck-mode)
;; ;; ;; (setq python-shell-interpreter "python"
;; ;; ;;       python-shell-interpreter-args "-i")
;; ;; ;; (setq python-shell-interpreter "jupyter"
;; ;; ;;       python-shell-interpreter-args "console --simple-prompt"
;; ;; ;;       python-shell-prompt-detect-failure-warning nil)
;; ;; ;; (add-to-list 'python-shell-completion-native-disabled-interpreters
;; ;; ;;              "jupyter")
;; ;;

;; slime
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

;; ;; kill buffer with live buffer attached to it
;; (setq kill-buffer-query-functions
;;   (remq 'process-kill-buffer-query-function
;;          kill-buffer-query-functions))

;; open recent files faster (from mastering emacs 
;; get rid of `find-file-read-only' and replace it with something
;; more useful.
;; (global-set-key (kbd "C-x C-r") 'recentf-open-files)
 
;; enable recent files mode.
(require 'recentf)
(recentf-mode t)
;; 50 files ought to be enough.
(setq recentf-max-saved-items 50)
;; (run-at-time nil (* 10 60) 'recentf-save-list)
;; (defun ido-recentf-open ()
;;   "Use `ido-completing-read' to \\[find-file] a recent file"
;;   (interactive)
;;   (if (find-file (ido-completing-read "Find recent file: " recentf-list))
;;       (message "Opening file...")
;;     (message "Aborting")))

;; evil
(require 'evil)
;; (evil-mode t)
(global-set-key (kbd "<f12>") 'evil-mode)
(evil-set-initial-state 'ibuffer-mode 'normal)
(evil-set-initial-state 'bookmark-bmenu-mode 'normal)
(evil-set-initial-state 'dired-mode 'emacs)
(evil-set-initial-state 'sunrise-mode 'emacs)
(evil-set-initial-state 'org-mode 'emacs)
(evil-set-initial-state 'elpy-mode 'emacs)
(evil-set-initial-state 'Emacs-Lisp-mode 'emacs)
(evil-set-initial-state 'text-mode 'normal)
(require 'evil-surround)
(global-evil-surround-mode 1)
;; (evil-rsi-mode)
;; (setq evil-move-cursor-back nil)	;sets the cursor after the last character, this is essential for editing/executing lisp code.
;; ;; (require 'evil-org)
;; ;; (add-hook 'org-mode-hook 'evil-org-mode)
;; ;; (evil-org-set-key-theme '(navigation insert textobjects additional calendar))
;; ;; (require 'evil-org-agenda)
;; ;; (evil-org-agenda-set-keys)
;; ;; show matching parens
(show-paren-mode t)

(setq inhibit-startup-message t)   ;; no welcome

;; no beep
(setq visible-bell nil)
(setq ring-bell-function 'ignore)

;; org mode
(setq org-adapt-indentation nil)
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(global-set-key "\C-cc" 'org-capture)
(setq org-agenda-files '("~/Documents/gtd/inbox.org"
                         "~/Documents/gtd/gtd.org"
                         "~/Documents/gtd/tickler.org"
			 "~/Documents/gtd/nextactions.org"))
(setq org-capture-templates '(("t" "Todo [inbox]" entry
                               (file+headline "~/Documents/gtd/inbox.org" "Tasks")
                               "* TODO %i%?")
                              ("T" "Tickler" entry
                               (file+headline "~/Documents/gtd/tickler.org" "Tickler")
                               "* %i%? \n %T")
			      ("n" "next actions" checkitem
                               (file "~/Documents/gtd/nextactions.org")
                               "- [ ] %?\n")
			      ("j" "journal" entry
                               (file+datetree "~/Documents/gtd/journal.org")
                               "* %?\nEntered on %U\n  %i\n  %a \n %K %k \n")
			      ("a" "Appointment" entry
			       (file  "~/Documents/gtd/gcal.org" )
			       "* %?\n\n%^T\n\n:PROPERTIES:\n:calendar-id: henry.kelderman@gmail.com\n:END:\n\n")))
(setq org-refile-targets '(("~/Documents/gtd/gtd.org" :maxlevel . 1)
                           ("~/Documents/gtd/someday.org" :level . 1)
			   ("~/Documents/gtd/tickler.org" :maxlevel . 2)
			   ("~/Documents/gtd/references.org" :level . 1)
			   ("~/Documents/gtd/nextactions.org" :maxlevel . 3)))
;; (require 'org-superstar)
;; (add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))
(setq org-duration-format (quote h:mm))

(fset 'yes-or-no-p 'y-or-n-p)
	
(setq confirm-nonexistent-file-or-buffer nil)


;; elpy
(setq indent-tabs-mode nil)
(elpy-enable)


;; Enable Flycheck
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))
;; (setq elpy-rpc-python-commmand "python3")
;; ;;
;; ;; org agenda / google calendar
;; ;;
;; (setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")
;; (setq package-check-signature nil)

;; (require 'org-gcal)
;; (use-package org-gcal
;; :ensure t
;; :config
;; (setq org-gcal-client-id "281225453865-fueirjvo55kdvlaapich8noblfr88tg4.apps.googleusercontent.com"
;; org-gcal-client-secret "L-SWgRtnKEAmfwx3oZe-WaOr"
;; org-gcal-file-alist '(("henry.kelderman@gmail.com" .  "~/Documents/gtd/gcal.org"))))
;; ;;
;; ;; org agenda capture google calendar
;; ;;
;; (add-hook 'org-agenda-mode-hook (lambda () (org-gcal-sync) ))
;; (add-hook 'org-capture-after-finalize-hook (lambda () (org-gcal-sync) ))

;; ;; ;; kill buffer with live buffer attached to it
;; ;; (setq kill-buffer-query-functions
;; ;;   (remq 'process-kill-buffer-query-function
;; ;;          kill-buffer-query-functions))
;; ;; 
;; ;; ;; (setq inferior-lisp-program "sbcl")	; your Lisp system
;; ;; ;; (require 'slime)
;; ;; ;; (slime-setup '(slime-fancy))
;; ;; ;; (require 'ac-slime)
;; ;; ;; (add-hook 'slime-mode-hook 'set-up-slime-ac)
;; ;; ;; (add-hook 'slime-repl-mode-hook 'set-up-slime-ac)
;; ;; ;;
;; ;; ;; discover
;; ;; ;;
;; ;; (require 'discover)
;; ;; (global-discover-mode 1)
;; ;; (require 'company-auctex)
;; ;; (company-auctex-init)
;; ess
(require 'ess-site)

;; ; ;; (require 'rtags)
;; ;; ;; (cmake-ide-setup)
(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)))
;; ;; (copy-face font-lock-constant-face 'calendar-iso-week-face)
;; ;; (set-face-attribute 'calendar-iso-week-face nil
;; ;;                     :height 0.7)
;; ;; (setq calendar-intermonth-text
;; ;;       '(propertize
;; ;;         (format "%2d"
;; ;;                 (car
;; ;;                  (calendar-iso-from-absolute
;; ;;                   (calendar-absolute-from-gregorian (list month day year)))))
;; ;;         'font-lock-face 'calendar-iso-week-face))

;; (custom-set-variables
;;  ;; custom-set-variables was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(ansi-color-faces-vector
;;    [default default default italic underline success warning error])
;;  '(ansi-color-names-vector
;;    ["#3c3836" "#fb4933" "#b8bb26" "#fabd2f" "#83a598" "#d3869b" "#8ec07c" "#ebdbb2"])
;;  '(compilation-message-face (quote default))
;;  '(cua-global-mark-cursor-color "#93E0E3")
;;  '(cua-normal-cursor-color "#DCDCCC")
;;  '(cua-overwrite-cursor-color "#F0DFAF")
;;  '(cua-read-only-cursor-color "#7F9F7F")
;;  '(custom-enabled-themes (quote (gruvbox-dark-medium)))
;;  '(custom-safe-themes
;;    (quote
;;     ("7661b762556018a44a29477b84757994d8386d6edee909409fabe0631952dad9" "123a8dabd1a0eff6e0c48a03dc6fb2c5e03ebc7062ba531543dfbce587e86f2a" "0fffa9669425ff140ff2ae8568c7719705ef33b7a927a0ba7c5e2ffcfac09b75" "4cf9ed30ea575fb0ca3cff6ef34b1b87192965245776afa9e9e20c17d115f3fb" "51ec7bfa54adf5fff5d466248ea6431097f5a18224788d0bd7eb1257a4f7b773" "b89ae2d35d2e18e4286c8be8aaecb41022c1a306070f64a66fd114310ade88aa" "a06658a45f043cd95549d6845454ad1c1d6e24a99271676ae56157619952394a" "e1d09f1b2afc2fed6feb1d672be5ec6ae61f84e058cb757689edb669be926896" "830877f4aab227556548dc0a28bf395d0abe0e3a0ab95455731c9ea5ab5fe4e1" "2809bcb77ad21312897b541134981282dc455ccd7c14d74cc333b6e549b824f3" "285d1bf306091644fb49993341e0ad8bafe57130d9981b680c1dbd974475c5c7" "9685cefcb4efd32520b899a34925c476e7920725c8d1f660e7336f37d6d95764" "aded61687237d1dff6325edb492bde536f40b048eab7246c61d5c6643c696b7f" default)))
;;  '(ein:output-area-inlined-images t)
;;  '(fci-rule-color "#4F4F4F")
;;  '(highlight-changes-colors (quote ("#DC8CC3" "#bbb0cb")))
;;  '(highlight-symbol-colors
;;    (quote
;;     ("#67a86387593f" "#548763ed646c" "#6037530c52d0" "#5bcd59505f42" "#4e90559c4e56" "#64795920520c" "#52ae607160f6")))
;;  '(highlight-symbol-foreground-color "#FFFFEF")
;;  '(highlight-tail-colors
;;    (quote
;;     (("#4F4F4F" . 0)
;;      ("#488249" . 20)
;;      ("#5dacaf" . 30)
;;      ("#57a2a4" . 50)
;;      ("#b6a576" . 60)
;;      ("#ac7b5a" . 70)
;;      ("#aa5790" . 85)
;;      ("#4F4F4F" . 100))))
;;  '(hl-bg-colors
;;    (quote
;;     ("#b6a576" "#ac7b5a" "#9f5c5c" "#aa5790" "#85749c" "#57a2a4" "#5dacaf" "#488249")))
;;  '(hl-fg-colors
;;    (quote
;;     ("#3F3F3F" "#3F3F3F" "#3F3F3F" "#3F3F3F" "#3F3F3F" "#3F3F3F" "#3F3F3F" "#3F3F3F")))
;;  '(hl-paren-colors (quote ("#93E0E3" "#F0DFAF" "#8CD0D3" "#bbb0cb" "#7F9F7F")))
;;  '(lsp-ui-doc-border "#FFFFEF")
;;  '(nrepl-message-colors
;;    (quote
;;     ("#CC9393" "#DFAF8F" "#F0DFAF" "#488249" "#95d291" "#57a2a4" "#93E0E3" "#DC8CC3" "#bbb0cb")))
;;  '(org-agenda-files
;;    (quote
;;     ("~/Documents/gtd/inbox.org" "~/Documents/gtd/gtd.org" "~/Documents/gtd/tickler.org" "~/Documents/gtd/gcal.org")))
;;  '(org-babel-load-languages
;;    (quote
;;     ((emacs-lisp)
;;      (python . t)
;;      (R . t)
;;      (awk . t)
;;      (shell . t))))
;;  '(org-beautify-theme-use-box-hack nil)
;;  '(package-selected-packages
;;    (quote
;;     (elpy company-rtags epl flycheck flycheck-rtags highlight-indent-guides notmuch rtags smartparens markdown-mode chess slime slime-company lorem-ipsum csv-mode ein ess ess-R-data-view org-gcal org-superstar gruvbox-theme evil-surround matlab-mode evil evil-paredit evil-rsi ido-vertical-mode magit paredit solarized-theme)))
;;  '(pdf-view-midnight-colors (quote ("#fdf4c1" . "#282828")))
;;  '(pos-tip-background-color "#4F4F4F")
;;  '(pos-tip-foreground-color "#FFFFEF")
;;  '(show-paren-mode t)
;;  '(smartrep-mode-line-active-bg (solarized-color-blend "#7F9F7F" "#4F4F4F" 0.2))
;;  '(term-default-bg-color "#3F3F3F")
;;  '(term-default-fg-color "#DCDCCC")
;;  '(vc-annotate-background nil)
;;  '(vc-annotate-background-mode nil)
;;  '(vc-annotate-color-map
;;    (quote
;;     ((20 . "#CC9393")
;;      (40 . "#de73b8c3a10d")
;;      (60 . "#e755cbcea809")
;;      (80 . "#F0DFAF")
;;      (100 . "#ca11c96d9eb2")
;;      (120 . "#b743beba96a7")
;;      (140 . "#a487b4178eb0")
;;      (160 . "#91cea98486ce")
;;      (180 . "#7F9F7F")
;;      (200 . "#8753b4279f64")
;;      (220 . "#8ae3beeeaff2")
;;      (240 . "#8e08c9d5c0bc")
;;      (260 . "#90bed4dbd1c1")
;;      (280 . "#93E0E3")
;;      (300 . "#9034d992dc92")
;;      (320 . "#8eced65fd95f")
;;      (340 . "#8d67d32ed62e")
;;      (360 . "#8CD0D3"))))
;;  '(vc-annotate-very-old-color nil)
;;  '(weechat-color-list
;;    (quote
;;     (unspecified "#3F3F3F" "#4F4F4F" "#9f5c5c" "#CC9393" "#488249" "#7F9F7F" "#b6a576" "#F0DFAF" "#57a2a4" "#8CD0D3" "#aa5790" "#DC8CC3" "#5dacaf" "#93E0E3" "#DCDCCC" "#6F6F6F")))
;;  '(xterm-color-names
;;    ["#4F4F4F" "#CC9393" "#7F9F7F" "#F0DFAF" "#8CD0D3" "#DC8CC3" "#93E0E3" "#fffff6"])
;;  '(xterm-color-names-bright
;;    ["#3F3F3F" "#DFAF8F" "#878777" "#6F6F6F" "#DCDCCC" "#bbb0cb" "#FFFFEF" "#FFFFFD"]))
;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(default ((t (:family "DejaVu Sans Mono" :foundry "PfEd" :slant normal :weight normal :height 113 :width normal)))))

;; (find-file "~/Documents/gtd/gtd.org")


;; dashboard
(require 'dashboard)
(dashboard-setup-startup-hook)

;; which-key
(require 'which-key)
(which-key-mode)

;; org-roam
(setq org-roam-directory "~/Documents/orgroam2")
(add-hook 'after-init-hook 'org-roam-mode)
(global-set-key (kbd "<f5>") 'org-roam-node-find)
(global-set-key (kbd "<f6>") 'org-roam-node-insert)
(setq org-roam-v2-ack t)

;; reftex
(require 'reftex)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(add-hook 'latex-mode-hook 'turn-on-reftex)

;; Spell-check
(require 'flyspell)
(setq flyspell-issue-message-flag nil
      ispell-local-dictionary "en_US"
      ispell-program-name "aspell"
      ispell-extra-args '("--sug-mode=ultra"))

(add-hook 'text-mode-hook 'flyspell-mode)
(add-hook 'prog-mode-hook 'flyspell-prog-mode)
(define-key flyspell-mode-map (kbd "C-;") 'helm-flyspell-correct)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("b06b2483f9fb7bfceb371c8341c0f20e3a38fecd7af7ac1c67bfa028aed9f45c" default))
 '(elpy-rpc-python-command "python3")
 '(helm-completing-read-handlers-alist
   '((find-tag . helm-completing-read-default-find-tag)
     (xref-find-definitions . helm-completing-read-default-find-tag)
     (xref-find-references . helm-completing-read-default-find-tag)
     (ggtags-find-tag-dwim . helm-completing-read-default-find-tag)
     (tmm-menubar)
     (find-file . ido)
     (execute-extended-command)
     (dired-do-rename . helm-read-file-name-handler-1)
     (dired-do-copy . helm-read-file-name-handler-1)
     (dired-do-symlink . helm-read-file-name-handler-1)
     (dired-do-relsymlink . helm-read-file-name-handler-1)
     (dired-do-hardlink . helm-read-file-name-handler-1)
     (basic-save-buffer . helm-read-file-name-handler-1)
     (write-file . helm-read-file-name-handler-1)
     (write-region . helm-read-file-name-handler-1)))
 '(org-babel-load-languages '((octave . t) (python . t) (shell . t) (awk . t)))
 '(org-confirm-babel-evaluate nil)
 '(org-export-backends '(ascii html icalendar latex md odt))
 '(package-selected-packages
   '(helm-flyspell helm-ag helm-swoop helm-flx helm markdown-mode fzf ivy counsel which-key dashboard ranger w3m company-plsense graphviz-dot-mode sqlite3 org-roam pomodoro esup magit auctex flycheck smartparens paredit ac-slime ess evil evil-surround slime slime-company elpy company))
 '(show-paren-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "DejaVu Sans Mono" :foundry "PfEd" :slant normal :weight normal :height 113 :width normal)))))
