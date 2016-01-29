unit sdsInternetAgent;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "InternetAgent"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/InternetAgent/sdsInternetAgent.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UseCaseControllerImp::Class>> F1 Встроенные продукты::InternetAgent::InternetAgent::InternetAgent::TsdsInternetAgent
//
// Реализация прецедента Интернет-агента
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
  l3Interfaces
  {$If not defined(NoVCM)}
  ,
  vcmControllers
  {$IfEnd} //not NoVCM
  ,
  InternetAgentInterfaces
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
  l3NotifyPtrList
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 _InitDataType_ = Il3CString;
 _SetType_ = IsdsInternetAgent;
 {$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormSetDataSourceWithoutData.imp.pas}
 TsdsInternetAgent = {ucc} class(_vcmFormSetDataSourceWithoutData_, IsdsInternetAgent)
  {* Реализация прецедента Интернет-агента }
 private
 // private fields
   f_MainViewArea : IvcmViewAreaControllerRef;
    {* Поле для области вывода MainViewArea}
 protected
 // realized methods
   function pm_GetMainViewArea: IdsInternetAgent;
   function DoGet_MainViewArea: IdsInternetAgent;
 protected
 // overridden protected methods
   {$If not defined(NoVCM)}
   procedure ClearAreas; override;
     {* Очищает ссылки на области ввода }
   {$IfEnd} //not NoVCM
 end;//TsdsInternetAgent
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  dsInternetAgent
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

type _Instance_R_ = TsdsInternetAgent;

{$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormSetDataSourceWithoutData.imp.pas}

// start class TsdsInternetAgent

function TsdsInternetAgent.pm_GetMainViewArea: IdsInternetAgent;
//#UC START# *4A37A70E01DE_49ECA984005Fget_var*
//#UC END# *4A37A70E01DE_49ECA984005Fget_var*
begin
 if (f_MainViewArea = nil) then
 begin
  f_MainViewArea := TvcmViewAreaControllerRef.Make;
  //#UC START# *4A37A70E01DE_49ECA984005Fget_init*
  // - код инициализации ссылки на ViewArea
  //#UC END# *4A37A70E01DE_49ECA984005Fget_init*
 end;//f_MainViewArea = nil
 if f_MainViewArea.IsEmpty
  //#UC START# *4A37A70E01DE_49ECA984005Fget_need*
  // - условие создания ViewArea
  //#UC END# *4A37A70E01DE_49ECA984005Fget_need*
  then
   f_MainViewArea.Referred := DoGet_MainViewArea;
 Result := IdsInternetAgent(f_MainViewArea.Referred);
end;

function TsdsInternetAgent.DoGet_MainViewArea: IdsInternetAgent;
//#UC START# *4A37A70E01DE_49ECA984005Farea_var*
//#UC END# *4A37A70E01DE_49ECA984005Farea_var*
begin
//#UC START# *4A37A70E01DE_49ECA984005Farea_impl*
 Result := TdsInternetAgent.Make(Self, InitialUseCaseData);
//#UC END# *4A37A70E01DE_49ECA984005Farea_impl*
end;//TsdsInternetAgent.DoGet_MainViewArea

{$If not defined(NoVCM)}
procedure TsdsInternetAgent.ClearAreas;
 {-}
begin
 if (f_MainViewArea <> nil) then f_MainViewArea.Referred := nil;
 inherited;
end;//TsdsInternetAgent.ClearAreas
{$IfEnd} //not NoVCM

{$IfEnd} //not Admin AND not Monitorings

end.