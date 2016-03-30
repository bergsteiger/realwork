unit vcmHistoryService;

// Модуль: "w:\common\components\gui\Garant\VCM\vcmHistoryService.pas"
// Стереотип: "Service"
// Элемент модели: "TvcmHistoryService" MUID: (559BA19C0076)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , l3ProtoObject
 , vcmInterfaces
;

 (*
 MvcmHistoryService = interface
  {* Контракт сервиса TvcmHistoryService }
  function GetFormHistory(const aForm: IvcmEntityForm): IvcmHistory;
  procedure SaveFormState(const aForm: IvcmEntityForm);
  function GetContainerHistory(const aContainer: IvcmContainer): IvcmHistory;
  function IsInBF(const aForm: IvcmEntityForm): Boolean;
  function Back(const aForm: IvcmEntityForm): Boolean;
 end;//MvcmHistoryService
 *)

type
 IvcmHistoryService = interface
  {* Интерфейс сервиса TvcmHistoryService }
  ['{CA5C1514-1050-411B-A26C-25710B226DA2}']
  function GetFormHistory(const aForm: IvcmEntityForm): IvcmHistory;
  procedure SaveFormState(const aForm: IvcmEntityForm);
  function GetContainerHistory(const aContainer: IvcmContainer): IvcmHistory;
  function IsInBF(const aForm: IvcmEntityForm): Boolean;
  function Back(const aForm: IvcmEntityForm): Boolean;
 end;//IvcmHistoryService

 TvcmHistoryService = {final} class(Tl3ProtoObject)
  private
   f_Alien: IvcmHistoryService;
    {* Внешняя реализация сервиса IvcmHistoryService }
  protected
   procedure pm_SetAlien(const aValue: IvcmHistoryService);
   procedure ClearFields; override;
  public
   function Back(const aForm: IvcmEntityForm): Boolean;
   function GetContainerHistory(const aContainer: IvcmContainer): IvcmHistory;
   function GetFormHistory(const aForm: IvcmEntityForm): IvcmHistory;
   procedure SaveFormState(const aForm: IvcmEntityForm);
   function IsInBF(const aForm: IvcmEntityForm): Boolean;
   class function Instance: TvcmHistoryService;
    {* Метод получения экземпляра синглетона TvcmHistoryService }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
  public
   property Alien: IvcmHistoryService
    write pm_SetAlien;
    {* Внешняя реализация сервиса IvcmHistoryService }
 end;//TvcmHistoryService
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , afwFacade
 , vcmBase
 , SysUtils
 , l3Base
;

var g_TvcmHistoryService: TvcmHistoryService = nil;
 {* Экземпляр синглетона TvcmHistoryService }

procedure TvcmHistoryServiceFree;
 {* Метод освобождения экземпляра синглетона TvcmHistoryService }
begin
 l3Free(g_TvcmHistoryService);
end;//TvcmHistoryServiceFree

procedure TvcmHistoryService.pm_SetAlien(const aValue: IvcmHistoryService);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//TvcmHistoryService.pm_SetAlien

function TvcmHistoryService.Back(const aForm: IvcmEntityForm): Boolean;
//#UC START# *18FC3BA729CF_559BA19C0076_var*
//#UC END# *18FC3BA729CF_559BA19C0076_var*
begin
//#UC START# *18FC3BA729CF_559BA19C0076_impl*
 if (f_Alien <> nil) then
  Result := f_Alien.Back(aForm)
 else
  Result := g_Dispatcher.History.Back;
//#UC END# *18FC3BA729CF_559BA19C0076_impl*
end;//TvcmHistoryService.Back

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

class function TvcmHistoryService.Instance: TvcmHistoryService;
 {* Метод получения экземпляра синглетона TvcmHistoryService }
begin
 if (g_TvcmHistoryService = nil) then
 begin
  l3System.AddExitProc(TvcmHistoryServiceFree);
  g_TvcmHistoryService := Create;
 end;
 Result := g_TvcmHistoryService;
end;//TvcmHistoryService.Instance

class function TvcmHistoryService.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TvcmHistoryService <> nil;
end;//TvcmHistoryService.Exists

procedure TvcmHistoryService.ClearFields;
begin
 Alien := nil;
 inherited;
end;//TvcmHistoryService.ClearFields
{$IfEnd} // NOT Defined(NoVCM)

end.
