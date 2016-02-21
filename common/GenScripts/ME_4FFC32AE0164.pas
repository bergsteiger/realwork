unit vcmFormSetFormsCollectionItem;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Visual\vcmFormSetFormsCollectionItem.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmFormSetFormsCollectionItemPrim
 , vcmInterfaces
 , vcmFormSetFormsCollectionPrimPrim
;

type
 TvcmFormSetFormsCollectionItem = class(TvcmFormSetFormsCollectionItemPrim)
  private
   f_Childs: TvcmFormSetFormsCollectionPrimPrim;
    {* Поле для свойства Childs }
  protected
   function pm_GetFormId: TvcmFormID;
   procedure CheckChilds;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   function MakeZoneType: TvcmZoneType;
    {* в случае если у формы указана зона vcm_ztModal, меняем ее на
vcm_ztManualModal, т.к. главную форму можно показывать только после
создания всех дочерних форм. }
   function IsSame(const aForm: IvcmEntityForm): Boolean;
  public
   property FormId: TvcmFormID
    read pm_GetFormId;
   property Childs: TvcmFormSetFormsCollectionPrimPrim
    read f_Childs;
 end;//TvcmFormSetFormsCollectionItem
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , SysUtils
 , Classes
 , vcmBase
 , vcmEntityForm
 , vcmFormSetFormsCollection
 , vcmBaseTypes
;

function TvcmFormSetFormsCollectionItem.pm_GetFormId: TvcmFormID;
//#UC START# *511CD7C201AC_4FFC32AE0164get_var*
//#UC END# *511CD7C201AC_4FFC32AE0164get_var*
begin
//#UC START# *511CD7C201AC_4FFC32AE0164get_impl*
 Assert(FormDescriptor <> nil);
 Result := FormDescriptor^.rFormID;
//#UC END# *511CD7C201AC_4FFC32AE0164get_impl*
end;//TvcmFormSetFormsCollectionItem.pm_GetFormId

function TvcmFormSetFormsCollectionItem.MakeZoneType: TvcmZoneType;
 {* в случае если у формы указана зона vcm_ztModal, меняем ее на
vcm_ztManualModal, т.к. главную форму можно показывать только после
создания всех дочерних форм. }
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

procedure TvcmFormSetFormsCollectionItem.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4FFC32AE0164_var*
//#UC END# *479731C50290_4FFC32AE0164_var*
begin
//#UC START# *479731C50290_4FFC32AE0164_impl*
 vcmFree(f_Childs);
 inherited;
//#UC END# *479731C50290_4FFC32AE0164_impl*
end;//TvcmFormSetFormsCollectionItem.Cleanup
{$IfEnd} // NOT Defined(NoVCM)

end.
