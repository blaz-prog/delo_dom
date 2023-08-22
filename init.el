(require 'package)
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
  (package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ispell-dictionary nil)
 '(org-agenda-files
   '("/home/blaz/navodila/clanki/emacs_bookmarks.org" "/home/blaz/navodila/clanki/odoo_registers.org" "/home/blaz/navodila/git/git_ignore.org" "/home/blaz/navodila/git/remote.org" "/home/blaz/navodila/agenda_files.org" "/home/blaz/navodila/amortizacija.org" "/home/blaz/navodila/anki_connect.org" "/home/blaz/navodila/bash.org" "/home/blaz/navodila/colorteme.org" "/home/blaz/navodila/command_line.org" "/home/blaz/navodila/datumi_zzzs.org" "/home/blaz/navodila/de.org" "/home/blaz/navodila/dravers.org" "/home/blaz/navodila/dz.org" "/home/blaz/navodila/emacs.org" "/home/blaz/navodila/instalacija_postgres.org" "/home/blaz/navodila/js.org" "/home/blaz/navodila/linux.org" "/home/blaz/navodila/main.org" "/home/blaz/navodila/new.org" "/home/blaz/navodila/nov.org" "/home/blaz/navodila/odoo_2many.org" "/home/blaz/navodila/odoo_py.org" "/home/blaz/navodila/osnovna.org" "/home/blaz/navodila/osnovna_sredstva.org" "/home/blaz/navodila/pg_sql.org" "/home/blaz/navodila/pgdump.org" "/home/blaz/navodila/popravi_place.org" "/home/blaz/navodila/posebnosti_prispevkov.org" "/home/blaz/navodila/postgres.org" "/home/blaz/navodila/prijava_virtualc.org" "/home/blaz/navodila/prispevki.org" "/home/blaz/navodila/psql_commands.org" "/home/blaz/navodila/py_postgres.org" "/home/blaz/navodila/python_dates.org" "/home/blaz/navodila/python_dev_env.org" "/home/blaz/navodila/python_loops.org" "/home/blaz/navodila/python_venv.org" "/home/blaz/navodila/regex.org" "/home/blaz/navodila/reki.org" "/home/blaz/navodila/rus.org" "/home/blaz/navodila/sample_entry.org" "/home/blaz/navodila/serverhino.org" "/home/blaz/navodila/ssh_keys.org" "/home/blaz/navodila/tar_zip.org" "/home/blaz/navodila/todo.org" "/home/blaz/navodila/todo_qt.org" "/home/blaz/navodila/todo_sluzba.org" "/home/blaz/navodila/update_packages.org" "/home/blaz/navodila/virtualenv.org" "/home/blaz/navodila/xquery.org" "/home/blaz/navodila/yasnippets.org" "/home/blaz/navodila/zdrava_hrana.org"))
 '(package-selected-packages
   '(eglot-jl hotfuzz marginalia vertico ag dashboard eglot super-save org-drill neotree xml-format anki-editor olivetti org-bullets zenburn-theme general use-package org-roam evil))
 '(warning-suppress-types '((comp))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(tool-bar-mode -1)
(load-theme 'zenburn t)
 (require 'evil)
  (evil-mode 1)
;; da lahko imam v evil complete whole line
 (defun my-expand-lines ()
    (interactive)
    (let ((hippie-expand-try-functions-list
           '(try-expand-line-all-buffers)))
      (call-interactively 'hippie-expand)))

  (define-key evil-insert-state-map (kbd "C-x C-w") 'my-expand-lines)

;; Da mi tab odpira in zapira headinge
(with-eval-after-load 'evil-maps (define-key evil-motion-state-map (kbd "TAB") nil))
;; da se z j in k premikam po visual lines
(define-key evil-normal-state-map (kbd "j") 'evil-next-visual-line)
(define-key evil-normal-state-map (kbd "k") 'evil-previous-visual-line)
(define-key evil-normal-state-map (kbd "gj") 'evil-next-line)
(define-key evil-normal-state-map (kbd "gk") 'evil-previous-line)

;;leader key
(use-package general
  :ensure t
  :after evil
  :config
  (general-create-definer tyrant-def
    :states '(normal insert motion emacs)
    :keymaps 'override
    :prefix "<SPC>"
    :non-normal-prefix "M-SPC")
  (tyrant-def "" nil)
  (general-def universal-argument-map
    "SPC u" 'universal-argument-more)
  (tyrant-def
    "dd" 'kill-this-buffer
    "fd" 'init-file
    "ff" 'find-file
    "fs" 'save-buffer
    "k" 'switch-to-buffer
    ";" 'next-buffer
    "a" 'previous-buffer
    "ys" 'yas-new-snippet
    "yi" 'yas-insert-snippet
    "ow" 'other-window
    "om" 'olivetti-mode
    "g" 'projectile-grep
    "xh" 'mark-whole-buffer))
;; end leader key

;; super save
(use-package super-save
  :ensure t
  :config
  (super-save-mode +1))


(blink-cursor-mode 0)
(setq inhibit-splash-screen t)
(require 'org)
(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 0)))
(require 'org-tempo)
(setq org-agenda-files (directory-files-recursively "~/navodila/" "\\.org$"))
;; da se lahko premikaj po agendi y j in k

(use-package org-roam
  :ensure t
  :custom
  (org-roam-directory "~/org_notes")
  ;;(org-roam-directory "~/org_ru_notes")
  :bind(
	("C-c n l" . org-roam-buffer-toggle)
	("C-c n f" . org-roam-node-find)
	("C-c n i" . org-roam-node-insert)
   )
  :config
  (org-roam-setup)
  )

(add-to-list 'load-path "~/yasnippet")
   (require 'yasnippet)
   (yas-global-mode 1)


(global-evil-surround-mode 1)

(global-set-key (kbd "C-c l") #'org-store-link)
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)


(org-babel-do-load-languages
'org-babel-load-languages
'((python . t)))


;;Anki
;;(require 'anki-editor)
;;spell
(setq ispell-program-name "aspell")

;;reformat xml
(use-package xml-format
  :demand t
  :after nxml-mode)

;;neotree (nerdtree for emacs)
;;(require 'neotree)
;;(global-set-key [f8] 'neotree-toggle)
;; hippie expansion
(global-set-key [remap dabbrev-expand] 'hippie-expand)


;; pogosto dostopani fajli
;; to visit the file whose name is in register r, type C-x r j r
(set-register ?g '(file . "~/gesla"))
(set-register ?i '(file . "~/.emacs.d/init.el"))

;;fb2
(use-package fb2-reader
  :commands (fb2-reader-continue))


;; projectile
(projectile-mode +1)
;; Recommended keymap prefix on Windows/Linux
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
(add-to-list 'projectile-globally-ignored-directories "node_modules")

;;(use-package dashboard
;;  :ensure t
;;  :config
;;  (dashboard-setup-startup-hook))

(use-package vertico
  :ensure t
  :bind (:map vertico-map
         ("C-j" . vertico-next)
         ("C-k" . vertico-previous)
         ("C-f" . vertico-exit)
         :map minibuffer-local-map
         ("M-h" . backward-kill-word))
  :custom
  (vertico-cycle t)
  :init
  (vertico-mode))

(use-package savehist
  :init
  (savehist-mode))

(use-package marginalia
  :after vertico
  :ensure t
  :custom
  (marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light nil))
  :init
  (marginalia-mode))

(setq completion-styles '(hotfuzz))


(use-package lsp-mode
  :config
  (setq lsp-idle-delay 0.5
        lsp-enable-symbol-highlighting t
        lsp-enable-snippet nil  ;; Not supported by company capf, which is the recommended company backend
        lsp-pyls-plugins-flake8-enabled t)
  (lsp-register-custom-settings
   '(("pyls.plugins.pyls_mypy.enabled" t t)
     ("pyls.plugins.pyls_mypy.live_mode" nil t)
     ("pyls.plugins.pyls_black.enabled" t t)
     ("pyls.plugins.pyls_isort.enabled" t t)

     ;; Disable these as they're duplicated by flake8
     ("pyls.plugins.pycodestyle.enabled" nil t)
     ("pyls.plugins.mccabe.enabled" nil t)
     ("pyls.plugins.pyflakes.enabled" nil t)))
  :hook
  ((python-mode . lsp)
   (lsp-mode . lsp-enable-which-key-integration))
  :bind (:map evil-normal-state-map
              ("gh" . lsp-describe-thing-at-point)
              :map md/leader-map
              ("Ff" . lsp-format-buffer)
              ("FR" . lsp-rename)))

(use-package lsp-ui
  :config (setq lsp-ui-sideline-show-hover t
                lsp-ui-sideline-delay 0.5
                lsp-ui-doc-delay 5
                lsp-ui-sideline-ignore-duplicates t
                lsp-ui-doc-position 'bottom
                lsp-ui-doc-alignment 'frame
                lsp-ui-doc-header nil
                lsp-ui-doc-include-signature t
                lsp-ui-doc-use-childframe t)
  :commands lsp-ui-mode
  :bind (:map evil-normal-state-map
              ("gd" . lsp-ui-peek-find-definitions)
              ("gr" . lsp-ui-peek-find-references)
              :map md/leader-map
              ("Ni" . lsp-ui-imenu)))

(use-package pyvenv
  :demand t
  :config
  (setq pyvenv-workon "emacs")  ; Default venv
  (pyvenv-tracking-mode 1))  ; Automatically use pyvenv-workon via dir-locals
