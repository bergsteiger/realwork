unit K218824755;

interface

uses
 l3IntfUses
 , ComplexScrollByLines
 , nevTools
;

type
 TK218824755 = class(TComplexScrollByLines)
  {* [RequestLink:218824755] }
  function GetScrollLineCount2Down: Integer;
   {* ���������� ����� ��� ��������� ���� }
  function GetScrollLineCount2Up: Integer;
   {* ���������� ����� ��� ��������� ����� }
 end;//TK218824755
 
implementation

uses
 l3ImplUses
 , TestFrameWork
;

end.
