unit pgJournalCache;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "PG"
// Модуль: "w:/common/components/rtl/Garant/PG/pgJournalCache.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi For Archi::PG::Provider::pgJournalCache
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\PG\pgDefine.inc}

interface

{$If defined(UsePostgres)}
uses
  l3ProtoDataContainer,
  daTypes,
  l3Memory,
  l3Interfaces,
  l3Types,
  l3Core,
  l3Except,
  Classes
  ;

type
 TpgJournalCacheRec = {$IfDef XE4}record{$Else}object{$EndIf}
 public
   rOperation : TdaJournalOperation;
   rFamilyID : TdaFamilyID;
   rExtID : LongInt;
   rData : LongInt;
 end;//TpgJournalCacheRec

 _ItemType_ = TpgJournalCacheRec;
 _l3RecordListPrim_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3RecordListPrim.imp.pas}
 TpgJournalCacheList = class(_l3RecordListPrim_)
 end;//TpgJournalCacheList

 PpgJournalCacheRec = ^TpgJournalCacheRec;

function TpgJournalCacheRec_C(aOperation: TdaJournalOperation;
     aFamilyID: TdaFamilyID;
     aExtID: LongInt;
     aData: LongInt): TpgJournalCacheRec;
{$IfEnd} //UsePostgres

implementation

{$If defined(UsePostgres)}
uses
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;


function TpgJournalCacheRec_C(aOperation: TdaJournalOperation;
        aFamilyID: TdaFamilyID;
        aExtID: LongInt;
        aData: LongInt): TpgJournalCacheRec;
//#UC START# *564ACD9A000D_564ACBEE0302_var*
//#UC END# *564ACD9A000D_564ACBEE0302_var*
begin
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *564ACD9A000D_564ACBEE0302_impl*
 Result.rOperation := aOperation;
 Result.rFamilyID :=aFamilyID;
 Result.rExtID :=aExtID;
 Result.rData := aData;
//#UC END# *564ACD9A000D_564ACBEE0302_impl*
end;//TpgJournalCacheRec.C

// start class TpgJournalCacheList

{$If defined(l3Items_NeedsAssignItem) AND not defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
  const aFrom: _ItemType_); forward;
{$IfEnd} //l3Items_NeedsAssignItem AND not l3Items_NoSort


function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If not defined(l3Items_IsAtomic)}
function IsSameItems(const A: _ItemType_;
  const B: _ItemType_): Boolean;
//#UC START# *47B07CF403D0_564AD17C02DC_var*
//#UC END# *47B07CF403D0_564AD17C02DC_var*
begin
//#UC START# *47B07CF403D0_564AD17C02DC_impl*
 Result := false;
 Assert(false);
//#UC END# *47B07CF403D0_564AD17C02DC_impl*
end;//IsSameItems
{$IfEnd} //not l3Items_IsAtomic

{$If defined(l3Items_NeedsAssignItem) AND not defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
  const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_564AD17C02DC_var*
//#UC END# *47B2C42A0163_564AD17C02DC_var*
begin
//#UC START# *47B2C42A0163_564AD17C02DC_impl*
 aTo := aFrom;
//#UC END# *47B2C42A0163_564AD17C02DC_impl*
end;//AssignItem
{$IfEnd} //l3Items_NeedsAssignItem AND not l3Items_NoSort

function CompareExistingItems(const CI: CompareItemsRec): Integer;
//#UC START# *47B99D4503A2_564AD17C02DC_var*
//#UC END# *47B99D4503A2_564AD17C02DC_var*
begin
//#UC START# *47B99D4503A2_564AD17C02DC_impl*
 Result := -1;
 Assert(false);
//#UC END# *47B99D4503A2_564AD17C02DC_impl*
end;//CompareExistingItems

type _Instance_R_ = TpgJournalCacheList;

{$Include w:\common\components\rtl\Garant\L3\l3RecordListPrim.imp.pas}

{$IfEnd} //UsePostgres
end.