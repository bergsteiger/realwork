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
  {* ���� �� ������� ������� �������. }
  function MoveCursorCount: Integer;
  procedure CheckPara(const aText: TevCustomEditorWindow);
  procedure Process(aForm: TPrimTextLoadForm);
   {* ���������� ������� ��������� ������ }
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
