;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Kevin Keefe"
      user-mail-address "keefekevin91@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "monospace" :size 16 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-dracula)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)
(map! "C-c c" 'org-capture)
(map! "C-c a" 'org-agenda)
(map! "C-c l" 'org-store-link)

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
;;

;;; LSP things
;; eglot isn't as agood as forcing to use specific lsp and lsp mode only, tbh
;; (after! eglot
;;   (add-to-list 'eglot-server-programs '((c++-mode c-mode) "/usr/bin/clangd-9")))
;; (add-hook 'c-mode-hook 'eglot-ensure)
;; (add-hook 'c++-mode-hook 'eglot-ensure)
;; (add-to-list 'flycheck-cppcheck-include-path '"/home/kpkeefe/root_builds/root/build/include")
;;; debug things, related to LSP
(require 'dap-python)
(setq dap-python-executable "python3") ;; make sure it knows what python we're talking about
(require 'dap-gdb-lldb)
(after! dap
  (setq dap-gdb-lldb-path-lldb '("node" "/home/kpkeefe/.emacs.d/.extension/vscode/webfreak.debug/extension/out/src/lldb.js")))
;; requires things from: [[https://github.com/llvm/llvm-project/tree/master/lldb/tools/lldb-vscode]]
;; $ mkdir -p ~/.vscode/extensions/llvm-org.lldb-vscode-0.1.0/bin
;; $ cp package.json ~/.vscode/extensions/llvm-org.lldb-vscode-0.1.0
;; $ cd ~/.vscode/extensions/llvm-org.lldb-vscode-0.1.0/bin
;; $ cp /path/to/a/built/lldb-vscode .
;; $ cp /path/to/a/built/liblldb.so .

;;; projectile configuration:
(after! projectile
  (add-to-list 'projectile-globally-ignored-directories '"build"))

;; local setqs
(setq default-directory "~/")

;; for configuring more org things we want
(after! org
  (setq org-agenda-files
        '("~/org/" "~/play/README.org"))
  (advice-add 'org-refile :after 'org-save-all-org-buffers))
;; taken from org website, append notes to the org file?
(setq org-default-notes-file (concat org-directory "/notes.org"))
