unit fsAutoreferatAfterSearch;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Search/fsAutoreferatAfterSearch.pas"
// Начат: 21.08.2009 20:46
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMFormSetFactory::Class>> F1 Пользовательские сервисы::Autoreferat::View::Search::PrimMonitorings::AutoreferatAfterSearch
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
  ,
  AutoreferatInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  DocumentUserTypes_dftAutoreferatAfterSearch_UserType,
  l3StringIDEx,
  Common_FormDefinitions_Controls
  {$If not defined(NoVCM)}
  ,
  vcmFormSetFormsCollectionItemPrim
  {$IfEnd} //not NoVCM
  ,
  DocumentInterfaces,
  DocumentUnit,
  bsTypesNew,
  DocumentAndListInterfaces,
  nevTools,
  bsTypes,
  afwInterfaces,
  FoldersDomainInterfaces,
  l3Interfaces
  {$If not defined(NoVCM)}
  ,
  vcmFormSetFactoryPrim
  {$IfEnd} //not NoVCM
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
  Tfs_AutoreferatAfterSearch = {final fsf} class(TvcmFormSetFactory)
  protected
  // overridden protected methods
   procedure InitFields; override;
    {$If not defined(NoVCM)}
   class function GetInstance: TvcmFormSetFactoryPrim; override;
    {$IfEnd} //not NoVCM
  public
  // public methods
   function TextFormParentDftAutoreferatAfterSearchNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      aSubUserType: TvcmUserType): Boolean;
     {* Обработчик OnNeedMakeForm для TextForm }
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
  public
  // singleton factory method
    class function Instance: Tfs_AutoreferatAfterSearch;
     {- возвращает экземпляр синглетона. }
  end;//Tfs_AutoreferatAfterSearch
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3Base {a},
  l3MessageID,
  SysUtils
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}


// start class Tfs_AutoreferatAfterSearch

var g_Tfs_AutoreferatAfterSearch : Tfs_AutoreferatAfterSearch = nil;

procedure Tfs_AutoreferatAfterSearchFree;
begin
 l3Free(g_Tfs_AutoreferatAfterSearch);
end;

class function Tfs_AutoreferatAfterSearch.Instance: Tfs_AutoreferatAfterSearch;
begin
 if (g_Tfs_AutoreferatAfterSearch = nil) then
 begin
  l3System.AddExitProc(Tfs_AutoreferatAfterSearchFree);
  g_Tfs_AutoreferatAfterSearch := Create;
 end;
 Result := g_Tfs_AutoreferatAfterSearch;
end;

var
    { Локализуемые строки AutoreferatAfterSearchCaptionLocalConstants }
   str_fsAutoreferatAfterSearchCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'fsAutoreferatAfterSearchCaption'; rValue : '#1040#1074#1090#1086#1088#1077#1092#1077#1088#1072#1090 #1087#1086#1089#1083#1077 #1087#1086#1080#1089#1082#1072');
    { Заголовок фабрики сборки форм "AutoreferatAfterSearch" }

// start class Tfs_AutoreferatAfterSearch

function Tfs_AutoreferatAfterSearch.TextFormParentDftAutoreferatAfterSearchNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  aSubUserType: TvcmUserType): Boolean;
var
 l_UseCase : IsdsAutoreferat;
begin
 if Supports(aDataSource, IsdsAutoreferat, l_UseCase) then
  try
//#UC START# *4FFA92850358NeedMake_impl*
   aNew := l_UseCase.dsDocument;
//#UC END# *4FFA92850358NeedMake_impl*
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_AutoreferatAfterSearch.TextFormParentDftAutoreferatAfterSearchNeedMakeForm

class function Tfs_AutoreferatAfterSearch.Exists: Boolean;
 {-}
begin
 Result := g_Tfs_AutoreferatAfterSearch <> nil;
end;//Tfs_AutoreferatAfterSearch.Exists

procedure Tfs_AutoreferatAfterSearch.InitFields;
 {-}
begin
 inherited;
 with AddZone('TextForm', vcm_ztParent, fm_TextForm) do
 begin
  UserType := dftAutoreferatAfterSearch;
  OnNeedMakeForm := TextFormParentDftAutoreferatAfterSearchNeedMakeForm;
 end;
 Caption := str_fsAutoreferatAfterSearchCaption.AsCStr;
 OwnerForm := 0;
end;//Tfs_AutoreferatAfterSearch.InitFields

{$If not defined(NoVCM)}
class function Tfs_AutoreferatAfterSearch.GetInstance: TvcmFormSetFactoryPrim;
 {-}
begin
 Result := Self.Instance;
end;//Tfs_AutoreferatAfterSearch.GetInstance
{$IfEnd} //not NoVCM

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_fsAutoreferatAfterSearchCaption
 str_fsAutoreferatAfterSearchCaption.Init;
{$IfEnd} //not Admin AND not Monitorings

end.