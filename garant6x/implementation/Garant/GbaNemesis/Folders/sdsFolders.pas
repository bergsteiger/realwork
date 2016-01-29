unit sdsFolders;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Folders"
// Автор: Морозов М.А.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Folders/sdsFolders.pas"
// Начат: 2006/05/03 14:59:45
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UseCaseControllerImp::Class>> F1 Основные прецеденты::Folders::Folders::Folders::TsdsFolders
//
// Прецедент "Папки"
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  FoldersInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmControllers
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmExternalInterfaces
  {$IfEnd} //not NoVCM
  ,
  l3ProtoObjectWithCOMQI,
  l3Interfaces,
  l3NotifyPtrList
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 _SetType_ = IsdsFolders;
 {$Include w:\common\components\gui\Garant\VCM\implementation\vcmTinyUseCaseController.imp.pas}
 TsdsFolders = {ucc} class(_vcmTinyUseCaseController_, IsdsFolders)
  {* Прецедент "Папки" }
 private
 // private fields
   f_dsFolders : IvcmViewAreaControllerRef;
    {* Поле для области вывода dsFolders}
   f_dsFoldersTree : IvcmViewAreaControllerRef;
    {* Поле для области вывода dsFoldersTree}
   f_dsFolderElement : IvcmViewAreaControllerRef;
    {* Поле для области вывода dsFolderElement}
 protected
 // realized methods
   function pm_GetDsFolders: IdsFolders;
   function DoGet_dsFolders: IdsFolders;
   function pm_GetDsFoldersTree: IdsFoldersTree;
   function DoGet_dsFoldersTree: IdsFoldersTree;
   function pm_GetDsFolderElement: IdsFolderElement;
   function DoGet_dsFolderElement: IdsFolderElement;
 protected
 // overridden protected methods
   {$If not defined(NoVCM)}
   procedure ClearAreas; override;
     {* Очищает ссылки на области ввода }
   {$IfEnd} //not NoVCM
 end;//TsdsFolders
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  dsFolders,
  dsFoldersTree,
  dsFolderElement
  {$If not defined(NoVCM)}
  ,
  vcmLocalInterfaces
  {$IfEnd} //not NoVCM
  ,
  l3Base,
  SysUtils,
  vcmFormDataSourceRef {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

type _Instance_R_ = TsdsFolders;

{$Include w:\common\components\gui\Garant\VCM\implementation\vcmTinyUseCaseController.imp.pas}

// start class TsdsFolders

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
end;

function TsdsFolders.DoGet_dsFolders: IdsFolders;
//#UC START# *492EAE8B01AC_492EE1A80008area_var*
//#UC END# *492EAE8B01AC_492EE1A80008area_var*
begin
//#UC START# *492EAE8B01AC_492EE1A80008area_impl*
 Result := TdsFolders.Make(Self);
//#UC END# *492EAE8B01AC_492EE1A80008area_impl*
end;//TsdsFolders.DoGet_dsFolders

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
end;

function TsdsFolders.DoGet_dsFoldersTree: IdsFoldersTree;
//#UC START# *492EB06D013C_492EE1A80008area_var*
//#UC END# *492EB06D013C_492EE1A80008area_var*
begin
//#UC START# *492EB06D013C_492EE1A80008area_impl*
 Result := TdsFoldersTree.Make(Self);
//#UC END# *492EB06D013C_492EE1A80008area_impl*
end;//TsdsFolders.DoGet_dsFoldersTree

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
end;

function TsdsFolders.DoGet_dsFolderElement: IdsFolderElement;
//#UC START# *492EB098008A_492EE1A80008area_var*
//#UC END# *492EB098008A_492EE1A80008area_var*
begin
//#UC START# *492EB098008A_492EE1A80008area_impl*
 Result := TdsFolderElement.Make(Self);
//#UC END# *492EB098008A_492EE1A80008area_impl*
end;//TsdsFolders.DoGet_dsFolderElement

{$If not defined(NoVCM)}
procedure TsdsFolders.ClearAreas;
 {-}
begin
 if (f_dsFolders <> nil) then f_dsFolders.Referred := nil;
 if (f_dsFoldersTree <> nil) then f_dsFoldersTree.Referred := nil;
 if (f_dsFolderElement <> nil) then f_dsFolderElement.Referred := nil;
 inherited;
end;//TsdsFolders.ClearAreas
{$IfEnd} //not NoVCM

{$IfEnd} //not Admin AND not Monitorings

end.