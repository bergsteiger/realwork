unit ScrollParamsTest;

interface

uses
 l3IntfUses
 , ScrollerParamsTestPrim
 , PrimTextLoad_Form
 , Types
;

type
 TScrollParamsTest = class(TScrollerParamsTestPrim)
  {* ����� ��� �������� ���������� ��������� ��� ��������� � �������� �� ����� ���������. }
  function GetSubNumber: Integer;
  procedure Process(aForm: TPrimTextLoadForm);
   {* ���������� ������� ��������� ������ }
 end;//TScrollParamsTest
 
implementation

uses
 l3ImplUses
 , TestFrameWork
;

end.
