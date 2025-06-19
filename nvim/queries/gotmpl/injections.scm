;; extends

((text) @injection.content
(#set! injection.language "html")
 (#set! injection.combined))

; ((node.script_tag) @injection.content
;  (#set! injection.language "javascript")
;  (#set! injection.combined))

; ((text) @injection.content @injection.language
;  (#match? @injection.language "<script[^>]*>")
;  (#gsub! @injection.language ".*<script[^>]*>.*" "javascript")
;  (#set! injection.combined))
