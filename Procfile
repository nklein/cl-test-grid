web: ASDF_OUTPUT_TRANSLATIONS=/: ./sbcl/sbcl-1.0.54-x86-64-linux/run-sbcl.sh --load quicklisp/setup.lisp --eval "(ql:quickload :test-grid-server)" --eval "(tg-server:start (make-instance :port $PORT :smtp-password \"$SMTP_PASSWORD\"))" --eval "(loop (sleep 1000))"