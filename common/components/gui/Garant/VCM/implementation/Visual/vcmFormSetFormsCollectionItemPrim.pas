unit vcmFormSetFormsCollectionItemPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM$Visual"
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/Visual/vcmFormSetFormsCollectionItemPrim.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VCM$Visual::FormSets::TvcmFormSetFormsCollectionItemPrim
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
  l3Interfaces,
  vcmInterfaces,
  vcmUserControls,
  l3ProtoObject
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
type
 TvcmNeedMakeFormEvent = function (const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  aSubUserType: TvcmUserType): Boolean of object;

 TvcmOnFormWeight = function (out aWeight: Integer): Boolean of object;

 TvcmFormCountEvent = procedure (const aDataSource: IvcmFormSetDataSource;
  out aCount: Integer) of object;

 TvcmFormSetFormsCollectionItemPrim = class(Tl3ProtoObject)
 private
 // private fields
   f_FormDescriptor : PvcmFormDescriptor;
    {* Поле для свойства FormDescriptor}
   f_Name : AnsiString;
    {* Поле для свойства Name}
   f_Caption : Il3CString;
    {* Поле для свойства Caption}
   f_OnFormCount : TvcmFormCountEvent;
    {* Поле для свойства OnFormCount}
   f_OnNeedMakeForm : TvcmNeedMakeFormEvent;
    {* Поле для свойства OnNeedMakeForm}
   f_OnFormWeight : TvcmOnFormWeight;
    {* Поле для свойства OnFormWeight}
   f_UserType : TvcmUserType;
    {* Поле для свойства UserType}
   f_ActivateIfUpdate : TvcmActivateIfUpdate;
    {* Поле для свойства ActivateIfUpdate}
   f_ZoneType : TvcmZoneType;
    {* Поле для свойства ZoneType}
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure InitFields; override;
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public properties
   property FormDescriptor: PvcmFormDescriptor
     read f_FormDescriptor
     write f_FormDescriptor;
   property Name: AnsiString
     read f_Name
     write f_Name;
   property Caption: Il3CString
     read f_Caption
     write f_Caption;
   property OnFormCount: TvcmFormCountEvent
     read f_OnFormCount
     write f_OnFormCount;
   property OnNeedMakeForm: TvcmNeedMakeFormEvent
     read f_OnNeedMakeForm
     write f_OnNeedMakeForm;
     {* данные необходимые для создания формы }
   property OnFormWeight: TvcmOnFormWeight
     read f_OnFormWeight
     write f_OnFormWeight;
     {* событие определения веса для формы }
   property UserType: TvcmUserType
     read f_UserType
     write f_UserType;
   property ActivateIfUpdate: TvcmActivateIfUpdate
     read f_ActivateIfUpdate
     write f_ActivateIfUpdate;
     {* определяет нужно ли сделать активной закладку с формой в случае
           изменения источника данных }
   property ZoneType: TvcmZoneType
     read f_ZoneType
     write f_ZoneType;
 end;//TvcmFormSetFormsCollectionItemPrim
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}

// start class TvcmFormSetFormsCollectionItemPrim

procedure TvcmFormSetFormsCollectionItemPrim.Cleanup;
//#UC START# *479731C50290_4FFC337003AF_var*
//#UC END# *479731C50290_4FFC337003AF_var*
begin
//#UC START# *479731C50290_4FFC337003AF_impl*
 f_Caption := nil;
 inherited;
//#UC END# *479731C50290_4FFC337003AF_impl*
end;//TvcmFormSetFormsCollectionItemPrim.Cleanup

procedure TvcmFormSetFormsCollectionItemPrim.InitFields;
//#UC START# *47A042E100E2_4FFC337003AF_var*
//#UC END# *47A042E100E2_4FFC337003AF_var*
begin
//#UC START# *47A042E100E2_4FFC337003AF_impl*
 inherited;
 f_UserType := vcm_utAny;
 f_ActivateIfUpdate := wafNone;
//#UC END# *47A042E100E2_4FFC337003AF_impl*
end;//TvcmFormSetFormsCollectionItemPrim.InitFields

procedure TvcmFormSetFormsCollectionItemPrim.ClearFields;
 {-}
begin
 {$If not defined(NoVCM)}
 Caption := nil;
 {$IfEnd} //not NoVCM
 inherited;
end;//TvcmFormSetFormsCollectionItemPrim.ClearFields

{$IfEnd} //not NoVCM

end.