unit vcmModuleOperationsForRegister;

// Модуль: "w:\common\components\gui\Garant\VCM\vcmModuleOperationsForRegister.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TvcmModuleOperationsForRegister" MUID: (5787730D03D7)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

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
 , vcmModule
 , vcmExternalInterfaces
;

type
 PvcmMOPID = ^TvcmMOPID;

 TvcmModuleOperationForRegister = object
  public
   rModule: RvcmModule;
   rOperationName: AnsiString;
   rOperationCaption: AnsiString;
   rNoPrefix: Boolean;
   rVar: PvcmMOPID;
  public
   function EQ(const anOther: TvcmModuleOperationForRegister): Boolean;
 end;//TvcmModuleOperationForRegister

 {$Define l3Items_NoSort}

 _ItemType_ = TvcmModuleOperationForRegister;
 _l3RecordListPrim_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3RecordListPrim.imp.pas}
 TvcmModuleOperationsForRegister = class(_l3RecordListPrim_)
  public
   class procedure AddOperation(const anOp: TvcmModuleOperationForRegister);
   class function Instance: TvcmModuleOperationsForRegister;
    {* Метод получения экземпляра синглетона TvcmModuleOperationsForRegister }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TvcmModuleOperationsForRegister

function TvcmModuleOperationForRegister_C(aModule: RvcmModule;
 const anOperationName: AnsiString;
 const anOperationCaption: AnsiString;
 aNoPrefix: Boolean;
 var theVar: TvcmMOPID): TvcmModuleOperationForRegister;
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

var g_TvcmModuleOperationsForRegister: TvcmModuleOperationsForRegister = nil;
 {* Экземпляр синглетона TvcmModuleOperationsForRegister }

function TvcmModuleOperationForRegister_C(aModule: RvcmModule;
 const anOperationName: AnsiString;
 const anOperationCaption: AnsiString;
 aNoPrefix: Boolean;
 var theVar: TvcmMOPID): TvcmModuleOperationForRegister;
//#UC START# *57877404001B_5787735E01E4_var*
//#UC END# *57877404001B_5787735E01E4_var*
begin
 Finalize(Result);
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *57877404001B_5787735E01E4_impl*
 Result.rModule := aModule;
 Result.rOperationName := anOperationName;
 Result.rOperationCaption := anOperationCaption;
 Result.rNoPrefix := aNoPrefix;
 Result.rVar := @theVar;
//#UC END# *57877404001B_5787735E01E4_impl*
end;//TvcmModuleOperationForRegister_C

procedure TvcmModuleOperationsForRegisterFree;
 {* Метод освобождения экземпляра синглетона TvcmModuleOperationsForRegister }
begin
 l3Free(g_TvcmModuleOperationsForRegister);
end;//TvcmModuleOperationsForRegisterFree

function TvcmModuleOperationForRegister.EQ(const anOther: TvcmModuleOperationForRegister): Boolean;
//#UC START# *578773D500B7_5787735E01E4_var*
//#UC END# *578773D500B7_5787735E01E4_var*
begin
//#UC START# *578773D500B7_5787735E01E4_impl*
 Result := (rModule = anOther.rModule) AND
           (rOperationName = anOther.rOperationName);
//#UC END# *578773D500B7_5787735E01E4_impl*
end;//TvcmModuleOperationForRegister.EQ

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_); forward;
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)
function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If NOT Defined(l3Items_IsAtomic)}
function IsSameItems(const A: _ItemType_;
 const B: _ItemType_): Boolean;
 {* Сравнивает элементы списка }
//#UC START# *47B07CF403D0_5787730D03D7_var*
//#UC END# *47B07CF403D0_5787730D03D7_var*
begin
//#UC START# *47B07CF403D0_5787730D03D7_impl*
 Result := A.EQ(B);
//#UC END# *47B07CF403D0_5787730D03D7_impl*
end;//IsSameItems
{$IfEnd} // NOT Defined(l3Items_IsAtomic)

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_5787730D03D7_var*
//#UC END# *47B2C42A0163_5787730D03D7_var*
begin
//#UC START# *47B2C42A0163_5787730D03D7_impl*
 !!! Needs to be implemented !!!
//#UC END# *47B2C42A0163_5787730D03D7_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_5787730D03D7_var*
//#UC END# *47B99D4503A2_5787730D03D7_var*
begin
//#UC START# *47B99D4503A2_5787730D03D7_impl*
 Result := -1;
 Assert(false);
//#UC END# *47B99D4503A2_5787730D03D7_impl*
end;//CompareExistingItems

type _Instance_R_ = TvcmModuleOperationsForRegister;

{$Include w:\common\components\rtl\Garant\L3\l3RecordListPrim.imp.pas}

class procedure TvcmModuleOperationsForRegister.AddOperation(const anOp: TvcmModuleOperationForRegister);
//#UC START# *578773AE01A5_5787730D03D7_var*
//#UC END# *578773AE01A5_5787730D03D7_var*
begin
//#UC START# *578773AE01A5_5787730D03D7_impl*
 with Instance do
  if (IndexOf(anOp) < 0) then
   Add(anOp);
//#UC END# *578773AE01A5_5787730D03D7_impl*
end;//TvcmModuleOperationsForRegister.AddOperation

class function TvcmModuleOperationsForRegister.Instance: TvcmModuleOperationsForRegister;
 {* Метод получения экземпляра синглетона TvcmModuleOperationsForRegister }
begin
 if (g_TvcmModuleOperationsForRegister = nil) then
 begin
  l3System.AddExitProc(TvcmModuleOperationsForRegisterFree);
  g_TvcmModuleOperationsForRegister := Create;
 end;
 Result := g_TvcmModuleOperationsForRegister;
end;//TvcmModuleOperationsForRegister.Instance

class function TvcmModuleOperationsForRegister.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TvcmModuleOperationsForRegister <> nil;
end;//TvcmModuleOperationsForRegister.Exists
{$IfEnd} // NOT Defined(NoVCM)

end.
