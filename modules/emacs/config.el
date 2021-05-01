;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

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

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Kevin Keefe"
      user-mail-address "kevinpk@hawaii.edu"
      doom-theme 'doom-dracula)

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
;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-font (font-spec :family "Monaco" :size 14 :weight 'semi-light))
      ;; doom-variable-pitch-font (font-spec :family "Menlo" :size 13))

;;; keybindings
;; set this because i'm tired of accidentally reverting..
(map! "C-c c" 'org-capture)
(map! "C-c a" 'org-agenda)
(map! "C-c l" 'org-store-link)
(map! "C-c f" 'org-footnote-action)
(map! "C-c r" 'org-roam-capture)
(map! :leader
      (:prefix "q"
        :n "l" #'evil-window-right
        :n "h" #'evil-window-left))
;; Switch to the new window after splitting
(setq evil-split-window-below t
      evil-vsplit-window-right t
      display-line-numbers-type t
      default-directory "~/")

;; for configuring more org things we want
(after! org
  (setq org-directory "~/org/"
        org-list-allow-alphabetical t
        org-default-notes-file (concat org-directory "notes.org")
        org-archive-location (concat org-directory "archive.org::* From %s")
        org-agenda-files '("~/org/README.org"
                           "~/org/todo.org"
                           "~/org/journal.org"
                           "~/org/gcal.org")
        ;; list of custom org templates
        org-capture-templates
        '(("w" "work" entry (file+headline "~/org/todo.org" "Work Tasks")
          "* TODO %?\n:Description:\n %^t \n %i \n" :prepend t)
          ("p" "code problems" entry (file+headline "~/org/todo.org" "Current Bugs")
          "* TODO %?\n:Description:\n \n%i %a\n" :prepend t)
          ("s" "self-stuff" entry (file+headline "~/org/todo.org" "Self Tasks")
          "* TODO %?\n:Description:\n \n %i \n" :prepend t)
          ("b" "breakthroughs" entry (file+headline "~/org/todo.org" "Breakthroughs!")
          "* DONE %?\n:Description:\n%^T\n%i \n" :prepend t)))
  (advice-add 'org-refile :after 'org-save-all-org-buffers))

;;; things for google calendar syncing..
;; (setq org-gcal-client-id "961006309840-31rc93jb94bqvf0oj3s0bb4qbq86aes0.apps.googleusercontent.com"
;;       org-gcal-client-secret "qC8jc8BBJEPFtTs8mvJEm9RX"
;;       org-gcal-file-alist '(("keefekevin91@gmail.com" .  "~/org/gcal.org")))

;;; c++ / ROOT lsp configuration nightmares
;;; LSP things
;; eglot isn't as agood as forcing to use specific lsp and lsp mode only, tbh
;; (after! eglot
;;   (add-to-list 'eglot-server-programs '((c++-mode c-mode) "/usr/bin/clangd-9")))
;; (add-hook 'c-mode-hook 'eglot-ensure)
;; (add-hook 'c++-mode-hook 'eglot-ensure)
;; (add-to-list 'flycheck-cppcheck-include-path '"/home/kpkeefe/root_builds/root/build/include")
;; straght from the lord hisself..
;; https://github.com/hlissner/doom-emacs/tree/develop/modules/lang/cc#macos
;; solution below fixes unncessary irony problems with MacOS stuff, solution i found at URL below..
;; https://github.com/Sarcasm/irony-mode/issues/507
;; also useful command from: https://github.com/Microsoft/vscode-cpptools/issues/1268 - clang -v -E -x c++ - < /dev/null
;; (setq irony-additional-clang-options
;;       (append '("-I" "/usr/local/Cellar/llvm/10.0.0_3/include/c++/v1") irony-additional-clang-options))
;; (setq irony-additional-clang-options
;;       (append '("-I" "/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include") irony-additional-clang-options))
;; ;; needed this 2/12/2020..
;; (setq irony-additional-clang-options
;;       (append '("-I" "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/clang/11.0.3/include") irony-additional-clang-options))
;; (setq irony-additional-clang-options
;;       (append '("-std=c++11") irony-additional-clang-options))
;; ;; using homebrew to manage root now.. fixing tf1 import errors and switching to manage python with pyenv 07/06/2020
;; (setq irony-additional-clang-options
;;       (append '("-I" "/usr/local/Cellar/root/6.22.00_1/include/root") irony-additional-clang-options))

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

;;; python configurations
;; check to see if python finally figured it out with this one..
(setq python-shell-interpreter "python3"
      flycheck-python-pycompile-executable "python3")

;; including based on recommendation from link:
;; https://github.com/hlissner/doom-emacs/tree/develop/modules/lang/python
(after! lsp-python-ms
  (set-lsp-priority! 'mspyls 1))

;; we want to ignore anything longer than 88
(setq lsp-pyls-plugins-pycodestyle-max-line-length 88
      +python-jupyter-repl-args '("--simple-prompt")
      +python-ipython-repl-args '("-i" "--simple-prompt" "--no-color-info"))

;;; projectile things
;;; projectile configuration:
(after! projectile
  (setq projectile-sort-order 'recentf
        projectile-auto-discover 'nil)
  (add-to-list 'projectile-globally-ignored-directories '"build"))
;; find the repo's you want above home
(after! magit
  (setq magit-repository-directories
        '(("~/" . 1))))

;; c++ projects:
;; we want the svsc_irs project separate:
;; (projectile-register-project-type 'svsc_irs')
(defvar org-babel-default-header-args:C++
  ;; need to include this in libs so that babel passes these arguments after main.cc or whatever babel uses
  '((:libs . "$(root-config --libs) $(root-config --cflags) -O0 -I$(pwd) -I$(pwd)/include/")
    (:includes . [list "<iostream>" "<vector>" "TCanvas.h"])))


;; python projects:

;;  tramp things
;; (setq tramp-default-user "kevinpk") ;; useful for mtc connection
;; (setq tramp-default-remote-shell "/usr/bin/bash")

;; todoist
;; (setq todoist-token "351f50b1999cb691178bed76dea651f838079d47")

;;; vhdl-tool
;; (flycheck-define-checker vhdl-tool
;;   "A VHDL syntax checker, type checker and linter using VHDL-Tool.
;; See URL `http://vhdltool.com'."
;;   :command ("vhdl-tool" "client" "lint" "--compact" "--stdin" "-f" source
;;             )
;;   :standard-input t
;;   :error-patterns
;;   ((warning line-start (file-name) ":" line ":" column ":w:" (message) line-end)
;;    (error line-start (file-name) ":" line ":" column ":e:" (message) line-end))
;;   :modes (vhdl-mode))
;; (add-to-list 'flycheck-checkers 'vhdl-tool)
;; ;; then include the lsp path
;; (after! lsp-vhdl-server
;;   (setq lsp-vhdl-server-path "vhdl-tool"))

;; ;; mu4e things
;; ;; Each path is relative to `+mu4e-mu4e-mail-path', which is ~/.mail by default
;; (set-email-account! "keefekevin91@gmail.com"
;;   '((mu4e-sent-folder       . "/keefekevin91@gmail.com/Sent Mail")
;;     (mu4e-drafts-folder     . "/keefekevin91@gmail.com/Drafts")
;;     (mu4e-trash-folder      . "/keefekevin91@gmail.com/Trash")
;;     (mu4e-refile-folder     . "/keefekevin91@gmail.com/All Mail")
;;     (smtpmail-smtp-user     . "keefekevin91@gmail.com")
;;     (mu4e-compose-signature . "---\nKevin Keefe"))
;;   t)
;;;
