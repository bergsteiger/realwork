unit evCustomWikiReader;

interface

uses
 l3IntfUses
 , evCustomTxtReader
 , l3ProtoIntegerList
 , l3Base
 , l3ProtoDataContainer
;

type
 TevFormatInfo = object
 end;//TevFormatInfo
 
 TevFormatInfoList = class(Tl3ProtoDataContainer)
  function IsSameItems(const A: _ItemType_;
   const B: _ItemType_): Boolean;
   {* Сравнивает элементы списка }
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
 end;//TevFormatInfoList
 
 TevCustomWikiReader = class(TevCustomTxtReader)
 end;//TevCustomWikiReader
 
implementation

uses
 l3ImplUses
 , l3String
 , k2Tags
 , TextSegment_Const
 , l3Interfaces
 , SysUtils
 , l3Types
 , l3Const
 , evdStyles
 , evSegLst
 , ControlsBlock_Const
 , evStyleTableTools
 , afwFont
 , StrUtils
 , Cloak_Const
 , Graphics
 , HyperLink_Const
 , evdTypes
 , k2Base
 , TypInfo
 , k2Attributes
 , l3MinMax
 , RTLConsts
;

end.
