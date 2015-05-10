;
; decode.scm
;

(use test s48-modules)
(include-relative "../decode.scm")

(test-begin "decode-tests")

;    /   f   r   e   q         ,  i         584
;  '(47 102 114 101 113 0 0 0 44 105 0 0 0 0 2 72)

(test "decode basic address"
      "/freq"
      (decode-address '(47 102 114 101 113 0 0 0 44 105 0 0 0 0 2 72)))

(test "decode longer address"
      "/freq/osc"
      (decode-address '(47 102 114 101 113 47 111 115 99 0 0 0 44 105 0 0 0 0 2 72)))

(test "decode single type"
      (list #\i)
      (decode-type '(47 102 114 101 113 0 0 0 44 105 0 0 0 0 2 72)))

(test "decode int and string"
      (list #\i #\s)
      (decode-type
        '(47 102 114 101 113 0 0 0 44 105 115 0 0 0 2 72 0 0 104 97 108 108 111 0 0 0)))

(test "decode int from normalized input"
      584
      (decode-int (list 0 0 2 72)))

(test "decode string from normalized input"
      "hallo"
      (decode-str (list 104 97 108 108 111 0 0 0)))

(test "decode float from normalized input"
      4.25
      (decode-float (list 64 136 0 0)))

(test "decode single message"
      (list 584)
      (decode-message (list 0 0 2 72) (list #\i)))

(test "decode multiple messages"
      (list "hallo" 4.25 584)
      (decode-message
        (list 104 97 108 108 111 0 0 0 64 136 0 0 0 0 2 72)
        (list #\s #\f #\i)))

(test "decode entire address and message"
      (list "/freq" 584)
      (decode-packet (list 47 102 114 101 113 0 0 0 44 105 0 0 0 0 2 72)))

(test-end "decode-tests")
