unit fsInternetAgent;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/InternetAgent/fsInternetAgent.pas"
// Начат: 27.04.2009 14:19
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMFormSetFactory::Class>> F1 Встроенные продукты::InternetAgent::View::InternetAgent::PrimInternetAgent$FP::InternetAgent
//
// Сборка форм для прецедента Интернет-агент
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
  InternetAgentInterfaces,
  InternetAgent_Form,
  l3StringIDEx
  {$If not defined(NoVCM)}
  ,
  vcmFormSetFormsCollectionItemPrim
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmFormSetFactoryPrim
  {$IfEnd} //not NoVCM
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
  Tfs_InternetAgent = {final fsf} class(TvcmFormSetFactory)
   {* Сборка форм для прецедента Интернет-агент }
  protected
  // overridden protected methods
   procedure InitFields; override;
    {$If not defined(NoVCM)}
   class function GetInstance: TvcmFormSetFactoryPrim; override;
    {$IfEnd} //not NoVCM
  public
  // public methods
   function InternetAgentParentNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      aSubUserType: TvcmUserType): Boolean;
     {* Обработчик OnNeedMakeForm для InternetAgent }
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
  public
  // singleton factory method
    class function Instance: Tfs_InternetAgent;
     {- возвращает экземпляр синглетона. }
  end;//Tfs_InternetAgent
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


// start class Tfs_InternetAgent

var g_Tfs_InternetAgent : Tfs_InternetAgent = nil;

procedure Tfs_InternetAgentFree;
begin
 l3Free(g_Tfs_InternetAgent);
end;

class function Tfs_InternetAgent.Instance: Tfs_InternetAgent;
begin
 if (g_Tfs_InternetAgent = nil) then
 begin
  l3System.AddExitProc(Tfs_InternetAgentFree);
  g_Tfs_InternetAgent := Create;
 end;
 Result := g_Tfs_InternetAgent;
end;

var
    { Локализуемые строки InternetAgentCaptionLocalConstants }
   str_fsInternetAgentCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'fsInternetAgentCaption'; rValue : 'Интернет-агент');
    { Заголовок фабрики сборки форм "InternetAgent" }

// start class Tfs_InternetAgent

function Tfs_InternetAgent.InternetAgentParentNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  aSubUserType: TvcmUserType): Boolean;
var
 l_UseCase : IsdsInternetAgent;
begin
 if Supports(aDataSource, IsdsInternetAgent, l_UseCase) then
  try
   aNew := l_UseCase.MainViewArea;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_InternetAgent.InternetAgentParentNeedMakeForm

class function Tfs_InternetAgent.Exists: Boolean;
 {-}
begin
 Result := g_Tfs_InternetAgent <> nil;
end;//Tfs_InternetAgent.Exists

procedure Tfs_InternetAgent.InitFields;
 {-}
begin
 inherited;
 with AddZone('InternetAgent', vcm_ztParent, fm_InternetAgentForm) do
 begin
  UserType := 0;
  OnNeedMakeForm := InternetAgentParentNeedMakeForm;
 end;
 Caption := str_fsInternetAgentCaption.AsCStr;
 OwnerForm := 0;
end;//Tfs_InternetAgent.InitFields

{$If not defined(NoVCM)}
class function Tfs_InternetAgent.GetInstance: TvcmFormSetFactoryPrim;
 {-}
begin
 Result := Self.Instance;
end;//Tfs_InternetAgent.GetInstance
{$IfEnd} //not NoVCM

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_fsInternetAgentCaption
 str_fsInternetAgentCaption.Init;
{$IfEnd} //not Admin AND not Monitorings

end.