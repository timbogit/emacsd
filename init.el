;; Set up some directory vars
(defvar home-dir)
(setq home-dir (concat (expand-file-name "~") "/"))
(defvar dot-emacs-dir (concat home-dir ".emacs.d/"))
(defvar emacs-plugins-dir (concat dot-emacs-dir "site-lisp/"))
;; Set up load path 
(setq load-path (append (list (concat home-dir "")
			      (concat emacs-plugins-dir "color-theme")
			      ;;(concat emacs-plugins-dir "emacs-colors-solarized")
                              (concat emacs-plugins-dir "emacs-color-theme-solarized")
			      (concat emacs-plugins-dir "rhtml")
                              (concat emacs-plugins-dir "emacs-nav-49")
			      (concat dot-emacs-dir "site-lisp"))
                        load-path))
;; load the themes and ack plugin
(require 'color-theme)
(require 'color-theme-solarized)
(color-theme-solarized-dark)
;;(require 'ack)
;;(setq ack-command "ack")
;;; rhtml-mode
(require 'rhtml-mode)
(add-hook 'rhtml-mode-hook
	  (lambda () (rinari-launch)))
;; nav settings
(require 'nav)
(nav-disable-overeager-window-splitting)
;; Optional: set up a quick key to toggle nav
(global-set-key [f8] 'nav-toggle)

;; Interactively Do Things
(require 'ido)
(ido-mode t)

;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
;(when
;    (load
;     (expand-file-name "~/.emacs.d/elpa/package.el"))
;  (package-initialize))
;(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
(add-hook 'yaml-mode-hook
      '(lambda ()
           (define-key yaml-mode-map "\C-m" 'newline-and-indent)))

;; tab to spaces settings, and highlight trailing white-space
;;(setq c-basic-indent 2)
;;(setq tab-width 4)
(setq-default indent-tabs-mode nil)
;;(highlight-tabs)
;;(highlight-trailing-whitespace)
(global-linum-mode 1)

;;; add ClojureMode major mode
(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))
;; Add in your own as you wish:
(defvar my-packages '(starter-kit starter-kit-eshell starter-kit-ruby clojure-mode)
  "A list of packages to ensure are installed at launch.")

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))
