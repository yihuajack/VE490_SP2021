; Inspired by https://forums.autodesk.com/t5/visual-lisp-autolisp-and-general/get-x-y-z-coordinates-of-vertices-of-multiple-3dpolylines/m-p/2822802/highlight/true#M292893
(defun c:test (/ ss cnt fn obj lst1 str)  ; Check parameters first, otherwise "错误: 参数类型错误: lselsetp nil" or "错误: 参数太多"
  (setq ss (ssget ":E" '((0 . "LINE")))  ; Exported electrodes are lines, not polylines; ":E" indicates selection set needed before running
    cnt -1
    fn (open "D:\\Documents\\Programming\\AutoLISP\\coordlist.txt" "w")  ; File operations are not necessary, just for checking
  )
  (repeat (sslength ss)
    (setq obj (vlax-ename->vla-object (ssname ss (setq cnt (1+ cnt)))))
    (if
      (= "AcDbLine" (vlax-get obj 'Objectname))  ; Alternatively ((eq (vla-get-ObjectName obj) "AcDbLine")
      (progn
        (setq sp (vlax-get obj 'StartPoint)  ; Alternatively (setq sp (vlax-curve-getstartpoint obj))
          ep (vlax-get obj 'EndPoint)  ; Alternatively (setq ep (vlax-curve-getendpoint obj))
          ; Note that different from "AcDbPolyline", "AcDbLine" does not have "Coordinates", otherwise "错误: ActiveX 服务器返回错误: 未知名称: "COORDINATES""
          str (strcat (rtos (car sp)) "," (rtos (cadr sp)) ";" (rtos (car ep)) "," (rtos (cadr ep)) ";")
          ; Here must be "cadr" rather than "cdr", otherwise "错误: 参数类型错误: numberp: (1300.0 0.0)"
          ; Remember don't concatenate str without initializing it by (setq str ""), otherwise "错误: 参数类型错误: stringp nil"
          mspace (vla-get-modelspace 
            (vla-get-activedocument 
              (vlax-get-acad-object)
            )
          )
        )
        (write-line str fn)
        (vla-addpoint mspace (vlax-3d-point sp))  ; (command "Point" sp ep)
        (vla-addpoint mspace (vlax-3d-point ep))  ; (vla-put -INSERTIONPOINT Obj mypoint) (vlax-put Obj 'INSERTIONPOINT mypoint)
        (vla-delete obj)  ; (command "Erase" obj)
      )
      (progn  ; Exception
        (redraw)
        (redraw (vlax-vla-object->ename obj) 3)
        (alert (strcat "This entity (Handle ID " (vlax-get obj 'Handle) ") is not a Line"))
      )
    )
  )
  (close fn)
  (princ)
)