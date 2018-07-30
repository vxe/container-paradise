;; set initial boot settings
(package-initialize)
(require 'gnutls)
(require 'package)

(progn

  (add-to-list 'package-archives
               '("melpa" . "https://melpa.org/packages/") t)


  (add-to-list 'package-archives
               '("melpa-stable" . "https://stable.melpa.org/packages/") t)


  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/"))))

(require 'package)
(setq package-enable-at-startup nil)
;; (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
;; (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
;; (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
;; (package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))
;; (require 'diminish)
;; (require 'bind-key)

(use-package async
  :ensure t)

(use-package cl
  :ensure t)

(use-package company
:ensure t
)

(use-package auto-complete
:ensure t
:init
(require 'auto-complete)
    (define-key ac-complete-mode-map "\C-n" 'ac-next)
    (define-key ac-complete-mode-map "\C-p" 'ac-previous))

(use-package dash
:ensure t
)

(use-package f
:ensure t
)

(use-package s
:ensure t)

(use-package ht
:ensure t)

(use-package exec-path-from-shell
:ensure t
)

(use-package helm
:ensure t
)

(use-package helm-projectile
:ensure t
)

(use-package hydra
:ensure t
)

(use-package jabber
:ensure t
)

(use-package magit
:ensure t
)

(use-package magit-org-todos
:ensure t 
:config
  (magit-org-todos-autoinsert))

(use-package multi-term
  :ensure t
  :init

  (add-hook 'sh-mode-hook (lambda ()
                            (define-key sh-mode-map (kbd "M-,") 'pop-tag-mark)))


  (add-hook 'term-mode-hook (lambda ()
                              (progn
                                (defun expose-global-binding-in-term (binding)
                                  (define-key term-raw-map binding
                                    (lookup-key (current-global-map) binding)))
                                (expose-global-binding-in-term (kbd "C-o")))))



  (defun vxe-mt-named-shell ()
    (interactive)
    (let ((input (completing-read "current:" (buffer-list))))
      (v-persp/split-terminal input)

      (rename-buffer (concat "$" input))))

  (defun vxe-mt-shell-split-static (shell-name)
    "open named shell and put into perspective"
    (interactive "si hereby christen this shell: ")
    (if (and (one-window-p t)
             (not (active-minibuffer-window)))
        (split-window-vertically))
                                        ;     (other-window 1)
    (vxe-shell shell-name))


  (defun vxe-term-shell-split-static (shell-name)
    "open named shell and put into perspective"
    (interactive "si hereby christen this shell: ")
    (if (and (one-window-p t)
             (not (active-minibuffer-window)))
        (split-window-vertically))
                                        ;     (other-window 1)
    (vxe-shell shell-name))


                                        ;(persp-add-buffer shell-name))

  (defun vxe-shell (name)
    (interactive)
    (if (or (eq system-type 'cygwin)
            (eq system-type 'gnu/linux)
            (eq system-type 'linux)
            (eq system-type 'darwin))

        (new-ansi name)  (new-ansi-powershell name)))

  (defun vxe-shell-term (name)
    (interactive)
    (if (or (eq system-type 'cygwin)
            (eq system-type 'gnu/linux)
            (eq system-type 'linux)
            (eq system-type 'darwin))

        (new-term name)  (new-ansi-powershell name)))


  (defun new-ansi (shell-name)
    "create a named ansi term"
    (interactive "si hereby christen this shell: ")
                                        ;   (other-window 1)
    (multi-term)
    (rename-buffer (format "%s" shell-name)))


  (defun new-term (shell-name)
    "create a named ansi term"
    (interactive "si hereby christen this shell: ")
                                        ;   (other-window 1)
    (term)
    (rename-buffer (format "%s" shell-name)))
  ;; end refactor




  (defun vxe-mt-generic-ssh ()
    (interactive)
    (cond ((eq system-type 'darwin)
           (let ((input (completing-read "server:" (split-string
                                                    (s-chomp (shell-command-to-string "~/bin/get-hostnames-from-dns ~/opt/dns"))
                                                    "\n"))))
             (defun vxe/generate-ssh-mac (host)
               (interactive "s where")
               (fset 'generic-ssh
                     (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item `(,(concat "ssh " host) 0 "%d") arg)))
               (generic-ssh))
             (vxe-mt-shell-split-static input)
             (rename-buffer (concat "$a" input))
             (vxe/generate-ssh-mac input)))
          ((eq system-type 'gnu/linux)
           (let ((input (completing-read "server:" (split-string
                                                    (s-chomp (shell-command-to-string "cat ~/.emacs.d/var/hosts")
                                        ;(s-chomp "~/.emacs.d/bin/get-hostnames-from-dns ~/.emacs.d/src/dns")
                                                             "\n"))))

                 (defun vxe/generate-ssh-linux (host)
                   (interactive "s where")
                   (fset 'generic-ssh
                         (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item `(,(concat "ssh " host) 0 "%d") arg)))
                   (generic-ssh))
                 (vxe-mt-shell-split-static input)
                 (rename-buffer (concat "$" input))
                 (vxe/generate-ssh-linux input))))))

  (defun vxe-term-generic-ssh ()
    (interactive)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    (cond ((eq system-type 'darwin)
           (let ((input
                  (if (region-active-p)
                      (buffer-substring (region-beginning) (region-end))
                    (completing-read "server:" sre:hosts)
                    )))

             (defun vxe/generate-ssh-mac (host)
               (interactive "s where")
               (fset 'generic-ssh
                     (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item `(,(concat "ssh " host) 0 "%d") arg)))
               (generic-ssh))


             (vxe-mt-shell-split-static input)
             (rename-buffer (concat "$" input))
             (vxe/generate-ssh-mac input)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
          ((eq system-type 'gnu/linux)
           (let ((input (completing-read "server:" (split-string
                                                    (s-chomp "~/bin/get-hostnames-from-dns ~/opt/dns")
                                                    "\n"))))
             (defun vxe/generate-ssh-linux (host)
               (interactive "s where")
               (fset 'generic-ssh
                     (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item `(,(concat "ssh " host) 0 "%d") arg)))
               (generic-ssh))

             (vxe-mt-shell-split-static input)
             (rename-buffer (concat "$" input))
             (vxe/generate-ssh-linux input)))))


  (defun vxe:shell-other-window ()
    (interactive)
    (other-window 1)
    (vxe-term-generic-ssh))



                                        ; date functions
  (defun vxe-date-generator (format)
    (interactive "sFormat String: ")
    (message (s-chomp (concat "date " format))))
                                        ; clush

  (defun vxe-mt-toggle-term-mode ()
    (interactive)
    (term-mode)
    (term-mode)
    (term-char-mode))

  (defun vxe-mt-shell-here ()
    (interactive)
    (multi-term)))





  (defun vxe-eww-inplace ()
    (interactive)
    (shell-command "touch ~/.emacs.d/.eww-history")
    (let ((url (completing-read "url: " (split-string (s-chomp "cat ~/.emacs.d/.eww-history") "\n"))))
      (shell-command (concat "echo " url " >> ~/.emacs.d/.eww-history"))
      (eww url)
      (sleep-for 3)
      (switch-to-buffer "*eww*")
      (rename-buffer (concat "*eww*-" url))))

  (require 'shell)
  (define-key shell-mode-map (kbd "C-c C-r") nil)
  (define-key shell-mode-map (kbd "C-x C-x") 'helm-M-x)

(use-package cc-mode
  :ensure t
  :init
  (require 'cc-mode)
  (define-key java-mode-map (kbd "C-k") 'sp-kill-hybrid-sexp)
  (add-hook 'java-mode-hook #'smartparens-mode)

  (define-key c-mode-map (kbd "C-k") 'sp-kill-hybrid-sexp)
  (add-hook 'c-mode-hook #'smartparens-mode)

  (define-key c++-mode-map (kbd "C-k") 'sp-kill-hybrid-sexp)
  (add-hook 'c++-mode-hook #'smartparens-mode))

(use-package ag
:ensure t)

(use-package ace-window
  :ensure t
  :init)
(setq aw-keys '(?e ?f ?p ?n ?q ?a ?d ?s ))

(defun aw-keys-8-windows ()
  (interactive)
  (setq aw-keys '(?q ?a ?d ?s ?e ?f ?p ?n )))

(defun aw-keys-4-windows ()
  (interactive)
  (setq aw-keys '(?e ?f ?p ?n ?q ?a ?d ?s )))

(use-package magit
  :ensure t)

(use-package emacsql
:ensure t
:init)

(use-package emacsql-sqlite
  :ensure t
  :init
(require 'emacsql-sqlite))

(cond ((not (file-exists-p "~/.emacs.d/emacs.db"))
       (defvar db (emacsql-sqlite "~/.emacs.d/emacs.db"))))

(use-package pdf-tools
    :ensure t
      :init
      ;;     (add-to-list 'auto-mode-alist '("\\.pdf\\'" . pdf-view-mode))

      (require 'pdf-tools)
      (add-to-list 'auto-mode-alist '("\\.pdf\\'" . pdf-view-mode))

      :config
      ;; (require 'org-pdfview)
  )

(require 'pdf-occur)
(define-key pdf-occur-buffer-mode-map (kbd "C-o") nil)

(use-package eredis
:ensure t 
)

(use-package es-mode
  :ensure t
  :init
  (autoload 'es-mode "es-mode.el"
    "Major mode for editing Elasticsearch queries" t)
  (add-to-list 'auto-mode-alist '("\\.es$" . es-mode)))

(use-package twittering-mode
:ensure t
:init
(setq twittering-use-master-password t)
)

(use-package sx
:ensure t
)

(defun vxe:sx-search ()
	 (interactive)
	 (let ((current-prefix-arg 4)) ;; emulate C-u
	 (call-interactively 'sx-search)))

(use-package elfeed
:ensure t
)

(use-package gnuplot
:ensure t
)

(use-package esup
:ensure t)

;;   (use-package darkburn-theme
  ;;     :ensure t)
  ;;   (use-package monokai-theme
  ;;     :ensure t)

    (use-package ir-black-theme
      :ensure t)

  ;;   (use-package color-theme-sanityinc-tomorrow
  ;;     :ensure t)
    (use-package zenburn-theme
      :ensure t)

  ;; (defun load-dark-theme ()
  ;; (interactive)
  ;;   (load-theme 'sanityinc-tomorrow-eighties t)

  ;;                                           ;(load-theme 'ir-black t)
  ;;                                           ;
  ;;                                           ;(load-theme 'darkburn t)
  ;;   (load-theme 'monokai t)
  ;;   (load-theme 'ir-black t)
  ;;   (load-theme 'zenburn t)			;
  ;;   (load-theme 'ir-black t)
  ;;   (load-theme 'darkburn t)
  ;;   (load-theme 'monokai t)
  ;;   (load-theme 'ir-black t)

  ;; )


;; (use-package org-beautify-theme
;;   :ensure t)


(defun atom-theme ()
  (interactive)
  (load-theme 'atom-dark-theme t)
  (load-theme 'org-beautify-theme t)
  (load-theme 'zenburn t)			;
  (load-theme 'ir-black t))


  ;; (use-package org-beautify-theme
  ;;           :ensure t)




                                            ;(load "~/.emacs.d/bin/erosiond-theme/erosiond-theme.el")
    (menu-bar-mode -1)
    (tool-bar-mode -1)
    (setq inhibit-splash-screen t)
    ;; (setq inhibit-splash-screen (find-file "~/.emacs.d/doc/init.org"))
    (setq-default cursor-type 'bar)

    (use-package beacon
      :ensure t)

(cond ((file-exists-p "~/.emacs.d/lib/work")
              (add-to-list 'load-path "~/.emacs.d/lib/work" t)
              (load-file "~/.emacs.d/lib/work/clush.el")
              (load-file "~/.emacs.d/lib/work/work.el")
              (load-file "~/.emacs.d/lib/work/sre.el")))

;; (setq tramp-ssh-controlmaster-options
      ;;       (concat
      ;;        "-o ControlPath=~/.ssh/sockets/%%r@%%h-%%p "
      ;;        "-o ControlMaster=auto -o ControlPersist=yes"))
(setq tramp-completion-reread-directory-timeout nil)
(setq temporary-file-directory "/tmp/")
(setq tramp-ssh-controlmaster-options "-o ControlPath='/tmp/ssh-ControlPath-%%r@%%h:%%p' -o ControlMaster=auto -o ControlPersist=5h")

(fset 'yes-or-no-p 'y-or-n-p)

                                        ; Mac OsX remap meta to commands
(setq mac-command-modifier 'meta)

;(setq mac-option-modifier nil)
                                        ; copy con select


                                        ; global flycheck
;(add-hook 'after-init-hook #'global-flycheck-mode)
                                    ; dired

(add-hook 'dired-mode-hook (lambda ()
                             (progn
			   (defun expose-global-binding-in-dired (binding)
                                 (define-key dired-mode-map binding
                                   (lookup-key (current-global-map) binding)))
			   (expose-global-binding-in-dired (kbd "C-o")))))

(defun vxe-copy-from-osx ()
  "http://stackoverflow.com/questions/9985316/how-to-paste-to-emacs-from-clipboard"
  (shell-command-to-string "pbpaste"))

(defun vxe-paste-to-osx (text &optional push)
  "http://stackoverflow.com/questions/9985316/how-to-paste-to-emacs-from-clipboard"
  (let ((process-connection-type nil))
    (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
      (process-send-string proc text)
      (process-send-eof proc))))


                                        ; make copy and paste work
(cond ((eq system-type 'darwin)
       (setq interprogram-cut-function 'vxe-paste-to-osx)
       (setq interprogram-paste-function 'vxe-copy-from-osx))
      ((eq system-type 'linux)
       (message "good os")))

(setq default-major-mode 'org-mode)

(cond ((eq system-type 'darwin)
       (setq browse-url-browser-function 'browse-url-generic
	 browse-url-generic-program "open"))
      ((eq system-type 'gnu/linux) (setq browse-url-browser-function 'eww-browse-url)))
; dired C-o
;; (defun expose-global-binding-in-dired (binding)
;;    (define-key dired-mode-map binding
;;      (lookup-key (current-global-map) binding)))

;; (progn
;;   (expose-global-binding-in-dired (kbd "C-o")))

(setq system-uses-terminfo nil)

(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))

(setq desktop-save-mode t)

(setq-default indent-tabs-mode nil)

(add-hook 'emacs-lisp-mode-hook
            (lambda ()
              (push '(">=" . ?≥) prettify-symbols-alist)))

(defconst lisp--prettify-symbols-alist
  '(("lambda"  . ?λ)))

(global-prettify-symbols-mode +1)

(appt-activate)

(server-start)

(setq browse-url-browser-function 'browse-url-generic)

(setq custom-file "~/.emacs.d/.customized.el")
(load-file "~/.emacs.d/.customized.el")

(defun htk (key map)
(interactive)
  (ht-get map key))

(defun json-ht-read (str)
  (interactive)
  (let ((json-key-type 'keyword)
        (json-object-type 'hash-table))
    (json-read-from-string str)))

(defun vxe-shell-on-region ()
  (interactive)
  (let ((current-prefix-arg 4)) ;; emulate C-u
    (call-interactively 'shell-command-on-region)))

(defun my-org-screenshot ()
  " WARNING OSX ONLY: Take a screenshot into a time stamped unique-named file in the
same directory as the org-buffer and insert a link to this file."
  (interactive)
  ;; (setq filename
  ;;       (concat
  ;;        (make-temp-name
  ;;         (concat (file-name-nondirectory (buffer-file-name))
  ;;                 "_"
  ;;                 (format-time-string "%Y%m%d_%H%M%S_")) ) ".png"))

  (shell-command "mkdir -p img")
  (setq filename (completing-read "filename:" (split-string
                       (s-chomp
                        (shell-command-to-string
                         "find -L ~/.emacs.d/wiki/img -maxdepth 1 -type f -print0 | xargs -0 basename"))
                       "\n")))
  (call-process "screencapture" nil nil nil "-i" (concat "./img/" filename ".png"))
  (insert (concat "[[./img/" filename ".png" "]]"))
  (org-display-inline-images))

(setq mouse-drag-copy-region t)

(defun vxe:gen-github-search (name)
(interactive "sproject name: ")
(kill-new (concat "https://github.com/search?utf8=?&q=" name "&type="))
(vxe-eww-inplace)
)

(defun clear-hook (hook)
  (interactive "Shook")
  (mapcar (lambda (feature)
            (remove-hook hook feature))
          (eval hook)))

(defun yank-line ()
  (interactive)
  (push-mark)
  (fset 'yy-enhanced
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([5 67108896 1 134217847] 0 "%d")) arg)))
  (yy-enhanced)
  (pop-to-mark-command))

(defun endless/simple-get-word ()
  (car-safe (save-excursion (ispell-get-word nil))))

(defun endless/ispell-word-then-abbrev (p)
  "Call `ispell-word', then create an abbrev for it.
With prefix P, create local abbrev. Otherwise it will
be global.
If there's nothing wrong with the word at point, keep
looking for a typo until the beginning of buffer. You can
skip typos you don't want to fix with `SPC', and you can
abort completely with `C-g'."
  (interactive "P")
  (let (bef aft)
    (save-excursion
      (while (if (setq bef (endless/simple-get-word))
                 ;; Word was corrected or used quit.
                 (if (ispell-word nil 'quiet)
                     nil ; End the loop.
                   ;; Also end if we reach `bob'.
                   (not (bobp)))
               ;; If there's no word at point, keep looking
               ;; until `bob'.
               (not (bobp)))
        (backward-word)
        (backward-char))
      (setq aft (endless/simple-get-word)))
    (if (and aft bef (not (equal aft bef)))
        (let ((aft (downcase aft))
              (bef (downcase bef)))
          (define-abbrev
            (if p local-abbrev-table global-abbrev-table)
            bef aft)
          (message "\"%s\" now expands to \"%s\" %sally"
                   bef aft (if p "loc" "glob")))
      (user-error "No typo at or before point"))))

(setq save-abbrevs 'silently)

(setq-default abbrev-mode t)

(defun vxe-wiki-search ()
  (interactive)
  (s-chomp (shell-command-to-string "mkdir -p ~/.emacs.d/wiki"))
  (defun vxe/generic-wiki (topic)
    (interactive "s ")
    ;; (if (and (one-window-p t)
    ;; 	     (not (active-minibuffer-window)))
    ;; 	(split-window-vertically))
    ;; (other-window 1)
    (cond ((string= topic "sc")
       (switch-to-buffer "*scratch*")
       (vxe-journal-mode))
      (t (find-file (concat "~/.emacs.d/wiki/" topic)))))

  (cond ((eq system-type 'windows-nt)
     (find-file (completing-read "book:"
                     (split-string (s-chomp
                            (concat "perl5.20.2.exe "
                                emacs-root
                                "Dropbox/.emacs.d/windows/get-wiki-list.pl"))"\n"))))
    ((eq system-type 'darwin)
     (let ((input (completing-read "topic:" (split-string
                                             (s-chomp
                                              (shell-command-to-string
                                               "find -L ~/.emacs.d/wiki -maxdepth 1 -type f -print0 | xargs -0 basename | grep -Ev '^#|^[.]'"))
                      "\n"))))
       (vxe/generic-wiki input)))
    ((eq system-type 'gnu/linux)
     (let ((input (completing-read "topic:" (split-string
                         (s-chomp
                          "find -L ~/.emacs.d/wiki -maxdepth 1 -type f -printf '%f\n' | grep -Ev '^#|^[.]' ")
                         "\n"))))
       (vxe/generic-wiki input)))


    (t     (let ((input (completing-read "topic:" (split-string
                               (s-chomp
                            "find -L ~/.emacs.d/wiki -maxdepth 1 -type f ! -name '*[#~]' ! -name '*html' ! -name '*git*' -printf '%f\n'")
                               "\n"))))
         (vxe/generic-wiki input)))))

(defun my-sql-save-history-hook ()
    (let ((lval 'sql-input-ring-file-name)
          (rval 'sql-product))
      (if (symbol-value rval)
          (let ((filename
                 (concat "~/.emacs.d/sql/"
                         (symbol-name (symbol-value rval))
                         "-history.sql")))
            (set (make-local-variable lval) filename))
        (error
         (format "SQL history will not be saved because %s is nil"
                 (symbol-name rval))))))

  (add-hook 'sql-interactive-mode-hook 'my-sql-save-history-hook)

(defun vxe:async-shell-command (command buffer-name)
  (interactive)
  (async-shell-command command buffer-name))

(defun process-running-p (process)
  (if (string= ""
               (shell-command-to-string
                (concat "ps -eaf | grep " process)))
             t)
         nil)

(defun whats-listening-on-port-osx (port)
  (interactive "sport: ")
  (async-shell-command (concat "sudo lsof -PiTCP -sTCP:LISTEN | grep " port)))

(defun pdf-goto-random-page (max-pages)
  (interactive "nnumber of pages:")
  (let ((random-page (random max-pages)))
    (pdf-view-goto-page random-page)))

(defun yank-buffer ()
(interactive)
(kill-new (current-buffer)))

(defun pkill (process)
  (interactive "sprocess: ")
  (async-shell-command (concat "ps -eaf | grep " process " |  awk '{print $2}' | xargs kill -9")))

(defun regex-extract (regex)
	 (interactive "sregex")
	 (kill-new (concat "perl -ne 'print \"$1\\n\" if /(" regex ")/'"))
	 (vxe-shell-on-region))

(defun ip-extract-no-port ()
	 (interactive)
	 (kill-new (concat "perl -ne 'print \"$1\\n\" if /(\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3})/'"))
	 (vxe-shell-on-region))

(defun ip-extract-with-port ()
	 (interactive)
	 (kill-new (concat "perl -ne 'print \"$1\\n\" if /(\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\:\\d{1,5})/'"))
	 (vxe-shell-on-region))

(defun apache:download-commons (package)
(interactive "sPackage: ")
(async-shell-command (concat "cd ~/.emacs.d/src; git clone git://git.apache.org/commons-" package ".git; cd ~/.emacs.d/src/commons-" package " && mvn package"))
)

; from enberg on #emacs
(setq compilation-finish-function
  (lambda (buf str)
    (if (null (string-match ".*exited abnormally.*" str))
        ;;no errors, make the compilation window go away in a few seconds
        (progn
          (run-at-time
           "2 sec" nil 'delete-windows-on
           (get-buffer-create "*compilation*"))
          (message "No Compilation Errors!")))))

(defun goto-random-line ()
  "Go to a random line in this buffer."
  ; good for electrobibliomancy.
  (interactive)
  (goto-line (1+ (random (buffer-line-count)))))

(defun buffer-line-count ()
  "Return the number of lines in this buffer."
  (count-lines (point-min) (point-max)))

(defun goto-random-quote ()
  (interactive)
  (goto-random-line)
  (search-forward "BEGIN_QUOTE"))

(defun vxe:occur (query)
	 (interactive "s/search term: ")
	 (occur query)
	 (other-window 1))

(defun dos2unix (buffer)
  "Automate M-% C-q C-m RET C-q C-j RET"
  (interactive "*b")
  (save-excursion
    (goto-char (point-min))
    (while (search-forward (string ?\C-m) nil t)
      (replace-match (string ?\C-j) nil t))))

(defun vxe:window-configuration-to-register ()
  (interactive)
  (let ((current-prefix-arg 4)) ;; emulate C-u
    (call-interactively 'window-configuration-to-register)))

(defun vxe:jump-to-register ()
  (interactive)
  (let ((current-prefix-arg 4)) ;; emulate C-u
    (call-interactively 'jump-to-register)))

(defun vxe:extract-ips ()
  (interactive)
  (kill-new (concat "perl -ne 'print " "\"" "$1\\n" "\"" " if /(\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\:\\d{1,5})/'"))
  (vxe-shell-on-region))

(defun vxe:url-decode (string)
  (interactive "s String:")
  (kill-new (shell-command-to-string
	     (concat "echo '" string  "' | perl -MURI::Escape -ne 'print uri_unescape(\$_);'"))))

(defun vxe:url-encode (string)
  (interactive "s String:")
  (kill-new (shell-command-to-string
	     (concat "echo '" string  "' | perl -MURI::Escape -ne 'print uri_escape(\$_);'"))))

(defun vxe-import-snippet-term-to-org ()
  (interactive)
   (let ((snippet (completing-read "snippet: " (split-string
					   (s-chomp
						"find -L ~/.emacs.d/snippets/term-mode -maxdepth 1 -type f -print0 | xargs -0 basename")
					   "\n"))))
  (s-chomp (concat "cp ~/.emacs.d/snippets/term-mode/" snippet " ~/.emacs.d/snippets/org-mode/" snippet))))

(defun vxe-import-snippet-org-to-term ()
  (interactive)
   (let ((snippet (completing-read "snippet: " (split-string
					   (s-chomp
						"find -L ~/.emacs.d/snippets/org-mode -maxdepth 1 -type f -print0 | xargs -0 basename")
					   "\n"))))
  (s-chomp (concat "cp ~/.emacs.d/snippets/org-mode/" snippet " ~/.emacs.d/snippets/term-mode/" snippet))))

(defun vxe-import-snippet-ielm-to-org ()
  (interactive)
   (let ((snippet (completing-read "snippet: " (split-string
					   (s-chomp
						"find -L ~/.emacs.d/snippets/inferior-emacs-lisp-mode -maxdepth 1 -type f -print0 | xargs -0 basename")
					   "\n"))))
  (s-chomp (concat "cp ~/.emacs.d/snippets/inferior-emacs-lisp-mode/" snippet " ~/.emacs.d/snippets/org-mode/" snippet))))

(defun vxe-import-snippet-org-to-inferior-emacs-lisp ()
  (interactive)
   (let ((snippet (completing-read "snippet: " (split-string
					   (s-chomp
						"find -L ~/.emacs.d/snippets/org-mode -maxdepth 1 -type f -print0 | xargs -0 basename")
					   "\n"))))
  (s-chomp (concat "cp ~/.emacs.d/snippets/org-mode/" snippet " ~/.emacs.d/snippets/inferior-emacs-lisp-mode/" snippet))))

(defun vxe-import-snippet-term-to-comint ()
  (interactive)
   (let ((snippet (completing-read "snippet: " (split-string
					   (s-chomp
						"find -L ~/.emacs.d/snippets/term-mode -maxdepth 1 -type f -print0 | xargs -0 basename")
					   "\n"))))
  (s-chomp (concat "cp ~/.emacs.d/snippets/term-mode/" snippet " ~/.emacs.d/snippets/comint-mode/" snippet))))

(defun vxe-import-snippet-comint-to-term ()
  (interactive)
   (let ((snippet (completing-read "snippet: " (split-string
					   (s-chomp
						"find -L ~/.emacs.d/snippets/comint-mode -maxdepth 1 -type f -print0 | xargs -0 basename")
					   "\n"))))
  (s-chomp (concat "cp ~/.emacs.d/snippets/comint-mode/" snippet " ~/.emacs.d/snippets/term-mode/" snippet))))

(use-package undo-tree
:ensure t
:init
;(global-undo-tree-mode 1)
;; make ctrl-z undo

(global-set-key (kbd "C-/") 'undo)
;; (global-set-key (kbd "C-z C-z") 'undo) ;for terminal emacs
;; make ctrl-Z redo
;; (defalias 'redo 'undo-tree-redo)
;; (global-set-key (kbd "C-S-/") 'redo)

)

(if (eq window-system nil)
    (global-set-key (kbd "M-z") 'undo)
  (global-set-key (kbd "C-/") 'undo))

(defun wget (url)
  (interactive "surl")
  (cd "~/Downloads")
  (async-shell-command (concat "wget " url))
  (dired "~/Downloads"))

(defun ls ()
(interactive)
(async-shell-command "ls -ltr"))

(defun vxe:open-url ()
  (interactive)
  (cond ((eq system-type 'darwin)
	 (copy-region-as-kill (point-min) (point-max) t)
	 (shell-command (concat "open \""
				(with-temp-buffer (yank) (buffer-string))
                             "\"")))))

(defun vxe:toggle-eww-browser ()
  (interactive)
  (setq browse-url-browser-function'eww-browse-url))

(defun vxe:toggle-desktop-browser ()
  (interactive)
  (setq browse-url-browser-function 'browse-url-generic))

(setq focus-areas-work '("unclear" "administrative" "kaizen" "release_management" "root_cause_analysis" "incident_management"))
  (setq activity-type-work '("unclear" "communicating" "reading" "watching" "researching" "writing" "troubleshooting" "creativing" "erranding" "practicing"))
   (setq context-work '("unclear" "email" "emacs" "grafana" "quip" "cst" "jenkins" "nagios" "radr" "leisure"))

  (defun vxe-tag-search-work ()
    (interactive)
    (let ((focus (completing-read "focus: " focus-areas-work))
	  (type (completing-read "type: " activity-type-work))
	  (context (completing-read "context" context-work)))
      (org-tags-view nil (concat ":" focus ":" type ":" context ":"))))


  (defun vxe-work-capture ()
    (interactive)
    (let ((focus (completing-read "focus: " focus-areas-work))
	  (type (completing-read "type: " activity-type-work))
	  (context (completing-read "context" context-work)))
      (kill-new (concat ":" focus ":" type ":" context ":work:"))
      (org-capture nil "w")))

  (defun vxe-work-capture-tag ()
    (interactive)
    (let ((focus (completing-read "focus: " focus-areas-work))
	  (type (completing-read "type: " activity-type-work))
	  (context (completing-read "context" context-work)))
      (kill-new (concat ":" focus ":" type ":" context ":work:"))))

  (defun vxe-work-focus-search ()
    (interactive)
    (let ((query (completing-read "focus: " focus-areas-work)))
      (org-tags-view nil query)))

  (defun vxe-work-activity-search ()
    (interactive)
    (let ((query (completing-read "focus: " activity-type-work)))
      (org-tags-view nil query)))

  (defun vxe-work-context-search ()
    (interactive)
    (let ((query (completing-read "focus: " context-work)))
      (org-tags-view nil query)))

  ; the goal is a minimal set of categories which covers most tasks
  (setq focus-areas-home '("unclear" "administrative" "career_development" "personal_development" "family" "social" "health" "dating"))
  (setq activity-type-home '("unclear" "communicating" "reading" "researching" "writing" "troubleshooting" "creativing" "erranding" "practicing"))
  (setq context-home '("unclear" "apartment" "emacs" "gym" "leisure")) ; favor specific places outside work, vs home, house etc.

  (defun vxe-tag-search-home ()
    (interactive)
    (let ((focus (completing-read "focus: " focus-areas-home))
	  (type (completing-read "type: " activity-type-home))
	  (context (completing-read "context" context-home)))
      (org-tags-view nil (concat ":" focus ":" type ":" context ":"))))


  (defun vxe-home-capture ()
    (interactive)
    (let ((focus (completing-read "focus: " focus-areas-home))
	  (type (completing-read "type: " activity-type-home))
	  (context (completing-read "context" context-home)))
      (kill-new (concat ":" focus ":" type ":" context ":home:"))
      (org-capture nil "h")))

  (defun vxe-home-capture-tag ()
    (interactive)
    (let ((focus (completing-read "focus: " focus-areas-home))
	  (type (completing-read "type: " activity-type-home))
	  (context (completing-read "context" context-home)))
      (kill-new (concat ":" focus ":" type ":" context ":home:"))))

  (defun vxe-home-focus-search ()
    (interactive)
    (let ((query (completing-read "focus: " focus-areas-home)))
      (org-tags-view nil query)))

  (defun vxe-home-activity-search ()
    (interactive)
    (let ((query (completing-read "focus: " activity-type-home)))
      (org-tags-view nil query)))

  (defun vxe-home-context-search ()
    (interactive)
    (let ((query (completing-read "focus: " context-home)))
      (org-tags-view nil query)))


  (setq focus-areas-bug-tracker '("unclear" "feature" "performance" "clarity"))
  (setq activity-type-bug-tracker '("unclear" "communicating" "researching" "troubleshooting" "creativing"))
  (setq context-bug-tracker '("emacs" "kepler" "jenkins" "work" "algo")) ; favor specific places outside work, vs bug-tracker, house etc.

  (defun vxe-tag-search-bug-tracker ()
    (interactive)
    (let ((focus (completing-read "focus: " focus-areas-bug-tracker))
	  (type (completing-read "type: " activity-type-bug-tracker))
	  (context (completing-read "context" context-bug-tracker)))
      (org-tags-view nil (concat ":" focus ":" type ":" context ":"))))


  (defun vxe-bug-tracker-capture ()
    (interactive)
    (let ((focus (completing-read "focus: " focus-areas-bug-tracker))
	  (type (completing-read "type: " activity-type-bug-tracker))
	  (context (completing-read "context" context-bug-tracker)))
      (kill-new (concat ":" focus ":" type ":" context ":bug:"))
      (org-capture nil "b")))

  (defun vxe-bug-tracker-capture-tag ()
    (interactive)
    (let ((focus (completing-read "focus: " focus-areas-bug-tracker))
	  (type (completing-read "type: " activity-type-bug-tracker))
	  (context (completing-read "context" context-bug-tracker)))
      (kill-new (concat ":" focus ":" type ":" context ":bug:"))))

  (defun vxe-bug-tracker-focus-search ()
    (interactive)
    (let ((query (completing-read "focus: " focus-areas-bug-tracker)))
      (org-tags-view nil query)))

  (defun vxe-bug-tracker-activity-search ()
    (interactive)
    (let ((query (completing-read "focus: " activity-type-bug-tracker)))
      (org-tags-view nil query)))

  (defun vxe-bug-tracker-context-search ()
    (interactive)
    (let ((query (completing-read "focus: " context-bug-tracker)))
      (org-tags-view nil query)))

  (setq focus-areas-drumming '("unclear" "theory" "coordination" "style"))
  (setq activity-type-drumming '("unclear" "communicating" "reading" "researching" "writing" "troubleshooting" "creativing" "erranding" "practicing"))
  (setq context-drumming '("unclear" "drum_set" "pad" "computer" "public")) ; favor specific places outside work, vs drumming, house etc.

  (defun vxe-tag-search-drumming ()
    (interactive)
    (let ((focus (completing-read "focus: " focus-areas-drumming))
	  (type (completing-read "type: " activity-type-drumming))
	  (context (completing-read "context" context-drumming)))
      (org-tags-view nil (concat ":" focus ":" type ":" context ":"))))


  (defun vxe-drumming-capture ()
    (interactive)
    (let ((focus (completing-read "focus: " focus-areas-drumming))
	  (type (completing-read "type: " activity-type-drumming))
	  (context (completing-read "context" context-drumming)))
      (kill-new (concat ":" focus ":" type ":" context ":drumming:"))
      (org-capture nil "d")))

  (defun vxe-drumming-capture-tag ()
    (interactive)
    (let ((focus (completing-read "focus: " focus-areas-drumming))
	  (type (completing-read "type: " activity-type-drumming))
	  (context (completing-read "context" context-drumming)))
      (kill-new (concat ":" focus ":" type ":" context ":drumming:"))))

  (defun vxe-drumming-focus-search ()
    (interactive)
    (let ((query (completing-read "focus: " focus-areas-drumming)))
      (org-tags-view nil query)))

  (defun vxe-drumming-activity-search ()
    (interactive)
    (let ((query (completing-read "focus: " activity-type-drumming)))
      (org-tags-view nil query)))

  (defun vxe-drumming-context-search ()
    (interactive)
    (let ((query (completing-read "focus: " context-drumming)))
      (org-tags-view nil query)))

  (setq focus-areas-blog '("unclear" "emacs" "linux" "politics" "fiction" "humor"))
  (setq activity-type-blog '("unclear" "communicating" "reading" "researching" "writing" "troubleshooting" "creativing" "erranding" "practicing"))
  (setq context-blog '("unclear" "internet" "emacs")) ; favor specific places outside work, vs blog, house etc.

  (defun vxe-tag-search-blog ()
    (interactive)
    (let ((focus (completing-read "focus: " focus-areas-blog))
	  (type (completing-read "type: " activity-type-blog))
	  (context (completing-read "context" context-blog)))
      (org-tags-view nil (concat ":" focus ":" type ":" context ":"))))


  (defun vxe-blog-capture ()
    (interactive)
    (let ((focus (completing-read "focus: " focus-areas-blog))
	  (type (completing-read "type: " activity-type-blog))
	  (context (completing-read "context" context-blog)))
      (kill-new (concat ":" focus ":" type ":" context ":blog:"))
      (org-capture nil "l")))

  (defun vxe-blog-capture-tag ()
    (interactive)
    (let ((focus (completing-read "focus: " focus-areas-blog))
	  (type (completing-read "type: " activity-type-blog))
	  (context (completing-read "context" context-blog)))
      (kill-new (concat ":" focus ":" type ":" context ":blog:"))))

  (defun vxe-blog-focus-search ()
    (interactive)
    (let ((query (completing-read "focus: " focus-areas-blog)))
      (org-tags-view nil query)))

  (defun vxe-blog-activity-search ()
    (interactive)
    (let ((query (completing-read "focus: " activity-type-blog)))
      (org-tags-view nil query)))

  (defun vxe-blog-context-search ()
    (interactive)
    (let ((query (completing-read "focus: " context-blog)))
      (org-tags-view nil query)))

(setq focus-areas-journal '("unclear" "administrative" "career_development" "personal_development" "family" "social" "health" "dating"))
(setq activity-type-journal '("unclear" "communicating" "reading" "researching" "writing" "troubleshooting" "creativing" "erranding" "practicing"))
(setq context-journal '("unclear" "apartment" "emacs" "gym" "leisure")) ; favor specific places outside work, vs journal, house etc.

(defun vxe-tag-search-journal ()
(interactive)
(let ((focus (completing-read "focus: " focus-areas-journal))
(type (completing-read "type: " activity-type-journal))
(context (completing-read "context" context-journal)))
(org-tags-view nil (concat ":" focus ":" type ":" context ":"))))


(defun vxe-journal-capture ()
(interactive)
(let ((focus (completing-read "focus: " focus-areas-journal))
(type (completing-read "type: " activity-type-journal))
(context (completing-read "context" context-journal)))
(kill-new (concat ":" focus ":" type ":" context ":journal:"))
(org-capture nil "j")))

(defun vxe-journal-capture-tag ()
(interactive)
(let ((focus (completing-read "focus: " focus-areas-journal))
(type (completing-read "type: " activity-type-journal))
(context (completing-read "context" context-journal)))
(kill-new (concat ":" focus ":" type ":" context ":journal:"))))

(defun vxe-journal-focus-search ()
(interactive)
(let ((query (completing-read "focus: " focus-areas-journal)))
(org-tags-view nil query)))

(defun vxe-journal-activity-search ()
(interactive)
(let ((query (completing-read "focus: " activity-type-journal)))
(org-tags-view nil query)))

(defun vxe-journal-context-search ()
(interactive)
(let ((query (completing-read "focus: " context-journal)))
(org-tags-view nil query)))

;;;;;;;;;;;;;;;;;;

(setq focus-areas-agenda '("persons" "name" "here" "with" "underscores" ))
(setq activity-type-agenda '("unclear" "brainstorming" "troubleshooting" "learning" "teaching" "planning"))
(setq context-agenda '("unclear" "office" "private" "email" "phone" )) ; favor specific places outside work, vs agenda, house etc.

(defun vxe-tag-search-agenda ()
(interactive)
(let ((focus (completing-read "focus: " focus-areas-agenda))
(type (completing-read "type: " activity-type-agenda))
(context (completing-read "context" context-agenda)))
(org-tags-view nil (concat ":" focus ":" type ":" context ":"))))


(defun vxe-agenda-capture ()
(interactive)
(let ((focus (completing-read "focus: " focus-areas-agenda))
(type (completing-read "type: " activity-type-agenda))
(context (completing-read "context" context-agenda)))
(kill-new (concat ":" focus ":" type ":" context ":agenda:"))
(org-capture nil "a")))

(defun vxe-agenda-capture-tag ()
(interactive)
(let ((focus (completing-read "focus: " focus-areas-agenda))
(type (completing-read "type: " activity-type-agenda))
(context (completing-read "context" context-agenda)))
(kill-new (concat ":" focus ":" type ":" context ":agenda:"))))

(defun vxe-agenda-focus-search ()
(interactive)
(let ((query (completing-read "focus: " focus-areas-agenda)))
(org-tags-view nil query)))

(defun vxe-agenda-activity-search ()
(interactive)
(let ((query (completing-read "focus: " activity-type-agenda)))
(org-tags-view nil query)))

(defun vxe-agenda-context-search ()
(interactive)
(let ((query (completing-read "focus: " context-agenda)))
(org-tags-view nil query)))


(setq focus-areas-career '("unclear" "administrative" "skills" "networking" "vision"))
(setq activity-type-career '("unclear" "communicating" "reading" "researching" "writing" "troubleshooting" "creativing" "practicing"))
(setq context-career '("unclear" "apartment" "emacs" "gym" "leisure")) ; favor specific places outside work, vs career, house etc.

(defun vxe-tag-search-career ()
(interactive)
(let ((focus (completing-read "focus: " focus-areas-career))
(type (completing-read "type: " activity-type-career))
(context (completing-read "context" context-career)))
(org-tags-view nil (concat ":" focus ":" type ":" context ":"))))


(defun vxe-career-capture ()
(interactive)
(let ((focus (completing-read "focus: " focus-areas-career))
(type (completing-read "type: " activity-type-career))
(context (completing-read "context" context-career)))
(kill-new (concat ":" focus ":" type ":" context ":career:"))
(org-capture nil "c")))

(defun vxe-career-capture-tag ()
(interactive)
(let ((focus (completing-read "focus: " focus-areas-career))
(type (completing-read "type: " activity-type-career))
(context (completing-read "context" context-career)))
(kill-new (concat ":" focus ":" type ":" context ":career:"))))

(defun vxe-career-focus-search ()
(interactive)
(let ((query (completing-read "focus: " focus-areas-career)))
(org-tags-view nil query)))

(defun vxe-career-activity-search ()
(interactive)
(let ((query (completing-read "focus: " activity-type-career)))
(org-tags-view nil query)))

(defun vxe-career-context-search ()
(interactive)
(let ((query (completing-read "focus: " context-career)))
(org-tags-view nil query)))

(defun command-line-tool  (command-name command-argument task-list  &optional task)
(interactive "argument")
  (let* ((task
          (if (string= nil task)
              (completing-read "task: " task-list)
            task)))

    (async-shell-command (concat command-name
                                 " "
                                 task
                                 " '"
                                 command-argument
                                 "'")
                         (concat "*" command-name "*" " - " " task " " - "  command-argument))))

(defun call-package-manager (package &optional task)
  (interactive "spackage")
  (cond ((string= system-type "darwin")
         (command-line-tool "brew "
                            package
                            (list "search"
                                  "info"
                                  "install"
                                  "update"
                                  "upgrade"
                                  "uninstall"
                                  "list"
                                  "config"
                                  "doctor"
                                  "install -vd ")
                            task))

        ((string= "Ubuntu" (shell-command-to-string "lsb_release -ds | awk '{print $1}'"))
         (command-line-tool "sudo apt-get "
                            package
                            (list "update"
                                 "upgrade"
                                 "install"
                                 "remove"
                                 "autoremove"
                                 "purge"
                                 "source"
                                 "build"
                                 "dist-upgrade"
                                 "dselect-upgrade"
                                 "clean"
                                 "autoclean"
                                 "check"
                                 "changelog"
                                 "download")

                            task))))

(defun emacs:compile-latest-osx ()
  (interactive)
  (async-shell-command (concat
                        "mkdir -p $HOME/.emacs.d/src;"
                        "cd $HOME/.emacs.d/src/ ;"
                        "rm -rf $HOME/.emacs.d/src/emacs;"
                        "git clone https://github.com/emacs-mirror/emacs.git;"
                        "cd emacs;"
                        "autoreconf -i;"
                        "./configure --with-modules --prefix=$HOME/.emacs.d;"
                        "make && make install"
                        )


                       (concat "*Emacs* - compile")))

(defun emacs:compile-by-version (version)
  (interactive "sversion: ")
  (async-shell-command (concat
                        "mkdir -p $HOME/.emacs/src;"
                        "cd $HOME/.emacs.d/src/ ;"
                        "rm -rf $HOME/.emacs.d/src/emacs-"
                        version
                        ".tar.gz;"
                        "wget https://github.com/emacs-mirror/emacs/archive/emacs-"
                        version
                        ".tar.gz -O emacs-"
                        version
                        ".tar.gz;"
                        "tar xvf emacs-"
                        version
                        ".tar.gz;"
                        "cd $HOME/.emacs.d/src/emacs-emacs-"
                        version
                        ";"
                        "autoreconf -i;"
                        "./configure --with-modules --prefix=$HOME/.emacs.d;"
                        "make && make install"
                        )


                       (concat "*Emacs* - compile"))

  (kill-new version)
  (find-file "~/Downloads"))

(defun emacs:compile-by-version-osx (version)
  (interactive "sversion: ")
  (async-shell-command (concat
                        "mkdir -p $HOME/.emacs/src;"
                        "cd $HOME/.emacs.d/src/ ;"
                        "rm -rf $HOME/.emacs.d/src/emacs-"
                        version
                        ".tar.gz;"
                        "wget https://github.com/emacs-mirror/emacs/archive/emacs-"
                        version
                        ".tar.gz -O emacs-"
                        version
                        ".tar.gz;"
                        "tar xvf emacs-"
                        version
                        ".tar.gz;"
                        "cd $HOME/.emacs.d/src/emacs-emacs-"
                        version
                        ";"
                        "autoreconf -i;"
                        "./configure --with-modules --with-ns;"
                        "make && sudo make install"
                        )


                       (concat "*Emacs* - compile"))

  (kill-new version)
  (find-file "~/Downloads"))

(defun emacs:compile-by-version-no-manuals-osx (version)
  (interactive "sversion: ")
  (async-shell-command (concat
                        "mkdir -p $HOME/.emacs/src;"
                        "cd $HOME/.emacs.d/src/ ;"
                        "rm -rf $HOME/.emacs.d/src/emacs-"
                        version
                        ".tar.gz;"
                        "wget https://github.com/emacs-mirror/emacs/archive/emacs-"
                        version
                        ".tar.gz -O emacs-"
                        version
                        ".tar.gz;"
                        "tar xvf emacs-"
                        version
                        ".tar.gz;"
                        "cd $HOME/.emacs.d/src/emacs-emacs-"
                        version
                        ";"
                        "autoreconf -i;"
                        "./configure --with-modules --without-makeinfo --with-ns;"
                        "make && sudo make install"
                        )


                       (concat "*Emacs* - compile"))

  (kill-new version)
  (find-file "~/Downloads"))

(defun emacs:compile-by-version-no-info (version)
  (interactive "sversion: ")
  (async-shell-command (concat
                        "cd $HOME/.emacs.d/src/ ;"
                        "rm -rf $HOME/.emacs.d/src/emacs-"
                        version
                        ".tar.gz;"
                        "wget https://github.com/emacs-mirror/emacs/archive/emacs-"
                        version
                        ".tar.gz -O emacs-"
                        version
                        ".tar.gz;"
                        "tar xvf emacs-"
                        version
                        ".tar.gz;"
                        "cd $HOME/.emacs.d/src/emacs-emacs-"
                        version
                        ";"
                        "autoreconf -i;"
                        "./configure --with-modules --without-makeinfo --prefix=$HOME/.emacs.d;"
                        "make && make install"
                        )


                       (concat "*Emacs* - compile"))

  (kill-new version)
  (find-file "~/Downloads"))

(defun emacs:compile-by-version-xinfo-xgnutls (version)
  (interactive "sversion: ")
  (async-shell-command (concat
                        "mkdir -p $HOME/.emacs/src;"
                        "cd $HOME/.emacs.d/src/ ;"
                        "rm -rf $HOME/.emacs.d/src/emacs-"
                        version
                        ".tar.gz;"
                        "wget https://github.com/emacs-mirror/emacs/archive/emacs-"
                        version
                        ".tar.gz -O emacs-"
                        version
                        ".tar.gz;"
                        "tar xvf emacs-"
                        version
                        ".tar.gz;"
                        "cd $HOME/.emacs.d/src/emacs-emacs-"
                        version
                        ";"
                        "autoreconf -i;"
                        "./configure --with-modules --without-makeinfo --with-gnutls=no --prefix=$HOME/.emacs.d;"
                        "make && make install"
                        )


                       (concat "*Emacs* - compile"))

  (kill-new version)
  (find-file "~/Downloads"))

(defun new-wiki-entry (title)
  (interactive "stitle ")
  (find-file (concat "~/.emacs.d/wiki/" title ".org")))

(add-to-list 'package-archives
             '("org" . "http://orgmode.org/elpa/") t)

(use-package org
  :ensure t
  :init)

(setq org-agenda-default-appointment-duration 30)
(setq org-agenda-todo-ignore-scheduled 'future)
(setq org-agenda-tags-todo-honor-ignore-options t)
(setq org-mobile-inbox-for-pull "~/Dropbox/desktop/Documents/gtd/flagged.org")
(setq org-mobile-directory "~/Dropbox/Apps/MobileOrg")
(setq org-goto-interface 'outline-path-completion)
(setq org-goto-max-level 10)
(setq org-src-fontify-natively t)

(require 'ox-md)
(require 'ox-latex)

(setq org-confirm-babel-evaluate nil)
(setq org-babel-default-header-args:sh '((:results . "output")))

(add-hook 'org-mode-hook 'flyspell-mode)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
(add-hook 'org-mode-hook
          '(lambda ()
             (define-key org-mode-map (kbd "C-c C-d") 'org-deadline) ;untested
             (define-key org-mode-map (kbd "C-c C-s") 'org-schedule)
             (define-key org-mode-map (kbd "C-c C-r") nil)
             (define-key org-mode-map (kbd "C-c r") nil)))
(add-hook 'org-mode-hook (lambda ()
                           (progn
                             (defun expose-global-binding-in-org (binding)
                               (define-key dired-mode-map binding
                                 (lookup-key (current-global-map) binding)))
                             (expose-global-binding-in-org (kbd "M-y")))))

(cond ((not (file-exists-p "~/.emacs.d/lib/org-mode"))
       (shell-command (concat
                             "mkdir -p ~/.emacs.d/lib;"
                             "cd ~/.emacs.d/lib;"
                             "curl -LO https://orgmode.org/org-9.1.6.tar.gz;"
                             "tar -xvf org-9.1.6.tar.gz;"
                             "mv ~/.emacs.d/lib/org-9.1.6 ~/.emacs.d/lib/org-mode"))))

(add-to-list 'load-path "~/.emacs.d/lib/org-mode/contrib/lisp" t)

;; (require 'org-notmuch)

(cond ((not (file-exists-p "~/.emacs.d/lib/org-mime.el"))
       (shell-command (concat "curl 'https://gist.githubusercontent.com/vxe/12509a252c07efa22b5fdf85fd4c6236/raw/5e26f49035d4c85ac9dd51081d027582dfbb28b3/gistfile1.txt' > ~/.emacs.d/lib/org-mime.el"))
       (add-to-list 'load-path "~/.emacs.d/lib" t)
       (require 'org-mime)))

(require 'org-checklist)

;; (use-package org-drill
;;              :config (progn
;; 		       (add-to-list 'org-modules 'org-drill)
;; 		       (plist-put org-format-latex-options :scale 2.0)
;; 		       (setq org-format-latex-options (plist-put org-format-latex-options :scale 2.0))
;; 		       (setq org-drill-add-random-noise-to-intervals-p t)
;; 		       (setq org-drill-hint-separator "||")
;; 		       (setq org-drill-left-cloze-delimiter "<[")
;; 		       (setq org-drill-right-cloze-delimiter "]>")
;; 		       (setq org-drill-learn-fraction 0.15)))

(cond ((not (file-exists-p "~/.emacs.d/lib/org-eww.el"))
       (shell-command (concat "curl 'https://gist.githubusercontent.com/vxe/7425c0d47ff3406e0b67290fba5182ff/raw/439f3ebcdeb7bb28aae58bb73f3b42c0c93711eb/org-eww.el' > ~/.emacs.d/lib/org-eww.el"))
       (add-to-list 'load-path "~/.emacs.d/lib" t)
       (require 'org-eww)))

;; (require 'ob-groovy)

(use-package org-bullets
:ensure t)

(use-package ox-gfm
  :ensure t)

(defun vxe-org-table-export (output)
  (interactive "F")
  (org-table-export output)
  (find-file output))

;; (cond ((file-exists-p "~/pull-requests")
;;        (load-file "~/pull-requests/blog/home/sbin/generate-html.el")))

(defun ox-clip:install ()
  (interactive)
  (shell-command "cd ~/.emacs.d/lib; git clone https://github.com/jkitchin/ox-clip.git"))

(use-package htmlize
  :ensure t
  :init
  (cond((not (file-exists-p "~/.emacs.d/lib/ox-clip/ox-clip.el"))
        (ox-clip:install)))

  (load-file "~/.emacs.d/lib/ox-clip/ox-clip.el"))

(use-package toc-org
  :ensure t
  :init
  (if (require 'toc-org nil t)
      (add-hook 'org-mode-hook 'toc-org-enable)
    (warn "toc-org not found"))
  (add-to-list 'org-tag-alist '("TOC" . ?T)))

(defun org-mind-map-install ()
  (interactive)
  (shell-command (concat
                        "cd ~/.emacs.d/lib;"
                        "git clone https://github.com/theodorewiles/org-mind-map.git;")))
(cond ((file-exists-p "~/.emacs.d/lib/org-mind-map")
       (add-to-list 'load-path "~/.emacs.d/lib/org-mind-map")))

(add-hook 'org-mode-hook
          (lambda ()
            (local-set-key "\C-c\M-o" 'org-mime-org-buffer-htmlize)))

(add-hook 'org-mode-hook
          (lambda ()
            (yas-minor-mode)))

(use-package yasnippet
  :ensure t
  :init

                                        ; set snippet directory
  (cond ((eq system-type 'darwin) (setq yas-snippet-dirs  '("~/.emacs.d/snippets")))
        ((eq system-type 'gnu/linux) (setq yas-snippet-dirs '("~/.emacs.d/snippets")))
        ((eq system-type 'windows-nt) (setq yas-snippet-dirs '("~/put-dir-here"))))
                                        ; reload snippets on emacs reboot



  (defun vxe-term-toggle-mode ()
    (interactive)
    (if (term-in-line-mode)
        (term-char-mode)
      (term-line-mode)))


  (defun vxe-helm-yas-complete ()
    (interactive)
                                        ;  (vxe-term-toggle-mode)

    (cond ((string= "term-mode" (message "%s" major-mode))
           (vxe-term-toggle-mode)))
    (yas-reload-all)
    (yas-minor-mode-on)
    (helm-yas-complete)
                                        ; (cond ((string= "term-mode" (message "%s" major-mode))(vxe-term-toggle-mode)))
    )

  ;; suppress warning when embedding elisp into snippets
                                        ;(add-to-list 'warning-suppress-types '(yasnippet backquote-change))

  :config
  (require 'yasnippet)
  (yas-reload-all))

(use-package helm
  :ensure t
  :init
  (add-hook 'helm-after-update-hook (lambda () (with-helm-window (fit-window-to-buffer))))
  (setq helm-always-two-windows  t)
  (setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
        helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
        helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
        helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
        helm-ff-file-name-history-use-recentf t)
  (setq helm-buffer-max-length nil)
  :config
  (require 'helm)
  (require 'helm-config)

  (when (executable-find "curl")
    (setq helm-google-suggest-use-curl-p t))
  (helm-mode 1)



  (defun vxe-helm-switch-buffer ()
    "this used to work"
    (interactive)
    (if (and (one-window-p t)
             (not (active-minibuffer-window)))
        (split-window-vertically))
                                        ;      (other-window 1)
    (helm-mini)
                                        ; if we get persp mode working
    ;;  (let ((current-buff (buffer-name)))
    ;;   (persp-add-buffers-by-regexp current-buff)))
    )


  ;; (defun vxe-helm-switch-buffer-new ()
  ;;   "this used to work"
  ;;   (interactive)
  ;; ;  (if (and (one-window-p t)
  ;; ;;      (not (active-minibuffer-window)))
  ;; ;      (split-window-vertically))
  ;; ;  (other-window 1)
  ;;   (helm-mini)
  ;;   (let ((current-buff (buffer-name)))
  ;;     (persp-add-buffers-by-regexp current-buff)))


  (defun vxe-helm-yas-complete-old ()
    (interactive)
    (cond ((string= "term-mode" (message "%s" major-mode))(vxe-term-toggle-mode)))
    (yas-reload-all)
    (yas-minor-mode-on)
    (helm-yas-complete)
    (cond ((string= "term-mode" (message "%s" major-mode))(vxe-term-toggle-mode))))

  (defun vxe-helm-yas-complete ()
    (interactive)
                                        ;  (vxe-term-toggle-mode)
    (cond ((string= "term-mode" (message "%s" major-mode))
           (vxe-term-toggle-mode)))
    (yas-reload-all)
    (yas-minor-mode-on)
    (helm-yas-complete)
                                        ; (cond ((string= "term-mode" (message "%s" major-mode))(vxe-term-toggle-mode)))
    )

  (defun vxe-helm-suggest-code-block ()
    (interactive)
    (let ((lang (completing-read "what language: " (split-string
                                                    (s-chomp "cat ~/.emacs.d/data/org-block-languages")
                                                    "\n"))))
      (insert lang)))

  (defun vxe-split-window-vertically ()
    (interactive)
    (split-window-vertically)
    (vxe-helm-switch-buffer))

  (defun vxe-split-window-horizontally ()
    (interactive)
    (split-window-horizontally)
    (vxe-helm-switch-buffer))

  (defun vxe-kb-search ()
    (interactive)
    (s-chomp "mkdir -p ~/.emacs.d/kb")
    (defun vxe/generic-kb (topic)
      (interactive "s ")
      ;; (if (and (one-window-p t)
      ;; 	     (not (active-minibuffer-window)))
      ;; 	(split-window-vertically))
      ;; (other-window 1)
      (cond ((string= topic "sc")
             (switch-to-buffer "*scratch*")
             (vxe-journal-mode))
            (t (find-file (concat "~/.emacs.d/kb/" topic)))))

    (cond ((eq system-type 'windows-nt)
           (find-file (completing-read "book:"
                                       (split-string (s-chomp
                                                      (concat "perl5.20.2.exe "
                                                              emacs-root
                                                              "Dropbox/.emacs.d/windows/get-kb-list.pl"))"\n"))))
          ((eq system-type 'darwin)
           (let ((input (completing-read "topic:" (split-string
                                                   (s-chomp
                                                    "find -L ~/Documents/kb -maxdepth 1 -type f -print0 | xargs -0 basename | grep -Ev '^#|^[.]'")
                                                   "\n"))))
             (vxe/generic-kb input)))
          ((eq system-type 'gnu/linux)
           (let ((input (completing-read "topic:" (split-string
                                                   (s-chomp
                                                    "find -L ~/Documents/kb -maxdepth 1 -type f -printf '%f\n' | grep -Ev '^#|^[.]' ")
                                                   "\n"))))
             (vxe/generic-kb input)))


          (t     (let ((input (completing-read "topic:" (split-string
                                                         (s-chomp
                                                          "find -L ~/.emacs.d/kb -maxdepth 1 -type f ! -name '*[#~]' ! -name '*html' ! -name '*git*' -printf '%f\n'")
                                                         "\n"))))
                   (vxe/generic-kb input)))))



  (defun vxe-img-search ()
    (interactive)
    (s-chomp "mkdir -p ~/.emacs.d/wiki/img")
    (defun vxe/generic-wiki (topic)
      (interactive "s ")
      ;; (if (and (one-window-p t)
      ;; 	     (not (active-minibuffer-window)))
      ;; 	(split-window-vertically))
      ;; (other-window 1)
      (cond ((string= topic "sc")
             (switch-to-buffer "*scratch*")
             (vxe-journal-mode))
            (t (find-file (concat "~/.emacs.d/wiki/img/" topic)))))

    (cond ((eq system-type 'windows-nt)
           (find-file (completing-read "book:"
                                       (split-string (s-chomp
                                                      (concat "perl5.20.2.exe "
                                                              emacs-root
                                                              "Dropbox/.emacs.d/windows/get-kb-list.pl"))"\n"))))
          ((eq system-type 'darwin)
           (let ((input (completing-read "topic:" (split-string
                                                   (s-chomp
                                                    "find -L ~/Documents/wiki/img -maxdepth 1 -type f -print0 | xargs -0 basename | grep -Ev '^#|^[.]'")
                                                   "\n"))))
             (vxe/generic-wiki input)))
          ((eq system-type 'gnu/linux)
           (let ((input (completing-read "topic:" (split-string
                                                   (s-chomp
                                                    "find -L ~/Documents/wiki/img -maxdepth 1 -type f -printf '%f\n' | grep -Ev '^#|^[.]' ")
                                                   "\n"))))
             (vxe/generic-wiki input)))


          (t     (let ((input (completing-read "topic:" (split-string
                                                         (s-chomp
                                                          "find -L ~/.emacs.d/wiki/img -maxdepth 1 -type f ! -name '*[#~]' ! -name '*html' ! -name '*git*' -printf '%f\n'")
                                                         "\n"))))
                   (vxe/generic-wiki input)))))


  (global-set-key (kbd "C-x C-f") 'helm-find-files)
  (global-set-key (kbd "C-x F") 'find-file)
  (global-set-key (kbd "C-x f") 'find-file-at-point)
  (global-set-key (kbd "C-x RET") 'helm-mini)
  (global-set-key (kbd "C-x <C-return>") 'helm-mini))
;; (global-set-key (kbd "M-\\") 'vxe-split-window-vertically)
;; (global-set-key (kbd "C-x C-Y") 'split-window-vertically)
;; (global-set-key (kbd "C-x Y") 'split-window-vertically)
;; (global-set-key (kbd "M-p") 'vxe-split-window-horizontally)
(global-set-key (kbd "C-x C-w") 'yank-line)
(global-set-key (kbd "C-x w") 'yank-line)
;; (global-set-key (kbd "C-x y") 'split-window-horizontally)
(global-set-key (kbd "C-x 4") 'vxe-wiki-search)
(global-set-key (kbd "C-x \#") 'vxe-img-search)
(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

(use-package helm-projectile
  :ensure t)

(use-package helm-ag
  :ensure t
  :init)

(defun vxe:install-ag ()
  (interactive)
  (cond ((eq system-type 'darwin)
         (shell-command "brew install ag"))))

(use-package helm-swoop
    :ensure t
    :init)

(use-package helm-c-yasnippet
    :ensure t
    :init)

(use-package helm-org-rifle
  :ensure t)

(setq multi-term-program (s-chomp (shell-command-to-string "which zsh")))

(use-package exec-path-from-shell
  :ensure t
  :init
    (when (memq window-system '(mac ns))
    (exec-path-from-shell-initialize)
    (exec-path-from-shell-copy-env "WORKON_HOME")
    (exec-path-from-shell-copy-env "PATH")
    (exec-path-from-shell-copy-env "TERM")
    (exec-path-from-shell-copy-env "GROOVY_HOME")
    (exec-path-from-shell-copy-env "NVM_DIR")
    (exec-path-from-shell-copy-env "PYTHONSTARTUP"))


  :config
  ;; find zsh
  ;; (if (string= "" (s-chomp (shell-command-to-string "which zsh")))
  ;;       (setenv "SHELL" (s-chomp (shell-command-to-string "which bash")))
  ;;   (setenv "SHELL" (s-chomp (shell-command-to-string "which zsh"))))


  )

(use-package notmuch
  :ensure t
  :init

  (require 'notmuch)



  (add-hook 'notmuch-message-mode-hook (lambda ()
                                         (define-key notmuch-message-mode-map (kbd "r") nil)))

  (add-hook 'notmuch-message-mode-hook
            '(lambda ()
               (define-key notmuch-message-mode-map (kbd "C-x i") 'mml-attach-file)
               (define-key notmuch-message-mode-map (kbd "C-c C-r") nil)
               (define-key notmuch-message-mode-map (kbd "C-c r") nil)))



  (setq message-default-mail-headers "Cc: \n")
  (define-key notmuch-show-mode-map (kbd "w") 'vxe-notmuch-show-save-attachment)
  (define-key notmuch-show-mode-map (kbd "c m") 'notmuch-get-message-id))
;; default function overrides

(defun notmuch-search-messageid-region ()
  (interactive)
  (copy-region-as-kill (point-min) (point-max) t)
  (notmuch-search-by-message-id (with-temp-buffer (yank) (buffer-string))))

(defun vxe-notmuch-show-save-attachment ()
  (interactive)
  (shell-command "mkdir -p ~/Downloads")
  (let (cwd (pwd))
    (with-temp-buffer
      (cd "~/Downloads")
      (notmuch-show-save-attachments))))

(defun vxe-compose-mail ()
  (interactive)
  (with-temp-buffer
    (cd "~/Downloads")
    (compose-mail)
    (company-mode)
    (setq pyenv-mode nil)))

(defun vxe:nm-edit-queries ()
  (interactive)
  (find-file "/usr/local/bin/mail-sync"))

(defun vxe-enable-gmail ()
  (interactive)
  (setq message-send-mail-function 'smtpmail-send-it
        smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
        smtpmail-auth-credentials '(("smtp.gmail.com" 587 "vedwin.dev@gmail.com" nil))
        smtpmail-default-smtp-server "smtp.gmail.com"
        smtpmail-smtp-server "smtp.gmail.com"
        smtpmail-smtp-service 587))

(defun vxe-default-email-config ()
  (interactive)
  (load-file "~/.gnus"))

(defun notmuch-get-message-id ()
  "get message id in Mail.app format"
  (interactive)
  (let* ((unformatted-id (notmuch-show-get-message-id))
         (first-iteration (replace-regexp-in-string "^id:" "message:<" unformatted-id))
         (output (replace-regexp-in-string "$" ">" first-iteration)))
    (kill-new output)))

(defun notmuch-search-by-message-id (message-id)
  (interactive "smessage-id: ")
  (let* ((first-iteration (replace-regexp-in-string "message:<" "" message-id))
         (output (replace-regexp-in-string ">$" "" first-iteration)))
    (notmuch-search (concat "id:" output))))

(add-hook 'notmuch-message-mode-hook #'flyspell-mode)

(use-package emms
  :ensure t
  :config
  (require 'emms-setup)
  (require 'emms-player-mplayer)
                                        ;(emms-standard)
  (emms-all)
  (emms-default-players)

  :init

  (defun vxe-emms-streams ()
    (interactive)
    (setq exec-path (append exec-path '("/usr/local/bin")))
    (require 'emms-setup)
    (require 'emms-player-mplayer)
                                        ;(emms-standard)
    (emms-all)
    (emms-default-players)

    (define-emms-simple-player mplayer '(file url)
      (regexp-opt '(".ogg" ".mp3" ".wav" ".mpg" ".mpeg" ".wmv" ".wma"
                    ".mov" ".avi" ".divx" ".ogm" ".asf" ".mkv" "http://" "mms://"
                    ".rm" ".rmvb" ".mp4" ".flac" ".vob" ".m4a" ".flv" ".ogv" ".pls"))
      "mplayer" "-nogui" "-slave" "-quiet" "-really-quiet")
    (emms-streams))


  (defun vxe-emms-play-video ()
    (interactive)

    (let ((input (completing-read "song: "
                                  (split-string (s-chomp "find -L \"$HOME/Movies\" -iname '*m4a' -o -iname '*m4a' -o -iname '*mp4' ")  "\n"))))
      (setq exec-path (append exec-path '("/usr/local/bin")))
      (require 'emms-setup)
      (require 'emms-player-mplayer)
                                        ;(emms-standard)
      (emms-all)
      (emms-default-players)

      (define-emms-simple-player mplayer '(file url)
        (regexp-opt '(".ogg" ".mp3" ".wav" ".mpg" ".mpeg" ".wmv" ".wma"
                      ".mov" ".avi" ".divx" ".ogm" ".asf" ".mkv" "http://" "mms://"
                      ".rm" ".rmvb" ".mp4" ".flac" ".vob" ".m4a" ".flv" ".ogv" ".pls"))
        "mplayer" "-nogui" "-slave" "-quiet" "-really-quiet")
      (emms-play-file input)))


  (defun vxe-emms-itunes-search ()
    (interactive)
    (let ((input (completing-read "song: "
                                  (split-string (s-chomp "find -L \"$HOME/Music/iTunes/iTunes Media/Music\" -iname '*m4a' -o -iname '*mp3' ")  "\n"))))
      ;; TODO add gnu/linux  case
      (cond ((eq system-type 'darwin)
             (define-emms-simple-player afplay '(file)
               (regexp-opt '(".mp3" ".m4a" ".aac" "pls"))
               "afplay")
             (setq emms-player-list `(,emms-player-afplay))))
      (emms-play-file input)))


  (defun vxe-emms-itunes-dir-play ()
    (interactive)
    (let ((input (completing-read "song: "
                                  (split-string (s-chomp "find -L \"$HOME/Music/iTunes/iTunes Media/Music\" -type d")  "\n"))))
      ;; TODO add gnu/linux  case
      (cond ((eq system-type 'darwin)
             (define-emms-simple-player afplay '(file)
               (regexp-opt '(".mp3" ".m4a" ".aac" "pls"))
               "afplay")
             (setq emms-player-list `(,emms-player-afplay))))
      (emms-play-file input)))


  (defun vxe-emms-shuffle-and-play-regexp ()
    (interactive)
    (let ((input (completing-read "song: "
                                  (split-string (s-chomp "find -L \"$HOME/Music/iTunes/iTunes Media/Music\" -type d")  "\n"))))
      ;; TODO add gnu/linux  case
      (cond ((eq system-type 'darwin)
             (define-emms-simple-player afplay '(file)
               (regexp-opt '(".mp3" ".m4a" ".aac" "pls"))
               "afplay")
             (setq emms-player-list `(,emms-player-afplay))))
      (emms-play-find "~/Music" input)
      (emms-shuffle)
      ))

  (defun vxe-emms-insert-find (regexp)
    (interactive "sinsert by regexp: ")
    (emms-insert-find "~/Music" regexp)
    (hydra-emms/body))


  (defun vxe-emms-playlist-new (name)
    (interactive "splaylist name: ")
    (let ((playlist-name (concat "emms-playlist-" name)))
      (emms-playlist-new playlist-name)
      (switch-to-buffer playlist-name)
      (hydra-emms/body)))

  (defun vxe-emms-podcast-play ()
    (interactive)
    (let ((input (completing-read "song: "
                                  (split-string (s-chomp "find -L \"$HOME/Music/iTunes/iTunes Media/Podcasts\" -iname '*m4a' -o -name '*mp3'")  "\n"))))
      (emms-play-file input))))

(defun vxe:download-geeknote ()
      (interactive)
      (with-temp-buffer
        (cd "~/.emacs.d/opt")
        (async-shell-command "git clone https://github.com/jeffkowalski/geeknote")))


    (defun vxe:install-geeknote ()
      (interactive)
      (with-temp-buffer
        (cd "~/.emacs.d/opt/geeknote")
        (shell-shell-command "pip install -r requirements.txt")
        (shell-shell-command "python setup.py install")
        (async-shell-command "geeknote settings --editor 'emacsclient'")
        (setq geeknote-command "python ~/.emacs.d/opt/geeknote/geeknote/geeknote.py")))

(defun vxe:download-emacs-geeknote ()
(interactive)
(async-shell-command "cd ~/.emacs.d/lib ; git clone https://github.com/vxe/emacs-geeknote.git")
)

(defun vxe:install-emacs-geeknote ()
(interactive)
(load-file "~/.emacs.d/lib/emacs-geeknote/geeknote.el"))

(defun vxe:create-geeknote-virtualenv ()
(interactive)
(async-shell-command "cd ~/.emacs.d/opt/geeknote; virtualenv .geeknote"))

  ;; (use-package geeknote
  ;;   :ensure t
  ;;   :init
  ;;  (setq geeknote-command "python ~/.emacs.d/opt/geeknote/geeknote/geeknote.py"))


(cond ((file-exists-p "~/.emacs.d/lib/emacs-geeknote/geeknote.el")
       (load-file "~/.emacs.d/lib/emacs-geeknote/geeknote.el")))

(defun geeknote:install-in-venv ()
  (interactive)
  (async-shell-command (concat "source ~/.emacs.d/var/"
                               venv-current-name
                               "/bin/activate;"
                               "mkdir -p ~/.emacs.d/tmp;"
                               "rm -rf ~/.emacs.d/tmp/geeknote;"
                               "cd ~/.emacs.d/tmp;"
                               "git clone https://github.com/jeffkowalski/geeknote.git;"
                               "cd geeknote;"
                               "python setup.py build;"
                               "pip install --upgrade .  ")
                               (concat "*geeknote* - install in venv " venv-current-name)))

(defun geeknote:install-in-specified-venv ()
  (interactive)
  (venv-workon)
  (async-shell-command (concat "source ~/.emacs.d/var/"
                               venv-current-name
                               "/bin/activate;"
                               "mkdir -p ~/.emacs.d/tmp;"
                               "rm -rf ~/.emacs.d/tmp/geeknote;"
                               "cd ~/.emacs.d/tmp;"
                               "git clone https://github.com/jeffkowalski/geeknote.git;"
                               "cd geeknote;"
                               "python setup.py build;"
                               "pip install --upgrade .  ")
                               (concat "*geeknote* - install in venv " venv-current-name)))

(setq maxima-version "5.40.0")
(setq maxima-binary (s-chomp "which maxima"))

(defun install-maxima-osx ()
  (interactive)
  (async-shell-command (concat "cd ~/.emacs.d/opt; wget https://sourceforge.net/projects/maxima/files/Maxima-MacOS/5.40.0-MacOSX/Maxima-"
                               maxima-version
                               "-VTK-macOS.dmg/download -O maxima.dmg; open maxima.dmg")))

;; (cond ((eq system-type 'darwin)
;;        (if (not (string= ""
;;                          maxima-binary))
;;            (progn
;;              (add-to-list 'load-path (s-chomp (shell-command-to-string "find /usr/local/Cellar -name  emacs | grep maxima")))
;;              (require 'maxima)
;;              (require 'imaxima)
;;              (require 'imath)
;;               (require 'emaxima))
;;          (message "install maxima"))))

(defun vxe-imaxima ()
(interactive)
(imaxima)
(smartparens-mode))

(use-package projectile
:ensure t
)

(use-package skeletor
:ensure t
)

(defun GNATS:download ()
  (interactive)
  (async-shell-command (concat
                        "cd ~/Downloads;"
                        "wget https://ftp.gnu.org/pub/gnu/gnats/gnats-4.2.0.tar.gz;"
                        "tar xvf gnats-4.2.0.tar.gz")
                       (concat "*GNATS - download*")))

(defun GNATS:compile ()
  (interactive)
  (async-shell-command (concat
                        "cd ~/Downloads/gnats-4.2.0;"
                        "./configure --prefix=$HOME/.emacs.d"
                        "make; "
                        "make install;"
                        "make install install-info")
                       (concat "*GNATS - compile*")))

(add-to-list 'load-path "~/.emacs.d/lib/gnats")
 (autoload 'send-pr "gnats"
    "Command to create and send a problem report." t)
 (autoload 'edit-pr "gnats"
    "Command to edit a problem report." t)
 (autoload 'view-pr "gnats"
    "Command to view a problem report." t)
 (autoload 'query-pr "gnats"
    "Command to query information about problem reports." t)
 (autoload 'unlock-pr "gnats"
    "Unlock a problem report." t)
 (autoload 'gnats-dbconfig-mode "gnats"
   "Major mode for editing the `dbconfig' GNATS configuration file." t)
 (add-to-list 'auto-mode-alist '("\\<dbconfig$" . gnats-dbconfig-mode))

(defun GNATS:create-default-db ()
  (interactive)
  (async-shell-command (concat "/usr/local/libexec/gnats/mkdb default")
                       (concat "*GNATS - create db*")
                       )
  )

(use-package cmake-mode
:ensure t
:init
(require 'cmake-mode)
(define-key cmake-mode-map (kbd "C-c d") 'cmake-help))

(defun cmake-generate-compilation-database ()
  (interactive)
  (async-shell-command (concat "mkdir -p "
                               projectile-project-root
                               "/build;"
                               "cd "
                               projectile-project-root
                               "/build;"
                               "cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1 .. ;"
                               "make")
                       (concat "*CMake* - compile with database")))

(use-package cmake-ide
:ensure t )

(defun dash:download-javadoc-generator ()
(interactive)
(async-shell-command "cd ~/.emacs.d/bin; wget http://kapeli.com/javadocset.zip; unzip javadocset.zip; chmod a+x javadocset ")
)

(use-package helpful
  :ensure t
  :init
  ;; Note that the built-in `describe-function' includes both functions
  ;; and macros. `helpful-function' is functions only, so we provide
  ;; `helpful-callable' as a drop-in replacement.
  (global-set-key (kbd "C-h f") #'helpful-callable)

  (global-set-key (kbd "C-h v") #'helpful-variable)
  (global-set-key (kbd "C-h k") #'helpful-key)

  ;; Lookup the current symbol at point. C-c C-d is a common keybinding
;; for this in lisp modes.
(global-set-key (kbd "C-c C-d") #'helpful-at-point)

;; Look up *F*unctions (excludes macros).
;;
;; By default, C-h F is bound to `Info-goto-emacs-command-node'. Helpful
;; already links to the manual, if a function is referenced there.
(global-set-key (kbd "C-h F") #'helpful-function)

;; Look up *C*ommands.
;;
;; By default, C-h C is bound to describe `describe-coding-system'. I
;; don't find this very useful, but it's frequently useful to only
;; look at interactive functions.
(global-set-key (kbd "C-h C") #'helpful-command)
  )

(use-package helm-dash
:ensure t
)

(use-package company-quickhelp
:ensure t
:config
 (add-hook 'company-mode-hook #'company-quickhelp-mode)
)

(use-package lice
:ensure t)

(defun compile-doxymacs ()
  (interactive)
  (async-shell-command "git clone https://github.com/vxe/doxymacs-osx.git && cd doxymacs-osx && ./configure && make && sudo make install"))

(defun download-linux-manpages-by-kernel (kernel-version)
  (interactive "skernel version")
  (async-shell-command (concat
                        "mkdir -p ~/.emacs.d/var/man"
                        "cd ~/.emacs.d/var/man;"
                        "wget https://www.kernel.org/pub/linux/docs/man-pages/man-pages-" kernel-version".tar.gz; "
                        "tar xvf man-pages-" kernel-version".tar.gz;")
                       (concat "*woman* - downloading linux manpages"))
  (customize-variable 'woman-manpath))

(defun download-procps-manpages ()
  (interactive)
  (async-shell-command (concat
                        "mkdir -p ~/.emacs.d/var/man"
                        "cd ~/.emacs.d/var/man;"
                        "git clone https://gitlab.com/procps-ng/procps/ ;"
                        "cd procps;"
                        "mkdir -p man;"
                        "mv * man")
                       (concat "*woman* - downloading procps manpages"))
  (customize-variable 'woman-manpath))

(defun download-docker-manpages ()
  (interactive)
  (async-shell-command (concat
                        "mkdir -p ~/.emacs.d/var/man;"
                        "mkdir -p ~/.emacs.d/var/man/docker/man;"
                        "cd ~/.emacs.d/var/man/docker/man;"
                        "wget http://manpages.ubuntu.com/manpages.gz/xenial/man1/docker.1.gz ;"
                        "gunzip docker.1.gz;")
                       (concat "*woman* - downloading docker manpages"))
  (customize-variable 'woman-manpath))

(defun linux-syscall-man-lookup ()
  (interactive)
  (let ((syscall (completing-read "syscall:" linux-system-calls)))
    (woman syscall)))

(use-package isend-mode
:ensure t
)

(use-package flycheck
:ensure t)

(use-package flycheck-rtags
:ensure t)

(use-package realgud
:ensure t)

(defun gdb:install ()
    (interactive)
    (async-shell-command (concat  "mkdir -p ~/.emacs.d/src;"
                                  "cd ~/.emacs.d/src;"
;                                  "rm -rf ~/.emacs.d/src/binutils-gdb.git;"
;                                  "git clone git://sourceware.org/git/binutils-gdb.git;"
                                  "cd ~/.emacs.d/src/binutils-gdb;"
                                  "./configure --prefix=$HOME/.emacs.d ;"
                                  "make && make install")
                         (concat "*gdb* - installing")))

(use-package git-gutter
:ensure t)

(use-package paredit
:ensure t)

(use-package rainbow-delimiters
:ensure t)

(use-package lispy
  :ensure t
  :init
  (require 'lispy)
  (define-key lispy-mode-map (kbd "C-j") 'paredit-newline)
  (define-key lispy-mode-map (kbd "[") 'paredit-open-square)
  (define-key lispy-mode-map (kbd "M-.") nil)
  (define-key lispy-mode-map (kbd ":") 'self-insert-command)
  )

(use-package smartparens
  :ensure t )

(use-package ycmd
  :ensure t
  :config
  (cond
   ((not (file-exists-p "~/.emacs.d/opt/ycmd/"))
    (shell-command (concat  "if [[ -d ~/.emacs.d/opt/ycmd ]]; then exit 0; else mkdir -p ~/.emacs.d/opt; cd ~/.emacs.d/opt; git clone https://github.com/Valloric/ycmd.git ; cd ycmd; git submodule update --init --recursive ; ./build.py --all ; fi")
                         (concat "*ycmd* - installing"))))

  (require 'ycmd-eldoc)
  (add-hook 'ycmd-mode-hook 'ycmd-eldoc-setup)
  (setq ycmd-server-command (list "python" (file-truename "~/.emacs.d/opt/ycmd/ycmd"))))

(defun ycmd:redownload
(interactive)
(shell-command "rm -rf ~/.emacs.d/opt/ycmd")
(async-shell-command "if [[ -d ~/.emacs.d/opt/ycmd ]]; then exit 0; else mkdir -p ~/.emacs.d/opt; cd ~/.emacs.d/opt; git clone https://github.com/Valloric/ycmd.git ; cd ycmd; git submodule update --init --recursive ; ./build.py --all ; fi")
)

(use-package company-ycmd
:ensure t
:init
(require 'company-ycmd)
(company-ycmd-setup))

(use-package flycheck-ycmd
  :ensure t
  :init
  (require 'flycheck-ycmd)
  (flycheck-ycmd-setup))

(use-package elisp-slime-nav
:ensure t
;; :init
;; (require 'elisp-slime-nav)
;; (dolist (hook '(emacs-lisp-mode-hook ielm-mode-hook))
;;   (add-hook hook 'elisp-slime-nav-mode))
)

(add-hook 'ielm-mode-hook             #'enable-paredit-mode)
(add-hook 'ielm-mode-hook             #'rainbow-delimiters-mode)
(add-hook 'ielm-mode-hook             #'show-paren-mode)
(add-hook 'ielm-mode-hook             #'eldoc-mode)
(add-hook 'ielm-mode-hook             #'lispy-mode)
(add-hook 'scheme-mode-hook             #'enable-paredit-mode)
(add-hook 'emacs-lisp-mode-hook             #'show-paren-mode)

;;; clojure forms

(defmacro ->> (&rest body)
  (let ((result (pop body)))
    (dolist (form body result)
      (setq result (append form (list result))))))

(defmacro -> (&rest body)
  (let ((result (pop body)))
    (dolist (form body result)
      (setq result (append (list (car form) result)
                           (cdr form))))))

(use-package elisp-refs
:ensure t
)

(use-package elisp-def
:ensure t
:init
(dolist (hook '(emacs-lisp-mode-hook ielm-mode-hook))
  (add-hook hook #'elisp-def-mode))
)

(add-hook 'emacs-lisp-mode-hook #'yas-minor-mode)

(add-hook 'emacs-lisp-mode-hook #'lispy-mode)

(add-hook 'emacs-lisp-mode-hook #'eldoc-mode)

(use-package ht
:ensure t)

(use-package s
:ensure t)

(use-package dash
:ensure t)

;; (use-package trie
;; :ensure t
;; :init
;; (require 'trie)
;; )

(use-package heap
:ensure t
:init
(require 'heap))

(use-package avl-tree
:ensure t
:init
(require 'avl-tree))

(use-package queue
:ensure t)

(use-package clojure-mode
  :ensure t
  :init

  (add-hook 'clojure-mode-hook #'linum-mode)
  (add-hook 'clojure-mode-hook #'paredit-mode)
  (add-hook 'clojure-mode-hook #'rainbow-mode)
  (add-hook 'clojure-mode-hook #'lispy-mode)
  (add-hook 'clojure-mode-hook #'projectile-mode))

(use-package cider
:ensure t
:init
(require 'cider)
(define-key cider-repl-mode-map (kbd "C-c b") 'cider-repl-clear-buffer)
)

(use-package clj-refactor
  :ensure t
  :init
  (require 'clj-refactor)

  (defun my-clojure-mode-hook ()
    (clj-refactor-mode 1)
    (yas-minor-mode 1) ; for adding require/use/import statements
    ;; This choice of keybinding leaves cider-macroexpand-1 unbound
    (cljr-add-keybindings-with-prefix "C-c C-m"))

  (add-hook 'clojure-mode-hook #'my-clojure-mode-hook))

(use-package clojars
:ensure t)

(shell-command "mkdir -p ~/.emacs.d/.m2")

(defun vxe:cider-connect (host port)
  (interactive "shost: \nsport: ")
  (cider-connect host port))

(defun vxe:cider-connect-clojurescript (host port)
  (interactive "shost: \nsport: ")
  (cider-connect host port)
  (cider-jack-in-clojurescript))

(cond ((file-exists-p "~/.emacs.d/lib/clojure-pretty-lambda.el")
       (require 'clojure-pretty-lambda)
       ))

(use-package inf-clojure
  :ensure t
  :init)

(define-key clojurescript-mode-map (kbd "C-c C-k") nil)
(define-key clojurescript-mode-map (kbd "C-c C-k") 'org-edit-src-abort)

(add-hook 'lisp-mode-hook #'paredit-mode)
(add-hook 'lisp-mode-hook #'lispy-mode)
(add-hook 'lisp-mode-hook #'projectile-mode)
(add-hook 'lisp-mode-hook #'enable-paredit-mode)
(add-hook 'lisp-mode-hook #'rainbow-delimiters-mode)
(add-hook 'lisp-mode-hook #'show-paren-mode)
(add-hook 'lisp-mode-hook #'eldoc-mode)

;;   (use-package slime
;;     :ensure t
;;     :init
;;     (require 'slime)
;; ;    (require 'slime-asdf)
;; )

(cond ((not (file-exists-p "~/.emacs.d/lib/slime"))
       (shell-command "cd ~/.emacs.d/lib; git clone https://github.com/slime/slime.git")))

(add-to-list 'load-path "~/.emacs.d/lib/slime")
(add-to-list 'load-path "~/.emacs.d/lib/slime/contrib")



  (use-package slime-docker
    :ensure t
    :init
;    (require 'slime-asdf)
)


(use-package ac-slime
:ensure t
:init
(require 'slime-repl)
(add-hook 'slime-mode-hook 'set-up-slime-ac)
(add-hook 'slime-repl-mode-hook 'set-up-slime-ac)
(add-hook 'slime-repl-mode-hook 'auto-complete-mode)
(add-hook 'slime-repl-mode-hook 'enable-paredit-mode)
(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes 'slime-repl-mode)))

(require 'slime-autoloads)
(setq slime-contribs '(slime-fancy))
;; (slime-setup '(slime-fancy))

(add-hook 'slime-repl-mode-hook #'paredit-mode)
(add-hook 'slime-repl-mode-hook #'lispy-mode)
(add-hook 'slime-repl-mode-hook #'projectile-mode)
(add-hook 'slime-repl-mode-hook #'enable-paredit-mode)
(add-hook 'slime-repl-mode-hook #'rainbow-delimiters-mode)
(add-hook 'slime-repl-mode-hook #'show-paren-mode)
(add-hook 'slime-repl-mode-hook #'eldoc-mode)

(define-key slime-repl-mode-map (kbd "C-x 5") 'vxe-wiki-search)
(define-key slime-repl-mode-map (kbd "C-x $") 'yas-new-snippet)
(define-key slime-repl-mode-map (kbd "C-x 4") 'vxe-helm-yas-complete)
(define-key slime-repl-mode-map (kbd "C-x %") 'yas-reload-all)

(use-package slime-company
  :ensure t)

(defun vxe:download-ecl ()
  (interactive)
  (with-temp-buffer
    (cd "~/src")
    (async-shell-command "git clone https://gitlab.com/embeddable-common-lisp/ecl.git")))

(defun vxe:redownload-ecl ()
  (interactive)
  (with-temp-buffer
    (cd "~/src")
    (async-shell-command "rm ~/src/ecl")
    (async-shell-command "git clone https://gitlab.com/embeddable-common-lisp/ecl.git")))

(defun vxe:build-ecl ()
  (interactive)
  (with-temp-buffer
    (cd "~/src/ecl")
    (async-shell-command "./configure && make")))

(defun clasp:install-externals ()
  (interactive)
  (async-shell-command (concat "mkdir -p ~/.emacs.d/opt;"
                               "cd ~/.emacs.d/opt;"
                               "git clone https://github.com/drmeister/externals-clasp;"
                               "cd ~/.emacs.d/opt/externals-clasp;"
                               "make"
                               )
                       (concat "*Clasp* Installing Externals")))

(use-package geiser
  :ensure t
  :init)

(add-hook 'geiser-repl-mode-hook #'lispy-mode)
(add-hook 'geiser-repl-mode-hook #'projectile-mode)
(add-hook 'geiser-repl-mode-hook #'enable-paredit-mode)
(add-hook 'geiser-repl-mode-hook #'rainbow-delimiters-mode)
(add-hook 'geiser-repl-mode-hook #'show-paren-mode)
(add-hook 'geiser-repl-mode-hook #'eldoc-mode)

(add-hook 'scheme-mode-hook #'geiser-mode)

(defun lfe-install ()
  (interactive)
  (async-shell-command (concat "cd ~/.emacs.d/opt; git clone https://github.com/rvirding/lfe.git; cd lfe; make compile; sudo make install")
                       (concat "*lfe* building...")))

(use-package lfe-mode
  :ensure t
  :init
  ;; repl config
  (require 'lfe-mode)
  (require 'inferior-lfe)
  (add-hook 'inferior-lfe-mode-hook #'smartparens-mode)
  (define-key inferior-lfe-mode-map (kbd "C-k") 'sp-kill-sexp))

(add-hook 'lfe-mode-hook #'enable-paredit-mode)

(add-hook 'lfe-mode-hook #'linum-mode)

;; (use-package ob-lfe
;; :ensure t )

(add-hook 'sh-mode-hook #'linum-mode)
(add-hook 'shell-mode-hook #'goto-address-mode)
(add-hook 'sh-mode-hook #'yas-minor-mode)
(add-hook 'shell-mode-hook #'yas-minor-mode)

(add-hook 'sh-mode-hook #'smartparens-mode)
(add-hook 'shell-mode-hook #'smartparens-mode)

(setq c-default-style "linux")

(when (require 'rtags nil :noerror)
         ;; make sure you have company-mode installed
         (require 'company)
         (define-key c-mode-map (kbd "M-.")
           (function rtags-find-symbol-at-point))
         (define-key c-mode-map (kbd "M-,")
           (function rtags-location-stack-back))

         ;; disable prelude's use of C-c r, as this is the rtags keyboard prefix
         ;; (define-key prelude-mode-map (kbd "C-c r") nil)
         ;; install standard rtags keybindings. Do M-. on the symbol below to
         ;; jump to definition and see the keybindings.
         (rtags-enable-standard-keybindings)
         ;; comment this out if you don't have or don't use helm
         (setq rtags-use-helm t)
         ;; company completion setup
         (setq rtags-autostart-diagnostics t)
         (rtags-diagnostics)
         (setq rtags-completions-enabled t)
         (push 'company-rtags company-backends)
                                     ;	  (global-company-mode)
         (define-key c-mode-base-map (kbd "<C-tab>") (function company-complete))
         ;; use rtags flycheck mode -- clang warnings shown inline
         (require 'flycheck-rtags)
         ;; c-mode-common-hook is also called by c++-mode
                                     ;	(add-hook 'c++-mode-hook #'setup-flycheck-rtags)
         )

(defun disable-rtags ()
  (interactive)
  (define-key c-mode-base-map (kbd "M-.") (function tags-find-symbol-at-point))
  (define-key c-mode-base-map (kbd "M-,") (function tags-find-references-at-point))
                                        ;(define-key c-mode-base-map (kbd "M-;") (function tags-find-file))
  (define-key c-mode-base-map (kbd "C-.") (function tags-find-symbol))
  (define-key c-mode-base-map (kbd "C-,") (function tags-find-references))
  (define-key c-mode-base-map (kbd "C-<") (function rtags-find-virtuals-at-point))
  (define-key c-mode-base-map (kbd "M-i") (function tags-imenu)))

(add-hook 'c-mode-hook #'yas-minor-mode)

(add-hook 'c-mode-hook #'linum-mode)

(setq-default c-basic-offset 4)

(require 'compile)
 (add-hook 'c-mode-hook
           (lambda ()
             (unless (file-exists-p "Makefile")
               (set (make-local-variable 'compile-command)
                    ;; emulate make's .c.o implicit pattern rule, but with
                    ;; different defaults for the CC, CPPFLAGS, and CFLAGS
                    ;; variables:
                    ;; $(CC) -c -o $@ $(CPPFLAGS) $(CFLAGS) $<
                    (let ((file (file-name-nondirectory buffer-file-name)))
                      (format "%s -c -o %s.o %s %s %s"
                              (or (getenv "CC") "gcc")
                              (file-name-sans-extension file)
                              (or (getenv "CPPFLAGS") "-DDEBUG=9")
                              (or (getenv "CFLAGS") "-ansi -pedantic -Wall -g")
                              file))))))

(defun recompile-quietly ()
  "Re-compile without changing the window configuration."
  (interactive)
  (save-window-excursion
    (recompile)))

(add-hook 'java-mode-hook 'projectile-mode)
(add-hook 'java-mode-hook 'linum-mode)

(defun java:install-version (version)
  (interactive "sjava version")
  (with-temp-buffer
    (async-shell-command (concat
                          "mkdir -p ~/.emacs.d/opt/java"
                          "cd ~/.emacs.d/opt/java;"
                          "curl -L --header \"Cookie: s_nr=1359635827494; s_cc=true; gpw_e24=http%3A%2F%2Fwww.oracle.com%2Ftechnetwork%2Fjava%2Fjavase%2Fdownloads%2Fjdk6downloads-1902814.html; s_sq=%5B%5BB%5D%5D; gpv_p24=no%20value\" http://download.oracle.com/otn-pub/java/jdk/6u39-b04/jdk-"
                          version
                          "-linux-x64.tar.gz -o jdk-"
                          version
                          "-linux-x64.tar.gz")
                         (concat "*Java* - Downloading new version..."))))

(use-package javadoc-lookup
:ensure t)

(defun mvn:install-osx ()
(interactive)
(async-shell-command "brew install maven"))

(defun mvn:search-central (query)
(interactive "squery: ")
(async-shell-command (concat "~/.emacs.d/bin/search-maven.rb " query)))

;; (use-package jdee
;; :ensure t
;; :init

;;   (defun vxe:download-jdee-server ()
;;   (interactive)
;; 	(with-temp-buffer
;;           (cd "~/.emacs.d/opt")
;;           (async-shell-command "git clone https://github.com/jdee-emacs/jdee-server.git")))



;;   (defun vxe:build-jdee-server ()
;;   (interactive)
;; 	(with-temp-buffer
;;         (cd "~/.emacs.d/opt/jdee-server")
;;         (async-shell-command "mvn -DskipTests=true assembly:assembly")
;;         (shell-command "cp target/jdee-bundle* ~/.emacs.d/bin")))

;; (setq jdee-server-dir "~/.emacs.d/bin")

;; )

(use-package meghanada
:ensure t
:init
(require 'meghanada)
(add-hook 'java-mode-hook
          (lambda ()
            ;; meghanada-mode on
            (meghanada-mode t)
            (setq c-basic-offset 2)
            ;; jump to defintion
            (define-key java-mode-map (kbd "M-,") 'meghanada-back-jump)
            ;; use code format
            (add-hook 'before-save-hook 'meghanada-code-beautify-before-save))))

(use-package lsp-java
  :ensure t
  :init
  (require 'lsp-java)
  (add-hook 'java-mode-hook #'lsp-java-enable)
)

(use-package lsp-java
  :ensure t
  :init
  (require 'lsp-java)
  (require 'lsp-mode)
  (add-hook 'java-mode-hook #'lsp-java-enable)
  ;; (setq lsp-java--workspace-folders (list "/path/to/project1"
  ;;                                       "/path/to/project2"
  ;;                                       ...))
  )

(use-package company-lsp
  :ensure t
  :init
  (require 'company-lsp)
  (push 'company-lsp company-backends))

(defun ant:compile-osx ()
  (interactive)
  (async-shell-command (concat "brew install ant")
                       (concat "*Ant* Install")))

(use-package jtags
:ensure t
)

(defun java-repl:install ()
  (interactive)
  (async-shell-command (concat "mkdir -p ~/.emacs.d/opt;"
                               "cd ~/.emacs.d/opt;"
                               "rm -rf ~/.emacs.d/opt/java-repl;"
                               "git clone https://github.com/albertlatacz/java-repl.git;"
                               "cd java-repl;"
                               "gradle shadowJar;")
                       (concat "*Java-Repl* - installing")))

(defun java-repl:run ()
  (interactive)
  (async-shell-command (concat "cd ~/.emacs.d/opt/java-repl;"
                               "java -jar build/libs/javarepl-dev.jar")
                       (concat "*JavaRepl* - running")))

(use-package rtags
          :ensure t
          :init
          :config
          (define-key c-mode-base-map (kbd "<C-tab>") (function company-complete))

          (push 'company-rtags company-backends)
          (require 'flycheck-rtags)
          (setq rtags-display-result-backend 'helm)
          (cond ((file-exists-p "~/.emacs.d/opt/rtags")
                 (load-file "~/.emacs.d/opt/rtags/src/rtags.el")))

          ;; (cond
          ;;  ((not (file-exists-p "~/.emacs.d/opt/rtags/"))
          ;;   (async-shell-command "if [[ -d ~/.emacs.d/opt/rtags ]]; then exit 0; else mkdir -p ~/.emacs.d/opt; cd ~/.emacs.d/opt; git clone --recursive https://github.com/Andersbakken/rtags.git ; cd rtags ; cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1 . ; make; fi")))

          ;; (add-to-list 'load-path "~/.emacs.d/opt/rtags/src" t)
          (defun setup-flycheck-rtags ()
            (interactive)
            (flycheck-select-checker 'rtags)
            ;; RTags creates more accurate overlays.
            (setq-local flycheck-highlighting-mode nil)
            (setq-local flycheck-check-syntax-automatically nil))
          ;; only run this if rtags is installed


          ;; c++ config
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
          (when (require 'rtags nil :noerror)
            ;; make sure you have company-mode installed
            (require 'company)
            (define-key c++-mode-map (kbd "M-.")
              (function rtags-find-symbol-at-point))
            (define-key c++-mode-map (kbd "M-,")
              (function rtags-location-stack-back))

            ;; disable prelude's use of C-c r, as this is the rtags keyboard prefix
            ;; (define-key prelude-mode-map (kbd "C-c r") nil)
            ;; install standard rtags keybindings. Do M-. on the symbol below to
            ;; jump to definition and see the keybindings.
            (rtags-enable-standard-keybindings)
            ;; comment this out if you don't have or don't use helm
            (setq rtags-use-helm t)
            ;; company completion setup
            (setq rtags-autostart-diagnostics t)
            (rtags-diagnostics)
            (setq rtags-completions-enabled t)
            (push 'company-rtags company-backends)
                                        ;	  (global-company-mode)
            (define-key c-mode-base-map (kbd "<C-tab>") (function company-complete))
            ;; use rtags flycheck mode -- clang warnings shown inline
            (require 'flycheck-rtags)
            ;; c-mode-common-hook is also called by c++-mode
                                        ;	(add-hook 'c++-mode-hook #'setup-flycheck-rtags)

            ;; c config
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
            )

          (when (require 'rtags nil :noerror)
            ;; make sure you have company-mode installed
            (require 'company)
            (define-key c-mode-map (kbd "M-.")
              (function rtags-find-symbol-at-point))
            (define-key c-mode-map (kbd "M-,")
              (function rtags-location-stack-back))

            ;; disable prelude's use of C-c r, as this is the rtags keyboard prefix
            ;; (define-key prelude-mode-map (kbd "C-c r") nil)
            ;; install standard rtags keybindings. Do M-. on the symbol below to
            ;; jump to definition and see the keybindings.
            (rtags-enable-standard-keybindings)
            ;; comment this out if you don't have or don't use helm
            (setq rtags-use-helm t)
            ;; company completion setup
            (setq rtags-autostart-diagnostics t)
            (rtags-diagnostics)
            (setq rtags-completions-enabled t)
            (push 'company-rtags company-backends)
                                        ;	  (global-company-mode)
            (define-key c-mode-base-map (kbd "<C-tab>") (function company-complete))
            ;; use rtags flycheck mode -- clang warnings shown inline
            (require 'flycheck-rtags)
            ;; c-mode-common-hook is also called by c++-mode
                                        ;	(add-hook 'c++-mode-hook #'setup-flycheck-rtags)
            )



          )

(use-package company-rtags
:ensure t)

(use-package helm-rtags
:ensure t)

(defun vxe:redownload-rtags ()
(interactive)
(with-temp-buffer
(cd "~/.emacs.d/opt")
(async-shell-command (concat
                      "rm -rf rtags;"
                      "git clone --recursive https://github.com/Andersbakken/rtags.git")
                     (concat "*RTags Install*"))))


(defun vxe:rebuild-rtags ()
(interactive)
(with-temp-buffer
  (cd "~/.emacs.d/opt/rtags")
  (async-shell-command (concat
                        "cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1 .;"
                        "make;"
                        "sudo make install")
                       (concat "*RTags Compile*"))))


(defun vxe:start-rtags-daemon ()
(interactive)
(with-temp-buffer
(async-shell-command "~/.emacs.d/opt/rtags/bin/rdm &")
))

(defun vxe:clear-rtags-cache ()
(interactive)
(async-shell-command "rm -rf ~/.cache/rtags")
)

(defun vxe:rtags-index-project ()
(interactive)
(with-temp-buffer
(async-shell-command "rc -J .")))

(defun use-rtags (&optional useFileManager)
  (and (rtags-executable-find "rc")
       (cond ((not (gtags-get-rootpath)) t)
             ((and (not (eq major-mode 'c++-mode))
                   (not (eq major-mode 'c-mode))) (rtags-has-filemanager))
             (useFileManager (rtags-has-filemanager))
             (t (rtags-is-indexed)))))

(defun tags-find-symbol-at-point (&optional prefix)
  (interactive "P")
  (if (and (not (rtags-find-symbol-at-point prefix)) rtags-last-request-not-indexed)
      (gtags-find-tag)))
(defun tags-find-references-at-point (&optional prefix)
  (interactive "P")
  (if (and (not (rtags-find-references-at-point prefix)) rtags-last-request-not-indexed)
      (gtags-find-rtag)))
(defun tags-find-symbol ()
  (interactive)
  (call-interactively (if (use-rtags) 'rtags-find-symbol 'gtags-find-symbol)))
(defun tags-find-references ()
  (interactive)
  (call-interactively (if (use-rtags) 'rtags-find-references 'gtags-find-rtag)))
(defun tags-find-file ()
  (interactive)
  (call-interactively (if (use-rtags t) 'rtags-find-file 'gtags-find-file)))
(defun tags-imenu ()
  (interactive)
  (call-interactively (if (use-rtags t) 'rtags-imenu 'idomenu)))

;; (define-key c-mode-base-map (kbd "M-.") (function tags-find-symbol-at-point))
;; (define-key c-mode-base-map (kbd "M-,") (function tags-find-references-at-point))
;; ;(define-key c-mode-base-map (kbd "M-;") (function tags-find-file))
;; (define-key c-mode-base-map (kbd "C-.") (function tags-find-symbol))
;; (define-key c-mode-base-map (kbd "C-,") (function tags-find-references))
;; (define-key c-mode-base-map (kbd "C-<") (function rtags-find-virtuals-at-point))
;; (define-key c-mode-base-map (kbd "M-i") (function tags-imenu))

;; (define-key global-map (kbd "M-.") (function tags-find-symbol-at-point))
;; (define-key global-map (kbd "M-,") (function tags-find-references-at-point))
;; ;(define-key global-map (kbd "M-;") (function tags-find-file))
;; (define-key global-map (kbd "C-.") (function tags-find-symbol))
;; (define-key global-map (kbd "C-,") (function tags-find-references))
;; (define-key global-map (kbd "C-<") (function rtags-find-virtuals-at-point))
;; (define-key global-map (kbd "M-i") (function tags-imenu))

(use-package ac-rtags
:ensure t
)

(use-package flycheck-rtags
:ensure t
)

(use-package helm-rtags
:ensure t
)

(defun c++-mode-indent-hook ()
  (setq c-basic-offset 4)
  (c-set-offset 'substatement-open 0))
(add-hook 'c++-mode-hook 'c++-mode-indent-hook)

;; (cond ((not (file-exists-p "~/go"))
;;        (shell-command (concat "cd ~/;"
;;                               "git clone https://github.com/vxe/.go.git go"))))

;(load-file "~/.emacs.d/site-lisp/go-autocomplete.el")
(use-package go-mode
  :ensure t
  :init
                                    ;    (require 'go-mode)
  (when (memq window-system '(mac ns))
    (exec-path-from-shell-initialize)
    (exec-path-from-shell-copy-env "GOPATH"))

  ;; (cond
  ;;  ((not (file-exists-p "~/go/bin/gocode"))
  ;;   (setenv "GOPATH" (concat (getenv "HOME") "/go") )        
  ;;   (shell-command "go get  -u github.com/nsf/gocode")))




  :config
(cond
 ((not (file-exists-p "~/.emacs.d/lib/company-go.el")) (shell-command "cd ~/.emacs.d/lib; wget https://raw.githubusercontent.com/nsf/gocode/master/emacs-company/company-go.el")))

  (setq gofmt-command "$HOME/go/bin/goimports")
  (defun vxe-go-mode-hook ()
    ;; https://gist.github.com/samertm/8bccfeb30c0902194de5
    ;; UPDATE: I commented the next line out because it isn't needed
    ;; with the gofmt-before-save hook above.
    ;; (local-set-key (kbd "C-c m") 'gofmt)
    (local-set-key (kbd "M-.") 'godef-jump)
    (local-set-key (kbd "M-,") 'pop-tag-mark)
    (local-set-key (kbd "C-x 5") 'vxe-helm-yas-complete)
    (set (make-local-variable 'company-backends) '(company-go))
    )






  ;; (add-hook 'before-save-hook 'gofmt-before-save)
  (add-hook 'go-mode-hook 'vxe-go-mode-hook)
  (add-hook 'go-mode-hook 'go-eldoc-setup)
  (add-hook 'go-mode-hook 'linum-mode)
  (add-hook 'go-mode-hook 'company-mode)


  (setq company-tooltip-limit 20)	; bigger popup window
  (setq company-idle-delay .3) ; decrease delay before autocompletion popup shows
  (setq company-echo-delay 0)  ; remove annoying blinking
  (setq company-begin-commands '(self-insert-command)) ; start autocompletion only after typing

  (require 'go-mode)
  (define-key go-mode-map (kbd "C-k") 'sp-kill-hybrid-sexp)
  (add-hook 'go-mode-hook #'smartparens-mode))

(use-package go-eldoc
:ensure t
:init)

(use-package go-dlv
:ensure t)

(defun gore-install ()
  (interactive)
  (async-shell-command (concat "go get -u github.com/motemen/gore")
                       (concat "*gore* - instaling")))

(use-package gorepl-mode
:ensure t )

(defun install-custom-ob-go ()
  (interactive)
  (shell-command (concat
                  "cd ~/.emacs.d/lib;"
                  "rm -rf ob-go;"
                  "git clone https://github.com/vxe/ob-go.git;"
                  ))
  (cond ((file-exists-p "~/.emacs.d/lib/ob-go")
         (add-to-list 'load-path "~/.emacs.d/lib/ob-go")
         (require 'ob-go))))

(defun go-get (package)
  (interactive "spackage: ")
  (async-shell-command (concat "go get -v -u "
                               package
                               )
                       (concat "*Go* - get: " package)))

(use-package erlang
:ensure t
:init
(exec-path-from-shell-copy-env "TERM") ;; run-lfe unless TERM is set to something other than https://github.com/rvirding/lfe/issues/156
)

(use-package edts
  :ensure t
  :init
  (require 'edts)
  (require 'edts-start)
  (define-key edts-mode-map (kbd "C-k") 'sp-kill-hybrid-sexp)
  (add-hook 'edts-mode-hook #'smartparens-mode)
  (add-hook 'edts-mode-hook #'auto-complete-mode)
  (add-hook 'edts-shell-mode-hook #'smartparens-mode)
  (add-hook 'edts-shell-mode-hook #'auto-complete-mode))

(add-hook 'erlang-mode-hook #'smartparens-mode)
(add-hook 'erlang-shell-mode-hook #'smartparens-mode)

(add-hook 'erlang-mode-hook #'linum-mode)

(defun rebar3:install ()
  (interactive)
  (async-shell-command (concat "cd ~/.emacs.d/bin; wget https://s3.amazonaws.com/rebar3/rebar3 && chmod +x rebar3")
                       (concat "*rebar3* - install")))

(defun rebar3:update ()
  (interactive)
  (async-shell-command (concat "rebar3 update")
                       (concat "*rebar3* - updating")))

(defun rebar3:new-project (name)
  (interactive "sapp-name: ")
  (async-shell-command (concat "rebar3 new release " name)
                       (concat "*rebar3* - new app: " name)))

(defun rebar3:compile ()
  (interactive)
  (async-shell-command (concat "rebar3 compile")
                       (concat "*rebar3* - compile")))

(defun npm:install (package)
(interactive "spackage: ")
(async-shell-command (concat "npm install " package)
                     (concat "*npm* - installing: " package)))

(defun npm:install-globally (package)
(interactive "spackage: ")
(async-shell-command (concat "npm install -g " package)
                     (concat "*npm* - installing - " package)))

(defun npm:install-yeoman ()
(interactive)
(async-shell-command "sudo npm install -g yo")
)

(defun yo:install-react-fullstack ()
(interactive)
(async-shell-command "sudo npm install -g generator-react-fullstack")
)

(use-package nvm
  :ensure t
  :init
  (defcustom vxe/node-version nil "Set node binary version"))

(defun vxe:download-tern ()
(interactive)
(async-shell-command "cd ~/.emacs.d/lib; git clone https://github.com/ternjs/tern.git; cd tern; npm init"))

(defun vxe:load-tern ()
  (interactive)
  (load-file "~/.emacs.d/lib/tern/emacs/tern.el")
  (load-file "~/.emacs.d/lib/tern/emacs/tern-auto-complete.el"))

(if (file-exists-p "~/.emacs.d/lib/tern/emacs/tern.el")
    (vxe:load-tern)
  (progn
    (vxe:download-tern)
    (message "run (vxe:load-tern)")
    (kill-new "(vxe:load-tern)")))

(defun tern-kill-server ()
  (interactive)
  (async-shell-command (concat "ps -eaf | grep '[t]ern' | awk '{print $2}' | xargs kill -9")
                       (concat "*tern* - killing server...")))

(defun tern-restart ()
  (interactive)
  (tern-kill-server)
  (tern-mode)
  (tern-mode))



;; (use-package company-tern
;;   :ensure t
;;   :init
;;   (require 'company-tern)
;;   (add-to-list 'company-backends 'company-tern))

(use-package indium
:ensure t)

(add-hook 'indium-repl-mode-hook #'smartparens-mode)

(use-package nodejs-repl
:ensure t
:init
(add-hook 'js-mode-hook
        (lambda ()
          (define-key js-mode-map (kbd "C-x C-e") 'nodejs-repl-send-last-expression)
          (define-key js-mode-map (kbd "C-c C-j") 'nodejs-repl-send-line)
          (define-key js-mode-map (kbd "C-c C-c") 'nodejs-repl-send-buffer)
          (define-key js-mode-map (kbd "C-c C-r") 'nodejs-repl-send-region)
          (define-key js-mode-map (kbd "C-c C-l") 'nodejs-repl-load-file)
          (define-key js-mode-map (kbd "C-c C-z") 'nodejs-repl-switch-to-repl))))

(use-package skewer-mode
:ensure t )

(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

(add-hook 'js2-mode-hook (lambda ()
                           (tern-mode)
                           (tern-ac-setup)
                           (auto-complete-mode)
                           (smartparens-mode)
                           (linum-mode)
                                        ;(sp-use-smartparens-bindings)
                           (indium-interaction-mode)))

(define-key js2-mode-map (kbd "C-k") 'sp-kill-hybrid-sexp)

(add-to-list 'semantic-inhibit-functions
             (lambda () (member major-mode '(js2-mode))))

(defun react:install-locally ()
  (interactive)
  (async-shell-command (concat "npm init;"
                               "npm install --save react react-dom")
                       (concat "*react* installing")))

(defun react:install-babel-locally ()
  (interactive)
  (async-shell-command (concat "npm init;"
                               "npm install --save-dev babel-core")
                       (concat "*react* installing babel")))

(defun react:install-build-tool ()
    (interactive)
    (npm:install-globally "create-react-app"))

(defun react:new-app (name)
  (interactive "sname")
  (async-shell-command (concat "create-react-app "
                               name)
                       (concat "*react* - creating project - " name))
  (find-file name))

(defun react:build-app ()
  (interactive)
  (async-shell-command (concat "npm run build"
                               (concat "*react* - building project - "))))

(define-skeleton babel:preset-skeleton
  "dat babel init"
  nil
  "{ \n"
  "  \"presets\" : [\"env\",\"react\"]  \n"
  "\n"
  "}")

(defun babel:generate-babelrc ()
  (interactive)
  (save-excursion
    ;;
    (progn
      (find-file ".babelrc")
      (insert (babelrc-skeleton)))))

(define-skeleton react:index-js-skeleton
  "a basic react index.html" nil
  "import React from 'react';\n"
  "import ReactDOM from 'react-dom';\n"
  "\n"
  "ReactDOM.render(\n"
  " <h1>Hello, world!</h1>, \n"
  "document.getElementById('root')\n"
  ");")

  (defun react:generate-index-js ()
    (interactive)
    (save-excursion
      ;;
      (progn
        (shell-command "mkdir -p ./index.js"
        (find-file "./src/index.htm")
        (insert (react:html-index-html-skeleton))))))

(define-skeleton react:html-index-html-skeleton
  "an example index.html for start a react project"
  "<!DOCTYPE html> \n"
  "<html> \n"
  " <head> \n"
  " <meta charset=\"UTF-8\"> \n"
  " <title>" _ "</title> \n"
  " </head> \n"
  "<body>\n"
  "<div id=\"root\"></div>\n"
  " </body> \n"
  "</html>"
  "\n"
  '(indent-region (point-min) (point-max)))

  (defun react:generate-index-html ()
    (interactive)
    (save-excursion
      ;;
      (progn
        (shell-command "mkdir -p ./public"
        (find-file "./public/index.html")
        (insert (react:html-index-html-skeleton))))))

(defun re-natal:install ()
  (interactive)
  (npm:install-globally "re-natal"))

(defun re-natal:new-app (app-name)
  (interactive "sapp-name")
  (async-shell-command (concat "re-natal init " app-name)
                       (concat "*re-natal* - creating new app: " app-name)))

(setq tern-config
      (json-ht-read "{\"plugins\": {\"node\": {},\"es_modules\": {}}}"))

(defun pip:install-in-virtualenv (package)
(interactive "spackage: ")
(async-shell-command (concat "cd ~/.emacs.d/var; virtualenv " package "; source ~/.emacs.d/var/" package "/bin/activate; pip install --upgrade pip; pip install " package) (concat "*pip install*" " - " package))

)

(defun pip3:install-in-virtualenv (package)
(interactive "spackage: ")
(async-shell-command (concat "cd ~/.emacs.d/var; python3 -m venv " package "; source ~/.emacs.d/var/" package "/bin/activate; pip3 install --upgrade pip; pip3 install " package)))

(defun pip:install (package)
(interactive "spackage: ")
(async-shell-command (concat "pip install --upgrade pip; pip install " package)))

(defun pip:install-in-virtualenv (package)
  (interactive "spackage: ")
  (let ((virtualenv (completing-read "env:" (split-string
                                             (s-chomp "find ~/.emacs.d/var -maxdepth 1 -type d -print0 | xargs -0 basename | grep -Ev '^#|^[.]'")
                                           "\n"))))
    (async-shell-command (concat "source ~/.emacs.d/var/" virtualenv "/bin/activate; pip install --upgrade pip; pip install " package))))

(defun pip:install-in-current-virtualenv (package)
  (interactive "spackage: ")
  (if (eq nil venv-current-name)
      (progn
        (message "no venv selected, choose one and call this function again")
        (venv-workon))
    (async-shell-command (concat
                          "source ~/.emacs.d/var/" venv-current-name "/bin/activate;"
                          "pip install --upgrade pip;"
                          "pip install " package)
                         (concat "*pip install* - " package))))

;; (defun pip3:install-in-current-virtualenv (package)
;;   (interactive "spackage: ")
;;   (let ((virtualenv (completing-read "env:" (split-string
;;                                            (s-chomp "find ~/.emacs.d/var -maxdepth 1 -type d -print0 | xargs -0 basename | grep -Ev '^#|^[.]'")
;;                                            "\n"))))
;;     (async-shell-command (concat "source ~/.emacs.d/var/" virtualenv "/bin/activate; pip3 install --upgrade pip; pip3 install " package))))

(defun python:create-virtualenv (name)
  (interactive "svirtualenv name: ")
  (async-shell-command (concat "cd ~/.emacs.d/var/ ; virtualenv "
                               name
                               "; cd ~/.emacs.d/var/"
                               name
                               "/bin; chmod a+x activate; ./activate; pip install --upgrade pip; cd ~/.python.d; pip install -r requirements.txt")
                       (concat "*Python* - creating virtualenv - " name))
  (geeknote:install-in-venv))

(defun python-install-bidict ()
(interactive)
(pip:install-in-virtualenv "bidict")
)

(use-package pydoc
:ensure t)

(use-package pydoc-info
:ensure t)

(use-package helm-pydoc
:ensure t)

(defun helm-pydoc-at-point ()
  (interactive)
  (let ((symbol
	 (if (region-active-p)
	     (buffer-substring (region-beginning) (region-end))
	   (current-word))))
    (helm :sources '(helm-pydoc--imported-source helm-pydoc--installed-source)
	  :buffer "*helm pydoc*" :history 'helm-pydoc--history :input symbol)))

(add-hook 'python-mode-hook 'linum-mode)

(use-package virtualenvwrapper
:ensure t
:init
(require 'virtualenvwrapper)
(venv-initialize-interactive-shells) ;; if you want interactive shell support
(venv-initialize-eshell) ;; if you want eshell support
;; note that setting `venv-location` is not necessary if you
;; use the default location (`~/.virtualenvs`), or if the
;; the environment variable `WORKON_HOME` points to the right place
(shell-command "mkdir -p ~/.emacs.d/var")
(setq venv-location "~/.emacs.d/var")
(if (file-exists-p "~/.emacs.d/var/emacs/")
    (progn
      (venv-workon "emacs")
      (pythonic-activate "~/.emacs.d/var/emacs"))))

(defun virtualenv:create-specify-python-path (name path)
(interactive "svirtualenc name: \nfpython path")
(async-shell-command (concat "cd ~/.emacs.d/var; virtualenv --python=" path " " name)))

(defun virtualenv:create-2-7-13-osx (name)
(interactive "svirtualenv name: ")
(async-shell-command (concat "cd ~/.emacs.d/var; virtualenv --python=/usr/local/Cellar/python/2.7.13/bin/python " name))
)

(defun virtualenv:create-python3 (name)
(interactive "sname: ")
(async-shell-command (concat "cd ~/.emacs.d/var; /usr/local/Cellar/python3/3.5.2/bin/pip3 --upgrade pip ; /usr/local/Cellar/python3/3.5.2/bin/python3 -m venv " name)))

(use-package anaconda-mode
 :ensure t
 :init
 (require 'anaconda-mode)
 (add-hook 'python-mode-hook 'anaconda-mode)
(define-key anaconda-mode-map (kbd "M-,") nil)
 (define-key anaconda-mode-map (kbd "M-*") nil)
 (define-key anaconda-mode-map (kbd "M-,") 'anaconda-mode-go-back)
 (define-key anaconda-mode-map (kbd "M-*") 'anaconda-find-assignments))

    (use-package company-anaconda
    :ensure t
    :init
    (eval-after-load "company"
        '(add-to-list 'company-backends 'company-anaconda)))

(define-key inferior-python-mode-map (kbd "C-c C-k") 'helm-pydoc-at-point)

(defun python-describe-symbol ()
  (interactive)
  (fset 'python-help
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ("help(\346\342" 0 "%d")) arg)))
  (python-help))

(define-key inferior-python-mode-map (kbd "C-c C-d") 'nil)
(define-key inferior-python-mode-map (kbd "C-c C-d") 'python-describe-symbol)

;; (add-hook 'inferior-python-mode-hook
   ;;   (lambda ()
   ;;     (setq
   ;;       indent-tabs-mode nil ;; i.e. indent with spaces
   ;;       tab-width 4          ;; i.e. tabs consts of 4 spaces
   ;;       )))


(defun send-input-and-indent ()
  (interactive)
  (comint-send-input)
  (indent-for-tab-command))

(define-key inferior-python-mode-map (kbd "C-j") 'send-input-and-indent)

(add-hook 'inferior-python-mode-hook #'smartparens-mode)

(add-hook 'inferior-python-mode-hook #'anaconda-mode)

(defun scimax:install-python-org-babel-extensions ()
  (interactive)
  (shell-command "cd ~/.emacs.d/lib; wget 'https://raw.githubusercontent.com/jkitchin/scimax/master/scimax-org-babel-python.el'"))

;; (cond ((not (file-exists-p "~/.emacs.d/site-lisp/scimax-org-babel-python.el"))
;;               (scimax:install-python-org-babel-extensions)))

;; (load-file "~/.emacs.d/site-lisp/scimax-org-babel-python.el")

;; (add-to-list 'org-ctrl-c-ctrl-c-hook 'org-babel-async-execute:python)

(use-package ein
:ensure t
:init
(setq ein:use-auto-complete t)
)

(defun jupyter:start-notebook-server ()
(interactive)
(async-shell-command "jupyter notebook")
)

(defun jupyter:open-notebook (path)
  (interactive "D notebook location: ")
  (with-temp-buffer
    (cd path)
    (jupyter:start-notebook-server)))

(use-package traad
:ensure t
:init
(require 'traad)
  (add-hook 'python-mode-hook
          (lambda ()
            (define-key python-mode-map (kbd "C-c r") 'traad-rename))))

(use-package elpy
:ensure t
:init
(require 'elpy))

(use-package robe
  :ensure t
  :init
  (add-hook 'robe-mode-hook 'ac-robe-setup))

(use-package inf-ruby
    :ensure t
:init
    (add-hook 'inf-ruby-mode-hook 'robe-mode)
    (add-hook 'inf-ruby-mode-hook 'ac-robe-setup))

(use-package enh-ruby-mode
  :ensure t
  :init
  (add-hook 'enh-ruby-mode-hook 'robe-mode)
  (add-hook 'enh-ruby-mode-hook 'auto-complete-mode)
  (add-hook 'enh-ruby-mode-hook 'ac-robe-setup)
  (add-hook 'enh-ruby-mode-hook 'smartparens-mode)
  (add-hook 'enh-ruby-mode-hook 'rainbow-mode)
  (add-hook 'enh-ruby-mode-hook 'yard-mode)
  (add-to-list 'auto-mode-alist
             '("\\(?:\\.rb\\|ru\\|rake\\|thor\\|jbuilder\\|gemspec\\|podspec\\|/\\(?:Gem\\|Rake\\|Cap\\|Thor\\|Vagrant\\|Guard\\|Pod\\)file\\)\\'" . enh-ruby-mode))
  )

(cond ((not (file-exists-p "~/.emacs.d/lib/ob-go"))
       (install-custom-ob-go)))

(defun cpan:install-local::lib ()
(interactive)
(async-shell-command  (concat "curl -L http://cpanmin.us | perl - App::cpanminus; cpanm --local-lib=~/.emacs.d/perl5 local::lib && eval $(perl -I ~/.emacs.d/perl5/lib/perl5/ -Mlocal::lib)")
                      (conct "*cpan* installing local::lib")))

(defun cpan:install-package (name)
(interactive "spackage: ")
(async-shell-command (concat "cpanm --local-lib=~/.emacs.d/perl5 local::lib && eval $(perl -I ~/.emacs.d/perl5/lib/perl5/ -Mlocal::lib); curl -L http://cpanmin.us | perl - " name)
                     (concat "*cpan* - installing: " name)))

(use-package ess
:ensure t
:init
(add-hook 'inferior-ess-mode-hook 'smartparens-mode))

(use-package ediprolog
:ensure t)

(use-package ob-prolog
:ensure t)

(add-hook 'inferior-prolog-mode-hook #'smartparens-mode)

(use-package groovy-mode
  :ensure t
  :init
  (require 'groovy-mode)
  (define-key groovy-mode-map (kbd "C-k") 'sp-kill-hybrid-sexp)
  (add-hook 'groovy-mode-hook #'smartparens-mode))

(add-hook 'groovy-mode-hook #'linum-mode)

(use-package mixal-mode
:ensure t
:init
(setq vxe-mdk-version "1.2.9")
:config
(defun vxe-download-mdk ()
  (interactive)
  (cond
   ((not (file-exists-p (concat "~/.emacs.d/opt/mdk-" vxe-mdk-version))) (async-shell-command (concat "cd ~/.emacs.d/opt ; wget https://mirrors.ocf.berkeley.edu/gnu/mdk/v" vxe-mdk-version "/mdk-" vxe-mdk-version ".tar.gz; tar xvf mdk-" vxe-mdk-version ".tar.gz ; rm -rf *.gz; mv ~/.emacs.d/opt/mdk-" vxe-mdk-version " ~/.emacs.d/opt/mdk" )))))
)

(use-package tex
  :defer t
  :ensure auctex
  :config
  (setq TeX-auto-save t))

(use-package helm-bibtex
  :ensure t
  :init
  (setq bibtex-completion-bibliography
        '("~/Documents/bibtex/master.bib"))
  (setq bibtex-completion-library-path '("~/Dropbox/pdfs"))
  ;;Bibtex-completion assumes that the name of a PDF consists of the
  ;; BibTeX key followed plus a user-defined suffix (.pdf by default).
  ;; For example, if a BibTeX entry has the key Darwin1859,
  ;; bibtex-completion searches for Darwin1859.pdf.
  )

(use-package org-ref
  :ensure t)

(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init
  (require 'markdown-mode)
  (setq markdown-command "~/.emacs.d/bin/flavor.rb")
  (add-hook 'markdown-mode-hook #'flyspell-mode)
  (add-hook 'markdown-mode-hook #'auto-fill-mode)
  (define-key markdown-mode-map (kbd "C-c C-c") 'server-edit))

(use-package tagedit
:ensure t
)

(eval-after-load 'sgml-mode
  '(progn
     (require 'tagedit)
     (tagedit-add-paredit-like-keybindings)
     (tagedit-add-experimental-features)
     (add-hook 'sgml-mode-hook (lambda () (tagedit-mode 1)))))

(use-package tagedit
:ensure t)

(add-hook 'sgml-mode-hook #'emmet-mode)

(defun download-html5-tidy ()
  (interactive)
  (shell-command "cd ~/.emacs.d/opt; git clone https://github.com/htacg/tidy-html5.git"))

(defun build-html5-tidy ()
  (interactive)
  (async-shell-command "cd ~/.emacs.d/opt/tidy-html5/build/cmake; cmake ../.. -DCMAKE_BUILD_TYPE=Release -DCMAKE_EXPORT_COMPILE_COMMANDS=1 && make && sudo make install"))

(define-key sgml-mode-map (kbd "C-c C-v") 'sgml-validate)

(use-package elnode
:ensure t
)

(defun init-h5bp-project-cwd ()
  (interactive)
  (async-shell-command "mv index.html index.html.orig;wget https://github.com/h5bp/html5-boilerplate/releases/download/5.3.0/html5-boilerplate_v5.3.0.zip -O out.zip; unzip out.zip"))

(defun init-h5bp-project-in-project ()
  (interactive)
  (async-shell-command "cd ./resources/public;mv index.html index.html.orig;wget https://github.com/h5bp/html5-boilerplate/releases/download/5.3.0/html5-boilerplate_v5.3.0.zip -O out.zip; unzip out.zip; rm index.html; mv index.html.orig index.html"))

(add-hook 'html-mode-hook #'sgml-mode)

(add-to-list 'auto-mode-alist '("\\.html\\'" . sgml-mode))

(use-package emmet-mode
:ensure t)

(add-hook 'css-mode-hook #'emmet-mode)

(use-package rainbow-mode
:ensure t
:init
(add-hook 'css-mode-hook #'rainbow-mode)
)

(add-hook 'css-mode-hook #'smartparens-mode)
(define-key css-mode-map (kbd "C-k") 'sp-kill-hybrid-sexp)

(use-package web-mode
:ensure t
:init
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode)))

(use-package json-mode
  :ensure t
  :init
  (require 'json-mode)
  (setq jsons-path-printer 'jsons-print-path-jq)
  ;; json
  (define-key json-mode-map (kbd "C-k") 'sp-kill-hybrid-sexp)
  (add-hook 'json-mode-hook #'smartparens-mode)
  (add-hook 'json-mode-hook #'linum-mode)
  )

(defun json-mode-path-kill ()
  (interactive)
    (kill-new (jsons-print-path)))

(define-key json-mode-map (kbd "C-c P") 'json-mode-path-kill)

(use-package flymake-json
:ensure t
:init
(add-hook 'json-mode 'flymake-json-load))

(defun parson:install ()
(interactive)
    (async-shell-command (concat
                          "cd ~/.emacs.d/lib;"
                          "git clone https://github.com/syohex/emacs-parson.git;"
                          "cd emacs-parson;"
                          "make;"
                          )
                         (concat "*parson* install")))

  (cond ((file-exists-p "~/.emacs.d/lib/emacs-parson")
         (add-to-list 'load-path "~/.emacs.d/lib/emacs-parson/")
         (require 'parson)))

(use-package csv
:ensure t)

(use-package yaml-mode
:ensure t)

(defun yaml:install-libyaml ()
  (interactive)
  (async-shell-command (concat
                        "cd ~/.emacs.d/lib;"
                        "git clone https://github.com/syohex/emacs-libyaml.git;"
                        "cd emacs-libyaml;"
                        "make;"
                        )
                       (concat "*libyaml* install")))

(cond ((file-exists-p "~/.emacs.d/lib/emacs-libyaml")
       (add-to-list 'load-path "~/.emacs.d/lib/emacs-libyaml/")
       (require 'libyaml)))

(defun install-h5bp ()
         (interactive)
         (async-shell-command (concat "mkdir -p tmp; cd tmp;"
                                      "wget https://github.com/h5bp/html5-boilerplate/releases/download/6.0.1/html5-boilerplate_v6.0.1.zip -O html5bp.tar.gz;"
                                      "tar xvf html5bp.tar.gz;"
                                      "rsync -avz --exclude '*.html' ./ .."
                                      )
                              (concat "*h5bp* - installing")))

(use-package edn
  :ensure t)

(keyboard-translate ?\C-q ?\C-x)
          (global-set-key (kbd "C-t") 'quoted-insert)
          (global-set-key (kbd "C-c") nil) ; hack to get rid non prefix errors
          (global-set-key (kbd "C-x x") 'helm-M-x)
          (global-set-key (kbd "C-x C-x") 'helm-M-x)
          (global-set-key (kbd "C-o") 'ace-window)
          (global-set-key (kbd "M-[") 'winner-undo)
          ;; (global-set-key (kbd "C-x 2") 'vxe-split-window-below)
          ;; (global-set-key (kbd "C-x 3") 'vxe-split-window-right)
;

                                                  ;(global-set-key (kbd "C-x C-[") 'winner-undo)

          (global-set-key (kbd "M-]") 'winner-redo)
                                                  ;(global-set-key (kbd "C-x C-]") 'winner-redo)
          (global-set-key (kbd "C-c v") 'org-capture)
          (global-set-key (kbd "C-c ]") 'org-remove-file)
          (global-set-key (kbd "C-c 9") 'vxe:nm-edit-queries)
          (global-set-key (kbd "C-c j") 'notmuch-company)
          (global-set-key (kbd "C-x 5") 'vxe-helm-yas-complete)
          (global-set-key (kbd "C-c k") 'yas-expand)
          (global-set-key (kbd "C-x 6") 'vxe-term-generic-ssh)
        ;  (global-set-key (kbd "C-x 6") 'vxe-search-projects)

          (global-set-key (kbd "C-)") 'paredit-forward-barf-sexp)
          (global-set-key (kbd "M-0") 'paredit-forward-barf-sexp)
          (global-set-key (kbd "M-9") 'paredit-backward-barf-sexp)
          (global-set-key (kbd "M-P") 'paredit-splice-sexp)
          (global-set-key (kbd "M-r") 'forward-whitespace)

          (global-set-key (kbd "M-;") 'comment-dwim)

          (global-set-key (kbd "C-x /") 'hydra-apps/body)
          (global-set-key (kbd "C-x C-/") 'hydra-apps/body)

          (global-set-key (kbd "C-x p") 'vxe-mt-shell-here)
          (global-set-key (kbd "C-x C-p") 'vxe-mt-shell-here)
          (global-set-key (kbd "C-x <f7>") 'isend-associate)

          (define-key org-mode-map (kbd "C-c C-w") 'org-refile)
  ;       
          (define-key org-mode-map (kbd "C-c C-w") 'org-refile)

          (define-key org-mode-map (kbd "C-x i") 'org-insert-link)
          (global-set-key (kbd "M-RET") 'org-meta-return)
          ;; (define-key org-mode-map (kbd "M-RET") 'org-insert-heading-respect-content)

          (define-key company-active-map (kbd "C-n") 'company-select-next-or-abort)
          (define-key company-active-map (kbd "C-p") 'company-select-previous-or-abort)


          (global-set-key (kbd "C-x g g") 'magit-status)
          (global-set-key (kbd "C-x v '") 'magit-diff)
          (global-set-key (kbd "C-x v i") 'magit-init)
          (global-set-key (kbd "C-x v b") 'magit-branch-and-checkout)
          (global-set-key (kbd "C-x v C") 'vc-rollback)
          (global-set-key (kbd "C-x v V") 'magit-checkout)
          (global-set-key (kbd "C-x v v") 'magit-stage-file)
          (global-set-key (kbd "C-x v c") 'magit-commit-popup)
          (global-set-key (kbd "C-x v p") 'magit-push-popup)
          (global-set-key (kbd "C-x v M") 'vc-merge)
          (global-set-key (kbd "C-x v m") 'magit-merge-popup)
          (global-set-key (kbd "C-x v f") 'magit-fetch-popup)
          (global-set-key (kbd "C-x v S") 'vc-create-tag)
          (global-set-key (kbd "C-x v s") 'magit-stash-popup)
          (global-set-key (kbd "C-x v R") 'vc-retrieve-tag)
          (global-set-key (kbd "C-x v r") 'magit-rebase-popup)

          (global-set-key (kbd "C-x m") 'notmuch-mua-new-mail)
          (global-set-key (kbd "C-x b") 'bookmark-jump)
          (global-set-key (kbd "C-c x") 'hydra-gtd/body)
          (global-set-key (kbd "C-c g") 'hydra-agenda/body)
    ;      (global-set-key (kbd "C-c g") 'org-todo-list)
          (global-set-key (kbd "C-c C-g") 'org-todo-list)
          (global-set-key (kbd "C-c Q") 'org-set-tags)
          (global-set-key (kbd "C-c G") 'org-todo)
          (global-set-key (kbd "M-y") 'helm-show-kill-ring)
          (global-set-key (kbd "M-o") 'vxe-shell-on-region)
          (define-key lispy-mode-map (kbd "M-o") 'nil)
          (define-key clojure-mode-map (kbd "M-o") 'vxe-shell-on-region)
          (global-set-key (kbd "C-x $") 'yas-new-snippet)
          (global-set-key (kbd "C-x b") 'bookmark-jump)
          (global-set-key (kbd "C-x 7") 'replace-regexp)


          ;(global-set-key (kbd "C-r") 'helm-swoop-without-pre-input)
          (global-set-key (kbd "C-S-R") 'helm-swoop)
          (global-set-key (kbd "C-S-s") 'helm-org-rifle-current-buffer)
          ;(global-set-key (kbd "C-s") 'helm-swoop-without-pre-input)
          (global-set-key (kbd "C-c G") 'org-tags-view)
        (global-set-key (kbd "C-c y") 'org-store-link)
        (global-set-key (kbd "M-O") 'revert-buffer)
        (global-set-key (kbd "C-c u") 'undo-tree-mode)
        (global-set-key (kbd "C-x \(") (lambda ()
                                         (interactive)
                                         (vxe-nm-inbox)))
        (global-set-key (kbd "<f5>") (lambda ()
                                       (interactive)
                                       (setq-local compilation-read-command nil)
                                       (call-interactively 'compile)))

        (global-set-key (kbd "M-+") 'text-scale-increase)
        (global-set-key (kbd "M-_") 'text-scale-decrease)
        ;(global-set-key (kbd "C-c C-r C-r") 'sre-radar-open-gui)
        (global-set-key (kbd "C-c C-r") 'sre-radar-open-gui)
        (global-set-key (kbd "C-x 9") 'sre-radar-open-gui)
        (global-set-key (kbd "C-c R") 'vxe:open-url)
        (global-set-key (kbd "C-c i") 'isend)
        (global-set-key (kbd "M-g p") 'vxe-search-projects)
        (global-set-key (kbd "M-g P") 'vxe-search-project-files)
        (global-set-key (kbd "C-x %") 'yas-reload-all)
        (global-set-key (kbd "C-M-w") 'ibuffer)
    ;    (global-set-key (kbd "C-c A") 'hydra-appt/body)
        (global-set-key (kbd "C-c a") 'calendar)
        (global-set-key (kbd "C-c A") 'org-agenda)
        (global-set-key (kbd "M-RET") 'org-meta-return)
        (global-set-key (kbd "C-c 6") 'org-sort)
        (global-set-key (kbd "C-c f") 'auto-fill-mode)
        (global-set-key (kbd "C-x O") 'occur)
        (global-set-key (kbd "C-c o") 'send-region-to-omnifocus)
        (global-set-key (kbd "C-c C-M-r") 'sre:gen-rdar-url)
        (global-set-key (kbd "C-x ^") 'vxe:shell-other-window)
        (global-set-key (kbd "M-s O") 'vxe:org-occur-in-agenda-files)
        (global-set-key (kbd "M-s o") 'vxe:occur)
        (global-set-key (kbd "C-|") 'set-input-method)
        (global-set-key (kbd "C-x C-i") 'endless/ispell-word-then-abbrev)
        (global-set-key (kbd "C-h u") 'helm-man-woman)
        (global-set-key (kbd "C-h D") 'my-dictionary-search)
        (global-set-key (kbd "C-h r") 'helm-regexp)

        (global-set-key (kbd "C-x \\") 'expand-abbrev)
        (global-set-key (kbd "C-x C-\\") 'expand-abbrev)
        (global-set-key (kbd "C-x '") 'vxe-term-toggle-mode)
        (global-set-key (kbd "C-x C-'") 'vxe-term-toggle-mode)
        (global-set-key (kbd "M-n") (kbd "C-u 1 C-v"))
        (global-set-key (kbd "M-p") (kbd "C-u 1 M-v"))
        (define-key pdf-view-mode-map (kbd "M-s o") 'pdf-occur)
        (define-key python-mode-map (kbd "C-C C-h") 'helm-pydoc-at-point)
        (define-key inferior-python-mode-map (kbd "C-C C-h") 'helm-pydoc-at-point)
        (define-key org-mode-map (kbd "M-.") 'org-open-at-point)
        (define-key org-mode-map (kbd "M-,") 'org-mark-ring-goto)

        (define-key org-mode-map (kbd "C-C C-t") 'org-show-todo-tree)
        (define-key emacs-lisp-mode-map (kbd "C-C C-c") 'eval-defun)
    (define-key emacs-lisp-mode-map (kbd "C-C C") 'eval-buffer)
    (define-key emacs-lisp-mode-map (kbd "M-.") 'elisp-def)

          (define-key slime-repl-mode-map (kbd "TAB") 'slime-fuzzy-complete-symbol)

(cond ((string= "0\n" (shell-command-to-string "which ag 2>&1  1>/dev/null; echo $?"))
         (global-set-key (kbd "M-g s") 'helm-projectile-ag)
         (global-set-key (kbd "M-g S") 'grep)
         (global-set-key (kbd "M-s G") 'ag)
         (define-key dired-mode-map (kbd "M-g") nil)
         (define-key dired-mode-map (kbd "e") 'imenu)
         (define-key dired-mode-map (kbd "P") 'dired-up-directory)
         (define-key dired-mode-map (kbd "M-g s") 'helm-projectile-ag))
        (t
         (global-set-key (kbd "M-g s") 'helm-projectile-grep)))

;; (cond ((not (eq 0 (shell-command "which ag")))
;;        (global-set-key (kbd "M-g s") 'helm-projectile-grep)
;;        (t
;; 	(global-set-key (kbd "M-g s") 'helm-projectile-ag)
;; 	(global-set-key (kbd "M-s G") 'ag)
;; 	(define-key dired-mode-map (kbd "M-g") nil)
;; 	(define-key dired-mode-map (kbd "M-g s") 'helm-projectile-ag))))



(global-set-key (kbd "M-g f") 'helm-projectile-find-file)

(global-set-key (kbd "C-x <f4>") 'helm-execute-kmacro) ; get list of macros
(global-set-key (kbd "C-x C-k N") 'insert-kbd-macro) ; get list of macros

(use-package which-key
:ensure t
:init
(require 'which-key)
(which-key-mode)
)

(use-package dired-imenu
:ensure t)

(add-hook 'nodejs-repl-mode-hook 'smartparens-mode)

(use-package hydra
:ensure t
:init
  (defhydra hydra-apps (:color green)
    "search"
    ("s" my-org-screenshot "screenshot")
    ("/" vxe-eww-inplace "eww")
    ("C-/" vxe-eww-inplace nil)
    ("?" vxe-eww nil)
    ("g" hydra-geeknote/body "geeknote" :exit t)
    ("c" quick-calc "calc")
    ("e" erc-tls "irc")
    ("v" vxe-emms-play-video "video")
    ("j" jabber-switch-to-roster-buffer "jabber")
    ("a" sx-search "stackoverflow")
    ("h" hackernews "HackerNews")
    ("i" hydra-lang/body "interpreters" :exit t)
    ("d" hydra-documentation/body "documentation" :exit t)
    ("w" wiki-summary "wikipedia")
    ("m" hydra-emms/body "music" :exit t)
    ("k" new-frame-kb "kb")
    ("r" elfeed "RSS")
    ("o" counsel-osx-app "osx")
    ("t" twit "Twitter")
    ("x" vxe:sx-search "Twitter")
    ("b" hydra-blog/body "Blog" :exit t)
    )

  (defhydra hydra-lang (:color blue)
    "interpreters"
    ("p" run-python "python")
    ("i" ielm "ielm")
    ("c" comint-run "comint")
    ("l" slime "lisp")
    ("g" run-geiser "scheme")
    ("e" run-erlang "erlang")
    ("E" run-lfe "lfe")
    ("o" run-prolog "prolog")
    ("t" run-gnuplot "gnuplot")
    )

)

(add-hook 'cider-repl-mode-hook #'paredit-mode)
(add-hook 'cider-repl-mode-hook #'lispy-mode)
(add-hook 'cider-repl-mode-hook #'goto-address-mode)
(add-hook 'cider-repl-mode-hook #'projectile-mode)
(add-hook 'cider-repl-mode-hook #'auto-complete-mode)
(add-hook 'cider-repl-mode-hook #'ac-cider-setup)
(add-hook 'cider-repl-mode-hook #'enable-paredit-mode)
(add-hook 'cider-repl-mode-hook #'yas-minor-mode)
(add-hook 'cider-repl-mode-hook #'rainbow-delimiters-mode)
(add-hook 'cider-repl-mode-hook #'show-paren-mode)
(add-hook 'cider-repl-mode-hook #'eldoc-mode)
(add-hook 'cider-mode-hook #'eldoc-mode)

(use-package elscreen
:ensure t 
:init
(elscreen-start))

(global-set-key (kbd "C-x C-e") 'eval-last-sexp)
(global-set-key (kbd "C-x e") 'imenu)

(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)

(use-package dired-du
:ensure t )

(use-package dired-k
:ensure t
:init
(require 'dired-k)
(define-key dired-mode-map (kbd "K") 'dired-k)

;; You can use dired-k alternative to revert-buffer
(define-key dired-mode-map (kbd "g") 'dired-k)

;; always execute dired-k when dired buffer is opened
(add-hook 'dired-initial-position-hook 'dired-k)

(add-hook 'dired-after-readin-hook #'dired-k-no-revert)
)

(define-key comint-mode-map (kbd "C-c b") 'comint-clear-buffer)

(add-hook 'org-mode-hook #'electric-pair-mode)

(defun new-emacs-instance ()
  (interactive)
  (async-shell-command "open -n -a /Applications/Emacs.app"))



(defun vxe-search-projects ()
  "search projects, add new dirs by updating ls command below"
  (interactive)
  (let ((query (completing-read "project: " (split-string
                                             (s-chomp (shell-command-to-string (concat "ls -l " vxe:project-path  "| awk '{print $9}'")))

                                             "\n"))))
                                      ;  (find-file (concat "~/opt/" query)))

    (with-temp-buffer
      (cd (concat "~/opt/" query))
      (helm-projectile-ag))))





(defun vxe-search-project-files ()
  "search projects, add new dirs by updating ls command below"
  (interactive)
  (let ((query (completing-read "project: " (split-string
                                             (s-chomp (shell-command-to-string (concat "ls -l " vxe:project-path  "| awk '{print $9}'")))
                                             "\n"))))
                                      ;  (find-file (concat "~/opt/" query)))

    (with-temp-buffer
      (cd (concat "~/opt/" query))
      (helm-projectile-find-file))))


(setq vxe:project-path "~/opt/")

(add-to-list 'load-path "~/.emacs.d/lib" t)
(require 'znc)

;; (define-key inferior-python-mode-map (kbd "C-c C-k") 'helm-pydoc-at-point)
(define-key inferior-python-mode-map (kbd "C-c D") 'python-describe-symbol)
(define-key inferior-python-mode-map (kbd "C-c C-d") 'python-eldoc-at-point)

(define-key indium-repl-mode-map (kbd "C-k") 'sp-kill-hybrid-sexp)

(use-package js2-refactor
  :ensure t
  :init
  (js2r-add-keybindings-with-prefix "C-c C-m"))
