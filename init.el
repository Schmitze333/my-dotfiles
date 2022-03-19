;;; init.el --- My homegrown Emacs init file
(setq inhibit-startup-message t)
(add-to-list 'initial-frame-alist '(fullscreen . maximized))

;; MacOS modifier
(setq mac-pass-command-to-system nil) ;; prevent OS defaults like CMD+h = hide
(setq mac-command-modifier 'super)
(setq mac-right-command-modifier 'meta)

;; Get rid of visual distractions
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)

;; No sound, no flash
(setq visible-bell t)
(setq ring-bell-function 'ignore)

;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;; Emacs stuff ;;;;;;

;; Do not make backups or lock files
(setq auto-save-default nil)
(setq make-backup-files nil)
(setq create-lockfiles nil)

;; Confirm with y only
(fset 'yes-or-no-p 'y-or-n-p)

;; Enable ALL commands
(setq disabled-command-function nil)

;; Process communication optimization
(setq gc-cons-threshold 100000000)
(setq read-process-output-max (* 1024 1024)) ;; 1mb

;; Default Font
(add-to-list 'default-frame-alist
       '(font . "Source Code Pro-12"))

;; Line numbers
(global-display-line-numbers-mode t)
(column-number-mode)

;; Highlight current line
(global-hl-line-mode 1)
(set-face-background 'hl-line "#600885")

;; Programming
(add-hook 'prog-mode-hook (lambda()
          (electric-pair-mode)
          (electric-quote-mode)
          (show-paren-mode)
          (which-function-mode 1)
          (setq show-trailing-whitespace t)))

;; Own functions
(defun transparency (value)
  "Set the frame transperancy (0=transp, 100=opaque)"
  (interactive "nTransparency Value 0 - 100 (opaque):")
  (set-frame-parameter (selected-frame) 'alpha value))

;; Initialize package sources
(require 'package)

(setq package-archives '(("stable-melpa" . "https://stable.melpa.org/packages/")
       ("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
 (package-refresh-contents))

;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; A few more useful configurations...
(use-package emacs
  :init
  ;; TAB cycle if there are only few candidates
  (setq completion-cycle-threshold 3)

  ;; Emacs 28: Hide commands in M-x which do not apply to the current mode.
  ;; Corfu commands are hidden, since they are not supposed to be used via M-x.
  ;; (setq read-extended-command-predicate
  ;;       #'command-completion-default-include-p)

  ;; Enable indentation+completion using the TAB key.
  ;; `completion-at-point' is often bound to M-TAB.
  (setq tab-always-indent 'complete))

;; All-the-icons
(use-package all-the-icons)

;; Ansi-colors in terminal
(require 'ansi-color)
(defun colorize-compilation-buffer ()
  (ansi-color-apply-on-region compilation-filter-start (point)))
(add-hook 'compilation-filter-hook 'colorize-compilation-buffer)

;; Startup with a Dashboard
(use-package dashboard
  :ensure t
  :demand
  :init
  (setq initial-buffer-choice (lambda () (get-buffer "*dashboard*")))
  (setq dashboard-banner-logo-title "Happy Hacking!")
  (setq dashboard-startup-banner "~/Downloads/rick3.png")
  (setq dashboard-center-content t)
  (setq dashboard-projects-backend 'projectile)
  (setq dashboard-items
	'((recents . 4)
	  (projects . 5)
	  (agenda . 4)))
  (setq dashboard-set-file-icons t)
  :config
  (dashboard-setup-startup-hook))

;; Dired config
(use-package dired
  :ensure nil
  :bind
  (("M-g d" . dired-jump)
   (:map dired-mode-map
   ("-" . dired-up-directory))
   ))

;; Doom Themes
(use-package doom-themes
  :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-snazzy t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; or for treemacs users
  (setq doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
  (doom-themes-treemacs-config)
  (doom-themes-org-config))

;; Modeline
(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 3)))

;; Completion System
(use-package vertico
  :bind
  (:map vertico-map ("C-l" . vertico-insert))
  :init (vertico-mode))

(use-package vertico-posframe
  :config
  (setq vertico-posframe-parameters
	'((left-fringe . 8)
	  (right-fringe . 8)))
  (vertico-posframe-mode 1))

;; Enable richer annotations using the Marginalia package
(use-package marginalia
  ;; Either bind `marginalia-cycle` globally or only in the minibuffer
  :bind (:map minibuffer-local-map
         ("M-A" . marginalia-cycle))
  :init
  (marginalia-mode))

;; Fuzzy completion
(use-package orderless
  :init
  (setq completion-styles '(substring orderless)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))

;; Persist history over Emacs restarts. Vertico sorts by history position.
(use-package savehist
  :init
  (savehist-mode))

;; consult
(use-package consult
  ;; Replace bindings. Lazily loaded due by `use-package'.
  :bind (;; C-c bindings (mode-specific-map)
         ;; ("C-c h" . consult-history)
         ("C-c m" . consult-mode-command)
         ;; ("C-c b" . consult-bookmark)
         ;; ("C-c k" . consult-kmacro)
         ;; C-x bindings (ctl-x-map)
         ("C-x M-:" . consult-complex-command)     ;; orig. repeat-complex-command
         ("C-x b" . consult-buffer)                ;; orig. switch-to-buffer
         ("C-x 4 b" . consult-buffer-other-window) ;; orig. switch-to-buffer-other-window
         ("C-x 5 b" . consult-buffer-other-frame)  ;; orig. switch-to-buffer-other-frame
         ;; Custom M-# bindings for fast register access
         ;; ("M-#" . consult-register-load)
         ;; ("M-'" . consult-register-store)          ;; orig. abbrev-prefix-mark (unrelated)
         ;; ("C-M-#" . consult-register)
         ;; Other custom bindings
         ("M-y" . consult-yank-pop)                ;; orig. yank-pop
         ("<help> a" . consult-apropos)            ;; orig. apropos-command
         ;; M-g bindings (goto-map)
         ("M-g e" . consult-compile-error)
         ("M-g f" . consult-flymake)               ;; Alternative: consult-flycheck
         ("M-g g" . consult-goto-line)             ;; orig. goto-line
         ("M-g M-g" . consult-goto-line)           ;; orig. goto-line
         ("M-g o" . consult-outline)               ;; Alternative: consult-org-heading
         ("M-g m" . consult-mark)
         ("M-g k" . consult-global-mark)
         ("M-g i" . consult-imenu)
         ("M-g I" . consult-imenu-multi)
	 ("M-g T" . consult-theme)
         ;; M-s bindings (search-map)
         ("M-s f" . consult-find)
         ("M-s F" . consult-locate)
         ("M-s g" . consult-grep)
         ("M-s G" . consult-git-grep)
         ("M-s r" . consult-ripgrep)
         ("M-s l" . consult-line)
         ("M-s L" . consult-line-multi)
         ("M-s m" . consult-multi-occur)
         ("M-s k" . consult-keep-lines)
         ("M-s u" . consult-focus-lines)
         ;; Isearch integration
         ("M-s e" . consult-isearch-history)

         :map isearch-mode-map
         ("M-e" . consult-isearch-history)         ;; orig. isearch-edit-string
         ("M-s e" . consult-isearch-history)       ;; orig. isearch-edit-string
         ("M-s l" . consult-line)                  ;; needed by consult-line to detect isearch
         ("M-s L" . consult-line-multi))           ;; needed by consult-line to detect isearch

  :hook (completion-list-mode . consult-preview-at-point-mode)
  :init
  ;; Optionally replace `completing-read-multiple' with an enhanced version.
  (advice-add #'completing-read-multiple :override #'consult-completing-read-multiple)
  :config

  ;; :preview-key on a per-command basis using the `consult-customize' macro.
  (consult-customize
   consult-theme
   :preview-key '(:debounce 0.1 any)
   consult-ripgrep consult-git-grep consult-grep
   consult-bookmark consult-recent-file consult-xref
   consult--source-recent-file consult--source-project-recent-file consult--source-bookmark
   :preview-key (kbd "M-."))

  ;;;; 2. projectile.el (projectile-project-root)
  (autoload 'projectile-project-root "projectile")
  (setq consult-project-root-function #'projectile-project-root))

(use-package embark
  :ensure t
  :bind
  (("C-." . embark-act)         ;; pick some comfortable binding
   ;; ("C-;" . embark-dwim)        ;; good alternative: M-.
   ("C-h B" . embark-bindings)) ;; alternative for `describe-bindings'
  :init
  ;; Optionally replace the key help with a completing-read interface
  (setq prefix-help-command #'embark-prefix-help-command)
  :config
  ;; Hide the mode line of the Embark live/completions buffers
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none)))))
(use-package embark-consult
  :ensure t
  :after (embark consult)
  :demand t ; only necessary if you have the hook below
  ;; if you want to have consult previews as you move around an
  ;; auto-updating embark collect buffer
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

;; Swiper
(use-package swiper
  :bind
  ("M-s s" . swiper)
  ("M-s M-s" . swiper-thing-at-point))

(use-package which-key
  :diminish which-key-mode
  :custom
  (which-key-idle-delay 0.5)
  :init (which-key-mode))

(use-package which-key-posframe
  :config
  (setq which-key-posframe-parameters
	'((left-fringe . 25)
	  (right-fringe . 25)))
  (which-key-posframe-mode))

;; Visual add-ons
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; EWW
(setq eww-search-prefix "https://duckduckgo.com/?q=")

;; Org mode
(use-package ox-gfm
  :after (org))

;; Projectile
(use-package projectile
  :diminish projectile-mode
  :config
  (projectile-mode)
  :bind ("C-M-j" . projectile-run-vterm)
  :bind-keymap
  ("s-p" . projectile-command-map)
  :init
  (when (file-directory-p "~/develop/projects")
    (setq projectile-project-search-path '("~/develop/projects")))
  (setq projectile-switch-project-action #'projectile-dired))

(use-package consult-projectile
  :after projectile)

;; Completion at point with Corfu
(use-package corfu
  ;; Optional customizations
  :custom
  (corfu-cycle t)                ;; Enable cycling for `corfu-next/previous'
  ;; (corfu-auto t)                 ;; Enable auto completion
  ;; (corfu-separator ?\s)          ;; Orderless field separator
  ;; (corfu-quit-at-boundary nil)   ;; Never quit at completion boundary
  ;; (corfu-quit-no-match nil)      ;; Never quit, even if there is no match
  ;; (corfu-preview-current nil)    ;; Disable current candidate preview
  ;; (corfu-preselect-first nil)    ;; Disable candidate preselection
  ;; (corfu-on-exact-match nil)     ;; Configure handling of exact matches
  ;; (corfu-echo-documentation nil) ;; Disable documentation in the echo area
  ;; (corfu-scroll-margin 5)        ;; Use scroll margin

  ;; You may want to enable Corfu only for certain modes.
  :hook ((prog-mode . corfu-mode)
         (shell-mode . corfu-mode)
         (eshell-mode . corfu-mode))

  ;; mapping some keys
  :bind
  (:map corfu-map
	("C-l". corfu-insert)
	("C-SPC" . corfu-insert-separator))

  ;; Recommended: Enable Corfu globally.
  ;; This is recommended since dabbrev can be used globally (M-/).
  :init
  (corfu-global-mode))

;; Use dabbrev with Corfu!
(use-package dabbrev
  ;; Swap M-/ and C-M-/
  :bind (("M-/" . dabbrev-completion)
         ("C-M-/" . dabbrev-expand)))

;; Add extensions
(use-package cape
  ;; Bind dedicated completion commands
  :bind (("C-c p p" . completion-at-point) ;; capf
         ("C-c p t" . complete-tag)        ;; etags
         ("C-c p d" . cape-dabbrev)        ;; or dabbrev-completion
         ("C-c p f" . cape-file)
         ("C-c p k" . cape-keyword)
         ("C-c p s" . cape-symbol)
         ("C-c p a" . cape-abbrev)
         ("C-c p i" . cape-ispell)
         ("C-c p l" . cape-line)
         ("C-c p w" . cape-dict)
         ("C-c p \\" . cape-tex)
         ("C-c p _" . cape-tex)
         ("C-c p ^" . cape-tex)
         ("C-c p &" . cape-sgml)
         ("C-c p r" . cape-rfc1345))
  :init
  ;; Add `completion-at-point-functions', used by `completion-at-point'.
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-tex)
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-keyword)
  (add-to-list 'completion-at-point-functions #'cape-ispell)
  (add-to-list 'completion-at-point-functions #'cape-dict)
  (add-to-list 'completion-at-point-functions #'cape-symbol)
  (add-to-list 'completion-at-point-functions #'cape-line)
  ;;(add-to-list 'completion-at-point-functions #'cape-sgml)
  ;;(add-to-list 'completion-at-point-functions #'cape-rfc1345)
  ;;(add-to-list 'completion-at-point-functions #'cape-abbrev)
)
;;; Corfu

;; IEdit
(use-package iedit)

;; Perspective.el
(use-package perspective
  :bind ("C-x C-b" . persp-list-buffers)   ; or use a nicer switcher, see below
  :custom
  (persp-mode-prefix-key (kbd "s-n"))
  :config
  (persp-mode))

;; Integrate perspective.el with projectile
(use-package persp-projectile
  :bind
  (:map projectile-command-map ("l" . #'projectile-persp-switch-project)))

;; Winum
(use-package winum
  :bind
  ("M-1". #'winum-select-window-1)
  ("M-2". #'winum-select-window-2)
  ("M-3". #'winum-select-window-3)
  ("M-4". #'winum-select-window-4)
  ("M-0". #'winum-select-window-0)
  :config
  (setq winum-auto-assign-0-to-minibuffer t)
  (winum-mode))

;; popwin
(use-package popwin
  :config
  (global-set-key (kbd "s-j") popwin:keymap)
  (push '(compilation-mode :noselect t :position bottom :height 22) popwin:special-display-config)
  (push '("*rspec-compilation*" :noselect t :position bottom :height 22) popwin:special-display-config)
  (push '("*vterm" :regexp t :stick t :position bottom :height 24) popwin:special-display-config)
  (popwin-mode))

;; Magit
(use-package magit
  :commands (magit-status magit-get-current-branch)
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

;; vterm
(use-package vterm)

;; Eshell - Git prompt
(use-package eshell-git-prompt
  :config
  (eshell-git-prompt-use-theme 'powerline))

;; Restclient
(use-package restclient)

;; Exec-path-from-shell
(use-package exec-path-from-shell
  :config
  (exec-path-from-shell-initialize))

;; add-node-modules-path
(use-package add-node-modules-path
  :hook (ruby-mode web-mode))

;; json-mode
(use-package json-mode)

;; yas-snippets
(use-package yasnippet
  :config
  (yas-reload-all)
  (yas-global-mode)
  :bind (:map yas-minor-mode-map
        ("C-'" . yas-expand)
        ([(tab)] . nil)
        ("TAB" . nil)))
(use-package react-snippets
  :after (yasnippet))
(use-package yasnippet-snippets
  :after (yasnippet))
(use-package js-react-redux-yasnippets
  :after (yasnippet))

;; Web-mode
(use-package web-mode
  :mode (("\\.js\\'" . web-mode)
   ("\\.jsx\\'" . web-mode)
   ("\\.ts\\'" . web-mode)
   ("\\.tsx\\'" . web-mode)
   ("\\.html\\'" . web-mode))
  :custom
  (web-mode-markup-indent-offset 2)
  (web-mode-code-indent-offset 2)
  (web-mode-css-indent-offset 2)
  (web-mode-auto-quote-style 2)
  :commands web-mode)

;; Prettier 🧞‍♀️
(use-package prettier-js
  :hook
  (web-mode . prettier-js-mode)
  (ruby-mode . prettier-js-mode)
  :bind (:map ruby-mode-map
        ("C-c =" . prettier-js)))

;; (use-package lsp-mode
;;   :init
;;   :hook ((web-mode . lsp-deferred)
;;    (ruby-mode . lsp-deferred)
;;          (lsp-mode . lsp-enable-which-key-integration))
;;   :config
;;   (setq lsp-log-io nil)
;;   (setq lsp-restart 'auto-restart)
;;   (setq lsp-keymap-prefix "C-c l")
;;   :commands lsp-deferred)

;; (use-package lsp-ui
;;   :custom
;;   (lsp-ui-sideline-show-diagnostics t)
;;   (lsp-ui-sideline-show-hover t)
;;   (lsp-ui-sideline-show-code-actions t)
;;   :commands lsp-ui-mode)

;; (use-package lsp-ivy :commands lsp-ivy-workspace-symbol)
;; (use-package lsp-treemacs :commands lsp-treemacs-errors-list)

;; optionally if you want to use debugger
;; (use-package dap-mode)
;; (use-package dap-LANGUAGE) to load the dap adapter for your language

;; eglot
(use-package eglot
  :config
  (add-to-list 'eglot-server-programs '(web-mode . ("typescript-language-server" "--stdio")))
  (add-hook 'ruby-mode-hook 'eglot-ensure)
  (add-hook 'web-mode-hook 'eglot-ensure))

;;;;;;;;;;;;;;;
;;;; Ruby ;;;;;
(use-package ruby-end)
(use-package flymake-ruby
  :hook (ruby-mode . flymake-ruby-load))
(use-package inf-ruby)
(use-package bundler
  :bind
  ((:map ruby-mode-map ("C-c b i" . #'bundle-install))
   (:map ruby-mode-map ("C-c b x" . #'bundle-exec))
   (:map ruby-mode-map ("C-c b u" . #'bundle-update))
   (:map ruby-mode-map ("C-c b o" . #'bundle-outdated))))

(use-package rspec-mode
  :hook (ruby-mode)
  :init
  (add-hook 'compilation-filter-hook #'inf-ruby-auto-enter)
  (add-hook 'rspec-before-verification-hook #'save-some-buffers)
  :config
  (rspec-install-snippets)
  (setq compilation-scroll-output t))

;; YAML
(use-package yaml-mode)

;; Read pdfs in Emacs
(use-package pdf-tools)

;;;;;;;;;;;;;;;;;;;
;; Supercollider ;;

;; used to visit documentation
(use-package w3m)

(use-package sclang
  :load-path "/Users/marcschmitz/Library/Application Support/SuperCollider/downloaded-quarks/scel/el"
  :init
  (setq exec-path (append exec-path '("/Applications/SuperCollider.app/Contents/MacOS/"))))
(use-package sclang-extensions)
(use-package sclang-snippets)

;; Show Dashboard screen
(dashboard-refresh-buffer)
(provide 'init)

;;; init.el ends here
