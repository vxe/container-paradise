(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(Info-additional-directory-list (quote ("~/man")))
 '(Info-default-directory-list
   (quote
    ("/usr/local/Cellar/emacs/24.5/share/info/emacs/" "/usr/local/share/info/" "/usr/share/info/" "~/share/info")))
 '(LilyPond-lilypond-command
   "/Applications/LilyPond.app/Contents/Resources/bin/lilypond")
 '(alert-default-style (quote notifier))
 '(appt-display-duration 60)
 '(appt-display-interval 10)
 '(appt-message-warning-time 30)
 '(auto-revert-remote-files t)
 '(aw-keys nil)
 '(backward-delete-char-untabify-method (quote hungry))
 '(browse-url-browser-function (quote eww-browse-url))
 '(c++-mode-hook nil)
 '(cal-tex-diary t)
 '(cal-tex-holidays nil)
 '(cider-cljs-lein-repl
   "(do (require 'figwheel-sidecar.repl-api) (figwheel-sidecar.repl-api/start-figwheel!) (figwheel-sidecar.repl-api/cljs-repl))")
 '(clush:alert-dashboard-file "~/.emacs.d/kb/wiggle-board.org")
 '(clush:dns-dir "~/opt/dns")
 '(company-idle-delay 0.7)
 '(custom-safe-themes
   (quote
    ("e11569fd7e31321a33358ee4b232c2d3cf05caccd90f896e1df6cab228191109" "e9460a84d876da407d9e6accf9ceba453e2f86f8b86076f37c08ad155de8223c" "3d5307e5d6eb221ce17b0c952aa4cf65dbb3fa4a360e12a71e03aab78e0176c5" "2cfc1cab46c0f5bae8017d3603ea1197be4f4fff8b9750d026d19f0b9e606fae" "490644a43ad9f71848f067be117bab2839b7c010eb9ec439abf3908d9a63d1dd" "72ef6008c5981a5f9f8760fad021e2801c19b28514ff46d3ddea663c5e61613d" "e297f54d0dc0575a9271bb0b64dad2c05cff50b510a518f5144925f627bb5832" "e3fc83cdb5f9db0d0df205f5da89af76feda8c56d79a653a5d092c82c7447e02" "eae43024404a1e3c4ea853a9cf7f6f2ad5f091d17234ec3478a23591f25802eb" "47744f6c8133824bdd104acc4280dbed4b34b85faa05ac2600f716b0226fb3f6" "d3a7eea7ebc9a82b42c47e49517f7a1454116487f6907cf2f5c2df4b09b50fc1" "4af6fad34321a1ce23d8ab3486c662de122e8c6c1de97baed3aa4c10fe55e060" "67e998c3c23fe24ed0fb92b9de75011b92f35d3e89344157ae0d544d50a63a72" "5f2b26c6fd4ae22a12f7c0bcc49c634c657f31c705adec7d5da66eef5c537997" "7153b82e50b6f7452b4519097f880d968a6eaf6f6ef38cc45a144958e553fbc6" "100d6bde8ef749efd2984f24db31434d90348d9aaf718f94231208e95fae37a2" "51e228ffd6c4fff9b5168b31d5927c27734e82ec61f414970fc6bcce23bc140d" "557c283f4f9d461f897b8cac5329f1f39fac785aa684b78949ff329c33f947ec" "b571f92c9bfaf4a28cb64ae4b4cdbda95241cd62cf07d942be44dc8f46c491f4" "94ba29363bfb7e06105f68d72b268f85981f7fba2ddef89331660033101eb5e5" "1c50040ec3b3480b1fec3a0e912cac1eb011c27dd16d087d61e72054685de345" "ce557950466bf42096853c6dac6875b9ae9c782b8665f62478980cc5e3b6028d" "9b402e9e8f62024b2e7f516465b63a4927028a7055392290600b776e4a5b9905" "603a9c7f3ca3253cb68584cb26c408afcf4e674d7db86badcfe649dd3c538656" "40bc0ac47a9bd5b8db7304f8ef628d71e2798135935eb450483db0dbbfff8b11" "45712b65018922c9173439d9b1b193cb406f725f14d02c8c33e0d2cdad844613" "405b0ac2ac4667c5dab77b36e3dd87a603ea4717914e30fcf334983f79cfd87e" "c4a784404a2a732ef86ee969ab94ec8b8033aee674cd20240b8addeba93e1612" "b79104a19e95f10698badb711bd4ab25565af3ffcf18fa7d3c7db4de7d759ac8" "1012cf33e0152751078e9529a915da52ec742dabf22143530e86451ae8378c1a" "f782ed87369a7d568cee28d14922aa6d639f49dd676124d817dd82c8208985d0" "7e67bf73d7b1e112a37b5f1e7fb4c2b3b45b2081b78eb1001f5b69c40835ac64" "12b7ed9b0e990f6d41827c343467d2a6c464094cbcc6d0844df32837b50655f9" "c3e6b52caa77cb09c049d3c973798bc64b5c43cc437d449eacf35b3e776bf85c" "b825687675ea2644d1c017f246077cdd725d4326a1c11d84871308573d019f67" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "fbcdb6b7890d0ec1708fa21ab08eb0cc16a8b7611bb6517b722eba3891dfc9dd" "51277c9add74612c7624a276e1ee3c7d89b2f38b1609eed6759965f9d4254369" "7feeed063855b06836e0262f77f5c6d3f415159a98a9676d549bfeb6c49637c4" "c158c2a9f1c5fcf27598d313eec9f9dceadf131ccd10abc6448004b14984767c" "3c739119f2999b646df6250658c0ef1ab15022aee177f496e7c519787e704a3a" "7997e0765add4bfcdecb5ac3ee7f64bbb03018fb1ac5597c64ccca8c88b1262f" "067d9b8104c0a98c916d524b47045367bdcd9cf6cda393c5dae8cd8f7eb18e2a" "ea489f6710a3da0738e7dbdfc124df06a4e3ae82f191ce66c2af3e0a15e99b90" "40c66989886b3f05b0c4f80952f128c6c4600f85b1f0996caa1fa1479e20c082" "959a77d21e6f15c5c63d360da73281fdc40db3e9f94e310fc1e8213f665d0278" "8aa7eb0cc23931423f719e8b03eb14c4f61aa491e5377073d6a55cba6a7bc125" "7ceb8967b229c1ba102378d3e2c5fef20ec96a41f615b454e0dc0bfa1d326ea6" default)))
 '(debug-on-error nil)
 '(desktop-auto-save-timeout 300)
 '(diary-file "~/.emacs.d/wiki/@@calendar")
 '(diredp-hide-details-initially-flag nil)
 '(dumb-jump-mode t)
 '(eclim-eclipse-dirs (quote ("/Applications/Eclipse.app/Contents/Eclipse")))
 '(eclim-executable "/Applications/Eclipse.app/Contents/Eclipse/eclim")
 '(elfeed-feeds (quote ("https://www.reddit.com/r/ableton.rss")))
 '(elnode-webserver-docroot "/Users/vedwin/.emacs.d/kb")
 '(elscreen-default-buffer-initial-major-mode (quote lisp-interaction-mode))
 '(elscreen-tab-display-control nil)
 '(elscreen-tab-display-kill-screen nil)
 '(emms-source-file-default-directory "~/Music")
 '(emms-stream-default-action "play")
 '(engine-mode t)
 '(evernote-developer-token
   "S=s526:U=58ea3e0:E=163b29c159c:C=15c5aeae6f8:P=1cd:A=en-devtoken:V=2:H=923d795ca68f9f5ddf81c1217d474e67")
 '(evernote-password-cache t)
 '(evernote-ruby-command "/Users/vedwin/.rbenv/shims/ruby")
 '(evernote-username "vedwin.dev@gmail.com")
 '(eww-search-prefix "https://www.google.com/search?q=")
 '(eyebrowse-keymap-prefix "")
 '(geeknote-command "geeknote")
 '(geeknote-default-tag "\"inbox\"")
 '(geeknote-venv "geeknote")
 '(geiser-default-implementation (quote guile))
 '(geiser-guile-init-file "~/.guile")
 '(global-company-mode t)
 '(global-semantic-idle-scheduler-mode nil)
 '(global-semanticdb-minor-mode nil)
 '(gnus-article-sort-functions (quote ((not gnus-article-sort-by-number))))
 '(gnus-thread-sort-functions (quote ((not gnus-thread-sort-by-number))))
 '(gofmt-command "gofmt")
 '(google-this-browse-url-function (quote eww))
 '(guide-key-mode t)
 '(helm-case-fold-search t)
 '(helm-dash-browser-func (quote eww-browse-url))
 '(helm-swoop-pre-input-function
   (quote
    #[0 "\300\301!\207"
        [thing-at-point symbol]
        2 "

(fn)"]))
 '(helm-swoop-speed-or-color t)
 '(ispell-local-dictionary nil)
 '(jabber-auto-reconnect nil)
 '(jabber-backlog-number 100)
 '(jabber-global-history-filename "~/Documents/chat/jabber-global-message-log")
 '(jabber-history-enable-rotation t)
 '(jabber-history-enabled t)
 '(jabber-history-muc-enabled nil)
 '(jabber-history-size-limit 1024)
 '(jabber-use-global-history nil)
 '(jdee-server-dir "~/.emacs.d/bin/jdee-server/target")
 '(jedi:complete-on-dot 1)
 '(jenkins-url "https://build.parsec.apple.com/jenkins/")
 '(ledger-reports
   (quote
    (("bal" "ledger -f %(ledger-file) bal")
     ("reg" "ledger -f %(ledger-file) reg")
     ("checking-account-diff" "ledger -f %(ledger-file) reg Assets:Bank:Checking:Citizens")
     ("expenses-this-month" "ledger -f %(ledger-file) bal Expenses --begin 'this month'")
     ("income-this-month" "ledger --monthly register ^income -f %(ledger-file)")
     ("liabilities-monthly" "ledger -f %(ledger-file) balance Liabilities")
     ("expenses-monthly" "ledger -f %(ledger-file) balance Expenses")
     ("budget-status" "ledger --budget  --monthly register ^expenses -f %(ledger-file)")
     ("unbudgeted-expenses" "ledger --unbudgeted  --monthly register ^expenses -f %(ledger-file)"))))
 '(lightsail-server-list (quote ("trashcat")))
 '(livedown:autostart nil)
 '(livedown:open t)
 '(livedown:port 1337)
 '(llvm:opt-program "/usr/local/Cellar/llvm/3.6.2/bin/opt")
 '(lsp-javascript-typescript-server "javascript-typescript-langserver")
 '(lsp-javascript-typescript-server-args (quote ("stdio")))
 '(mail-host-address "vijays-mbp.localhost")
 '(major-mode (quote org-mode))
 '(markdown-command "flavor.rb")
 '(markdown-preview-port 6419)
 '(md4rd-subs-active
   (quote
    (lisp+Common_Lisp prolog ableton ADHD Anxiety Archeology Art artificial AskMen AskWomen astrology bassnectar bearapp Bitwig comedy comics dating dating_advice Drugs edmproduction electricdaisycarnival emacs Futurology gender history Instagram introverts Jokes languagelearning linguistics marshmello math MDMA memes mildlyinteresting mythology Parenting philosophy programming psychology quotes relationships religion Rezz seduction sex Showerthoughts socialanxiety teslamotors Tinder)))
 '(mu4e-maildir "/Users/vedwin/gmail-wtf")
 '(mu4e-sent-folder "/sent")
 '(network-security-level (quote low))
 '(notmuch-address-use-company t)
 '(notmuch-always-prompt-for-sender t)
 '(notmuch-archive-tags (quote ("-inbox")))
 '(notmuch-fcc-dirs nil)
 '(notmuch-mua-user-agent-function (quote notmuch-mua-user-agent-emacs))
 '(notmuch-saved-searches
   (quote
    ((:name "inbox" :query "tag:inbox" :key "i")
     (:name "unread" :query "tag:unread" :key "u")
     (:name "flagged" :query "tag:flagged" :key "f")
     (:name "sent" :query "tag:sent" :key "t")
     (:name "drafts" :query "tag:draft" :key "d")
     (:name "all mail" :query "*" :key "a")
     (:name "shift-change" :query "date:3w..!")
     (:name "ESPRESSO" :query "tag:ESPRESSO")
     (:name "TRITON-SRE" :query "to:triton-sre@group.apple.com")
     (:name "steven-duplinksky" :query "from:sduplinsky@apple.com"))))
 '(notmuch-search-oldest-first nil)
 '(notmuch-show-all-tags-list t)
 '(org-agenda-files (quote ("~/.emacs.d/wiki/work.org")))
 '(org-agenda-restore-windows-after-quit t)
 '(org-agenda-skip-function-global
   (quote
    (org-agenda-skip-entry-if
     (quote todo)
     (quote done))))
 '(org-agenda-skip-scheduled-if-done t)
 '(org-agenda-sorting-strategy
   (quote
    ((agenda habit-down time-up priority-down category-keep)
     (todo priority-down category-keep tag-up)
     (tags priority-down category-keep)
     (search category-keep))))
 '(org-agenda-sticky t)
 '(org-babel-load-languages
   (quote
    ((emacs-lisp . t)
     (shell . t)
     (scheme . t)
     (makefile . t)
     (latex . t)
     (lilypond . t)
     (gnuplot . t)
     (python . t))))
 '(org-babel-python-command "python")
 '(org-capture-templates
   (quote
    (("j" "journal" entry
      (file+datetree "~/.emacs.d/kb/journal.org")
      "* %?")
     ("i" "inbox" entry
      (file+headline "~/.emacs.d/kb/anxiety-box.org" "capture")
      "* INCOMPLETE %?
%u")
     ("t" "talk_to" entry
      (file "~/.emacs.d/kb/agenda.org")
      "* INCOMPLETE %?
%u" :prepend t)
     ("e" "email" entry
      (file+headline "~/.emacs.d/kb/work.org" "E-mail")
      "*** INCOMPLETE %?" :prepend t)
     ("w" "work" entry
      (file+headline "~/.emacs.d/kb/work.org" "inbox")
      "*** INCOMPLETE %?"))))
 '(org-directory "~/Dropbox/desktop/Documents/gtd/")
 '(org-drill-learn-fraction 0.25)
 '(org-export-backends (quote (ascii html icalendar latex md)))
 '(org-export-use-babel nil)
 '(org-file-apps
   (quote
    ((t . emacs)
     ("\\.mm\\'" . default)
     ("\\.x?html?\\'" . default)
     ("\\.pdf\\'" . default))))
 '(org-format-latex-options
   (quote
    (:foreground default :background default :scale 2.0 :html-foreground "Black" :html-background "Transparent" :html-scale 1.0 :matchers
                 ("begin" "$1" "$" "$$" "\\(" "\\["))))
 '(org-hide-emphasis-markers t)
 '(org-hide-leading-stars t)
 '(org-html-head
   "<link rel=\"stylesheet\" type=\"text/css\" href=\"style.css\" />")
 '(org-image-actual-width 100)
 '(org-imenu-depth 3)
 '(org-link-frame-setup
   (quote
    ((vm . vm-visit-folder-other-frame)
     (vm-imap . vm-visit-imap-folder-other-frame)
     (gnus . org-gnus-no-new-news)
     (file . find-file)
     (wl . wl-other-frame))))
 '(org-publish-project-alist
   (quote
    (("octopress" :components
      ("octopress-posts" "octopress-org"))
     ("octopress-posts" :base-directory "~/octopress/source/blog" :publishing-directory "~/octopress/source/_posts" :base-extension "org" :recursive nil :exclude "/[^0-9][^/]+\\.org$" :publishing-function org-jekyll-publish-to-html)
     ("octopress-org" :base-directory "~/octopress/source" :publishing-directory "~/octopress/source" :base-extension "org" :exclude "[0-9]\\{4\\}-[0-9][0-9]-[0-9][0-9]-.*\\.org$" :recursive t :publishing-function org-jekyll-publish-to-html)
     ("octopress-static" :base-directory "~/octopress/source" :publishing-directory "~/octopress/source" :base-extension ".*" :exclude "\\.org$" :recursive t :publishing-function org-publish-attachment)
     ("current" :components
      ("current-org" "current-static" "current-static-top"))
     ("current-org" :base-directory "/Users/vedwin/src/vxe.github.io/_posts" :base-extension "org" :publishing-directory "/Users/vedwin/src/vxe.github.io/html" :recursive nil :publishing-function org-html-publish-to-html)
     ("current-static" :base-directory "/Users/vedwin/src/vxe.github.io/_posts" :base-extension ".*" :exclude "^\\(attic\\|top\\|options\\|.*\\.org\\)$" :publishing-directory "/Users/vedwin/src/vxe.github.io/html" :recursive t :publishing-function org-publish-attachment)
     ("current-static-top" :base-directory "/Users/vedwin/src/vxe.github.io/_posts/pub/top" :base-extension ".*" :include
      (".htaccess")
      :publishing-directory "/Users/vedwin/src/vxe.github.io/html" :recursive nil :publishing-function org-publish-attachment)
     ("blog" :base-directory "~/src/vxe.github.io/src" :publishing-directory "~/src/vxe.github.io/_posts" :publishing-function org-md-publish-to-md :base-extension "org$")
     ("gtd" :base-directory "~/Dropbox/desktop/Documents/gtd/horizons-of-focus/src" :publishing-directory "~/Dropbox/desktop/Documents/gtd/horizons-of-focus" :publishing-function org-latex-publish-to-pdf :base-extension "org$")
     ("home" :base-directory "/Users/vedwin/pull-requests/blog/home/org" :base-extension "org$" :publishing-directory "/Users/vedwin/pull-requests/blog/home/docs" :recursive t :publishing-function org-html-publish-to-html))))
 '(org-ref-insert-cite-key "C-c C-]")
 '(org-refile-targets (quote ((org-agenda-files :maxlevel . 2))))
 '(org-return-follows-link t)
 '(org-reverse-note-order t)
 '(org-use-speed-commands t)
 '(org-use-tag-inheritance nil)
 '(package-archives
   (quote
    (("gnu" . "http://elpa.gnu.org/packages/")
     ("melpa" . "http://melpa.org/packages/")
     ("org" . "http://orgmode.org/elpa/"))))
 '(package-selected-packages
   (quote
    (s js2-refactor lsp-javascript-typescript dired-rainbow dired-k dired-du all-the-icons-dired dired-imenu which-key undo-tree edbi eredis emmet-mode enh-ruby-mode robe elpy company-lsp flycheck emacsql helm f dash auto-complete async use-package flymake-yaml ac-rtags rtags elscreen ac-helm session magit-org-todos md4rd atom-dark-theme ubuntu-theme github-modern-theme nofrils-acme-theme poet-theme org-beautify-theme intellij-theme faff-theme company ac-geiser es-mode es lsp-java relax pg emacsql-psql emacsql-sqlite auto-complete-sage ac-cider banner-comment helpful elisp-def elisp-refs org-pomodoro helm-cider cider clj-refactor esup xah-lookup ob-sagemath sage-shell-mode mastodon sx anki-editor slack twittering-mode puppet-mode docker helm-aws ssh-tunnels wiki-summary gnuplot elfeed emojify emms password-generator edn yaml-mode csv flymake-json json-mode web-mode rainbow-mode elnode tagedit markdown-mode org-ref helm-bibtex auctex inf-ruby ess groovy-mode traad ein company-anaconda anaconda-mode virtualenvwrapper helm-pydoc pydoc-info pydoc ob-prolog ediprolog lfe-mode edts skewer-mode nodejs-repl indium company-tern nvm jtags meghanada javadoc-lookup gorepl-mode go-dlv go-eldoc go-mode helm-rtags company-rtags geiser heap ht elisp-slime-nav slime-company ac-slime slime-docker inf-clojure clojars clojure-mode flycheck-ycmd company-ycmd ycmd smartparens lispy rainbow-delimiters paredit flycheck-rtags lice helm-dash cmake-ide cmake-mode notmuch ag helm-org-rifle helm-c-yasnippet helm-swoop helm-ag toc-org htmlize ox-gfm org-bullets zenburn-theme yasnippet use-package-ensure-system-package spinner skeletor realgud queue multi-term monokai-theme magit jabber isend-mode ir-black-theme hydra hy-mode helm-projectile git-gutter flycheck-cask exec-path-from-shell erlang elscreen-persist darkburn-theme company-quickhelp color-theme-sanityinc-tomorrow beacon ace-window)))
 '(pdf-info-epdfinfo-program "/usr/local/bin/epdfinfo")
 '(projectile-completion-system (quote helm))
 '(projectile-mode t nil (projectile))
 '(projectile-project-root-files
   (quote
    ("rebar.config" "project.clj" "build.boot" "SConstruct" "pom.xml" "build.sbt" "gradlew" "build.gradle" ".ensime" "Gemfile" "requirements.txt" "setup.py" "tox.ini" "gulpfile.js" "Gruntfile.js" "bower.json" "composer.json" "Cargo.toml" "mix.exs" "stack.yaml" "info.rkt" "DESCRIPTION" "TAGS" "GTAGS" "CMakeLists.txt")))
 '(python-shell-interpreter "python")
 '(python-shell-prompt-input-regexps
   (quote
    (">>> " "\\.\\.\\. " "In \\[[0-9]+\\]: " "   \\.\\.\\.: " "In : " "\\.\\.\\.: " "\\[[0-9][0-9]:[0-9][0-9]:[0-9][0-9]\\] \\(/[a-zA-Z.-]*\\)* [$.] ")))
 '(safe-local-variable-values
   (quote
    ((eval flycheck-cask-setup)
     (projectile-project-compilation-cmd . "cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1 . ; make")
     (projectile-project-compilation-cmd . "cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1 .")
     (elisp-slime-nav-mode . t)
     (eval setq-local org-babel-default-header-args:sh
           (quote
            ((:results . "output"))))
     (flyspell-mode)
     (auto-fill-mode . t)
     (c-file-offsets
      (innamespace . 0)
      (substatement-open . 0)
      (c . c-lineup-dont-change)
      (inextern-lang . 0)
      (comment-intro . c-lineup-dont-change)
      (arglist-cont-nonempty . c-lineup-arglist)
      (block-close . 0)
      (statement-case-intro . ++)
      (brace-list-intro . ++)
      (cpp-define-intro . +))
     (c-auto-align-backslashes)
     (cmake-ide-dir . "~/src/github/magnum/"))))
 '(semantic-mode nil)
 '(send-mail-function (quote sendmail-send-it))
 '(sgml-validate-command "/usr/local/bin/tidy --gnu-emacs yes -utf8 -e -q")
 '(sh-basic-offset 2)
 '(skeletor-project-directory "/Users/vedwin/src")
 '(tab-width 4)
 '(toc-org-max-depth 20)
 '(tramp-verbose 3 nil (tramp))
 '(twittering-mode-hook (quote (twittering-icon-mode)))
 '(visible-bell nil)
 '(warning-suppress-types nil)
 '(weka:workbench-version (quote 3-8-1))
 '(winner-mode t)
 '(woman-manpath
   (quote
    ("~/.emacs.d/var/man/docker/man" "~/.emacs.d/var/man/notmuch" "~/.emacs.d/var/man/procps/" "~/.emacs.d/var/man/coreutils-8.21/" "~/.emacs.d/var/man/man-pages-4.07/" "~/.emacs.d/var/man/man-pages-4.06/" "~/.emacs.d/var/man/man-pages-4.04/" "~/.plenv/versions/5.20.0/man" "/usr/share/man" "/usr/local/share/man" "/usr/X11/man"
     ("/bin" . "/usr/share/man")
     ("/sbin" . "/usr/share/man")
     ("/usr/bin" . "/usr/share/man")
     ("/usr/sbin" . "/usr/share/man")
     ("/usr/local/bin" . "/usr/local/share/man")
     ("/usr/local/sbin" . "/usr/local/share/man")
     ("/usr/X11/bin" . "/usr/X11/man")
     ("/usr/bin/X11" . "/usr/X11/man")
     ("/usr/bin/mh" . "/usr/share/man")
     "~/.emacs.d/share/man")))
 '(woman-path (quote ("~/.emacs.d/var/man")))
 '(ycmd-server-command nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#1d1f21" :foreground "#c5c8c6" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :foundry "nil" :family "Menlo"))))
 '(cider-stacktrace-face ((t (:inherit widget-inactive))))
 '(cider-stacktrace-fn-face ((t (:inherit default :background "black" :weight bold))))
 '(eldoc-highlight-function-argument ((t (:inherit nil :foreground "light green"))))
 '(elscreen-tab-background-face ((t (:background "gray13"))))
 '(elscreen-tab-control-face ((t (:background "black" :foreground "black"))))
 '(elscreen-tab-current-screen-face ((t (:background "gray13" :foreground "green yellow"))))
 '(elscreen-tab-other-screen-face ((t (:background "gray13" :foreground "gray"))))
 '(helm-candidate-number ((t (:background "LightCyan2" :foreground "#005cc5"))))
 '(helm-match ((t (:background "lavender" :foreground "#24292e" :weight bold))))
 '(helm-source-header ((t (:background "LightCyan2" :foreground "#d73a49" :box (:line-width -1 :style released-button) :underline nil :weight bold))))
 '(org-block ((t (:background "Black" :foreground "gray100" :box nil))))
 '(org-block-begin-line ((t (:background "dark slate gray" :foreground "gray100"))))
 '(org-block-end-line ((t (:background "Black" :foreground "gray100"))))
 '(org-hide ((t (:foreground "Black"))))
 '(org-level-1 ((t (:inherit default :foreground "gray95" :box nil :slant normal :weight normal :height 1.5 :width normal :foundry "nil" :family "Lucida Grande"))))
 '(org-level-2 ((t (:inherit default :foreground "#BFEBBF" :box nil :slant normal :weight normal :height 1.25 :width normal :foundry "nil" :family "Lucida Grande"))))
 '(org-level-3 ((t (:inherit default :foreground "#7CB8BB" :box nil))))
 '(vc-annotate-face-CCCCFF ((t (:background "color-16"))) t)
 '(vc-annotate-face-CCD8FF ((t (:background "color-57" :foreground "white"))) t)
 '(vc-annotate-face-CCE4FF ((t (:background "color-56" :foreground "white"))) t)
 '(vc-annotate-face-CCF0FF ((t (:background "brightblack" :foreground "white"))) t)
 '(vc-annotate-face-CCFCFF ((t (:background "color-72" :foreground "white"))) t)
 '(vc-annotate-face-CCFFD2 ((t (:background "color-23" :foreground "white"))) t)
 '(vc-annotate-face-CCFFDE ((t (:background "color-30" :foreground "white"))) t)
 '(vc-annotate-face-CCFFEA ((t (:background "color-24" :foreground "white"))) t)
 '(vc-annotate-face-CCFFF6 ((t (:background "color-31" :foreground "white"))) t)
 '(vc-annotate-face-D2FFCC ((t (:background "color-24" :foreground "white"))) t)
 '(vc-annotate-face-DEFFCC ((t (:background "color-25" :foreground "white"))) t)
 '(vc-annotate-face-EAFFCC ((t (:background "color-24" :foreground "white"))) t)
 '(vc-annotate-face-F6FFCC ((t (:background "color-89" :foreground "white"))) t)
 '(vc-annotate-face-FFCCCC ((t (:background "color-88" :foreground "white"))) t)
 '(vc-annotate-face-FFD8CC ((t (:background "color-90" :foreground "white"))) t)
 '(vc-annotate-face-FFE4CC ((t (:background "color-91" :foreground "white"))) t)
 '(vc-annotate-face-FFF0CC ((t (:background "color-94" :foreground "white"))) t)
 '(vc-annotate-face-FFFCCC ((t (:background "color-99" :foreground "white"))) t))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
