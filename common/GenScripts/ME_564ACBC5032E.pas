unit pgJournalCache;

// Модуль: "w:\common\components\rtl\Garant\PG\pgJournalCache.pas"
// Стереотип: "UtilityPack"

{$Include pgDefine.inc}

interface

{$If Defined(UsePostgres)}
uses
 l3IntfUses
 , daTypes
 , l3ProtoDataContainer
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 TpgJournalCacheRec = object
  public
   rOperation: TdaJournalOperation;
   rFamilyID: TdaFamilyID;
   rExtID: LongInt;
   rData: LongInt;
 end;//TpgJournalCacheRec

 _ItemType_ = TpgJournalCacheRec;
 _l3RecordListPrim_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include l3RecordListPrim.imp.pas}
 TpgJournalCacheList = class(_l3RecordListPrim_)
 end;//TpgJournalCacheList

 PpgJournalCacheRec = ^TpgJournalCacheRec;

function TpgJournalCacheRec_C(aOperation: TdaJournalOperation;
 aFamilyID: TdaFamilyID;
 aExtID: LongInt;
 aData: LongInt): TpgJournalCacheRec;
{$IfEnd} // Defined(UsePostgres)

implementation

{$If Defined(UsePostgres)}
uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

function TpgJournalCacheRec_C(aOperation: TdaJournalOperation;
 aFamilyID: TdaFamilyID;
 aExtID: LongInt;
 aData: LongInt): TpgJournalCacheRec;
//#UC START# *564ACD9A000D_564ACBEE0302_var*
//#UC END# *564ACD9A000D_564ACBEE0302_var*
begin
//#UC START# *564ACD9A000D_564ACBEE0302_impl*
 Result.rOperation := aOperation;
 Result.rFamilyID :=aFamilyID;
 Result.rExtID :=aExtID;
 Result.rData := aData;
//#UC END# *564ACD9A000D_564ACBEE0302_impl*
end;//TpgJournalCacheRec_C

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_); forward;
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)
function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If NOT Defined(l3Items_IsAtomic)}
function IsSameItems(const A: _ItemType_;
 const B: _ItemType_): Boolean;
 {* Сравнивает элементы списка }
//#UC START# *47B07CF403D0_564AD17C02DC_var*
//#UC END# *47B07CF403D0_564AD17C02DC_var*
begin
//#UC START# *47B07CF403D0_564AD17C02DC_impl*
 Result := false;
 Assert(false);
//#UC END# *47B07CF403D0_564AD17C02DC_impl*
end;//IsSameItems
{$IfEnd} // NOT Defined(l3Items_IsAtomic)

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_564AD17C02DC_var*
//#UC END# *47B2C42A0163_564AD17C02DC_var*
begin
//#UC START# *47B2C42A0163_564AD17C02DC_impl*
 aTo := aFrom;
//#UC END# *47B2C42A0163_564AD17C02DC_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_564AD17C02DC_var*
//#UC END# *47B99D4503A2_564AD17C02DC_var*
begin
//#UC START# *47B99D4503A2_564AD17C02DC_impl*
 Result := -1;
 Assert(false);
//#UC END# *47B99D4503A2_564AD17C02DC_impl*
end;//CompareExistingItems

type _Instance_R_ = TpgJournalCacheList;

{$Include l3RecordListPrim.imp.pas}
{$IfEnd} // Defined(UsePostgres)

end.
