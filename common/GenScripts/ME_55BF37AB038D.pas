unit tfwValueTypesCache;

interface

uses
 l3IntfUses
 , tfwValueTypesList
 , tfwValueTypes
;

type
 TtfwValueTypesCache = class(TtfwValueTypesList)
  function CheckList(aValue: TtfwValueTypes): TtfwValueTypes;
  function Exists: Boolean;
   {* ��������� ������ ��������� ���������� ��� ��� }
 end;//TtfwValueTypesCache
 
implementation

uses
 l3ImplUses
;

end.
