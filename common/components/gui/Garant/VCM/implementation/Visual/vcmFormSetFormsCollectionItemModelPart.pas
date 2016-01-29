unit vcmFormSetFormsCollectionItemModelPart;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM$Visual"
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/Visual/vcmFormSetFormsCollectionItemModelPart.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VCM$Visual::FormSets::TvcmFormSetFormsCollectionItemModelPart
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
  vcmUserControls,
  vcmFormSetFormsCollectionItem,
  vcmFormSetFormItemList,
  vcmBaseTypes
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
type
 TvcmFormSetFormsCollectionItemModelPart = class(TvcmFormSetFormsCollectionItem)
 private
 // private fields
   f_FormList : TvcmFormSetFormList;
    {* Поле для свойства FormList}
 protected
 // property methods
   function pm_GetFormList: TvcmFormSetFormList; virtual;
   procedure pm_SetFormList(aValue: TvcmFormSetFormList); virtual;
 public
 // public methods
   function AddZone(const aName: AnsiString;
     aZoneType: TvcmZoneType;
     const aFormDescriptor: TvcmFormDescriptor): TvcmFormSetFormsCollectionItemModelPart; overload; 
   function AddZone(const aName: AnsiString;
     aZoneType: TvcmZoneType;
     const aFormDescriptor: TvcmFormDescriptor;
     aUserType: TvcmUserType;
     aNeedMakeDS: TvcmNeedMakeDS = vcm_nmNo): TvcmFormSetFormsCollectionItemModelPart; overload; 
 public
 // public properties
   property FormList: TvcmFormSetFormList
     read pm_GetFormList
     write pm_SetFormList;
 end;//TvcmFormSetFormsCollectionItemModelPart
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}
uses
  vcmFormSetFormsCollectionPrim
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}

// start class TvcmFormSetFormsCollectionItemModelPart

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
  aNeedMakeDS: TvcmNeedMakeDS = vcm_nmNo): TvcmFormSetFormsCollectionItemModelPart;
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

{$IfEnd} //not NoVCM

end.