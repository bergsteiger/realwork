unit fsAutoreferat;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Search/fsAutoreferat.pas"
// Начат: 21.08.2009 20:46
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMFormSetFactory::Class>> F1 Пользовательские сервисы::Autoreferat::View::Search::PrimMonitorings::Autoreferat
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
  DocumentUserTypes_dftAutoreferat_UserType,
  l3StringIDEx,
  PrimNewsLine_nltMain_UserType,
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
  Tfs_Autoreferat = {final fsf} class(TvcmFormSetFactory)
  protected
  // overridden protected methods
   procedure InitFields; override;
    {$If not defined(NoVCM)}
   class function GetInstance: TvcmFormSetFactoryPrim; override;
    {$IfEnd} //not NoVCM
  public
  // public methods
   function TextFormParentDftAutoreferatNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      aSubUserType: TvcmUserType): Boolean;
     {* Обработчик OnNeedMakeForm для TextForm }
   function NewsLineNavigatorNltMainNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      aSubUserType: TvcmUserType): Boolean;
     {* Обработчик OnNeedMakeForm для NewsLine }
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
  public
  // singleton factory method
    class function Instance: Tfs_Autoreferat;
     {- возвращает экземпляр синглетона. }
  end;//Tfs_Autoreferat
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


// start class Tfs_Autoreferat

var g_Tfs_Autoreferat : Tfs_Autoreferat = nil;

procedure Tfs_AutoreferatFree;
begin
 l3Free(g_Tfs_Autoreferat);
end;

class function Tfs_Autoreferat.Instance: Tfs_Autoreferat;
begin
 if (g_Tfs_Autoreferat = nil) then
 begin
  l3System.AddExitProc(Tfs_AutoreferatFree);
  g_Tfs_Autoreferat := Create;
 end;
 Result := g_Tfs_Autoreferat;
end;

var
    { Локализуемые строки AutoreferatCaptionLocalConstants }
   str_fsAutoreferatCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'fsAutoreferatCaption'; rValue : '#1044#1086#1082#1091#1084#1077#1085#1090');
    { Заголовок фабрики сборки форм "Autoreferat" }

// start class Tfs_Autoreferat

function Tfs_Autoreferat.TextFormParentDftAutoreferatNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  aSubUserType: TvcmUserType): Boolean;
var
 l_UseCase : IsdsAutoreferat;
begin
 if Supports(aDataSource, IsdsAutoreferat, l_UseCase) then
  try
//#UC START# *4FFA8808003ENeedMake_impl*
   aNew := l_UseCase.dsDocument;
//#UC END# *4FFA8808003ENeedMake_impl*
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_Autoreferat.TextFormParentDftAutoreferatNeedMakeForm

function Tfs_Autoreferat.NewsLineNavigatorNltMainNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  aSubUserType: TvcmUserType): Boolean;
var
 l_UseCase : IsdsAutoreferat;
begin
 if Supports(aDataSource, IsdsAutoreferat, l_UseCase) then
  try
//#UC START# *4FFA88E3034ENeedMake_impl*
   aNew := l_UseCase.MakeNewsLineFakeDS;
//#UC END# *4FFA88E3034ENeedMake_impl*
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_Autoreferat.NewsLineNavigatorNltMainNeedMakeForm

class function Tfs_Autoreferat.Exists: Boolean;
 {-}
begin
 Result := g_Tfs_Autoreferat <> nil;
end;//Tfs_Autoreferat.Exists

procedure Tfs_Autoreferat.InitFields;
 {-}
begin
 inherited;
 with AddZone('TextForm', vcm_ztParent, fm_TextForm) do
 begin
  UserType := dftAutoreferat;
  OnNeedMakeForm := TextFormParentDftAutoreferatNeedMakeForm;
 end;
 with AddZone('NewsLine', vcm_ztNavigator, fm_enNewsLine) do
 begin
  UserType := nltMain;
  ActivateIfUpdate := wafIfNotActivated;
  OnNeedMakeForm := NewsLineNavigatorNltMainNeedMakeForm;
 end;
 Caption := str_fsAutoreferatCaption.AsCStr;
 OwnerForm := 0;
end;//Tfs_Autoreferat.InitFields

{$If not defined(NoVCM)}
class function Tfs_Autoreferat.GetInstance: TvcmFormSetFactoryPrim;
 {-}
begin
 Result := Self.Instance;
end;//Tfs_Autoreferat.GetInstance
{$IfEnd} //not NoVCM

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_fsAutoreferatCaption
 str_fsAutoreferatCaption.Init;
{$IfEnd} //not Admin AND not Monitorings

end.