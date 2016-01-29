unit vcmBaseCollection;

interface

uses
 l3IntfUses
 , Classes
 , vcmBaseCollectionItem
 , vcmPrimCollectionItem
 , vcmExternalInterfaces
;

 {$Define _UnknownNeedsQI}
 
 {$Define _UnknownNotNeedL3}
 
type
 RvcmBaseCollection = class of TvcmBaseCollection;
 
 TvcmBaseCollection = class(TOwnedCollection)
  function FindItemByName(const aName: AnsiString): TvcmBaseCollectionItem;
  procedure Sort;
  procedure Create(anOwner: TPersistent);
  function GetItemClass: TCollectionItemClass;
  function CheckItemByName(const aName: AnsiString): TvcmBaseCollectionItem;
  function FindItemByCaption(const aName: AnsiString): TvcmBaseCollectionItem;
  function FindItemByID(anID: TvcmControlID): TvcmBaseCollectionItem;
  procedure CaptionChanged(aItem: TvcmBaseCollectionItemPrim);
 end;//TvcmBaseCollection
 
implementation

uses
 l3ImplUses
 , l3String
 , TtfwClassRef_Proxy
 , SysUtils
 , l3Base
 , l3Core
 , Windows
 , l3MemUtils
 , l3Interlocked
;

end.
