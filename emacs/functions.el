(defun create-tmp-file ()
  "Save current buffer to a tmp file."
  (interactive)
  (with-current-buffer (current-buffer)
    (write-region (point-min) (point-max) "/tmp/emacstmp")))

(defun docker-stylish-haskell ()
  "Let a docker process run stylish-haskell on current buffer."
  (interactive)
  (with-current-buffer (current-buffer)
    (create-tmp-file)
    (shell-command
     "docker run --rm -v /tmp/emacstmp:/file.hs stylish-haskell > /tmp/stylish-haskell-out")
    (erase-buffer)
    (insert-file-contents "/tmp/stylish-haskell-out")
    ))

(defun clean-docker-stuff ()
  "Clean up docker ghci result"
  (interactive)
  (with-current-buffer (current-buffer)
    (replace-regexp "[^\t\n\r\f -~]" "")
   )
 )

(defun haskell-interactive-mode-expr-result (state response)
  "Print the result of evaluating the expression."
  (let ((response
         (with-temp-buffer
           (insert (haskell-interactive-mode-cleanup-response
                    (cl-caddr state) response))
           (haskell-interactive-mode-handle-h)
           (delete-trailing-whitespace)
           (kill-whole-line)
           (beginning-of-buffer)
           (kill-whole-line)
           (write-region (point-min) (point-max) "~/tmp/haskellrepl")
           (erase-buffer)
           (shell-command "tr -cd '[:print:]\n' < ~/tmp/haskellrepl | sed 's/\\[\\?1l>\\(.*\\)/\\1/'" t)
           (buffer-string)
           )))
    (message "Haskell response: %s" response)
    (when haskell-interactive-mode-eval-mode
      (unless (haskell-process-sent-stdin-p (cadr state))
        (haskell-interactive-mode-eval-as-mode (car state) response))))
  (haskell-interactive-mode-prompt (car state)))
