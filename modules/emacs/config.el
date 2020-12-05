;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Kevin Keefe"
      user-mail-address "kevinpk@hawaii.edu")

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
(setq doom-font (font-spec :family "monospace" :size 16 ))
      ;; doom-variable-pitch-font (font-spec :family "Courier" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-dracula)

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

;; for configuring more org things we want
(after! org
  (setq org-directory "~/org/")
  (setq org-list-allow-alphabetical t)
  (setq org-agenda-files
        '("~/org/" "~/play/README.org"))
  (advice-add 'org-refile :after 'org-save-all-org-buffers))
;; taken from org website, append notes to the org file?
(setq org-default-notes-file (concat org-directory "/notes.org"))

;; ;; set this because i'm tired of accidentally reverting..
(map! :leader
      (:prefix "q"
        :n "l" #'evil-window-right
        :n "h" #'evil-window-left))

;; Switch to the new window after splitting
(setq evil-split-window-below t
      evil-vsplit-window-right t
      default-directory "~/")

;; additional personal things:
;; ;; org keybinds to set
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-c f") 'org-footnote-action)

;; list of custom org templates
(after! org
  (setq org-capture-templates
        '(("w" "work" entry (file+headline "~/org/work_done.org" "Work_Tasks")
          "* TODO %?\n:Description:\n %^t \n %i \n")
          ("s" "self-stuff" entry (file+headline "~/org/work_done.org" "Self_Tasks")
          "* TODO %?\n:Description:\n %^t \n %i \n")
          ("v" "quick work" entry (file+headline "~/org/work_done.org" "Quick_Tasks")
          "* TODO %?\n:Description:\n %^t \n %i \n")
          ("c" "creative" entry (file+headline "~/org/work_done.org" "Creative_Work")
          "* TODO %?\n:Description:\n%^t \n %i \n")
          ("p" "code problems" entry (file+headline "~/org/current_bugs.org" "Current Bugs")
          "* TODO %?\n:Description:\n%^T\n%i %a\n" :prepend t)
          ("b" "breakthroughs" entry (file+headline "~/org/current_bugs.org" "Breakthroughs!")
          "* DONE %?\n:Description:\n%^T\n%i %a\n"))))

;; where we set the org-agenda files to look for TODO values..
(setq org-agenda-files (list "~/org/work_done.org"
                             "~/org/current_bugs.org"
                             ;; added by the lord
                             "~/org/org_notes.org"
                             "~/org/todo.org"
                             "~/org/journal.org"
                             ;; not currently using gcal..
                             "~/org/gcal.org"))

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

;; ;; check to see if python finally figured it out with this one..
;; (setq python-shell-interpreter "python3"
;;       flycheck-python-pycompile-executable "python3")

;; including based on recommendation from link:
;; https://github.com/hlissner/doom-emacs/tree/develop/modules/lang/python
(after! lsp-python-ms
  (set-lsp-priority! 'mspyls 1))

;; we want to ignore anything longer than 88
(setq lsp-pyls-plugins-pycodestyle-max-line-length 88)

;; we don't want this stupid checker
;; (setq flycheck-disabled-checkers '(python-pylint))
(setq +python-ipython-repl-args '("-i" "--simple-prompt" "--no-color-info"))
(setq +python-jupyter-repl-args '("--simple-prompt"))

;;; basic package configurations beyond language:

;; things for google calendar syncing..
;; (setq org-gcal-client-id "961006309840-31rc93jb94bqvf0oj3s0bb4qbq86aes0.apps.googleusercontent.com"
;;       org-gcal-client-secret "qC8jc8BBJEPFtTs8mvJEm9RX"
;;       org-gcal-file-alist '(("keefekevin91@gmail.com" .  "~/org/gcal.org")))

;;; projectile things
(setq projectile-sort-order 'recentf) ;; want to open most recent things
(setq projectile-auto-discover 'nil) ;; don't get projects we don't want..
;; (setq projectile-globally-ignored-directories  '("/Users/kevinkeefe/Documents/SVSC-Work-Stations/WorkStation3/svsc_irs/build"))

;;  tramp things
;; (setq tramp-default-user "kevinpk") ;; useful for mtc connection
;; (setq tramp-default-remote-shell "/usr/bin/bash")

;; c++ projects:
;; we want the svsc_irs project separate:
;; (projectile-register-project-type 'svsc_irs ')

;; python projects:

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
