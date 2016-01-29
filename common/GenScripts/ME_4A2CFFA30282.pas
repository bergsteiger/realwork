unit evdBlockNameAdder;

interface

uses
 l3IntfUses
 , evdHeaderHyperlinkAdder
 , k2Base
 , l3Variant
 , l3Interfaces
 , l3ProtoDataContainer
;

type
 TevdBlocks = class(Tl3ProtoDataContainer)
  {* Накопленные в результате анализа документа блоки }
  function IsSameItems(const A: _ItemType_;
   const B: _ItemType_): Boolean;
   {* Сравнивает элементы списка }
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
 end;//TevdBlocks
 
 TevdBlockNameAdder = class(TevdHeaderHyperlinkAdder)
  {* Фильтр, добавляющий имена блоков }
 end;//TevdBlockNameAdder
 
implementation

uses
 l3ImplUses
 , SysUtils
 , Block_Const
 , k2Tags
 , TextPara_Const
 , evTextStyle_Const
 , l3CustomString
 , ContentsElement_Const
 , Document_Const
 , evdTypes
 , Table_Const
 , PageBreak_Const
 , l3String
 , k2Facade
 , SegmentsLayer_Const
 , HyperLink_Const
 , Address_Const
 , evdTextStyle_Const
 , DecorTextPara_Const
 , l3Base
 , l3MinMax
 , RTLConsts
;

type
 TevdBlockInfo = record
  {* Информация о блоке }
 end;//TevdBlockInfo
 
end.
