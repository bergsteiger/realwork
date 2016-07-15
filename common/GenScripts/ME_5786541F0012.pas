unit vcmModulesForRegister;

// Модуль: "w:\common\components\gui\Garant\VCM\vcmModulesForRegister.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TvcmModulesForRegister" MUID: (5786541F0012)

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
;

 {$Define l3Items_NoSort}

type
 TvcmModuleForRegister = object
  public
   rModule: RvcmModule;
   rModuleCaption: AnsiString;
  public
   function EQ(const anOther: TvcmModuleForRegister): Boolean;
 end;//TvcmModuleForRegister

 _ItemType_ = TvcmModuleForRegister;
 _l3RecordListPrim_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3RecordListPrim.imp.pas}
 TvcmModulesForRegister = class(_l3RecordListPrim_)
  public
   class procedure AddModule(const aModule: TvcmModuleForRegister);
   class function Instance: TvcmModulesForRegister;
    {* Метод получения экземпляра синглетона TvcmModulesForRegister }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TvcmModulesForRegister

function TvcmModuleForRegister_C(aModule: RvcmModule;
 const aModuleName: AnsiString): TvcmModuleForRegister;
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

var g_TvcmModulesForRegister: TvcmModulesForRegister = nil;
 {* Экземпляр синглетона TvcmModulesForRegister }

function TvcmModuleForRegister_C(aModule: RvcmModule;
 const aModuleName: AnsiString): TvcmModuleForRegister;
//#UC START# *578654D00255_578654600168_var*
//#UC END# *578654D00255_578654600168_var*
begin
 Finalize(Result);
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *578654D00255_578654600168_impl*
 Result.rModule := aModule;
 Result.rModuleCaption := aModuleName;
//#UC END# *578654D00255_578654600168_impl*
end;//TvcmModuleForRegister_C

procedure TvcmModulesForRegisterFree;
 {* Метод освобождения экземпляра синглетона TvcmModulesForRegister }
begin
 l3Free(g_TvcmModulesForRegister);
end;//TvcmModulesForRegisterFree

function TvcmModuleForRegister.EQ(const anOther: TvcmModuleForRegister): Boolean;
//#UC START# *578654F80090_578654600168_var*
//#UC END# *578654F80090_578654600168_var*
begin
//#UC START# *578654F80090_578654600168_impl*
 Result := (rModule = anOther.rModule);
//#UC END# *578654F80090_578654600168_impl*
end;//TvcmModuleForRegister.EQ

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_); forward;
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)
function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If NOT Defined(l3Items_IsAtomic)}
function IsSameItems(const A: _ItemType_;
 const B: _ItemType_): Boolean;
 {* Сравнивает элементы списка }
//#UC START# *47B07CF403D0_5786541F0012_var*
//#UC END# *47B07CF403D0_5786541F0012_var*
begin
//#UC START# *47B07CF403D0_5786541F0012_impl*
 Result := A.EQ(B);
//#UC END# *47B07CF403D0_5786541F0012_impl*
end;//IsSameItems
{$IfEnd} // NOT Defined(l3Items_IsAtomic)

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_5786541F0012_var*
//#UC END# *47B2C42A0163_5786541F0012_var*
begin
//#UC START# *47B2C42A0163_5786541F0012_impl*
 !!! Needs to be implemented !!!
//#UC END# *47B2C42A0163_5786541F0012_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_5786541F0012_var*
//#UC END# *47B99D4503A2_5786541F0012_var*
begin
//#UC START# *47B99D4503A2_5786541F0012_impl*
 Result := -1;
 Assert(false);
//#UC END# *47B99D4503A2_5786541F0012_impl*
end;//CompareExistingItems

type _Instance_R_ = TvcmModulesForRegister;

{$Include w:\common\components\rtl\Garant\L3\l3RecordListPrim.imp.pas}

class procedure TvcmModulesForRegister.AddModule(const aModule: TvcmModuleForRegister);
//#UC START# *57865E0C018D_5786541F0012_var*
//#UC END# *57865E0C018D_5786541F0012_var*
begin
//#UC START# *57865E0C018D_5786541F0012_impl*
 with Instance do
  if (IndexOf(aModule) < 0) then
   Add(aModule);
//#UC END# *57865E0C018D_5786541F0012_impl*
end;//TvcmModulesForRegister.AddModule

class function TvcmModulesForRegister.Instance: TvcmModulesForRegister;
 {* Метод получения экземпляра синглетона TvcmModulesForRegister }
begin
 if (g_TvcmModulesForRegister = nil) then
 begin
  l3System.AddExitProc(TvcmModulesForRegisterFree);
  g_TvcmModulesForRegister := Create;
 end;
 Result := g_TvcmModulesForRegister;
end;//TvcmModulesForRegister.Instance

class function TvcmModulesForRegister.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TvcmModulesForRegister <> nil;
end;//TvcmModulesForRegister.Exists
{$IfEnd} // NOT Defined(NoVCM)

end.
