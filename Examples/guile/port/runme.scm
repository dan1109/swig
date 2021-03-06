;; Call with standard output
(print-int (current-output-port) 314159)

;; Redirection to a file. Note that the port is automatically flushed
;; (via force-output) before calling the C function, and that the C
;; function gets a temporary "FILE" stream, which is closed after the
;; call. So you can simply mix Scheme and C output.
(with-output-to-file "test.out"
  (lambda ()
    (display 4711)
    (newline)
    (print-int (current-output-port) 314159)
    (display 815)
    (newline)))

;; Redirection to a string or soft port won't work --
;; we can only handle file ports.
(catch #t
       (lambda ()
	 (with-output-to-string
	   (lambda ()
	     (print-int (current-output-port) 314159))))
       (lambda args
	 (display "Attempting to write to a string or soft port will result in this error:")
	 (newline)
	 (write args) (newline)))

;; Read from a file port. Note that it is a bad idea to mix Scheme and
;; C input because of buffering.
(with-input-from-file "test.out"
  (lambda ()
    (display (read-int (current-input-port)))
    (newline)))

