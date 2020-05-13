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

;; External settings file with additional machine dependent settings.
;; The settings in this file will overwrite the settings from the main
;; config file if they conflict.
(defvar extern-file "~/.emacs.d/settings.el")
(load extern-file :noerror)
