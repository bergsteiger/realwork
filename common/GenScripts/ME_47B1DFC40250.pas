unit l3StringListPrim;

interface

uses
 l3IntfUses
 , l3ProtoPersistentDataContainer
 , l3CustomString
 , l3Base
 , l3Interfaces
 , l3Variant
 , Classes
 , l3Core
;

 {$Undef l3Items_NeedsBeforeFreeItem}
 
 {$Define l3Items_NoOwner}
 
 {$Define l3Items_HasCustomSort}
 
type
 Tl3StringListPrim = class(_l3StringList_)
  function Add(const Item: Tl3WString): Integer; overload;
  function WStrToItem(const aStr: Tl3WString): Tl3CustomString;
  function StringItemClass: Rl3String;
  function Add(anItem: Tl3PrimString): Integer; overload;
  function IndexOf(anItem: Tl3PrimString): Integer; overload;
  procedure SaveToStream(aStream: TStream);
   {* Сохраняет в поток. }
  procedure LoadFromStream(aStream: TStream;
   aNeedSort: Boolean);
   {* Загружает из потока. }
 end;//Tl3StringListPrim
 
implementation

uses
 l3ImplUses
 , l3Filer
 , l3Chars
 , l3String
 , l3_String
 , l3MinMax
 , RTLConsts
 , SysUtils
 , l3Stream
;

end.
