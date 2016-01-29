unit fsAACContents;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/AAC/fsAACContents.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMFormSetFactory::Class>> F1 Пользовательские сервисы::AAC::View::AAC::AACPrim::AACContents$FormSetFactory
//
// Сборка для документа ОГЛАВЛЕНИЯ ААК
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
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmFormSetFactory
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  Common_FormDefinitions_Controls,
  WorkWithDocumentInterfaces,
  DocumentUserTypes_dftAACContentsLeft_UserType,
  DocumentUserTypes_dftAACContentsRight_UserType,
  AACContentsContainer_Form
  {$If not defined(NoVCM)}
  ,
  vcmFormSetFormsCollectionItemPrim
  {$IfEnd} //not NoVCM
  ,
  AACContainerPrim_AACContentsContainer_UserType,
  nevTools,
  DocumentInterfaces,
  bsTypes,
  DocumentUnit,
  bsTypesNew,
  afwInterfaces,
  FoldersDomainInterfaces,
  DocumentAndListInterfaces,
  l3Interfaces
  {$If not defined(NoVCM)}
  ,
  vcmFormSetFactoryPrim
  {$IfEnd} //not NoVCM
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
  Tfs_AACContents = {final fsf} class(TvcmFormSetFactory)
   {* Сборка для документа ОГЛАВЛЕНИЯ ААК }
  protected
  // overridden protected methods
   procedure InitFields; override;
    {$If not defined(NoVCM)}
   class function GetInstance: TvcmFormSetFactoryPrim; override;
    {$IfEnd} //not NoVCM
  public
  // public methods
   function AACContainerParentAACContentsContainerNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      aSubUserType: TvcmUserType): Boolean;
     {* Обработчик OnNeedMakeForm для AACContainer }
   function LeftChildDftAACContentsLeftNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      aSubUserType: TvcmUserType): Boolean;
     {* Обработчик OnNeedMakeForm для Left }
   function RightMainDftAACContentsRightNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      aSubUserType: TvcmUserType): Boolean;
     {* Обработчик OnNeedMakeForm для Right }
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
  public
  // singleton factory method
    class function Instance: Tfs_AACContents;
     {- возвращает экземпляр синглетона. }
  end;//Tfs_AACContents
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3Base {a},
  SysUtils
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}


// start class Tfs_AACContents

var g_Tfs_AACContents : Tfs_AACContents = nil;

procedure Tfs_AACContentsFree;
begin
 l3Free(g_Tfs_AACContents);
end;

class function Tfs_AACContents.Instance: Tfs_AACContents;
begin
 if (g_Tfs_AACContents = nil) then
 begin
  l3System.AddExitProc(Tfs_AACContentsFree);
  g_Tfs_AACContents := Create;
 end;
 Result := g_Tfs_AACContents;
end;


function Tfs_AACContents.AACContainerParentAACContentsContainerNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  aSubUserType: TvcmUserType): Boolean;
var
 l_UseCase : IsdsAAC;
begin
 if Supports(aDataSource, IsdsAAC, l_UseCase) then
  try
   aNew := l_UseCase.Container;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_AACContents.AACContainerParentAACContentsContainerNeedMakeForm

function Tfs_AACContents.LeftChildDftAACContentsLeftNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  aSubUserType: TvcmUserType): Boolean;
var
 l_UseCase : IsdsAAC;
begin
 if Supports(aDataSource, IsdsAAC, l_UseCase) then
  try
   aNew := l_UseCase.Left;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_AACContents.LeftChildDftAACContentsLeftNeedMakeForm

function Tfs_AACContents.RightMainDftAACContentsRightNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  aSubUserType: TvcmUserType): Boolean;
var
 l_UseCase : IsdsAAC;
begin
 if Supports(aDataSource, IsdsAAC, l_UseCase) then
  try
   aNew := l_UseCase.Right;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_AACContents.RightMainDftAACContentsRightNeedMakeForm

class function Tfs_AACContents.Exists: Boolean;
 {-}
begin
 Result := g_Tfs_AACContents <> nil;
end;//Tfs_AACContents.Exists

procedure Tfs_AACContents.InitFields;
 {-}
begin
 inherited;
 with AddZone('AACContainer', vcm_ztParent, fm_AACContentsContainerForm) do
 begin
  UserType := AACContentsContainer;
  with AddZone('Left', vcm_ztChild, fm_TextForm) do
  begin
   UserType := dftAACContentsLeft;
   OnNeedMakeForm := LeftChildDftAACContentsLeftNeedMakeForm;
  end;
  with AddZone('Right', vcm_ztMain, fm_TextForm) do
  begin
   UserType := dftAACContentsRight;
   OnNeedMakeForm := RightMainDftAACContentsRightNeedMakeForm;
  end;
  OnNeedMakeForm := AACContainerParentAACContentsContainerNeedMakeForm;
 end;
 OwnerForm := 0;
end;//Tfs_AACContents.InitFields

{$If not defined(NoVCM)}
class function Tfs_AACContents.GetInstance: TvcmFormSetFactoryPrim;
 {-}
begin
 Result := Self.Instance;
end;//Tfs_AACContents.GetInstance
{$IfEnd} //not NoVCM

{$IfEnd} //not Admin AND not Monitorings

end.