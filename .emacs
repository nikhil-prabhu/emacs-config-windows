(package-initialize)

;; Set and load external custom file
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file :noerror)

;; Add melpa to package archives
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

(mapc
 (lambda (package)
   ;; Install missing packages automatically
   (if (not (package-installed-p package))
       (progn
	 (package-refresh-contents)
	 (package-install package))))
 '(use-package))

;; Load use-package
(eval-when-compile
  (require 'use-package))

;; Interface settings ;;

;; Default theme (Tango Dark)
(load-theme 'tango-dark t)

;; Disable scrollbar
(scroll-bar-mode -1)

;; Disable toolbar
(tool-bar-mode -1)

;; Disable menubar
(menu-bar-mode -1)

;; Disable ring bell
(setq ring-bell-function 'ignore)

;; Word wrap
(global-visual-line-mode t)

;; Line numbers for programming languages and Org
(when (version<= "26.0.50" emacs-version)
  (add-hook 'prog-mode-hook 'display-line-numbers-mode)
  (add-hook 'org-mode-hook 'display-line-numbers-mode))

;; Pair matching
(electric-pair-mode t)

;; Custom frame title format
(setq-default frame-title-format '("%b [%m] - GNU Emacs"))

;; Packages ;;

;; auto-package-update
(use-package auto-package-update
  :ensure t
  :if (not (daemonp))
  :custom
  (auto-package-update-interval 7) ;; in days
  (auto-package-update-prompt-before-update t)
  (auto-package-update-delete-old-versions t)
  (auto-package-update-hide-results t)
  :config
  (auto-package-update-maybe))

;; evil
(use-package evil
  :ensure t
  :init (evil-mode t))

;; flycheck
(use-package flycheck
  :ensure t
  :init (add-hook 'after-init-hook #'global-flycheck-mode))

;; treemacs
(use-package treemacs
  :ensure t
  :bind ("C-x t" . treemacs)
  :config (setq treemacs-no-png-images t))

;; ctrlf
(use-package ctrlf
  :ensure t
  :init (ctrlf-mode +1))

;; ace-window
(use-package ace-window
  :ensure t
  :bind ("M-o" . ace-window))

;; smex
(use-package smex
  :ensure t
  :init (smex-initialize)
  :bind (("M-x" . smex)
	 ("M-X" . smex-major-mode-commands)
	 ("C-c C-c M-x" . execute-extended-command)))

;; ox-twbs
(use-package ox-twbs
  :ensure t)

;; nyan-mode
(use-package nyan-mode
  :ensure t
  :init (nyan-mode))

;; Keybindings ;;

;; Open a shell buffer
(global-set-key (kbd "C-x s") 'shell)

;; Clear shell buffer
(global-set-key (kbd "C-c l") 'comint-clear-buffer)

;; Display line numbers
(global-set-key (kbd "C-x n") 'display-line-numbers-mode)

;; External settings file with additional machine dependent settings.
;; The settings in this file will overwrite the settings from the main
;; config file if they conflict.
(defvar extern-file "~/.emacs.d/settings.el")
(load extern-file :noerror)
