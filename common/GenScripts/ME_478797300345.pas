unit l3ValueMap;

interface

uses
 l3IntfUses
 , l3BaseWithIDList
 , l3Interfaces
 , l3Except
;

type
 El3ValueMap = class(El3Error)
 end;//El3ValueMap
 
 El3ValueMapValueNotFound = class(El3ValueMap)
 end;//El3ValueMapValueNotFound
 
 Tl3ValueMap = class(Tl3BaseWithIDList, Il3ValueMap)
  {* ������� ���������� ��� "������"-���-��. }
  procedure DoGetDisplayNames(const aList: Il3StringsEx);
  function GetMapSize: Integer;
  procedure Create(const aID: Tl3ValueMapID);
  function MapID: Tl3ValueMapID;
   {* ������������� ����. }
  procedure GetDisplayNames(const aList: Il3StringsEx);
   {* ��������� ������ ���������� "UI-������" }
  function MapSize: Integer;
   {* ���������� ��������� � ����. }
 end;//Tl3ValueMap
 
implementation

uses
 l3ImplUses
 , l3Base
;

end.
