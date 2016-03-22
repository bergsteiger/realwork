unit vcmFormSetFormsCollectionItemPrim;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Visual\vcmFormSetFormsCollectionItemPrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TvcmFormSetFormsCollectionItemPrim" MUID: (4FFC337003AF)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , l3ProtoObject
 , vcmInterfaces
 , l3Interfaces
 , vcmUserControls
;

type
 TvcmNeedMakeFormEvent = function(const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  aSubUserType: TvcmUserType): Boolean of object;
  {* данные необходимые для создания формы }

 TvcmOnFormWeight = function(out aWeight: Integer): Boolean of object;
  {* определить вес для формы }

 TvcmFormCountEvent = procedure(const aDataSource: IvcmFormSetDataSource;
  out aCount: Integer) of object;
  {* количество форм которое необходимо создать }

 TvcmFormSetFormsCollectionItemPrim = class(Tl3ProtoObject)
  private
   f_FormDescriptor: PvcmFormDescriptor;
    {* Поле для свойства FormDescriptor }
   f_Name: AnsiString;
    {* Поле для свойства Name }
   f_Caption: Il3CString;
    {* Поле для свойства Caption }
   f_OnFormCount: TvcmFormCountEvent;
    {* Поле для свойства OnFormCount }
   f_OnNeedMakeForm: TvcmNeedMakeFormEvent;
    {* Поле для свойства OnNeedMakeForm }
   f_OnFormWeight: TvcmOnFormWeight;
    {* Поле для свойства OnFormWeight }
   f_UserType: TvcmUserType;
    {* Поле для свойства UserType }
   f_ActivateIfUpdate: TvcmActivateIfUpdate;
    {* Поле для свойства ActivateIfUpdate }
   f_ZoneType: TvcmZoneType;
    {* Поле для свойства ZoneType }
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
   procedure ClearFields; override;
  public
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
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
;

procedure TvcmFormSetFormsCollectionItemPrim.Cleanup;
 {* Функция очистки полей объекта. }
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
begin
 Name := '';
 Caption := nil;
 inherited;
end;//TvcmFormSetFormsCollectionItemPrim.ClearFields
{$IfEnd} // NOT Defined(NoVCM)

end.
