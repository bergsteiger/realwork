unit vcmTaskPanelServices;

// Модуль: "w:\common\components\gui\Garant\VCM\vcmTaskPanelServices.pas"
// Стереотип: "Service"
// Элемент модели: "TvcmTaskPanelServices" MUID: (578E02D603D1)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , l3ProtoObject
 {$If NOT Defined(NoVCL)}
 , Menus
 {$IfEnd} // NOT Defined(NoVCL)
 , vcmTaskPanelInterfaces
;

 (*
 MvcmTaskPanelServices = interface
  {* Контракт сервиса TvcmTaskPanelServices }
  procedure CustomizePanel(const aPanel: IvcmCustOps);
  function TasksPanelPopupMenu: TPopupMenu;
 end;//MvcmTaskPanelServices
 *)

type
 IvcmTaskPanelServices = interface
  {* Интерфейс сервиса TvcmTaskPanelServices }
  procedure CustomizePanel(const aPanel: IvcmCustOps);
  function TasksPanelPopupMenu: TPopupMenu;
 end;//IvcmTaskPanelServices

 TvcmTaskPanelServices = {final} class(Tl3ProtoObject)
  private
   f_Alien: IvcmTaskPanelServices;
    {* Внешняя реализация сервиса IvcmTaskPanelServices }
  protected
   procedure pm_SetAlien(const aValue: IvcmTaskPanelServices);
   procedure ClearFields; override;
  public
   procedure CustomizePanel(const aPanel: IvcmCustOps);
   function TasksPanelPopupMenu: TPopupMenu;
   class function Instance: TvcmTaskPanelServices;
    {* Метод получения экземпляра синглетона TvcmTaskPanelServices }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
  public
   property Alien: IvcmTaskPanelServices
    write pm_SetAlien;
    {* Внешняя реализация сервиса IvcmTaskPanelServices }
 end;//TvcmTaskPanelServices
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_TvcmTaskPanelServices: TvcmTaskPanelServices = nil;
 {* Экземпляр синглетона TvcmTaskPanelServices }

procedure TvcmTaskPanelServicesFree;
 {* Метод освобождения экземпляра синглетона TvcmTaskPanelServices }
begin
 l3Free(g_TvcmTaskPanelServices);
end;//TvcmTaskPanelServicesFree

procedure TvcmTaskPanelServices.pm_SetAlien(const aValue: IvcmTaskPanelServices);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//TvcmTaskPanelServices.pm_SetAlien

procedure TvcmTaskPanelServices.CustomizePanel(const aPanel: IvcmCustOps);
//#UC START# *726DEE2EAA6F_578E02D603D1_var*
//#UC END# *726DEE2EAA6F_578E02D603D1_var*
begin
//#UC START# *726DEE2EAA6F_578E02D603D1_impl*
 if (f_Alien <> nil) then
  f_Alien.CustomizePanel(aPanel);
//#UC END# *726DEE2EAA6F_578E02D603D1_impl*
end;//TvcmTaskPanelServices.CustomizePanel

function TvcmTaskPanelServices.TasksPanelPopupMenu: TPopupMenu;
//#UC START# *171E8E0C4B22_578E02D603D1_var*
//#UC END# *171E8E0C4B22_578E02D603D1_var*
begin
//#UC START# *171E8E0C4B22_578E02D603D1_impl*
 if (f_Alien <> nil) then
  Result := f_Alien.TasksPanelPopupMenu
 else
  Result := nil;
//#UC END# *171E8E0C4B22_578E02D603D1_impl*
end;//TvcmTaskPanelServices.TasksPanelPopupMenu

class function TvcmTaskPanelServices.Instance: TvcmTaskPanelServices;
 {* Метод получения экземпляра синглетона TvcmTaskPanelServices }
begin
 if (g_TvcmTaskPanelServices = nil) then
 begin
  l3System.AddExitProc(TvcmTaskPanelServicesFree);
  g_TvcmTaskPanelServices := Create;
 end;
 Result := g_TvcmTaskPanelServices;
end;//TvcmTaskPanelServices.Instance

class function TvcmTaskPanelServices.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TvcmTaskPanelServices <> nil;
end;//TvcmTaskPanelServices.Exists

procedure TvcmTaskPanelServices.ClearFields;
begin
 Alien := nil;
 inherited;
end;//TvcmTaskPanelServices.ClearFields
{$IfEnd} // NOT Defined(NoVCM)

end.
