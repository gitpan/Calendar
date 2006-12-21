;; This is a function to create calendar date from emacs.
;; You can execute the function to create data file.
;; The script t/Calendar.t contain three comment line that create the
;; same data as this elisp function. You can copy them to a new file
;; and run the script, then compare the difference of the two calendar
;; system. I did it for 200 years since 1900, and no difference found.

(require 'calendar)
(require 'cal-china)

(defun ywb-create-cal-data (type start days &optional file)
  "Create date from TYPE, if the file is given, save to file
\"FILE-TYPE.txt\""
  (let ((start (calendar-absolute-from-gregorian start))
        (func (intern (format "calendar-%s-from-absolute" type))))
    (with-current-buffer (get-buffer-create "*cal*")
      (erase-buffer)
      (dotimes (i days)
        (insert (format "%d => %S\n" (+ start i)
                        (funcall func (+ start i)))))
      (if file
          (write-file (concat file "-" type ".txt"))
        (display-buffer (current-buffer))))))


(ywb-create-cal-data
 "gregorian"
 '(1 1 1900)
 (* 365 200)
 "cal")

(ywb-create-cal-data
 "julian"
 '(1 1 1900)
 (* 365 200)
 "cal")

(ywb-create-cal-data
 "chinese"
 '(1 1 1900)
 (* 365 200)
 "cal")
