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

;;;;;;;;;;;;;;;;;;;;;;;;;
;; Org Mode Appearance ;;
;;;;;;;;;;;;;;;;;;;;;;;;;

;; Set further font and theme customizations
(custom-set-variables
   '(crafted-ui-default-font
     '(:font "JetBrains Mono" :weight light :height 180)))

(defvar my/variable-width-font "Iosevka Aile"
  "The font to use for variable pitch (document) text.")

(set-face-attribute 'variable-pitch nil :font my/variable-width-font :weight 'light :height 1.1)

(require 'org-faces)

;; Resize Org headings
(dolist (face '((org-level-1 . 1.2)
                (org-level-2 . 1.1)
                (org-level-3 . 1.05)
                (org-level-4 . 1.0)
                (org-level-5 . 1.1)
                (org-level-6 . 1.1)
                (org-level-7 . 1.1)
                (org-level-8 . 1.1)))
  (set-face-attribute (car face) nil :font my/variable-width-font :weight 'medium :height (cdr face)))

;; Make the document title a bit bigger
(set-face-attribute 'org-document-title nil :font my/variable-width-font :weight 'bold :height 1.3)

;; Make sure certain org faces use the fixed-pitch face when variable-pitch-mode is on
(set-face-attribute 'org-block nil :foreground nil :inherit 'fixed-pitch)
(set-face-attribute 'org-table nil :inherit 'fixed-pitch)
(set-face-attribute 'org-formula nil :inherit 'fixed-pitch)
(set-face-attribute 'org-code nil :inherit '(shadow fixed-pitch))
(set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
(set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
(set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
(set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; visual-fill-column package ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(straight-use-package 'visual-fill-column)

;; Configure fill width
(setq visual-fill-column-width 110
      visual-fill-column-center-text t)

;;;;;;;;;;;;;;;;;
;; org-present ;;
;;;;;;;;;;;;;;;;;

(straight-use-package 'org-present)

(defun my/org-present-prepare-slide (buffer-name heading)
  ;; show only top-level headlines
  (org-overview)

  ;; Unfold the current entry
  (org-show-entry)

  ;; Show only direct subheadings of the slide but don't expand them
  (org-show-children)
  )

(defun my/org-present-start ()
  "Tweak font sizes"
  (setq-local face-remapping-alist '((default (:height 1.5) variable-pitch)
                                     (header-line (:height 4.0) variable-pitch)
                                     (org-document-title (:height 1.75) org-document-title)
                                     (org-code (:height 1.55) org-code)
                                     (org-verbatim (:height 1.55) org-verbatim)
                                     (org-block (:height 1.25) org-block)
                                     (org-block-begin-line (:height 0.7) org-block)))

  ;; Set a blank header line string to create blank space at the top
  (setq header-line-format " ")

  ;; Display inline images automatically
  (org-display-inline-images)

  ;; Center the presentation and wrap lines
  (visual-fill-column-mode 1)
  (visual-line-mode 1))

(defun my/org-present-end ()
  ;; Reset font customizations
  (setq-local face-remapping-alist '((default variable-pitch default)))

  ;; Clear the header line string so that it isn't displayed
  (setq header-line-format nil)

  ;; Stop displaying inline images
  (org-remove-inline-images)

  ;; Stop centering the document
  (visual-fill-column-mode 0)
  (visual-line-mode 0))

;; Turn on variable pitch fonts in Org Mode buffers
(add-hook 'org-mode-hook 'variable-pitch-mode)

;; Register hooks with org-present
(add-hook 'org-present-mode-hook 'my/org-present-start)
(add-hook 'org-present-mode-quit-hook 'my/org-present-end)
(add-hook 'org-present-after-navigate-functions 'my/org-present-prepare-slide)




;; (add-hook 'org-present-mode-hook
;;           (lambda ()
;;             (org-present-big)
;;             (org-display-inline-images)
;;             (org--latex-preview-region (point-min) (point-max))
;;             (org-present-hide-cursor)
;;             (org-present-read-only)
;;             ))
;; (add-hook 'org-present-mode-quit-hook
;;           (lambda ()
;;             (org-present-small)
;;             (org-remove-inline-images)
;;             (org-present-show-cursor)
;;             (org-present-read-write)))


(load "custom")
;;; example-config.el ends here
