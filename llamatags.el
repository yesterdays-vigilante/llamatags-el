;; This variable should be altered or added to in order
;; to reflect tag file names used
(defvar tag-file-names `("TAGS"))

(defun directory-up (dir)
  (if (equal "/" dir)
      nil
    (progn
      (string-match ".*/" (directory-file-name dir))
      (match-string 0 dir))))

(defun directory-owner-uid (dir)
  (nth 2 (file-attributes dir 'integer)))

(defun tag-file-in-directory (dir)
  (let (ret)
    (dolist (file (directory-files dir))
      (if (member file tag-file-names)
          (setq ret (concatenate 'string (file-name-as-directory dir) file))))
    ret))

(defun add-or-create-tags-list (file)
  (if tags-table-list
      (if (not (member file tags-table-list))
          (add-to-list 'tags-table-list file)
        nil)

    (setq tags-table-list `(,file))))

;; This could probably be made more optimal by using iteration
;; (apparently elisp isn't tail call optimised!), but this way
;; reads nicer and hasn't posed any performance issues yet.
(defun tag-file-in-path (dir)
  (if (and dir (eq (directory-owner-uid dir) (user-real-uid)))
      (let ((tag-file (tag-file-in-directory dir)))
        (if tag-file
            tag-file
          (tag-file-in-path (directory-up dir))))
    nil))

(defun set-tags-file-from-path (dir)
  (interactive)
  (with-temp-message 
      "Searching for tags file..."
    (add-or-create-tags-list (tag-file-in-path dir))))

(defun set-tags-file-from-default ()
  (interactive)
  (if buffer-file-name
      (set-tags-file-from-path (file-name-directory buffer-file-name))
    nil))

(defun llamatags-init ()
  (add-hook 'find-file-hook 'set-tags-file-from-default))

(provide 'llamatags)
