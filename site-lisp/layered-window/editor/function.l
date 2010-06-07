;;; -*- mode: lisp; package: layered-window.editor -*-
;;;
;;; File: layered-window/editor/function.l
;;;
;;; License:
;;;
;;;   Copyright (c) 2007 MIYAMUKO Katsuyuki.
;;;
;;;   layered-window is released under an MIT license.
;;;   See layered-window/docs/MIT-LICENSE for full license.
;;;

(eval-when (:compile-toplevel :load-toplevel :execute)
  (require "layered-window/api")
  (require "layered-window/editor/package")
  )

(in-package :layered-window.editor)

(export '(layered-window-get-opacity
          layered-window-get-alpha
          layered-window-get-transparency-color
          ))

;; �s�����x (0-100) �̎擾
(defun layered-window-get-opacity ()
  "layered-window: ���݂̓����x���擾����B
���ߐݒ肵�Ă��Ȃ��ꍇ�� nil ��Ԃ��B"
  (let ((alpha (layered-window-get-alpha)))
    (when alpha
      (alpha->opacity alpha))))

;; ���l (0-255) �̎擾
(defun layered-window-get-alpha ()
  "layered-window: ���݂̃��l���擾����B
���ߐݒ肵�Ă��Ȃ��ꍇ�� nil ��Ԃ��B"
  (get-layered-window-attributes/alpha (get-window-handle)))

;; ���ߐF�擾
(defun layered-window-get-transparency-color ()
  "layered-window: ���ߐF�Ɏw�肳��Ă���F���擾����B
�߂�l�� RGB �̃��X�g -> '(R G B)
���ߐݒ肵�Ă��Ȃ��ꍇ�� nil ��Ԃ��B"
  (let ((color (get-layered-window-attributes/color (get-window-handle))))
    (when color
      (color->rgb color))))

(defun layered-window-refresh (&optional (hwnd (get-window-handle)))
  (interactive)
  (layered-window.api::redraw-window hwnd))


(provide "layered-window/editor/function")

;;; End