((org-mode . (
              ;;
              ;;; ox-hugo dirs

              (org-hugo-base-dir . "../../")
              (org-hugo-section . "notes")
              (org-hugo-default-static-subdirectory-for-externals . "_export")

              ;;
              ;;; ox-hugo tweaks

              (org-hugo-use-code-for-kbd . t)
              (org-hugo-date-format . "%Y-%m-%d")
              (org-hugo-paired-shortcodes . "note warning caution")
              (org-hugo-auto-set-lastmod . t)
              (org-hugo-suppress-lastmod-period . 86400.0)
              (eval . (org-hugo-auto-export-mode))

              ;;
              ;;; org tweaks

              (org-export-headline-levels . 5)
              (org-export-with-toc . nil)
              (org-use-sub-superscripts . '{})
              (org-export-with-sub-superscripts . '{})

              ;;
              ;;; treat mp4 and webm as image files, so that ox-hugo generates
              ;;; =figure= shortcodes for them

              (org-html-inline-image-rules . (("file" . "\\(?:\\.\\(?:gif\\|jp\\(?:e?g\\)\\|png\\|svg\\|webp\\|mp4\\|webm\\)\\)")
                                              ("http" . "\\(?:\\.\\(?:gif\\|jp\\(?:e?g\\)\\|png\\|svg\\|webp\\|mp4\\|webm\\)\\)")
                                              ("https" . "\\(?:\\.\\(?:gif\\|jp\\(?:e?g\\)\\|png\\|svg\\|webp\\|mp4\\|webm\\)\\)")))

              ;;
              ;;; custom org-link handlers

              (eval . (org-link-set-parameters
                       "codepen-embed"
                       :follow
                       (lambda (pen-id)
                         (browse-url (concat "https://codepen.io/unindented/pen/" pen-id)))
                       :export
                       (lambda (pen-id description backend)
                         (let* ((url (concat "https://codepen.io/unindented/pen/" pen-id))
                                (embed-url (format "https://codepen.io/unindented/embed/preview/%s?default-tab=result" pen-id))
                                (description-or-fallback (or description "Vimeo video")))
                           (cl-case backend
                             (md   (format
                                    "{{< codepen \"%s\" \"%s\" >}}"
                                    pen-id description-or-fallback))
                             (html (format
                                    "<iframe width=\"640\" height=\"360\" src=\"%s\" title=\"%s\"></iframe>"
                                    embed-url description-or-fallback))
                             (t    (url)))))))

              (eval . (org-link-set-parameters
                       "vimeo-embed"
                       :follow
                       (lambda (video-id)
                         (browse-url (concat "https://vimeo.com/" video-id)))
                       :export
                       (lambda (video-id description backend)
                         (let* ((url (concat "https://vimeo.com/" video-id))
                                (embed-url (format "https://player.vimeo.com/video/%s?dnt=1" video-id))
                                (description-or-fallback (or description "Vimeo video")))
                           (cl-case backend
                             (md   (format
                                    "{{< vimeo \"%s\" \"%s\" >}}"
                                    video-id description-or-fallback))
                             (html (format
                                    "<iframe width=\"640\" height=\"360\" src=\"%s\" title=\"%s\"></iframe>"
                                    embed-url description-or-fallback))
                             (t    (url)))))))

              (eval . (org-link-set-parameters
                       "youtube-embed"
                       :follow
                       (lambda (video-id)
                         (browse-url (concat "https://youtu.be/" video-id)))
                       :export
                       (lambda (video-id description backend)
                         (let* ((url (concat "https://youtu.be/" video-id))
                                (embed-url (format "https://www.youtube-nocookie.com/embed/%s" video-id))
                                (description-or-fallback (or description "YouTube video")))
                           (cl-case backend
                             ;; ox-hugo identifies itself as =md= for some reason
                             (md   (format
                                    "{{< youtube \"%s\" \"%s\" >}}"
                                    video-id description-or-fallback))
                             (html (format
                                    "<iframe width=\"640\" height=\"360\" src=\"%s\" title=\"%s\"></iframe>"
                                    embed-url description-or-fallback))
                             (t    (url)))))))

              ;;
              ;;; auto-commit

              (gac-automatically-push-p . t)
              (gac-automatically-add-new-files-p . t)
              (eval . (if (package-installed-p 'git-auto-commit-mode) (git-auto-commit-mode 1))))))
