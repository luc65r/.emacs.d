(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)

(load-theme 'dracula t)

;(add-to-list 'default-frame-alist '(font . "Iosevka-12"))
(set-face-attribute 'default nil :font "Iosevka-12")
(set-fontset-font t nil "Material Design Icons-12" nil 'append)

;(add-to-list 'org-latex-packages-alist
;             '("AUTO" "babel" t ("pdflatex")))

(ido-mode t)

(rg-enable-default-bindings)

(require 'lsp)
(add-to-list 'lsp-language-id-configuration '(nix-mode . "nix"))
(lsp-register-client
 (make-lsp-client :new-connection (lsp-stdio-connection '("rnix-lsp"))
                  :major-modes '(nix-mode)
                  :server-id 'nix))
(require 'lsp-haskell)

(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024)
      lsp-completion-provider :capf)

(require 'company)
(setq company-minimum-prefix-length 1
      company-idle-delay 0.0)

(setq lsp-enable-on-type-formatting nil)

(setq ccls-initialization-options '(:compilationDatabaseDirectory "build"))

(setq c-default-style "java"
      c-basic-offset 4)

(pinentry-start)

(direnv-mode)
