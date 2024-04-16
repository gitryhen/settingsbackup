;; ;; 20230829
;; ;; 20230913 first straight.el
;; ;; 20231220 clean up of recentf

(setq load-path (cons "~/.emacs.d/dotemacs/" load-path))
(prefer-coding-system 'utf-8)
(setq package-enable-at-startup nil)
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))
(straight-use-package 'use-package)
(fset 'yes-or-no-p 'y-or-n-p)
(setq visible-bell nil)
(setq bidi-paragraph-direction 'left-to-right)
(if (display-graphic-p)
    (setq initial-frame-alist
	  '((background-color . "honeydew"))))
(global-set-key "\M-z" 'zap-up-to-char)
(setq backup-directory-alist '(("." . "~/Backup")))
(with-eval-after-load 'tramp
(add-to-list 'tramp-backup-directory-alist
             (cons tramp-file-name-regexp nil)))
(setq savehist-file "~/Backup/emacssavehistory")
(savehist-mode 1)
(setq history-length t)
(setq history-delete-duplicates t)
(setq savehist-save-minibuffer-history 1)
(setq savehist-additional-variables
      '(kill-ring
        search-ring
        regexp-search-ring))
(setq-default abbrev-mode t)

;; select limited expansion on hippie expand
(setq hippie-expand-try-functions-list
      '(
        try-expand-dabbrev
        try-expand-dabbrev-all-buffers
        ;; try-expand-dabbrev-from-kill
        try-complete-lisp-symbol-partially
        try-complete-lisp-symbol
        try-complete-file-name-partially
        try-complete-file-name
        ;; try-expand-all-abbrevs
        ;; try-expand-list
        ;; try-expand-line
        ))

;; improve(d) backup
(setq backup-directory-alist '(("." . "~/.config/emacs/backups")))
(setq delete-old-version -1)
(setq version-control t)
(setq vc-make-backup-files t)
(setq delete-old-versions t)
(setq auto-save-file-name-transforms '((".*" "~/.config/emacs/auto-save-list/" t)))
(setq system-trash-exclude-matches '("#[^/]+#$" ".*~$" "\\.emacs\\.desktop.*"))
(setq system-trash-exclude-paths '("/tmp"))
;; stop prompting
;; source https://www.youtube.com/watch?v=ZFJlxBPvzE0 wretchedness of confirmation in emacs
(setq dired-confirm-shell-command nil)
(setq dired-no-confirm t)
(setq dired-recursive-deletes (quote always))
(setq dired-deletion-confirmer '(lambda (x) t))
(setq confirm-kill-emacs nil)
(setq confirm-kill-processes nil)
(setq confirm-nonexistent-file-or-buffer nil)
(set-buffer-modified-p nil)
(add-hook 'kill-buffer-query-functions (lambda () (not-modified) t))
(electric-pair-mode)
(setq large-file-warning-threshold nil)
;; stop showing warnings
(setq warning-minimum-level :emergency)
(autoload 'save-and-make "saver")
(global-set-key (kbd "<f6>") 'save-and-make)
(autoload 'xah-select-line "xah")
(autoload 'my/file-by-date-with-inline-skeleton "saver")
(global-set-key (kbd "<f12>") 'my/file-by-date-with-inline-skeleton)
(global-set-key (kbd "S-<f12>") 'my/org-file-by-date-with-inline-skeleton)

(keymap-global-set "M-2" #'xah-select-line)
(keymap-global-set "M-3" #'xah-select-text-in-quote)


;; (use-package ess
;;   :straight t
;;   :init
;;   (require 'ess-site)
;;   (setq org-babel-R-command "/usr/bin/R --no-save"))


(require 'flyspell)
(setq flyspell-issue-message-flag nil
      ispell-local-dictionary "en_US,nl"
      ispell-program-name "aspell"
      ispell-extra-args '("--sug-mode=ultra"))
(add-hook 'text-mode-hook 'flyspell-mode)
(add-hook 'prog-mode-hook 'flyspell-prog-mode)
(define-key flyspell-mode-map (kbd "C-;") 'helm-flyspell-correct)

(use-package pyvenv
  :straight t
  :init
  (pyvenv-activate "/home/henry/venv"))

;; (use-package company
;;   :straight t
;;   :bind (:map company-active-map
;; 	      ("C-n" . company-select-next)
;; 	      ("C-p" . company-select-previous))
;;   :config
;;   (add-to-list 'company-backends 'company-c-headers 'company-plsense)
;;   (add-hook 'perl-mode-hook 'company-mode)
;;   (add-hook 'cperl-mode-hook 'company-mode)
;;   (add-hook 'python-mode 'company-mode)
;;   (setq company-idle-delay 0.3))

(use-package org-roam
  :straight t
  :custom
  (org-roam-directory "~/OneDrive/Documents/orgroam")
  :config
  (org-roam-db-autosync-mode)
  (org-roam-setup))

(use-package org-ref
  :straight t)

(use-package notmuch
  :straight t)

(use-package magit
  :straight t)

(use-package smex
  :straight t
  :bind
  (("M-x" . smex)
  ("C-c C-c M-x" . execute-extended-command)))

(use-package ido-vertical-mode
  :straight t
  :config
  (ido-mode 1)
  (ido-vertical-mode 1)
  (ido-everywhere t)
  (setq ido-vertical-define-keys 'C-n-and-C-p-only))

(autoload 'ido-choose-from-recentf "myrecent")

(use-package recentf
  :straight t
  :config
  (setq recentf-max-saved-items 24
	recent-max-menu-items 5)
  (recentf-mode t)
  :bind
  ("C-x C-r" . ido-choose-from-recentf)
  :hook (after-init . recentf-mode))

(use-package init-open-recentf
      :after recentf
      :config (init-open-recentf))

;; ;; (use-package recentf
;; ;;   :straight t
;; ;;   :config
;; ;;   (setq recentf-max-saved-items 20)
;; ;;   (recentf-mode t)
;; ;;   :bind
;; ;;   ("C-x C-r" . ido-choose-from-recentf))

;;; (global-set-key (kbd "C-x C-r") 'ido-choose-from-recentf)

;; here was org
(require 'orgstuff)
;; ;; The following from Rainer Konig results in an error when saving
;; ;; as it asks to add missing non-existent-agenda file.
;; ;; so i add ids by hand and nog by saving
;; (add-hook 'org-mode-hook
;;           (lambda ()
;;             (add-hook 'before-save-hook 'my/org-add-ids-to-headlines-in-file nil 'local)))
(global-set-key (kbd "<f7>") 'my/copy-id-to-clipboard)
(global-set-key (kbd "<f8>") 'my/copy-idlink-to-clipboard)
(global-set-key (kbd "<f9>") 'my/org-add-ids-to-headlines-in-file)
(setq org-adapt-indentation nil)
(setq org-duration-format (quote h:mm))
(setq org-id-link-to-org-use-id t)
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c b") 'org-iswitchb)
(global-set-key (kbd "C-c c") 'org-capture)

(use-package ag
  :straight t)

;; ;; (use-package slime
;; ;;   :straight t
;; ;;   :init
;; ;;   (slime-setup '(slime-fancy))
;; ;;   :config
;; ;;   (setq inferior-lisp-program "/usr/bin/clisp"))

;; (use-package tex
;;   :straight auctex
;;   :defer t)

;; (use-package which-key
;;   :straight t
;;   :config
;;   (which-key-mode t))

(use-package doom-modeline
  :straight t
  :hook (after-init . doom-modeline-mode))

(use-package corfu
  :straight t
  :custom
  (corfu-cycle t)                ;; Enable cycling for `corfu-next/previous'
  (corfu-auto t)                 ;; Enable auto completion
  (corfu-separator ?\s)          ;; Orderless field separator
  (corfu-quit-at-boundary nil)   ;; Never quit at completion boundary
  (corfu-quit-no-match t)      ;; Never quit, even if there is no match
  (corfu-preview-current nil)    ;; Disable current candidate preview
  (corfu-preselect 'prompt)      ;; Preselect the prompt
  (corfu-on-exact-match nil)     ;; Configure handling of exact matches
  (corfu-scroll-margin 5)        ;; Use scroll margin

  ;; ;; Enable Corfu only for certain modes.
  ;; :hook ((prog-mode . corfu-mode)
  ;;        (shell-mode . corfu-mode)
  ;;        (eshell-mode . corfu-mode))

  ;; Recommended: Enable Corfu globally.  This is recommended since Dabbrev can
  ;; be used globally (M-/).  See also the customization variable
  ;; `global-corfu-modes' to exclude certain modes.
  :init
  (setf corfu-auto t)
  (global-corfu-mode)
  (corfu-history-mode))

;; Use Dabbrev with Corfu!
(use-package dabbrev
  ;; Swap M-/ and C-M-/
  :bind (("M-/" . hippie-expand)
         ("C-M-/" . dabbrev-completion))
  ;; Other useful Dabbrev configurations.
  :custom
  (dabbrev-ignored-buffer-regexps '("\\.\\(?:pdf\\|jpe?g\\|png\\)\\'")))

;; ;; A few more useful configurations...
;; (use-package emacs
;;   :init
;;   ;; TAB cycle if there are only few candidates
;;   (setq completion-cycle-threshold 3)

;;   ;; Emacs 28: Hide commands in M-x which do not apply to the current mode.
;;   ;; Corfu commands are hidden, since they are not supposed to be used via M-x.
;;   ;; (setq read-extended-command-predicate
;;   ;;       #'command-completion-default-include-p)

;;   ;; Enable indentation+completion using the TAB key.
;;   ;; `completion-at-point' is often bound to M-TAB.
;;   (setq tab-always-indent 'complete))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(electric-pair-mode t)
 '(ido-mode 'both nil (ido))
 '(newsticker-url-list
   '(("nos nieuws" "https://feeds.nos.nl/nosnieuwsalgemeen" nil nil nil)
     ("zerohedge" "http://feeds.feedburner.com/zerohedge/feed" nil nil nil)))
 '(org-babel-load-languages
   '((python . t)
     (perl . t)
     (emacs-lisp . t)
     (R . t)
     (awk . t)
     (gnuplot . t)
     (latex . t)
     (dot . t)))
 '(org-confirm-babel-evaluate nil)
 '(org-id-locations-file "~/OneDrive/Documents/.org-id-locations")
 '(package-selected-packages '(ido-vertical-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Iosevka Fixed SS05" :foundry "UKWN" :slant normal :weight regular :height 113 :width normal)))))
(put 'set-goal-column 'disabled nil)
