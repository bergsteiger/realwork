unit VCMCustomization_Customization_Contracts;

// Модуль: "w:\common\components\gui\Garant\VCM\View\VCMCustomization_Customization_Contracts.pas"
// Стереотип: "VCMContracts"
// Элемент модели: "Customization" MUID: (578E02C50241)

{$Include w:\common\components\gui\sdoDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmTaskPanelInterfaces
 , l3ProtoObject
 {$If NOT Defined(NoVCL)}
 , Menus
 {$IfEnd} // NOT Defined(NoVCL)
 , vcmExternalInterfaces
;

 (*
 MTaskPanelService = interface
  {* Контракт сервиса TTaskPanelService }
  procedure CustomizePanel(const aPanel: IvcmCustOps);
   {* Настроить панель иструментов }
  function TasksPanelPopupMenu: TPopupMenu;
 end;//MTaskPanelService
 *)

type
 ITaskPanelService = interface
  {* Интерфейс сервиса TTaskPanelService }
  procedure CustomizePanel(const aPanel: IvcmCustOps);
   {* Настроить панель иструментов }
  function TasksPanelPopupMenu: TPopupMenu;
 end;//ITaskPanelService

 TTaskPanelService = {final} class(Tl3ProtoObject)
  private
   f_Alien: ITaskPanelService;
    {* Внешняя реализация сервиса ITaskPanelService }
  protected
   procedure pm_SetAlien(const aValue: ITaskPanelService);
   procedure ClearFields; override;
  public
   procedure CustomizePanel(const aPanel: IvcmCustOps);
    {* Настроить панель иструментов }
   function TasksPanelPopupMenu: TPopupMenu;
   class function Instance: TTaskPanelService;
    {* Метод получения экземпляра синглетона TTaskPanelService }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
  public
   property Alien: ITaskPanelService
    write pm_SetAlien;
    {* Внешняя реализация сервиса ITaskPanelService }
 end;//TTaskPanelService

 (*
 MToolbarMenuService = interface
  {* Контракт сервиса TToolbarMenuService }
 end;//MToolbarMenuService
 *)

 IToolbarMenuService = interface
  {* Интерфейс сервиса TToolbarMenuService }
 end;//IToolbarMenuService

 TToolbarMenuService = {final} class(Tl3ProtoObject)
  private
   f_Alien: IToolbarMenuService;
    {* Внешняя реализация сервиса IToolbarMenuService }
  protected
   procedure pm_SetAlien(const aValue: IToolbarMenuService);
   procedure ClearFields; override;
  public
   class function Instance: TToolbarMenuService;
    {* Метод получения экземпляра синглетона TToolbarMenuService }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
  public
   property Alien: IToolbarMenuService
    write pm_SetAlien;
    {* Внешняя реализация сервиса IToolbarMenuService }
 end;//TToolbarMenuService

var mod_opcode_TaskPanelService_Customize: TvcmMOPID = (rMoID : -1; rOpID : -1);
var mod_opcode_ToolbarMenuService_AvailableOperations: TvcmMOPID = (rMoID : -1; rOpID : -1);
var mod_opcode_ToolbarMenuService_Customize: TvcmMOPID = (rMoID : -1; rOpID : -1);
var mod_opcode_ToolbarMenuService_Fasten: TvcmMOPID = (rMoID : -1; rOpID : -1);
var mod_opcode_ToolbarMenuService_IconsSize: TvcmMOPID = (rMoID : -1; rOpID : -1);
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , vcmOperationsForRegister
 , vcmOperationStatesForRegister
 , SysUtils
 , l3Base
 , vcmBase
;

var g_TTaskPanelService: TTaskPanelService = nil;
 {* Экземпляр синглетона TTaskPanelService }
var g_TToolbarMenuService: TToolbarMenuService = nil;
 {* Экземпляр синглетона TToolbarMenuService }

procedure TTaskPanelServiceFree;
 {* Метод освобождения экземпляра синглетона TTaskPanelService }
begin
 l3Free(g_TTaskPanelService);
end;//TTaskPanelServiceFree

procedure TToolbarMenuServiceFree;
 {* Метод освобождения экземпляра синглетона TToolbarMenuService }
begin
 l3Free(g_TToolbarMenuService);
end;//TToolbarMenuServiceFree

procedure TTaskPanelService.pm_SetAlien(const aValue: ITaskPanelService);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//TTaskPanelService.pm_SetAlien

procedure TTaskPanelService.CustomizePanel(const aPanel: IvcmCustOps);
 {* Настроить панель иструментов }
begin
 if (f_Alien <> nil) then
  f_Alien.CustomizePanel(aPanel);
end;//TTaskPanelService.CustomizePanel

function TTaskPanelService.TasksPanelPopupMenu: TPopupMenu;
begin
 if (f_Alien <> nil) then
  Result := f_Alien.TasksPanelPopupMenu
 else
 begin
  System.FillChar(Result, SizeOf(Result), 0);
 end;
end;//TTaskPanelService.TasksPanelPopupMenu

class function TTaskPanelService.Instance: TTaskPanelService;
 {* Метод получения экземпляра синглетона TTaskPanelService }
begin
 if (g_TTaskPanelService = nil) then
 begin
  l3System.AddExitProc(TTaskPanelServiceFree);
  g_TTaskPanelService := Create;
 end;
 Result := g_TTaskPanelService;
end;//TTaskPanelService.Instance

class function TTaskPanelService.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TTaskPanelService <> nil;
end;//TTaskPanelService.Exists

procedure TTaskPanelService.ClearFields;
begin
 Alien := nil;
 inherited;
end;//TTaskPanelService.ClearFields

procedure TToolbarMenuService.pm_SetAlien(const aValue: IToolbarMenuService);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//TToolbarMenuService.pm_SetAlien

class function TToolbarMenuService.Instance: TToolbarMenuService;
 {* Метод получения экземпляра синглетона TToolbarMenuService }
begin
 if (g_TToolbarMenuService = nil) then
 begin
  l3System.AddExitProc(TToolbarMenuServiceFree);
  g_TToolbarMenuService := Create;
 end;
 Result := g_TToolbarMenuService;
end;//TToolbarMenuService.Instance

class function TToolbarMenuService.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TToolbarMenuService <> nil;
end;//TToolbarMenuService.Exists

procedure TToolbarMenuService.ClearFields;
begin
 Alien := nil;
 inherited;
end;//TToolbarMenuService.ClearFields

initialization
{$IfEnd} // NOT Defined(NoVCM)

end.
