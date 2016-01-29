unit vcmBaseCollectionItem;

interface

uses
 l3IntfUses
 , vcmPrimCollectionItem
 , Classes
;

type
 TvcmBaseCollectionItemPrim = class(TvcmPrimCollectionItem)
  procedure SetCaptionFromName(const aName: AnsiString);
  procedure NameChanged;
  procedure DoSetCaption(const aName: AnsiString);
  procedure ChangeName(const anOld: AnsiString;
   const aNew: AnsiString);
  function MakeID(const aName: AnsiString): Integer;
  function GetID: Integer;
  procedure ChangeCaption(const anOld: AnsiString;
   const aNew: AnsiString);
  procedure CaptionChanged;
  function GetCaptionStored: Boolean;
  function CaptionStored: Boolean;
   {* "������� ������������, ��� �������� Caption �����������" }
 end;//TvcmBaseCollectionItemPrim
 
 TvcmBaseCollectionItem = class(TvcmBaseCollectionItemPrim)
 end;//TvcmBaseCollectionItem
 
implementation

uses
 l3ImplUses
 , vcmBaseCollection
 , TtfwClassRef_Proxy
;

end.
