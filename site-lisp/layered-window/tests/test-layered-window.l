;; --*- mode: lisp-interaction; package: user -*--

(super-require "layered-window" :use '(:layered-window.api :layered-window.editor))

(set-layered-window-attributes/alpha (get-window-handle) 240)
(set-layered-window-attributes/color (get-window-handle) '(255 255 255))

(get-layered-window-attributes/alpha (get-window-handle))
(get-layered-window-attributes/color (get-window-handle))


(set-window-ex-layered (get-window-handle) nil)
(window-ex-layered-p (get-window-handle))
t

(alpha->opacity 255)
100
(opacity->alpha 100)
255
(color->rgb #xff)
(255 0 0)
(rgb->color 255 0 0)
255
(coerce-to-color '(255 0 0))
255
(coerce-to-color 255)
255

(layered-window-api-version)
1

*layered-window-default-opacity*
80
*layered-window-hook*
layered-window.editor::layered-window-refresh

(layered-window-set-alpha 240)
1
(layered-window-set-opacity 90)
(layered-window-set-transparency-color 255 255 255)
(layered-window-set-transparency-color-bgr "FFFFFF")
1
(layered-window-set-opaque)

(layered-window-get-alpha)
nil
(layered-window-get-opacity)
nil
(layered-window-get-transparency-color)
nil

(toggle-layered-window)
(layered-window-p)

(layered-window-version)
"1.0.0"

