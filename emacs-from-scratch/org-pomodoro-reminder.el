;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Play a reminder sound after pomodoro break finishes every minute ;;
;; to remind to start a new pomodoro				    ;;
;; 								    ;;
;; Author: James Brusey, 25/1/2024				    ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defvar org-pomodoro-reminder-timer nil
  "Timer to remind to start a new pomodoro after a break.")

(defun org-pomodoro-reminder-play-sound ()
  "Play sound every minute until the next pomodoro starts."
  (org-pomodoro-maybe-play-sound :overtime))

(defun org-pomodoro-reminder-start ()
  "Start reminding to start a new pomodoro after break."
  (when org-pomodoro-reminder-timer
    (cancel-timer org-pomodoro-reminder-timer))
  (setq org-pomodoro-reminder-timer (run-at-time t 60 'org-pomodoro-reminder-play-sound)))

(defun org-pomodoro-reminder-stop ()
  "Stop reminding to start a new pomodoro. Can be called interactively."
  (interactive)
  (when org-pomodoro-reminder-timer
    (cancel-timer org-pomodoro-reminder-timer)
    (setq org-pomodoro-reminder-timer nil)))

(add-hook 'org-pomodoro-break-finished-hook 'org-pomodoro-reminder-start)
(add-hook 'org-pomodoro-started-hook 'org-pomodoro-reminder-stop)
