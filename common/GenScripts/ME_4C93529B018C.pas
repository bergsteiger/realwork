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
  {* ���� �����������/������� ����� ����� ������ }
  function DoSelect(aText: TevCustomEditorWindow;
   const anOp: Il3OpPack): InevRange;
   {* �������� ����� � ��������� }
  procedure Process(aForm: TPrimTextLoadForm);
   {* ���������� ������� ��������� ������ }
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
