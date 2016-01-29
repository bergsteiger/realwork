unit evPageBreakPainter;

interface

uses
 l3IntfUses
 , evLeafParaPainter
 , l3Interfaces
 , l3Units
 , l3StringIDEx
;

type
 TevPageBreakPainter = class(TevLeafParaPainter)
  {* ���������� ����������� ��������� ��� ������� �������. }
  function GetString: Il3CString;
   {* ������� ������� ��� �����������. }
  procedure NewPage;
   {* ���������� ����� ������� ����� ��������. }
  procedure DrawLine(const A: Tl3Point;
   const B: Tl3Point);
   {* ���������� ����� �������. }
 end;//TevPageBreakPainter
 
implementation

uses
 l3ImplUses
 , k2Tags
 , l3Const
 , nevBase
 , Graphics
 , l3String
 , l3MessageID
;

end.
