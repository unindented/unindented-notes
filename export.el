#!/usr/bin/env sh
":"; exec emacs --no-window-system --quick --script "$0" -- "$@" # -*- mode: emacs-lisp; lexical-binding: t; -*-

(require 'package)

(setq package-user-dir (file-truename (concat default-directory ".packages")))
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(setq package-list '(org-roam ox-hugo))

(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

(dolist (package package-list)
  (require package))

;; Don't try this at home!
(setq enable-local-variables :all)

(setq user-full-name "Daniel Perez Alvarez"
      user-mail-address "daniel@unindented.org")

(setq org-directory default-directory)
(setq org-roam-directory default-directory)

(defun my/measure-execution-time (func &rest args)
  (let ((start-time (current-time)))
    (apply func args)
    (message "[debug] %s: %.3f seconds"
             (symbol-name func)
             (float-time (time-subtract (current-time) start-time)))))

(defun my/export-org-to-md (globs)
  (dolist (f (mapcan #'file-expand-wildcards globs))
    (with-current-buffer (find-file f)
      (org-hugo-export-wim-to-md))))

(defun my/append-backlinks (_backend)
  (when (org-roam-node-at-point)
    (goto-char (point-max))
    (let* ((backlinks (org-roam-backlinks-get (org-roam-node-at-point))))
      (when (> (length backlinks) 0)
        (insert "\n\n* Backlinks\n\n")
        (dolist (backlink backlinks)
          (let* ((source-node (org-roam-backlink-source-node backlink))
                 (node-file (org-roam-node-file source-node))
                 (file-name (file-name-nondirectory node-file))
                 (title (org-roam-node-title source-node)))
            (insert
             (format "- [[./%s][%s]]\n" file-name title))))))))

(add-hook 'org-export-before-processing-functions #'my/append-backlinks)

(my/measure-execution-time 'org-roam-db-sync)
(my/measure-execution-time 'my/export-org-to-md (or (cdr argv) '("*.org")))

(kill-emacs 0)
