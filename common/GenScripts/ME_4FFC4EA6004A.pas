unit vcmFormSetFormsCollectionItemModelPart;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Visual\vcmFormSetFormsCollectionItemModelPart.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmFormSetFormsCollectionItem
 , vcmFormSetFormItemList
 , vcmInterfaces
 , vcmBaseTypes
 , vcmUserControls
;

type
 TvcmFormSetFormsCollectionItemModelPart = class(TvcmFormSetFormsCollectionItem)
  private
   f_FormList: TvcmFormSetFormList;
    {* Поле для свойства FormList }
  protected
   function pm_GetFormList: TvcmFormSetFormList; virtual;
   procedure pm_SetFormList(aValue: TvcmFormSetFormList); virtual;
  public
   function AddZone(const aName: AnsiString;
    aZoneType: TvcmZoneType;
    const aFormDescriptor: TvcmFormDescriptor): TvcmFormSetFormsCollectionItemModelPart; overload;
   function AddZone(const aName: AnsiString;
    aZoneType: TvcmZoneType;
    const aFormDescriptor: TvcmFormDescriptor;
    aUserType: TvcmUserType;
    aNeedMakeDS: TvcmNeedMakeDS = vcmBaseTypes.vcm_nmNo): TvcmFormSetFormsCollectionItemModelPart; overload;
  public
   property FormList: TvcmFormSetFormList
    read pm_GetFormList
    write pm_SetFormList;
 end;//TvcmFormSetFormsCollectionItemModelPart
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , vcmFormSetFormsCollectionPrim
;

function TvcmFormSetFormsCollectionItemModelPart.pm_GetFormList: TvcmFormSetFormList;
//#UC START# *528DB966026A_4FFC4EA6004Aget_var*
//#UC END# *528DB966026A_4FFC4EA6004Aget_var*
begin
//#UC START# *528DB966026A_4FFC4EA6004Aget_impl*
 Result := f_FormList;
//#UC END# *528DB966026A_4FFC4EA6004Aget_impl*
end;//TvcmFormSetFormsCollectionItemModelPart.pm_GetFormList

procedure TvcmFormSetFormsCollectionItemModelPart.pm_SetFormList(aValue: TvcmFormSetFormList);
//#UC START# *528DB966026A_4FFC4EA6004Aset_var*
//#UC END# *528DB966026A_4FFC4EA6004Aset_var*
begin
//#UC START# *528DB966026A_4FFC4EA6004Aset_impl*
 f_FormList := aValue;
//#UC END# *528DB966026A_4FFC4EA6004Aset_impl*
end;//TvcmFormSetFormsCollectionItemModelPart.pm_SetFormList

function TvcmFormSetFormsCollectionItemModelPart.AddZone(const aName: AnsiString;
 aZoneType: TvcmZoneType;
 const aFormDescriptor: TvcmFormDescriptor): TvcmFormSetFormsCollectionItemModelPart;
//#UC START# *4FFC4EDE01B9_4FFC4EA6004A_var*
//#UC END# *4FFC4EDE01B9_4FFC4EA6004A_var*
begin
//#UC START# *4FFC4EDE01B9_4FFC4EA6004A_impl*
 CheckChilds;
 Result := TvcmFormSetFormsCollectionPrim(Childs).AddZone(aName, aZoneType, aFormDescriptor);
 Result.FormList := FormList;
//#UC END# *4FFC4EDE01B9_4FFC4EA6004A_impl*
end;//TvcmFormSetFormsCollectionItemModelPart.AddZone

function TvcmFormSetFormsCollectionItemModelPart.AddZone(const aName: AnsiString;
 aZoneType: TvcmZoneType;
 const aFormDescriptor: TvcmFormDescriptor;
 aUserType: TvcmUserType;
 aNeedMakeDS: TvcmNeedMakeDS = vcmBaseTypes.vcm_nmNo): TvcmFormSetFormsCollectionItemModelPart;
//#UC START# *528DB98D00C0_4FFC4EA6004A_var*
//#UC END# *528DB98D00C0_4FFC4EA6004A_var*
begin
//#UC START# *528DB98D00C0_4FFC4EA6004A_impl*
 Result := AddZone(aName, aZoneType, aFormDescriptor);
 Result.UserType := aUserType;
 if (FormList <> nil) then
  FormList.Add(TvcmFormSetFormItem_C(TvcmFormSetFormItemDescr_C(aFormDescriptor.rFormID,
   aZoneType, aUserType), aNeedMakeDS));
//#UC END# *528DB98D00C0_4FFC4EA6004A_impl*
end;//TvcmFormSetFormsCollectionItemModelPart.AddZone
{$IfEnd} // NOT Defined(NoVCM)

end.
