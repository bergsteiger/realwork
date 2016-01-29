unit vcmHistoryService;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM$Visual"
// Модуль: "w:/common/components/gui/Garant/VCM/vcmHistoryService.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Service::Class>> Shared Delphi::VCM$Visual::Services::TvcmHistoryService
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\VCM\vcmDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  vcmInterfaces,
  l3ProtoObject
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
(*
 MvcmHistoryService = PureMixIn
  {* Контракт сервиса TvcmHistoryService }
   function GetFormHistory(const aForm: IvcmEntityForm): IvcmHistory;
   procedure SaveFormState(const aForm: IvcmEntityForm);
   function GetContainerHistory(const aContainer: IvcmContainer): IvcmHistory;
   function IsInBF(const aForm: IvcmEntityForm): Boolean;
 end;//MvcmHistoryService
*)

type
 IvcmHistoryService = interface(IUnknown)
  {* Интерфейс сервиса TvcmHistoryService }
   ['{CA5C1514-1050-411B-A26C-25710B226DA2}']
  // MvcmHistoryService
   function GetFormHistory(const aForm: IvcmEntityForm): IvcmHistory;
   procedure SaveFormState(const aForm: IvcmEntityForm);
   function GetContainerHistory(const aContainer: IvcmContainer): IvcmHistory;
   function IsInBF(const aForm: IvcmEntityForm): Boolean;
 end;//IvcmHistoryService

 TvcmHistoryService = {final} class(Tl3ProtoObject)
 private
 // private fields
   f_Alien : IvcmHistoryService;
    {* Поле для свойства Alien}
 protected
 // property methods
   procedure pm_SetAlien(const aValue: IvcmHistoryService);
 public
 // realized methods
   function GetContainerHistory(const aContainer: IvcmContainer): IvcmHistory;
   function GetFormHistory(const aForm: IvcmEntityForm): IvcmHistory;
   procedure SaveFormState(const aForm: IvcmEntityForm);
   function IsInBF(const aForm: IvcmEntityForm): Boolean;
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 public
 // public properties
   property Alien: IvcmHistoryService
     write pm_SetAlien;
     {* Внешняя реализация сервиса IvcmHistoryService }
 public
 // singleton factory method
   class function Instance: TvcmHistoryService;
    {- возвращает экземпляр синглетона. }
 end;//TvcmHistoryService
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}
uses
  l3Base {a},
  afwFacade,
  vcmBase
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}


// start class TvcmHistoryService

var g_TvcmHistoryService : TvcmHistoryService = nil;

procedure TvcmHistoryServiceFree;
begin
 l3Free(g_TvcmHistoryService);
end;

class function TvcmHistoryService.Instance: TvcmHistoryService;
begin
 if (g_TvcmHistoryService = nil) then
 begin
  l3System.AddExitProc(TvcmHistoryServiceFree);
  g_TvcmHistoryService := Create;
 end;
 Result := g_TvcmHistoryService;
end;


procedure TvcmHistoryService.pm_SetAlien(const aValue: IvcmHistoryService);
 {-}
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//TvcmHistoryService.pm_SetAlien

class function TvcmHistoryService.Exists: Boolean;
 {-}
begin
 Result := g_TvcmHistoryService <> nil;
end;//TvcmHistoryService.Exists

function TvcmHistoryService.GetContainerHistory(const aContainer: IvcmContainer): IvcmHistory;
//#UC START# *27BEBF0EE9FD_559BA19C0076_var*
//#UC END# *27BEBF0EE9FD_559BA19C0076_var*
begin
//#UC START# *27BEBF0EE9FD_559BA19C0076_impl*
 if (f_Alien <> nil) then
  Result := f_Alien.GetContainerHistory(aContainer)
 else
  Result := g_Dispatcher.History;
//#UC END# *27BEBF0EE9FD_559BA19C0076_impl*
end;//TvcmHistoryService.GetContainerHistory

function TvcmHistoryService.GetFormHistory(const aForm: IvcmEntityForm): IvcmHistory;
//#UC START# *96E2DB43E67B_559BA19C0076_var*
//#UC END# *96E2DB43E67B_559BA19C0076_var*
begin
//#UC START# *96E2DB43E67B_559BA19C0076_impl*
 if (f_Alien <> nil) then
  Result := f_Alien.GetFormHistory(aForm)
 else
  Result := g_Dispatcher.History;
//#UC END# *96E2DB43E67B_559BA19C0076_impl*
end;//TvcmHistoryService.GetFormHistory

procedure TvcmHistoryService.SaveFormState(const aForm: IvcmEntityForm);
//#UC START# *975F702287E2_559BA19C0076_var*
var
 l_History: IvcmHistory;
//#UC END# *975F702287E2_559BA19C0076_var*
begin
//#UC START# *975F702287E2_559BA19C0076_impl*
 if (f_Alien <> nil) then
  f_Alien.SaveFormState(aForm)
 else
 begin
  l_History := GetFormHistory(aForm);
  Assert(l_History <> nil);
  l_History.ForceSaveState(aForm);
 end;
//#UC END# *975F702287E2_559BA19C0076_impl*
end;//TvcmHistoryService.SaveFormState

function TvcmHistoryService.IsInBF(const aForm: IvcmEntityForm): Boolean;
//#UC START# *A872A2AAB575_559BA19C0076_var*
var
 l_History: IvcmHistory;
//#UC END# *A872A2AAB575_559BA19C0076_var*
begin
//#UC START# *A872A2AAB575_559BA19C0076_impl*
 if (f_Alien <> nil) then
  Result := f_Alien.IsInBF(aForm)
 else
 begin
  l_History := GetFormHistory(aForm);
  Result := l_History.InBF;
 end;
//#UC END# *A872A2AAB575_559BA19C0076_impl*
end;//TvcmHistoryService.IsInBF

procedure TvcmHistoryService.ClearFields;
 {-}
begin
 {$If not defined(NoVCM)}
 Alien := nil;
 {$IfEnd} //not NoVCM
 inherited;
end;//TvcmHistoryService.ClearFields

{$IfEnd} //not NoVCM

end.