unit vcmCommandIDsListPrim;
 {* Список информации о командах }

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\vcmCommandIDsListPrim.pas"
// Стереотип: "SimpleClass"

{$Include vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , l3ProtoDataContainer
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 TvcmCommandInfo = object
  {* Информация о команде }
  public
   rIsModule: Boolean;
    {* Модуль? }
   rItemID: Integer;
    {* Идентификатор элемента (модуля/сущности) }
   rOperationID: Integer;
    {* Идентификатор операции }
  public
   function EQ: Boolean;
 end;//TvcmCommandInfo

 _ItemType_ = TvcmCommandInfo;
 _l3RecordWithEQList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include l3RecordWithEQList.imp.pas}
 TvcmCommandIDsListPrim = class(_l3RecordWithEQList_)
  {* Список информации о командах }
 end;//TvcmCommandIDsListPrim

function TvcmCommandInfo_C: TvcmCommandInfo;
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

function TvcmCommandInfo_C: TvcmCommandInfo;
//#UC START# *4A8D71180299_4A8D70780075_var*
//#UC END# *4A8D71180299_4A8D70780075_var*
begin
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *4A8D71180299_4A8D70780075_impl*
 Result.rItemID := aItemID;
 Result.rIsModule := aIsModule;
 Result.rOperationID := aOperationID;
//#UC END# *4A8D71180299_4A8D70780075_impl*
end;//TvcmCommandInfo_C

function TvcmCommandInfo.EQ: Boolean;
//#UC START# *4A8D7588039F_4A8D70780075_var*
//#UC END# *4A8D7588039F_4A8D70780075_var*
begin
//#UC START# *4A8D7588039F_4A8D70780075_impl*
 Result := (rIsModule = aB.rIsModule) AND
           (rItemID = aB.rItemID) AND
           (rOperationID = aB.rOperationID);
//#UC END# *4A8D7588039F_4A8D70780075_impl*
end;//TvcmCommandInfo.EQ

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_4A8D6F31034F_var*
//#UC END# *47B2C42A0163_4A8D6F31034F_var*
begin
//#UC START# *47B2C42A0163_4A8D6F31034F_impl*
 Assert(false);
//#UC END# *47B2C42A0163_4A8D6F31034F_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_4A8D6F31034F_var*
//#UC END# *47B99D4503A2_4A8D6F31034F_var*
begin
//#UC START# *47B99D4503A2_4A8D6F31034F_impl*
 Result := -1;
 Assert(false);
//#UC END# *47B99D4503A2_4A8D6F31034F_impl*
end;//CompareExistingItems

type _Instance_R_ = TvcmCommandIDsListPrim;

{$Include l3RecordWithEQList.imp.pas}
{$IfEnd} // NOT Defined(NoVCM)

end.
