unit vcmFormGUIDFromMainFormList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM$Visual"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/Visual/vcmFormGUIDFromMainFormList.pas"
// Начат: 24.01.2012 20:37
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VCM$Visual::Visual::TvcmFormGUIDFromMainFormList
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  vcmInterfaces,
  vcmMainForm,
  l3ProtoDataContainer,
  l3Memory,
  l3Interfaces,
  l3Types,
  l3Core,
  l3Except,
  Classes
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
type
 TvcmFormGUIDFromMainFormRec = {$IfDef XE4}record{$Else}object{$EndIf}
 public
   rMainForm : TvcmMainForm;
   rGUID : TGUID;
 end;//TvcmFormGUIDFromMainFormRec

 _ItemType_ = TvcmFormGUIDFromMainFormRec;
 _l3RecordListPrim_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3RecordListPrim.imp.pas}
 TvcmFormGUIDFromMainFormList = class(_l3RecordListPrim_)
 protected
 // overridden protected methods
   procedure InitFields; override;
 public
 // public methods
   procedure CreateFormGUID(const aForm: IvcmEntityForm;
     var theGUID: TGUID);
 end;//TvcmFormGUIDFromMainFormList
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
function TvcmFormGUIDFromMainFormRec_C(aMainForm: TvcmMainForm;
     const aGUID: TGUID): TvcmFormGUIDFromMainFormRec; overload;
{$IfEnd} //not NoVCM
{$If not defined(NoVCM)}
function TvcmFormGUIDFromMainFormRec_C(aMainForm: TvcmMainForm): TvcmFormGUIDFromMainFormRec; overload;
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}
uses
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}

// start class TvcmFormGUIDFromMainFormList

{$If defined(l3Items_NeedsAssignItem) AND not defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
  const aFrom: _ItemType_); forward;
{$IfEnd} //l3Items_NeedsAssignItem AND not l3Items_NoSort


function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If not defined(l3Items_IsAtomic)}
function IsSameItems(const A: _ItemType_;
  const B: _ItemType_): Boolean;
//#UC START# *47B07CF403D0_4F1EDCBC012F_var*
//#UC END# *47B07CF403D0_4F1EDCBC012F_var*
begin
//#UC START# *47B07CF403D0_4F1EDCBC012F_impl*
 Result := (A.rMainForm = B.rMainForm);
//#UC END# *47B07CF403D0_4F1EDCBC012F_impl*
end;//IsSameItems
{$IfEnd} //not l3Items_IsAtomic

{$If defined(l3Items_NeedsAssignItem) AND not defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
  const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_4F1EDCBC012F_var*
//#UC END# *47B2C42A0163_4F1EDCBC012F_var*
begin
//#UC START# *47B2C42A0163_4F1EDCBC012F_impl*
 Assert(false);
//#UC END# *47B2C42A0163_4F1EDCBC012F_impl*
end;//AssignItem
{$IfEnd} //l3Items_NeedsAssignItem AND not l3Items_NoSort

function CompareExistingItems(const CI: CompareItemsRec): Integer;
//#UC START# *47B99D4503A2_4F1EDCBC012F_var*
//#UC END# *47B99D4503A2_4F1EDCBC012F_var*
begin
//#UC START# *47B99D4503A2_4F1EDCBC012F_impl*
 Result := Integer(CI.rA.rMainForm) - Integer(CI.rB.rMainForm);
//#UC END# *47B99D4503A2_4F1EDCBC012F_impl*
end;//CompareExistingItems

type _Instance_R_ = TvcmFormGUIDFromMainFormList;

{$Include w:\common\components\rtl\Garant\L3\l3RecordListPrim.imp.pas}

// start class TvcmFormGUIDFromMainFormList

procedure TvcmFormGUIDFromMainFormList.CreateFormGUID(const aForm: IvcmEntityForm;
  var theGUID: TGUID);
//#UC START# *4F1EDDBF01BF_4F1EDCBC012F_var*
var
 l_Index : Integer;
 l_Item  : TvcmFormGUIDFromMainFormRec;
//#UC END# *4F1EDDBF01BF_4F1EDCBC012F_var*
begin
//#UC START# *4F1EDDBF01BF_4F1EDCBC012F_impl*
 l_Item.rMainForm := aForm.NativeMainForm.AsForm.VCLWinControl As TvcmMainForm;
 if FindData(l_Item, l_Index) then
  theGUID := Items[l_Index].rGUID
 else
 begin
  SysUtils.CreateGUID(l_Item.rGUID);
  theGUID := l_Item.rGUID;
  Add(l_Item);
 end;//FindData(l_Item, l_Index)
//#UC END# *4F1EDDBF01BF_4F1EDCBC012F_impl*
end;//TvcmFormGUIDFromMainFormList.CreateFormGUID

function TvcmFormGUIDFromMainFormRec_C(aMainForm: TvcmMainForm;
        const aGUID: TGUID): TvcmFormGUIDFromMainFormRec;
//#UC START# *4F1EDD7B0180_4F1EDD2901A2_var*
//#UC END# *4F1EDD7B0180_4F1EDD2901A2_var*
begin
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *4F1EDD7B0180_4F1EDD2901A2_impl*
 Result.rMainForm := aMainForm;
 Result.rGUID := aGUID;
//#UC END# *4F1EDD7B0180_4F1EDD2901A2_impl*
end;//TvcmFormGUIDFromMainFormRec.C


function TvcmFormGUIDFromMainFormRec_C(aMainForm: TvcmMainForm): TvcmFormGUIDFromMainFormRec;
//#UC START# *4F1EDDA3036D_4F1EDD2901A2_var*
var
 l_GUID : TGUID;
//#UC END# *4F1EDDA3036D_4F1EDD2901A2_var*
begin
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *4F1EDDA3036D_4F1EDD2901A2_impl*
 SysUtils.CreateGUID(l_GUID);
 Result := TvcmFormGUIDFromMainFormRec_C(aMainForm, l_GUID);
//#UC END# *4F1EDDA3036D_4F1EDD2901A2_impl*
end;//TvcmFormGUIDFromMainFormRec.C

// start class TvcmFormGUIDFromMainFormList

procedure TvcmFormGUIDFromMainFormList.InitFields;
//#UC START# *47A042E100E2_4F1EDCBC012F_var*
//#UC END# *47A042E100E2_4F1EDCBC012F_var*
begin
//#UC START# *47A042E100E2_4F1EDCBC012F_impl*
 inherited;
 Sorted := true;
//#UC END# *47A042E100E2_4F1EDCBC012F_impl*
end;//TvcmFormGUIDFromMainFormList.InitFields

{$IfEnd} //not NoVCM

end.