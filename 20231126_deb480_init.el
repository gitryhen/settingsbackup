;; 20230829
;; 20230913 first straight.el
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
	  '((background-color . "light goldenrod yellow"))))
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

(autoload 'save-and-make "saver")
(global-set-key (kbd "<f6>") 'save-and-make)
(autoload 'xah-select-line "xah")

(keymap-global-set "M-2" #'xah-select-line)
(keymap-global-set "M-3" #'xah-select-text-in-quote)

(use-package recentf
  :straight t
  :config
  (setq recentf-max-saved-items 50)
  (recentf-mode t))

(use-package ess
  :straight t
  :init
  (require 'ess-site)
  (setq org-babel-R-command "/usr/bin/R --no-save"))

(require 'flyspell)
(setq flyspell-issue-message-flag nil
      ispell-local-dictionary "en_US"
      ispell-program-name "aspell"
      ispell-extra-args '("--sug-mode=ultra"))
(add-hook 'text-mode-hook 'flyspell-mode)
(add-hook 'prog-mode-hook 'flyspell-prog-mode)
(define-key flyspell-mode-map (kbd "C-;") 'helm-flyspell-correct)

(use-package pyvenv
  :straight t
  :init
  (pyvenv-activate "/home/henry/venv"))

(use-package lsp-mode
  :straight t
  :config
  (lsp-register-custom-settings
   '(("pylsp.plugins.pylsp_mypy.enabled" t t)
     ("pylsp.plugins.pylsp_mypy.live_mode" nil t)
     ("pylsp.plugins.pylsp_black.enabled" t t)
     ("pylsp.plugins.pylsp_isort.enabled" t t)
     ("pylsp.plugins.flake8.enable" t t)))
  :hook
  ((python-mode . lsp)))

(use-package company
  :straight t
  :bind (:map company-active-map
	      ("C-n" . company-select-next)
	      ("C-p" . company-select-previous))
  :config
  (add-to-list 'company-backends 'company-c-headers 'company-plsense)
  (add-hook 'perl-mode-hook 'company-mode)
  (add-hook 'cperl-mode-hook 'company-mode)
  (add-hook 'python-mode 'company-mode)
  (setq company-idle-delay 0.3))

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
  :config
  (recentf-mode t)
  (setq recent-max-saved-items 100)
  :bind
  ("C-x C-r" . ido-choose-from-recentf))

(global-set-key (kbd "C-x C-r") 'ido-choose-from-recentf)

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

(use-package slime
  :straight t
  :init
  (slime-setup '(slime-fancy))
  :config
  (setq inferior-lisp-program "/usr/bin/clisp"))

(use-package tex
  :straight auctex
  :defer t)

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
 '(package-selected-packages '(ido-vertical-mode company)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Iosevka Fixed SS05" :foundry "UKWN" :slant normal :weight regular :height 113 :width normal)))))
(put 'set-goal-column 'disabled nil)
