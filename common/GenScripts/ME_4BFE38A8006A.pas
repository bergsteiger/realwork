unit ScrollAndSelectPtTest;

interface

uses
 l3IntfUses
 , SelectPtTest
 , nevTools
 , PrimTextLoad_Form
;

type
 TScrollAndSelectPtTest = class(TSelectPtTest)
  {* ����� ���� - ���������, ���������� � ������ }
  function NeedScrollUp: Boolean;
  function NeedScrollByLine: Boolean;
  function GetScrollCount: Integer;
  procedure CheckAfterScroll(const aView: InevInputView);
   {* �������� ����� ��������� }
 end;//TScrollAndSelectPtTest
 
implementation

uses
 l3ImplUses
 , TestFrameWork
;

end.
