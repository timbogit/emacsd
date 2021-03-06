
;; ;; nav settings
;; (require 'nav)
;; (nav-disable-overeager-window-splitting)

;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
;(when
;    (load
;     (expand-file-name "~/.emacs.d/elpa/package.el"))
;  (package-initialize))

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
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)
 
(when (not package-archive-contents)
  (package-refresh-contents))
;; Add in your own as you wish:
(defvar my-packages '(better-defaults
                      clojure-mode
                      cider
                      company
                      paredit
                      exec-path-from-shell
                      projectile
                      flx-ido
                      smex
                      magit
                      ack-and-a-half
                      yaml-mode
                      solarized-theme
                      neotree)
  "A list of packages to ensure are installed at launch.")
(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))


(require 'ido)
(ido-mode t)
(require 'flx-ido)
(ido-everywhere t)
(flx-ido-mode t)
(setq ido-enable-flex-matching t)
(setq ido-use-faces nil)
;;; Smex
(autoload 'smex "smex"
    "Smex is a M-x enhancement for Emacs, it provides a convenient interface to
your recently and most frequently used commands.")
(global-set-key (kbd "M-x") 'smex)
;;; Ack-And-A-Half
(require 'ack-and-a-half)
(defalias 'ack 'ack-and-a-half)
(defalias 'ack-same 'ack-and-a-half-same)
(defalias 'ack-find-file 'ack-and-a-half-find-file)
(defalias 'ack-find-file-same 'ack-and-a-half-find-file-same)

(global-company-mode)
(projectile-global-mode)

(add-hook 'clojure-mode-hook 'paredit-mode)
(add-hook 'cider-repl-mode-hook 'paredit-mode)
 
(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
(setq nrepl-hide-special-buffers t)

;; color theme
(load-theme 'solarized-dark t)

;; yaml-mode
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
(add-hook 'yaml-mode-hook
     '(lambda ()
          (define-key yaml-mode-map "\C-m" 'newline-and-indent)))

;; neotree - like NERDtree for emacs
;; Optional: set up a quick key to toggle nav
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)

;; Switch off the automatic insertion of the # -*- coding: utf-8 -*-
;; on top of Ruby mode files
(setq ruby-insert-encoding-magic-comment nil)
