unit sdsFolders;
 {* Прецедент "Папки" }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Folders\sdsFolders.pas"
// Стереотип: "UseCaseControllerImp"
// Элемент модели: "TsdsFolders" MUID: (492EE1A80008)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , FoldersInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmControllers
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3ProtoObjectWithCOMQI
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Interfaces
 , l3NotifyPtrList
;

type
 _SetType_ = IsdsFolders;
 {$Include w:\common\components\gui\Garant\VCM\implementation\vcmTinyUseCaseController.imp.pas}
 TsdsFolders = class(_vcmTinyUseCaseController_, IsdsFolders)
  {* Прецедент "Папки" }
  private
   f_dsFolders: IvcmViewAreaControllerRef;
    {* Поле для области вывода dsFolders }
   f_dsFoldersTree: IvcmViewAreaControllerRef;
    {* Поле для области вывода dsFoldersTree }
   f_dsFolderElement: IvcmViewAreaControllerRef;
    {* Поле для области вывода dsFolderElement }
  protected
   function pm_GetdsFolders: IdsFolders;
   function pm_GetdsFoldersTree: IdsFoldersTree;
   function pm_GetdsFolderElement: IdsFolderElement;
   {$If NOT Defined(NoVCM)}
   procedure ClearAreas; override;
    {* Очищает ссылки на области ввода }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure ClearFields; override;
 end;//TsdsFolders
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , dsFolders
 , dsFoldersTree
 , dsFolderElement
 {$If NOT Defined(NoVCM)}
 , vcmLocalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Base
 , SysUtils
;

{$If NOT Defined(NoVCM)}
type _Instance_R_ = TsdsFolders;

{$Include w:\common\components\gui\Garant\VCM\implementation\vcmTinyUseCaseController.imp.pas}

function TsdsFolders.pm_GetdsFolders: IdsFolders;
//#UC START# *492EAE8B01AC_492EE1A80008get_var*
//#UC END# *492EAE8B01AC_492EE1A80008get_var*
begin
//#UC START# *492EAE8B01AC_492EE1A80008get_impl*
 !!! Needs to be implemented !!!
//#UC END# *492EAE8B01AC_492EE1A80008get_impl*
end;//TsdsFolders.pm_GetdsFolders

function TsdsFolders.pm_GetdsFoldersTree: IdsFoldersTree;
//#UC START# *492EB06D013C_492EE1A80008get_var*
//#UC END# *492EB06D013C_492EE1A80008get_var*
begin
//#UC START# *492EB06D013C_492EE1A80008get_impl*
 !!! Needs to be implemented !!!
//#UC END# *492EB06D013C_492EE1A80008get_impl*
end;//TsdsFolders.pm_GetdsFoldersTree

function TsdsFolders.pm_GetdsFolderElement: IdsFolderElement;
//#UC START# *492EB098008A_492EE1A80008get_var*
//#UC END# *492EB098008A_492EE1A80008get_var*
begin
//#UC START# *492EB098008A_492EE1A80008get_impl*
 !!! Needs to be implemented !!!
//#UC END# *492EB098008A_492EE1A80008get_impl*
end;//TsdsFolders.pm_GetdsFolderElement

procedure TsdsFolders.ClearAreas;
 {* Очищает ссылки на области ввода }
//#UC START# *4938F7E702B7_492EE1A80008_var*
//#UC END# *4938F7E702B7_492EE1A80008_var*
begin
//#UC START# *4938F7E702B7_492EE1A80008_impl*
 !!! Needs to be implemented !!!
//#UC END# *4938F7E702B7_492EE1A80008_impl*
end;//TsdsFolders.ClearAreas

procedure TsdsFolders.ClearFields;
begin
 f_dsFolders := nil;
 f_dsFoldersTree := nil;
 f_dsFolderElement := nil;
 inherited;
end;//TsdsFolders.ClearFields
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
