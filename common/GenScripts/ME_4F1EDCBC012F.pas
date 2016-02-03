unit vcmFormGUIDFromMainFormList;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Visual\vcmFormGUIDFromMainFormList.pas"
// Стереотип: "SimpleClass"

{$Include vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , l3ProtoDataContainer
 , vcmInterfaces
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
 , vcmMainForm
;

type
 TvcmFormGUIDFromMainFormRec = object
  public
   rMainForm: TvcmMainForm;
   rGUID: TGUID;
 end;//TvcmFormGUIDFromMainFormRec

 _ItemType_ = TvcmFormGUIDFromMainFormRec;
 _l3RecordListPrim_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include l3RecordListPrim.imp.pas}
 TvcmFormGUIDFromMainFormList = class(_l3RecordListPrim_)
  protected
   procedure InitFields; override;
  public
   procedure CreateFormGUID(const aForm: IvcmEntityForm;
    var theGUID: TGUID);
 end;//TvcmFormGUIDFromMainFormList

function TvcmFormGUIDFromMainFormRec_C(aMainForm: TvcmMainForm;
 const aGUID: TGUID): TvcmFormGUIDFromMainFormRec; overload;
function TvcmFormGUIDFromMainFormRec_C(aMainForm: TvcmMainForm): TvcmFormGUIDFromMainFormRec; overload;
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

function TvcmFormGUIDFromMainFormRec_C(aMainForm: TvcmMainForm;
 const aGUID: TGUID): TvcmFormGUIDFromMainFormRec;
//#UC START# *4F1EDD7B0180_4F1EDD2901A2_var*
//#UC END# *4F1EDD7B0180_4F1EDD2901A2_var*
begin
 Finalize(Result);
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *4F1EDD7B0180_4F1EDD2901A2_impl*
 Result.rMainForm := aMainForm;
 Result.rGUID := aGUID;
//#UC END# *4F1EDD7B0180_4F1EDD2901A2_impl*
end;//TvcmFormGUIDFromMainFormRec_C

function TvcmFormGUIDFromMainFormRec_C(aMainForm: TvcmMainForm): TvcmFormGUIDFromMainFormRec;
//#UC START# *4F1EDDA3036D_4F1EDD2901A2_var*
var
 l_GUID : TGUID;
//#UC END# *4F1EDDA3036D_4F1EDD2901A2_var*
begin
 Finalize(Result);
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *4F1EDDA3036D_4F1EDD2901A2_impl*
 SysUtils.CreateGUID(l_GUID);
 Result := TvcmFormGUIDFromMainFormRec_C(aMainForm, l_GUID);
//#UC END# *4F1EDDA3036D_4F1EDD2901A2_impl*
end;//TvcmFormGUIDFromMainFormRec_C

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_); forward;
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)
function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If NOT Defined(l3Items_IsAtomic)}
function IsSameItems(const A: _ItemType_;
 const B: _ItemType_): Boolean;
 {* Сравнивает элементы списка }
//#UC START# *47B07CF403D0_4F1EDCBC012F_var*
//#UC END# *47B07CF403D0_4F1EDCBC012F_var*
begin
//#UC START# *47B07CF403D0_4F1EDCBC012F_impl*
 Result := (A.rMainForm = B.rMainForm);
//#UC END# *47B07CF403D0_4F1EDCBC012F_impl*
end;//IsSameItems
{$IfEnd} // NOT Defined(l3Items_IsAtomic)

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_4F1EDCBC012F_var*
//#UC END# *47B2C42A0163_4F1EDCBC012F_var*
begin
//#UC START# *47B2C42A0163_4F1EDCBC012F_impl*
 Assert(false);
//#UC END# *47B2C42A0163_4F1EDCBC012F_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_4F1EDCBC012F_var*
//#UC END# *47B99D4503A2_4F1EDCBC012F_var*
begin
//#UC START# *47B99D4503A2_4F1EDCBC012F_impl*
 Result := Integer(CI.rA.rMainForm) - Integer(CI.rB.rMainForm);
//#UC END# *47B99D4503A2_4F1EDCBC012F_impl*
end;//CompareExistingItems

type _Instance_R_ = TvcmFormGUIDFromMainFormList;

{$Include l3RecordListPrim.imp.pas}

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

procedure TvcmFormGUIDFromMainFormList.InitFields;
//#UC START# *47A042E100E2_4F1EDCBC012F_var*
//#UC END# *47A042E100E2_4F1EDCBC012F_var*
begin
//#UC START# *47A042E100E2_4F1EDCBC012F_impl*
 inherited;
 Sorted := true;
//#UC END# *47A042E100E2_4F1EDCBC012F_impl*
end;//TvcmFormGUIDFromMainFormList.InitFields
{$IfEnd} // NOT Defined(NoVCM)

end.
