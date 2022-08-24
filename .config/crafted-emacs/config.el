;;; config.el -- James Brusey's crafted-emacs customization file -*- lexical-binding: t; -*-

;;; Commentary:
;;
;; This is a configuration based on Crafted Emacs.
;;
;; I am using `straight' for package management and this is set-up
;; using early-config.el.
;;
;; See the README.org file in the crafted-emacs repository for
;; additional information.
;;
;; Modification history
;; 1. 24-Aug-22 move to dotfiles

;;; Code:
(require 'crafted-defaults)
(require 'crafted-screencast)
(require 'crafted-ui)
(require 'crafted-editing)
(require 'crafted-completion)
(require 'crafted-windows)
(require 'crafted-org)

;; Set further font and theme customizations
(custom-set-variables
   '(crafted-ui-default-font
     '(:font "JetBrains Mono" :weight light :height 185)))

(load-theme 'modus-operandi t)

;; set up for mac laptop keyboard
(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'super) ; make opt key do Super
(setq mac-control-modifier 'control) ; make Control key do Control
(setq ns-function-modifier 'hyper)  ; make Fn key do Hyper

;; global visual line mode
(global-visual-line-mode)

;; turn off auto revert messages
(setq auto-revert-verbose nil)

;; jupyter
(straight-use-package '(jupyter :type git :host github :repo "nnicandro/emacs-jupyter"))
(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (python . t)
   (jupyter . t)
   (shell . t)
   ))



;; org-ref
(straight-use-package '(org-ref :type git :host github :repo "jkitchin/org-ref"))

;; magit
(straight-use-package 'magit)
;; I had this previously but I'm not convinced it is needed or useful.
;; (customize-set-variable magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1)


(load "custom")
;;; example-config.el ends here
