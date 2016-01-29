unit k2Attributes;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , k2Tags
;

type
 Tk2Attribute = object
 end;//Tk2Attribute
 
 Tk2Attributes = class(Tl3ProtoDataContainer)
  function IDByName(const aName: AnsiString): Integer;
  function NameByID(anID: Integer): AnsiString;
  function CheckIDByName(const aName: AnsiString): Integer;
  function Exists: Boolean;
   {* ��������� ������ ��������� ���������� ��� ��� }
  function IsSameItems(const A: _ItemType_;
   const B: _ItemType_): Boolean;
   {* ���������� �������� ������ }
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* ���������� ��� ������������ ��������. }
 end;//Tk2Attributes
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 , TypInfo
;

end.
