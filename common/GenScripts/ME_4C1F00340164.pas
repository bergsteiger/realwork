unit K219120094;

interface

uses
 l3IntfUses
 , ComplexScrollByLines
 , nevTools
;

type
 TK219120094 = class(TComplexScrollByLines)
  {* [$219120094] }
  function GetScrollLineCount2Down: Integer;
   {* ���������� ����� ��� ��������� ���� }
  function GetScrollLineCount2Up: Integer;
   {* ���������� ����� ��� ��������� ����� }
 end;//TK219120094
 
implementation

uses
 l3ImplUses
 , TestFrameWork
;

end.
