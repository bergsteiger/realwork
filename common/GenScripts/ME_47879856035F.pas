unit l3_Base;

interface

uses
 l3IntfUses
 , l3SimpleObject
;

type
 Tl3_Base = class(Tl3SimpleObject)
  {* ! ������� ����� �������� ���������� L3. ������������� ��� ������������ �� ���� ��������� ��������������� ��������. ������������ �������� �� �������������� ������ � ������������� ��������. }
  function OCompare(anObject: Tl3_Base): Integer;
   {* ������� ��������� ������� � ������ ��������. }
  procedure Create;
   {* ����������� �������. ���������� ������, �� ��������� ������ ������ 1. }
 end;//Tl3_Base
 
implementation

uses
 l3ImplUses
 , l3Base
;

end.
