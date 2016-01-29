unit CopyPasteTest;

interface

uses
 l3IntfUses
 , TextViaEditorProcessor
 , nevTools
 , evCustomEditorWindow
 , l3Variant
 , PrimTextLoad_Form
;

type
 TCopyPasteTest = class(TTextViaEditorProcessor)
  {* Тест копирования/вставки через буфер обмена }
  function DoSelect(aText: TevCustomEditorWindow;
   const anOp: Il3OpPack): InevRange;
   {* Выделяет текст в редакторе }
  procedure Process(aForm: TPrimTextLoadForm);
   {* Собственно процесс обработки текста }
 end;//TCopyPasteTest
 
implementation

uses
 l3ImplUses
 , k2Prim
 , evTypes
 , TestFrameWork
 , evMsgCode
 , evOp
 , l3Base
 , l3InternalInterfaces
;

end.
