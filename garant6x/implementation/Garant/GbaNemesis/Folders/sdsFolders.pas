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
   function pm_GetDsFolders: IdsFolders;
   function DoGet_DsFolders: IdsFolders;
   function pm_GetDsFoldersTree: IdsFoldersTree;
   function DoGet_DsFoldersTree: IdsFoldersTree;
   function pm_GetDsFolderElement: IdsFolderElement;
   function DoGet_DsFolderElement: IdsFolderElement;
   procedure ClearFields; override;
   {$If NOT Defined(NoVCM)}
   procedure ClearAreas; override;
    {* Очищает ссылки на области ввода }
   {$IfEnd} // NOT Defined(NoVCM)
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
 {$If NOT Defined(NoVCM)}
 , vcmFormDataSourceRef
 {$IfEnd} // NOT Defined(NoVCM)
;

{$If NOT Defined(NoVCM)}
type _Instance_R_ = TsdsFolders;

{$Include w:\common\components\gui\Garant\VCM\implementation\vcmTinyUseCaseController.imp.pas}

function TsdsFolders.pm_GetDsFolders: IdsFolders;
//#UC START# *492EAE8B01AC_492EE1A80008get_var*
//#UC END# *492EAE8B01AC_492EE1A80008get_var*
begin
 if (f_dsFolders = nil) then
 begin
  f_dsFolders := TvcmViewAreaControllerRef.Make;
  //#UC START# *492EAE8B01AC_492EE1A80008get_init*
  // - код инициализации ссылки на ViewArea
  //#UC END# *492EAE8B01AC_492EE1A80008get_init*
 end;//f_dsFolders = nil
 if f_dsFolders.IsEmpty
  //#UC START# *492EAE8B01AC_492EE1A80008get_need*
  // - условие создания ViewArea
  //#UC END# *492EAE8B01AC_492EE1A80008get_need*
  then
   f_dsFolders.Referred := DoGet_dsFolders;
 Result := IdsFolders(f_dsFolders.Referred);
end;//TsdsFolders.pm_GetDsFolders

function TsdsFolders.DoGet_DsFolders: IdsFolders;
//#UC START# *492EAE8B01AC_492EE1A80008area_var*
//#UC END# *492EAE8B01AC_492EE1A80008area_var*
begin
//#UC START# *492EAE8B01AC_492EE1A80008area_impl*
 Result := TdsFolders.Make(Self);
//#UC END# *492EAE8B01AC_492EE1A80008area_impl*
end;//TsdsFolders.DoGet_DsFolders

function TsdsFolders.pm_GetDsFoldersTree: IdsFoldersTree;
//#UC START# *492EB06D013C_492EE1A80008get_var*
//#UC END# *492EB06D013C_492EE1A80008get_var*
begin
 if (f_dsFoldersTree = nil) then
 begin
  f_dsFoldersTree := TvcmViewAreaControllerRef.Make;
  //#UC START# *492EB06D013C_492EE1A80008get_init*
  // - код инициализации ссылки на ViewArea
  //#UC END# *492EB06D013C_492EE1A80008get_init*
 end;//f_dsFoldersTree = nil
 if f_dsFoldersTree.IsEmpty
  //#UC START# *492EB06D013C_492EE1A80008get_need*
  // - условие создания ViewArea
  //#UC END# *492EB06D013C_492EE1A80008get_need*
  then
   f_dsFoldersTree.Referred := DoGet_dsFoldersTree;
 Result := IdsFoldersTree(f_dsFoldersTree.Referred);
end;//TsdsFolders.pm_GetDsFoldersTree

function TsdsFolders.DoGet_DsFoldersTree: IdsFoldersTree;
//#UC START# *492EB06D013C_492EE1A80008area_var*
//#UC END# *492EB06D013C_492EE1A80008area_var*
begin
//#UC START# *492EB06D013C_492EE1A80008area_impl*
 Result := TdsFoldersTree.Make(Self);
//#UC END# *492EB06D013C_492EE1A80008area_impl*
end;//TsdsFolders.DoGet_DsFoldersTree

function TsdsFolders.pm_GetDsFolderElement: IdsFolderElement;
//#UC START# *492EB098008A_492EE1A80008get_var*
//#UC END# *492EB098008A_492EE1A80008get_var*
begin
 if (f_dsFolderElement = nil) then
 begin
  f_dsFolderElement := TvcmViewAreaControllerRef.Make;
  //#UC START# *492EB098008A_492EE1A80008get_init*
  // - код инициализации ссылки на ViewArea
  //#UC END# *492EB098008A_492EE1A80008get_init*
 end;//f_dsFolderElement = nil
 if f_dsFolderElement.IsEmpty
  //#UC START# *492EB098008A_492EE1A80008get_need*
  // - условие создания ViewArea
  //#UC END# *492EB098008A_492EE1A80008get_need*
  then
   f_dsFolderElement.Referred := DoGet_dsFolderElement;
 Result := IdsFolderElement(f_dsFolderElement.Referred);
end;//TsdsFolders.pm_GetDsFolderElement

function TsdsFolders.DoGet_DsFolderElement: IdsFolderElement;
//#UC START# *492EB098008A_492EE1A80008area_var*
//#UC END# *492EB098008A_492EE1A80008area_var*
begin
//#UC START# *492EB098008A_492EE1A80008area_impl*
 Result := TdsFolderElement.Make(Self);
//#UC END# *492EB098008A_492EE1A80008area_impl*
end;//TsdsFolders.DoGet_DsFolderElement

procedure TsdsFolders.ClearFields;
begin
 f_dsFolders := nil;
 f_dsFoldersTree := nil;
 f_dsFolderElement := nil;
 inherited;
end;//TsdsFolders.ClearFields

procedure TsdsFolders.ClearAreas;
 {* Очищает ссылки на области ввода }
begin
 if (f_dsFolders <> nil) then f_dsFolders.Referred := nil;
 if (f_dsFoldersTree <> nil) then f_dsFoldersTree.Referred := nil;
 if (f_dsFolderElement <> nil) then f_dsFolderElement.Referred := nil;
 inherited;
end;//TsdsFolders.ClearAreas
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
