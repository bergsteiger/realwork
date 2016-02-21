unit vcmFormSetFormsCollectionPrim;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Visual\vcmFormSetFormsCollectionPrim.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmFormSetFormsCollectionPrimPrim
 , vcmFormSetFormItemList
 , vcmFormSetFormsCollectionItemModelPart
 , vcmInterfaces
 , vcmBaseTypes
 , vcmUserControls
;

type
 TvcmFormSetFormsCollectionPrim = class(TvcmFormSetFormsCollectionPrimPrim)
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
    aNeedMakeDS: TvcmNeedMakeDS = vcm_nmNo): TvcmFormSetFormsCollectionItemModelPart; overload;
  public
   property FormList: TvcmFormSetFormList
    read pm_GetFormList
    write pm_SetFormList;
 end;//TvcmFormSetFormsCollectionPrim
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , vcmFormSetFormsCollectionItem
 , SysUtils
 , vcmControllers
;

function TvcmFormSetFormsCollectionPrim.pm_GetFormList: TvcmFormSetFormList;
//#UC START# *528DBAA4009A_4FFC4CD30122get_var*
//#UC END# *528DBAA4009A_4FFC4CD30122get_var*
begin
//#UC START# *528DBAA4009A_4FFC4CD30122get_impl*
 Result := f_FormList;
//#UC END# *528DBAA4009A_4FFC4CD30122get_impl*
end;//TvcmFormSetFormsCollectionPrim.pm_GetFormList

procedure TvcmFormSetFormsCollectionPrim.pm_SetFormList(aValue: TvcmFormSetFormList);
//#UC START# *528DBAA4009A_4FFC4CD30122set_var*
//#UC END# *528DBAA4009A_4FFC4CD30122set_var*
begin
//#UC START# *528DBAA4009A_4FFC4CD30122set_impl*
 f_FormList := aValue;
//#UC END# *528DBAA4009A_4FFC4CD30122set_impl*
end;//TvcmFormSetFormsCollectionPrim.pm_SetFormList

function TvcmFormSetFormsCollectionPrim.AddZone(const aName: AnsiString;
 aZoneType: TvcmZoneType;
 const aFormDescriptor: TvcmFormDescriptor): TvcmFormSetFormsCollectionItemModelPart;
//#UC START# *4FFC4D6E00E1_4FFC4CD30122_var*
var
 l_Item : TvcmFormSetFormsCollectionItemModelPart;
//#UC END# *4FFC4D6E00E1_4FFC4CD30122_var*
begin
//#UC START# *4FFC4D6E00E1_4FFC4CD30122_impl*
 l_Item := TvcmFormSetFormsCollectionItemModelPart.Create;
 try
  Add(l_Item);
  Result := l_Item;
 finally
  FreeAndNil(l_Item);
 end;//try..finally
 Result.Name := aName;
 Result.FormDescriptor := @aFormDescriptor;
 //Result.FormName := aFormDescriptor.rName;
 Result.ZoneType := aZoneType;
 Result.FormList := FormList;
//#UC END# *4FFC4D6E00E1_4FFC4CD30122_impl*
end;//TvcmFormSetFormsCollectionPrim.AddZone

function TvcmFormSetFormsCollectionPrim.AddZone(const aName: AnsiString;
 aZoneType: TvcmZoneType;
 const aFormDescriptor: TvcmFormDescriptor;
 aUserType: TvcmUserType;
 aNeedMakeDS: TvcmNeedMakeDS = vcm_nmNo): TvcmFormSetFormsCollectionItemModelPart;
//#UC START# *528B3B1702DF_4FFC4CD30122_var*
//#UC END# *528B3B1702DF_4FFC4CD30122_var*
begin
//#UC START# *528B3B1702DF_4FFC4CD30122_impl*
 Result := AddZone(aName, aZoneType, aFormDescriptor);
 Result.UserType := aUserType;
 if (FormList <> nil) then
  FormList.Add(TvcmFormSetFormItem_C(TvcmFormSetFormItemDescr_C(aFormDescriptor.rFormID,
   aZoneType, aUserType), aNeedMakeDS));
//#UC END# *528B3B1702DF_4FFC4CD30122_impl*
end;//TvcmFormSetFormsCollectionPrim.AddZone
{$IfEnd} // NOT Defined(NoVCM)

end.
