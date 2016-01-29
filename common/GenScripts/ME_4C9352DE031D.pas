unit K234363615;

interface

uses
 l3IntfUses
 , CopyPasteTest
 , nevTools
 , evCustomEditorWindow
 , l3Variant
;

type
 TK234363615 = class(TCopyPasteTest)
  {* [RequestLink:234363615]. }
  function DoSelect(aText: TevCustomEditorWindow;
   const anOp: Il3OpPack): InevRange;
   {* Выделяет текст в редакторе }
 end;//TK234363615
 
implementation

uses
 l3ImplUses
 , TestFrameWork
;

end.
