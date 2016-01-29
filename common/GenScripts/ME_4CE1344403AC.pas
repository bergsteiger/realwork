unit ClipboardOperations.imp;

interface

uses
 l3IntfUses
 , evCustomEditorWindow
;

type
 _ClipboardOperations_ = class
  {* Примесь для поддержки работы с буфером обмена (с его очисткой после работы). }
  procedure CopyToClipboard(aText: TevCustomEditorWindow);
   {* Скопировать выдленное в буфер обмена }
  procedure PasteFromClipboard(aText: TevCustomEditorWindow);
   {* Вставить из буфера обмена }
  procedure ClearClipboard;
   {* Очистка буфера обмена (чтобы не было утечек памяти). }
  procedure CopyAndPaste2DocumentBottom(aText: TevCustomEditorWindow);
   {* Скопировать выделенное и поместить в конец документа. }
 end;//_ClipboardOperations_
 
implementation

uses
 l3ImplUses
 , l3Base
 , evOp
 , l3InternalInterfaces
;

end.
