unit fsViewChangedFragments;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/ChangesBetweenEditons/fsViewChangedFragments.pas"
// Начат: 24.05.2011 17:14
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMFormSetFactory::Class>> F1 Пользовательские сервисы::ChangesBetweenEditions::View::ChangesBetweenEditons::ChangesBetweenEditions::ViewChangedFragments$FSF
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
  ChangesBetweenEditons_Form,
  ChangesBetweenEditionsInterfaces,
  PrimChangesBetweenEditons_DocumentChanges_UserType
  {$If not defined(NoVCM)}
  ,
  vcmFormSetFormsCollectionItemPrim
  {$IfEnd} //not NoVCM
  ,
  DocumentUnit,
  nevTools,
  DocumentInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmFormSetFactoryPrim
  {$IfEnd} //not NoVCM
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
  Tfs_ViewChangedFragments = {final fsf} class(TvcmFormSetFactory)
  protected
  // overridden protected methods
   procedure InitFields; override;
    {$If not defined(NoVCM)}
   class function GetInstance: TvcmFormSetFactoryPrim; override;
    {$IfEnd} //not NoVCM
  public
  // public methods
   function ParentParentDocumentChangesNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      aSubUserType: TvcmUserType): Boolean;
     {* Обработчик OnNeedMakeForm для Parent }
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
  public
  // singleton factory method
    class function Instance: Tfs_ViewChangedFragments;
     {- возвращает экземпляр синглетона. }
  end;//Tfs_ViewChangedFragments
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3Base {a},
  SysUtils
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}


// start class Tfs_ViewChangedFragments

var g_Tfs_ViewChangedFragments : Tfs_ViewChangedFragments = nil;

procedure Tfs_ViewChangedFragmentsFree;
begin
 l3Free(g_Tfs_ViewChangedFragments);
end;

class function Tfs_ViewChangedFragments.Instance: Tfs_ViewChangedFragments;
begin
 if (g_Tfs_ViewChangedFragments = nil) then
 begin
  l3System.AddExitProc(Tfs_ViewChangedFragmentsFree);
  g_Tfs_ViewChangedFragments := Create;
 end;
 Result := g_Tfs_ViewChangedFragments;
end;


function Tfs_ViewChangedFragments.ParentParentDocumentChangesNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  aSubUserType: TvcmUserType): Boolean;
var
 l_UseCase : IsdsChangesBetweenEditions;
begin
 if Supports(aDataSource, IsdsChangesBetweenEditions, l_UseCase) then
  try
   aNew := l_UseCase.Changes;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_ViewChangedFragments.ParentParentDocumentChangesNeedMakeForm

class function Tfs_ViewChangedFragments.Exists: Boolean;
 {-}
begin
 Result := g_Tfs_ViewChangedFragments <> nil;
end;//Tfs_ViewChangedFragments.Exists

procedure Tfs_ViewChangedFragments.InitFields;
 {-}
begin
 inherited;
 with AddZone('Parent', vcm_ztParent, fm_ChangesBetweenEditonsForm) do
 begin
  UserType := DocumentChanges;
  OnNeedMakeForm := ParentParentDocumentChangesNeedMakeForm;
 end;
 OwnerForm := 0;
end;//Tfs_ViewChangedFragments.InitFields

{$If not defined(NoVCM)}
class function Tfs_ViewChangedFragments.GetInstance: TvcmFormSetFactoryPrim;
 {-}
begin
 Result := Self.Instance;
end;//Tfs_ViewChangedFragments.GetInstance
{$IfEnd} //not NoVCM

{$IfEnd} //not Admin AND not Monitorings

end.