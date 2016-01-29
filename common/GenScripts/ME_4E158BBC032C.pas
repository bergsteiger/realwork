unit InsertSectionBreak;

interface

uses
 l3IntfUses
 , TextViaEditorProcessor
 , evCustomEditorWindow
 , PrimTextLoad_Form
;

type
 TInsertSectionBreak = class(TTextViaEditorProcessor)
  {* Тест на вставку разрыва раздела. }
  function MoveCursorCount: Integer;
  procedure CheckPara(const aText: TevCustomEditorWindow);
  procedure Process(aForm: TPrimTextLoadForm);
   {* Собственно процесс обработки текста }
 end;//TInsertSectionBreak
 
implementation

uses
 l3ImplUses
 , evdTypes
 , TestFrameWork
 , evMsgCode
 , evOp
;

end.
