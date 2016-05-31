unit dsFolderElement;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Folders\dsFolderElement.pas"
// Стереотип: "ViewAreaControllerImp"
// Элемент модели: "TdsFolderElement" MUID: (492195FE01B3)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , FoldersInterfaces
 , FoldersDomainInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3ProtoObjectWithCOMQI
 {$If NOT Defined(NoVCM)}
 , vcmLocalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Interfaces
 , l3NotifyPtrList
;

type
 _FormDataSourceType_ = IdsFolderElement;
 {$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSourcePrim.imp.pas}
 TdsFolderElement = class(_vcmFormDataSourcePrim_, IdsFolderElement)
  private
   f_SaveObject: IdeSaveObject;
  protected
   function pm_GetSaveObject: IdeSaveObject;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
 end;//TdsFolderElement
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , deSaveObject
 , l3InterfacesMisc
 , SysUtils
 , l3Base
;

{$If NOT Defined(NoVCM)}
type _Instance_R_ = TdsFolderElement;

{$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSourcePrim.imp.pas}

function TdsFolderElement.pm_GetSaveObject: IdeSaveObject;
//#UC START# *492192AA0144_492195FE01B3get_var*
//#UC END# *492192AA0144_492195FE01B3get_var*
begin
//#UC START# *492192AA0144_492195FE01B3get_impl*
 if not Assigned(f_SaveObject) then
  f_SaveObject := TdeSaveObject.Make;
 Result := f_SaveObject;
//#UC END# *492192AA0144_492195FE01B3get_impl*
end;//TdsFolderElement.pm_GetSaveObject

procedure TdsFolderElement.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_492195FE01B3_var*
//#UC END# *479731C50290_492195FE01B3_var*
begin
//#UC START# *479731C50290_492195FE01B3_impl*
 f_SaveObject := nil;
 inherited;
//#UC END# *479731C50290_492195FE01B3_impl*
end;//TdsFolderElement.Cleanup
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
