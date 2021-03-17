;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Seth Doty"
      user-mail-address "sethmdoty@posteo.net")
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
(setq doom-font (font-spec :family "JetBrains Mono" :size 12 :weight 'semi-light)
      doom-big-font (font-spec :family "JetBrains Mono" :size 24)
      doom-variable-pitch-font (font-spec :family "JetBrains Mono" :size 13)
      doom-serif-font (font-spec :family "Source Sans Pro" :weight 'light))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-nord)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Sync/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;;General improvements
(setq with-editor-emacsclient-executable "/etc/profiles/per-user/sethdoty/bin/emacsclient")

(setq-default
 delete-by-moving-to-trash t                      ; Delete files to trash
 tab-width 4                                      ; Set width for tabs
 uniquify-buffer-name-style 'forward              ; Uniquify buffer names
 window-combination-resize t                      ; take new window space from all other windows (not just current)
 x-stretch-cursor t)                              ; Stretch cursor to the glyph width

(delete-selection-mode 1)                         ; Replace selection when inserting text
(global-subword-mode 1)                           ; Iterate through CamelCase words

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
;;Python Stuff
(after! lsp-python-ms
  (set-lsp-priority! 'mspyls 1))
(setq org-babel-python-command "python3")

(after! dired
  (setq dired-listing-switches "-aBhl  --group-directories-first"
        dired-dwim-target t
        dired-recursive-copies (quote always)
        dired-recursive-deletes (quote top)))

;; ORG
(setq org-agenda-files (list "~/Sync/org/org-files/")
      org-use-property-inheritance t
      org-log-done 'time
      org-list-allow-alphabetical t
      org-export-in-backgroup t
      org-catch-invisible-edits 'smart)
;;Org task keywords
(setq org-todo-keywords
      '((sequence "TODO(t)" "NEXT(n)" "IN PROGRESS(I)" "|" "DONE(d)")
        (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)")))
;; Org clocking config
(setq org-log-done 'time
      org-log-into-drawer t
      org-log-state-notes-insert-after-drawers nil)
;;Org mode tag listing
(setq org-tag-alist '(("@errand" . ?e)
                      ("@office" . ?o)
                      ("@home" . ?h)
                      (:newline)
                      ("CANCELLED" . ?c)))
;;Org Roam Configuration
(use-package! org-roam
  :after org
  :commands (org-roam-insert org-roam-find-file org-roam-switch-to-buffer org-roam)
  :hook
  (after-init . org-roam-mode)
  :init
  (setq org-roam-directory "~/Sync/org/roam/"
        org-roam-db-location "~/Sync/org/roam/org-roam.db"
        org-roam-db-gc-threshold most-positive-fixnum
        org-roam-graph-exclude-matcher "private"
        org-roam-tag-sources '(prop last-directory)
        org-id-link-to-org-use-id t)
  :config
  (setq org-roam-capture-templates
             '(("d" "default" plain (function org-roam--capture-get-point)
     "\n-tags::\n%?"
     :file-name "%<%Y%m%d%H%M%S>-${slug}"
     :head "#+TITLE: ${title}"
     :unnarrowed t))))
;; Org Journal Setup
(use-package! org-journal
  :after org
  :custom
  (org-journal-date-prefix "#+title: ")
  (org-journal-enable-agenda-integration t)
  (org-journal-dir (format "~/Sync/org/roam/" (format-time-string "%Y")))
  (org-journal-file-format "%Y-%m-%d.org")
  (org-journal-date-format "%A, %d %B %Y"))
;;
;; Gotta get that sweet org-chef auto insert
;;
(use-package! org-chef
  :after org
  :commands (org-chef-insert-recipe org-chef-get-recipe-from-url))
;;
;;Org cite
;;
;; (use-package! org-ref
;;    :after org
;;    :config
;;    (setq org-ref-completion-library 'org-ref-ivy-cite))
;;
;;Org SuperAgenda
;;
(use-package! org-super-agenda
  :commands (org-super-agenda-mode))
(after! org-agenda
  (org-super-agenda-mode))

(setq org-agenda-skip-scheduled-if-done t
      org-agenda-skip-deadline-if-done t
      org-agenda-include-deadlines t
      org-agenda-block-separator nil
      org-agenda-tags-column 100 ;; from testing this seems to be a good value
      org-agenda-compact-blocks t)

(setq org-agenda-custom-commands
      '(("o" "Overview"
         ((agenda "" ((org-agenda-span 'day)
                      (org-super-agenda-groups
                       '((:name "Today"
                                :time-grid t
                                :date today
                                :todo "TODAY"
                                :scheduled today
                                :order 1)))))
          (alltodo "" ((org-agenda-overriding-header "")
                       (org-super-agenda-groups
                        '((:name "Next to do"
                                 :todo "NEXT"
                                 :order 1)
                          (:name "Important"
                                 :tag "Important"
                                 :priority "A"
                                 :order 6)
                          (:name "Due Today"
                                 :deadline today
                                 :order 2)
                          (:name "Due Soon"
                                 :deadline future
                                 :order 8)
                          (:name "Overdue"
                                 :deadline past
                                 :face error
                                 :order 7)
                          (:name "Assignments"
                                 :tag "Assignment"
                                 :order 10)
                          (:name "Issues"
                                 :tag "Issue"
                                 :order 12)
                          (:name "Emacs"
                                 :tag "Emacs"
                                 :order 13)
                          (:name "Projects"
                                 :tag "Project"
                                 :order 14)
                          (:name "Research"
                                 :tag "Research"
                                 :order 15)
                          (:name "To read"
                                 :tag "Read"
                                 :order 30)
                          (:name "Waiting"
                                 :todo "WAITING"
                                 :order 20)
                          (:name "Trivial"
                                 :priority<= "E"
                                 :tag ("Trivial" "Unimportant")
                                 :todo ("SOMEDAY" )
                                 :order 90)
                          (:discard (:tag ("Chore" "Routine" "Daily")))))))))))
;;
;; Org Capture
;;
;; Doct allows an easy to use org-capture template setup so I can actually read this stuff
;; 
(use-package! doct
  :after org
  :commands (doct))

(after! org-capture
  ;;
  ;; Set my org file paths
  ;; 
  (setq +org-capture-recipies  "~/Sync/org/org-files/cookbook.org")
  (setq +org-capture-todo-file "~/Sync/org/org-files/todo.org")
  (setq +org-capture-central-project-notes-file "~/Sync/org/org-files/projects.org")
  (setq +org-capture-central-project-todo-file "~/Sync/org/org-files/projects.org")
  (setq +org-capture-links-file "~/Sync/org/org-files/links.org")
;;
;; We have just been making things pretty.  I should probably make some actual templates
;; 
  (add-transient-hook! 'org-capture-select-template
    (setq org-capture-templates
          (doct `(("Tasks" :keys "t"
                   :icon ("inbox" :set "octicon" :color "yellow")
                   :file +org-capture-todo-file
                   :prepend t
                   :headline "Tasks"
                   :type entry
                   :template ("* TODO %? %^G%{extra}"
                              "%i %a")
                   :children (("General Task" :keys "k"
                               :icon ("inbox" :set "octicon" :color "yellow")
                               :extra ""
                               )
                              ("Task with deadline" :keys "d"
                               :icon ("timer" :set "material" :color "orange" :v-adjust -0.1)
                               :extra "\nDEADLINE: %^{Deadline:}t"
                               )
                              ("Scheduled Task" :keys "s"
                               :icon ("calendar" :set "octicon" :color "orange")
                               :extra "\nSCHEDULED: %^{Start time:}t"
                               )
                              ))
                  ("Personal note" :keys "n"
                   :icon ("sticky-note-o" :set "faicon" :color "green")
                   :file +org-capture-todo-file
                   :prepend t
                   :headline "Inbox"
                   :type entry
                   :template ("* %?"
                              "%i %a")
                   )
                  ("Cliplink" :keys "l"
                   :icon ("sticky-note-o" :set "faicon" :color "blue")
                   :file +org-capture-links-file
                   :prepend t
                   :headline "Links"
                   :type entry
                   :template ("* TODO %(org-cliplink-capture) \n
                              %i %a")
                   )
                  ("Cookbook" :keys "b"
                   :icon ("checklist" :set "octicon" :color "blue")
                   :file +org-capture-recipies
                   :prepend t
                   :type entry
                   :template ("%(org-chef-get-recipe-from-url)")
                   )
                  ("Email" :keys "f"
                   :icon ("checklist" :set "octicon" :color "yellow")
                   :file +org-capture-todo-file
                   :prepend t
                   :type entry
                   :template ("* TODO %a by [[mailto:%:fromaddress][%:fromname]]\n%U\n\n%i%?\n"))
                ("Project" :keys "p"
                 :icon ("repo" :set "octicon" :color "silver")
                   :prepend t
                   :type entry
                   :headline "Inbox"
                   :template ("* %{time-or-todo} %?"
                              "%i"
                              "%a")
                   :file ""
                   :custom (:time-or-todo "")
                   :children (("Project-local todo" :keys "t"
                               :icon ("checklist" :set "octicon" :color "green")
                               :time-or-todo "TODO"
                               :file +org-capture-project-todo-file)
                              ("Project-local note" :keys "n"
                               :icon ("sticky-note" :set "faicon" :color "yellow")
                               :time-or-todo "%U"
                               :file +org-capture-project-notes-file))
                   ))))))
