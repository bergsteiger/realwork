unit l3RangeManager;

interface

uses
 l3IntfUses
 , l3CProtoObject
 , l3Interfaces
;

type
 Tl3RangeManager = class(Tl3CProtoObject, Il3RangeManager)
  function HasPage(anIndex: Integer): Boolean;
   {* �������� �� �������� ��������� ��������. }
  function Count: Integer;
   {* ���������� ������������� �������. }
  function Pages: Integer;
  function IndexOfPage: Integer;
   {* ����� ������������ � ������� ��������� ��������� ��������. }
 end;//Tl3RangeManager
 
implementation

uses
 l3ImplUses
;

end.
