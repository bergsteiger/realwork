unit vcmFormSetFormsCollectionItem;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM$Visual"
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/Visual/vcmFormSetFormsCollectionItem.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VCM$Visual::FormSets::TvcmFormSetFormsCollectionItem
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
  vcmFormSetFormsCollectionItemPrim,
  vcmFormSetFormsCollectionPrimPrim
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
type
 TvcmFormSetFormsCollectionItem = class(TvcmFormSetFormsCollectionItemPrim)
 private
 // private fields
   f_Childs : TvcmFormSetFormsCollectionPrimPrim;
    {* Поле для свойства Childs}
 protected
 // property methods
   function pm_GetFormId: TvcmFormID;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 protected
 // protected methods
   procedure CheckChilds;
     {* Сигнатура метода CheckChilds }
 public
 // public methods
   function MakeZoneType: TvcmZoneType;
     {* в случае если у формы указана зона vcm_ztModal, меняем ее на
vcm_ztManualModal, т.к. главную форму можно показывать только после
создания всех дочерних форм. }
   function IsSame(const aForm: IvcmEntityForm): Boolean;
 public
 // public properties
   property FormId: TvcmFormID
     read pm_GetFormId;
   property Childs: TvcmFormSetFormsCollectionPrimPrim
     read f_Childs;
 end;//TvcmFormSetFormsCollectionItem
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}
uses
  SysUtils,
  Classes,
  vcmBase,
  vcmEntityForm,
  vcmFormSetFormsCollection,
  vcmBaseTypes
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}

// start class TvcmFormSetFormsCollectionItem

function TvcmFormSetFormsCollectionItem.MakeZoneType: TvcmZoneType;
//#UC START# *511CD84A009F_4FFC32AE0164_var*
//#UC END# *511CD84A009F_4FFC32AE0164_var*
begin
//#UC START# *511CD84A009F_4FFC32AE0164_impl*
 if ZoneType = vcm_ztModal then
  Result := vcm_ztManualModal
 else
  Result := ZoneType;
//#UC END# *511CD84A009F_4FFC32AE0164_impl*
end;//TvcmFormSetFormsCollectionItem.MakeZoneType

function TvcmFormSetFormsCollectionItem.IsSame(const aForm: IvcmEntityForm): Boolean;
//#UC START# *511CD887038E_4FFC32AE0164_var*
//#UC END# *511CD887038E_4FFC32AE0164_var*
begin
//#UC START# *511CD887038E_4FFC32AE0164_impl*
 Assert(FormDescriptor <> nil);
 if Assigned(aForm) then
  Result := (aForm.UserType = Self.UserType) and
            (aForm.ZoneType = Self.ZoneType) and
            ((aForm.VCLWinControl as TvcmEntityForm).FormID.
             EQ(FormDescriptor^.rFormID))
 else
  Result := false;
//#UC END# *511CD887038E_4FFC32AE0164_impl*
end;//TvcmFormSetFormsCollectionItem.IsSame

procedure TvcmFormSetFormsCollectionItem.CheckChilds;
//#UC START# *511CD8A30163_4FFC32AE0164_var*
//#UC END# *511CD8A30163_4FFC32AE0164_var*
begin
//#UC START# *511CD8A30163_4FFC32AE0164_impl*
 if (f_Childs = nil) then
  f_Childs := TvcmFormSetFormsCollection.Create;
//#UC END# *511CD8A30163_4FFC32AE0164_impl*
end;//TvcmFormSetFormsCollectionItem.CheckChilds

function TvcmFormSetFormsCollectionItem.pm_GetFormId: TvcmFormID;
//#UC START# *511CD7C201AC_4FFC32AE0164get_var*
//#UC END# *511CD7C201AC_4FFC32AE0164get_var*
begin
//#UC START# *511CD7C201AC_4FFC32AE0164get_impl*
 Assert(FormDescriptor <> nil);
 Result := FormDescriptor^.rFormID;
//#UC END# *511CD7C201AC_4FFC32AE0164get_impl*
end;//TvcmFormSetFormsCollectionItem.pm_GetFormId

procedure TvcmFormSetFormsCollectionItem.Cleanup;
//#UC START# *479731C50290_4FFC32AE0164_var*
//#UC END# *479731C50290_4FFC32AE0164_var*
begin
//#UC START# *479731C50290_4FFC32AE0164_impl*
 vcmFree(f_Childs);
 inherited;
//#UC END# *479731C50290_4FFC32AE0164_impl*
end;//TvcmFormSetFormsCollectionItem.Cleanup

{$IfEnd} //not NoVCM

end.