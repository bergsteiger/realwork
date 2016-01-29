unit ddRTFExpandedTextWriter;

interface

uses
 l3IntfUses
 , ddRTFSegmentWriter
 , l3Variant
 , k2Interfaces
 , l3ProtoDataContainer
;

type
 TddBlockInfo = class(Tl3ProtoDataContainer)
  {* Свойства блока, нужные для выливки. }
 end;//TddBlockInfo
 
 TddBlockInfoStack = class(_l3UncomparabeObjectRefList_)
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
 end;//TddBlockInfoStack
 
 TddSyleEnum = (
  dd_wsNone
  , dd_wsCheckCollapsed
  , dd_wsOtherStyle
  , dd_wsExpandedText
 );//TddSyleEnum
 
 TddRTFExpandedTextWriter = class(TddRTFSegmentWriter)
  function NeedCheckCollapsed(aStyle: Integer): Boolean;
  function NeedCorrectIndent(aStyle: Integer): Boolean;
  function GetStyleLeftIndent(aStyleID: Integer): Integer;
 end;//TddRTFExpandedTextWriter
 
implementation

uses
 l3ImplUses
 , SysUtils
 , k2Tags
 , k2VariantImpl
 , evdStyles
 , ddTypes
 , ddRTFProperties
 , l3Base
 , l3MinMax
 , RTLConsts
;

end.
