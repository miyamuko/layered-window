;;; -*- mode: lisp; package: layered-window.editor -*-
;;;
;;; File: layered-window/editor/command.l
;;;
;;; License:
;;;
;;;   Copyright (c) 2003-2007 MIYAMUKO Katsuyuki.
;;;
;;;   layered-window is released under an MIT license.
;;;   See layered-window/docs/MIT-LICENSE for full license.
;;;

(eval-when (:compile-toplevel :load-toplevel :execute)
  (require "layered-window/api")
  (require "layered-window/editor/package")
  (require "layered-window/editor/util")
  (require "layered-window/editor/hook")
  (require "layered-window/editor/function")
  )



(in-package :layered-window.editor)

(export '(*layered-window-default-opacity*

          toggle-layered-window

          layered-window-set-opacity
          layered-window-set-alpha
          layered-window-set-transparency-color
          layered-window-set-transparency-color-bgr
          layered-window-set-opaque

          layered-window-p
          ))

;;
;; �ϐ�
;;

(defvar *layered-window-default-opacity* 80
  "layered-window: �g�O���Ő؂�ւ���Ƃ��̃f�t�H���g�̕s������(%)")


;;;
;;; �R�}���h
;;;

;; �������� toggle
(defun toggle-layered-window ()
  "layered-window: �E�B���h�E�̓��������g�O��"
  (interactive)
  (if (layered-window-p)
      (layered-window-set-opaque)
    (layered-window-set-opacity *layered-window-default-opacity*)))

;; ��������
(defun layered-window-set-opacity (opacity)
  "layered-window: �E�B���h�E�𔼓����ɂ���B
�����ɂ͕s�����x�� 0-100 �͈̔͂Ŏw�肷��B"
  (interactive "nOpacity(0-100%): ")
  (layered-window-set-alpha (opacity->alpha opacity)))

;; �������� ����2
(defun layered-window-set-alpha (alpha)
  "layered-window: �E�B���h�E�𔼓����ɂ���B
�����ɂ̓A���t�@�l�� 0-255�͈̔͂Ŏw�肷��B"
  (interactive "nAlpha(0-255): ")
  (unless (and (integerp alpha) (<= 0 alpha 255))
    (plain-error "���l�� 0-255 �͈̔͂Ŏw�肵�Ă�������: ~S" alpha))
  (let ((hwnd (get-window-handle)))
    (set-window-ex-layered hwnd t)
    (set-layered-window-attributes/alpha hwnd alpha)
    (layered-window-run-hooks hwnd)))

;; ���ߐF�ݒ�
(defun layered-window-set-transparency-color-bgr (bgr)
  "layered-window: �w�肵���F�𓧉ߐF�ɐݒ肷��B"
  (interactive "sBGR: ")
  (apply 'layered-window-set-transparency-color
         (parse-bgr bgr)))

(defun layered-window-set-transparency-color (r g b)
  "layered-window: �w�肵���F�𓧉ߐF�ɐݒ肷��B"
  (interactive "nRed(0-255): \nnGreen(0-255): \nnBlue(0-255): ")
  (unless (and (integerp r) (<= 0 r 255)
               (integerp g) (<= 0 g 255)
               (integerp b) (<= 0 b 255))
    (plain-error "RGB �̊e�l�� 0-255 �͈̔͂Ŏw�肵�Ă�������: RGB(~S ~S ~S)" r g b))
  (let ((hwnd (get-window-handle)))
    (set-window-ex-layered hwnd t)
    (set-layered-window-attributes/color hwnd (rgb->color r g b))
    (layered-window-run-hooks hwnd)))

;; �s������ (���������̉���)
(defun layered-window-set-opaque ()
  "layered-window: �E�B���h�E��s�����ɂ���B"
  (interactive)
  (unless (layered-window-p)
    (return-from layered-window-set-opaque))
  (let ((hwnd (get-window-handle)))
    (set-window-ex-layered hwnd nil)
    (layered-window-run-hooks hwnd)))

;; non-nil  ����
;; nil      �s����
(defun layered-window-p (&optional (hwnd (get-window-handle)))
  "layered-window: �E�B���h�E�� Layered Window �����肷��B
�E�B���h�E�����ߏ�ԂȂ� non-nil
�E�B���h�E���s�����Ȃ� nil"
  (interactive)
  (window-ex-layered-p (get-window-handle)))


(provide "layered-window/editor/command")

;;; End