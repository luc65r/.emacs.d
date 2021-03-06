(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)

(load-theme 'dracula t)

;(add-to-list 'default-frame-alist '(font . "Iosevka-12"))
(set-face-attribute 'default nil :font "Iosevka-12")
(set-fontset-font t nil "Material Design Icons-12" nil 'append)

;(add-to-list 'org-latex-packages-alist
;             '("AUTO" "babel" t ("pdflatex")))

(setq backup-by-copying t
      backup-directory-alist `(("." . "~/.saves"))
      vc-make-backup-files t
      version-control t
      delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2)

(ivy-mode 1)
(setq ivy-use-virtual-buffers t
      ivy-count-format "(%d/%d) "
      ivy-re-builders-alist '((t . ivy--regex-fuzzy)))

(rg-enable-default-bindings)

; Use a new terminal type instead of "dumb" for special care
(setq tramp-terminal-type "tramp")

(pdf-loader-install)

(setq TeX-view-program-selection
      '((output-pdf "PDF Tools")))
(add-hook 'TeX-after-compilation-finished-functions
          #'TeX-revert-document-buffer)

(require 'lsp)
(add-to-list 'lsp-language-id-configuration '(nix-mode . "nix"))
(add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]\\.direnv\\'")
(lsp-register-client
 (make-lsp-client :new-connection (lsp-stdio-connection '("rnix-lsp"))
                  :major-modes '(nix-mode)
                  :server-id 'nix))
(require 'lsp-haskell)

(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024)
      lsp-completion-provider :capf)

(require 'company)
(add-hook 'after-init-hook 'global-company-mode)
(setq company-minimum-prefix-length 1
      company-idle-delay 0.0)
(with-eval-after-load 'company
  (define-key company-active-map (kbd "RET") nil)
  (define-key company-active-map (kbd "<return>") nil)
  (define-key company-active-map (kbd "C-RET") #'company-complete-selection)
  (define-key company-active-map (kbd "C-<return>") #'company-complete-selection))

(setq lsp-enable-on-type-formatting nil)

(setq ccls-initialization-options '(:compilationDatabaseDirectory "build"))

(setq c-default-style "java"
      c-basic-offset 4)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

(pinentry-start)

(direnv-mode)

(require 'org)
(add-hook 'org-mode-hook 'turn-on-org-cdlatex)
(setq org-format-latex-options (plist-put org-format-latex-options :scale 1.5))

(require 'mu4e)
(setq mail-user-agent 'mu4e-user-agent
      mu4e-get-mail-command "mbsync -a"
      mu4e-contexts
      `(,(make-mu4e-context
	  :name "tedomum"
	  :enter-func (lambda () (mu4e-message "Entering tedomum context"))
	  :leave-func (lambda () (mu4e-message "Leaving tedomum context"))
	  :match-func (lambda (msg)
			(when msg
			  (string-match-p "^/tedomum"
					  (mu4e-message-field msg :maildir))))
	  :vars '((user-mail-address . "lucas@ransan.tk")
		  (user-full-name . "Lucas Ransan")
		  (mu4e-sent-folder . "/tedomum/Sent")
		  (mu4e-drafts-folder . "/tedomum/Drafts")
		  (mu4e-trash-folder . "/tedomum/Trash")
		  (mu4e-refile-folder . "/tedomum/Archive")))
	,(make-mu4e-context
	  :name "eisti"
	  :enter-func (lambda () (mu4e-message "Entering eisti context"))
	  :leave-func (lambda () (mu4e-message "Leaving eisti context"))
	  :match-func (lambda (msg)
			(when msg
			  (string-match-p "^/eisti"
					  (mu4e-message-field msg :maildir))))
	  :vars '((user-mail-address . "lucas.ransan@eisti.eu")
		  (user-full-name . "Lucas Ransan")
		  (mu4e-sent-folder . "/eisti/[Gmail]/Messages envoy&AOk-s")
		  (mu4e-drafts-folder . "/eisti/[Gmail]/Brouillons")
		  (mu4e-trash-folder . "/eisti/[Gmail]/Corbeille")
		  (mu4e-refile-folder . "/eisti/[Gmail]/Tous les messages")
		  (mu4e-sent-messages-behavior . delete))))
      mu4e-headers-date-format "%F"
      mu4e-use-fancy-chars t
      sendmail-program "msmtp"
      message-sendmail-f-is-evil t
      message-sendmail-extra-arguments '("--read-envelope-from")
      send-mail-function 'smtpmail-send-it
      message-send-mail-function 'message-send-mail-with-sendmail)

(require 'emms-setup)
(require 'emms-player-mpd)
(emms-all)
(add-to-list 'emms-info-functions 'emms-info-mpd)
(add-to-list 'emms-player-list 'emms-player-mpd)
(setq emms-player-mpd-server-name "localhost"
      emms-player-mpd-server-port "6600")

(setq asm-comment-char ?#)

(setq nasm-basic-offset 4
      nasm-after-mnemonic-whitespace nil)
