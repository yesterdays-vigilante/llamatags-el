(defvar tag-file-names `("TAGS"))

(defun get-directory-up (dir)
  (string-match ".+/" (directory-file-name dir))
  (match-string 0 dir))

(defun tag-file-in-directory (dir)
  (let (ret)
    (dolist (file (directory-files dir))
      (if (member file tag-file-names)
          (setq ret (concatenate 'string dir file))))
    ret))
