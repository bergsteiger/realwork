unit vgReminderWithAction;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VT$Rem"
// Модуль: "w:/common/components/gui/Garant/VT/vgReminderWithAction.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VT$Rem::NewReminders::TvgReminderWithAction
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\VT\vtDefine.inc}

interface

{$If not defined(NoVGScene)}
uses
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmExternalInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCL)}
  ,
  ActnList
  {$IfEnd} //not NoVCL
  ,
  vgRemindersLine
  ;
{$IfEnd} //not NoVGScene

{$If not defined(NoVGScene)}
type
 TvgReminderActionLink = class(TActionLink)
 protected
 // overridden protected methods
   {$If not defined(NoVCL)}
   procedure SetCaption(const Value: String); override;
   {$IfEnd} //not NoVCL
   {$If not defined(NoVCL)}
   procedure SetHint(const Value: AnsiString); override;
   {$IfEnd} //not NoVCL
   {$If not defined(NoVCL)}
   procedure SetVisible(Value: Boolean); override;
   {$IfEnd} //not NoVCL
   procedure AssignClient(AClient: TObject); override;
 protected
 // protected fields
   f_Client : TComponent;
 end;//TvgReminderActionLink

//#UC START# *533931C50210ci*
//#UC END# *533931C50210ci*
//#UC START# *533931C50210cit*
//#UC END# *533931C50210cit*
 TvgReminderWithAction = class(TvgReminder {$If not defined(NoVCM)}, IvcmComponentWithAction{$IfEnd} //not NoVCM
 )
 private
 // private fields
   f_EntityName : AnsiString;
    {* Поле для свойства EntityName}
   f_OperationName : AnsiString;
    {* Поле для свойства OperationName}
   f_ActionLink : TvgReminderActionLink;
    {* Поле для свойства ActionLink}
 private
 // private methods
   procedure DoActionChange(Sender: TObject);
     {* TNotifyEvent is used for events that do not require parameters. }
 protected
 // realized methods
    {$If not defined(NoVCM)}
   function GetParentForm: TComponent;
    {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   function Get_EntityName: AnsiString;
   procedure Set_EntityName(const aValue: AnsiString);
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   function Get_OperationName: AnsiString;
   procedure Set_OperationName(const aValue: AnsiString);
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   function Get_Action: TCustomAction;
   procedure Set_Action(aValue: TCustomAction);
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   function Get_Hint: AnsiString;
   procedure Set_Hint(const aValue: AnsiString);
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   function Get_Caption: AnsiString;
   procedure Set_Caption(const aValue: AnsiString);
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   function Get_Visible: Boolean;
   procedure Set_Visible(aValue: Boolean);
   {$IfEnd} //not NoVCM
    {$If not defined(NoVCM)}
   function GetComponent: TComponent;
    {$IfEnd} //not NoVCM
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure DoClick(out aHandled: Boolean); override;
   procedure UpdateAction; override;
     {* Сигнатура метода UpdateAction }
 public
 // overridden public methods
   constructor Create(AOwner: TComponent); override;
 protected
 // protected methods
   procedure InitAction;
     {* Сигнатура метода InitAction }
 public
 // public properties
   property EntityName: AnsiString
     read Get_EntityName
     write Set_EntityName;
   property OperationName: AnsiString
     read Get_OperationName
     write Set_OperationName;
   property ActionLink: TvgReminderActionLink
     read f_ActionLink
     write f_ActionLink;
//#UC START# *533931C50210publ*
 published
   property PopupMenu;
//#UC END# *533931C50210publ*
 end;//TvgReminderWithAction
{$IfEnd} //not NoVGScene

implementation

{$If not defined(NoVGScene)}
uses
  SysUtils,
  l3String,
  l3Base
  {$If not defined(NoVCM)}
  ,
  vcmUtils
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  ;
{$IfEnd} //not NoVGScene

{$If not defined(NoVGScene)}

// start class TvgReminderWithAction

procedure TvgReminderWithAction.DoActionChange(Sender: TObject);
//#UC START# *53394910012D_533931C50210_var*
//#UC END# *53394910012D_533931C50210_var*
begin
//#UC START# *53394910012D_533931C50210_impl*
 if Sender is TCustomAction then
 begin
  Self.Set_Caption(TCustomAction(Sender).Caption);
  Self.Set_Hint(TCustomAction(Sender).Hint);
  Self.Set_Visible(TCustomAction(Sender).Visible);
  //Self.Set_ImageIndex(TCustomAction(Sender).ImageIndex);
 end;
//#UC END# *53394910012D_533931C50210_impl*
end;//TvgReminderWithAction.DoActionChange

procedure TvgReminderWithAction.InitAction;
//#UC START# *5339555E0016_533931C50210_var*
//#UC END# *5339555E0016_533931C50210_var*
begin
//#UC START# *5339555E0016_533931C50210_impl*
 vcmUtils.vcmMakeControlAction(Self, f_EntityName, f_OperationName);
//#UC END# *5339555E0016_533931C50210_impl*
end;//TvgReminderWithAction.InitAction
// start class TvgReminderActionLink

{$If not defined(NoVCL)}
procedure TvgReminderActionLink.SetCaption(const Value: String);
//#UC START# *508F991B003B_5339352C031C_var*
//#UC END# *508F991B003B_5339352C031C_var*
begin
//#UC START# *508F991B003B_5339352C031C_impl*
 (f_Client as TvgReminderWithAction).Set_Caption(Value);
//#UC END# *508F991B003B_5339352C031C_impl*
end;//TvgReminderActionLink.SetCaption
{$IfEnd} //not NoVCL

{$If not defined(NoVCL)}
procedure TvgReminderActionLink.SetHint(const Value: AnsiString);
//#UC START# *508F99710030_5339352C031C_var*
//#UC END# *508F99710030_5339352C031C_var*
begin
//#UC START# *508F99710030_5339352C031C_impl*
 (f_Client as TvgReminderWithAction).Set_Hint(Value);
//#UC END# *508F99710030_5339352C031C_impl*
end;//TvgReminderActionLink.SetHint
{$IfEnd} //not NoVCL

{$If not defined(NoVCL)}
procedure TvgReminderActionLink.SetVisible(Value: Boolean);
//#UC START# *508F99970386_5339352C031C_var*
//#UC END# *508F99970386_5339352C031C_var*
begin
//#UC START# *508F99970386_5339352C031C_impl*
 (f_Client as TvgReminderWithAction).Set_Visible(Value);
//#UC END# *508F99970386_5339352C031C_impl*
end;//TvgReminderActionLink.SetVisible
{$IfEnd} //not NoVCL

procedure TvgReminderActionLink.AssignClient(AClient: TObject);
//#UC START# *5339368F0001_5339352C031C_var*
//#UC END# *5339368F0001_5339352C031C_var*
begin
//#UC START# *5339368F0001_5339352C031C_impl*
 f_Client := aClient as TvgReminderWithAction;
//#UC END# *5339368F0001_5339352C031C_impl*
end;//TvgReminderActionLink.AssignClient

{$If not defined(NoVCM)}
function TvgReminderWithAction.GetParentForm: TComponent;
//#UC START# *533933040073_533931C50210_var*
//#UC END# *533933040073_533931C50210_var*
begin
//#UC START# *533933040073_533931C50210_impl*
 Result := (Owner as TvgRemindersLine).Owner;
//#UC END# *533933040073_533931C50210_impl*
end;//TvgReminderWithAction.GetParentForm
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
function TvgReminderWithAction.Get_EntityName: AnsiString;
//#UC START# *5339336E01A0_533931C50210get_var*
//#UC END# *5339336E01A0_533931C50210get_var*
begin
//#UC START# *5339336E01A0_533931C50210get_impl*
 Result := f_EntityName;
//#UC END# *5339336E01A0_533931C50210get_impl*
end;//TvgReminderWithAction.Get_EntityName
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TvgReminderWithAction.Set_EntityName(const aValue: AnsiString);
//#UC START# *5339336E01A0_533931C50210set_var*
//#UC END# *5339336E01A0_533931C50210set_var*
begin
//#UC START# *5339336E01A0_533931C50210set_impl*
 if (aValue = '')
  then f_EntityName := ''
  else f_EntityName := 'en' + aValue;

 InitAction;
//#UC END# *5339336E01A0_533931C50210set_impl*
end;//TvgReminderWithAction.Set_EntityName
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
function TvgReminderWithAction.Get_OperationName: AnsiString;
//#UC START# *5339338502DC_533931C50210get_var*
//#UC END# *5339338502DC_533931C50210get_var*
begin
//#UC START# *5339338502DC_533931C50210get_impl*
 Result := f_OperationName;
//#UC END# *5339338502DC_533931C50210get_impl*
end;//TvgReminderWithAction.Get_OperationName
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TvgReminderWithAction.Set_OperationName(const aValue: AnsiString);
//#UC START# *5339338502DC_533931C50210set_var*
//#UC END# *5339338502DC_533931C50210set_var*
begin
//#UC START# *5339338502DC_533931C50210set_impl*
 if (aValue = '')
  then f_OperationName := ''
  else f_OperationName := 'op' + aValue;

 InitAction;
//#UC END# *5339338502DC_533931C50210set_impl*
end;//TvgReminderWithAction.Set_OperationName
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
function TvgReminderWithAction.Get_Action: TCustomAction;
//#UC START# *533933BB014A_533931C50210get_var*
//#UC END# *533933BB014A_533931C50210get_var*
begin
//#UC START# *533933BB014A_533931C50210get_impl*
 if Assigned(f_ActionLink)
  then Result := f_ActionLink.Action as TCustomAction
  else Result := nil;
//#UC END# *533933BB014A_533931C50210get_impl*
end;//TvgReminderWithAction.Get_Action
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TvgReminderWithAction.Set_Action(aValue: TCustomAction);
//#UC START# *533933BB014A_533931C50210set_var*
//#UC END# *533933BB014A_533931C50210set_var*
begin
//#UC START# *533933BB014A_533931C50210set_impl*
 if aValue = nil then
 begin
  f_ActionLink.Free;
  f_ActionLink := nil;
 end else
 begin
  if f_ActionLink = nil then
   f_ActionLink := TvgReminderActionLink.Create(Self);
  f_ActionLink.Action := aValue;
  f_ActionLink.OnChange := DoActionChange;
  DoActionChange(aValue);
  //Value.FreeNotification(Self);
 end;
 //ActionRefChanged;
//#UC END# *533933BB014A_533931C50210set_impl*
end;//TvgReminderWithAction.Set_Action
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
function TvgReminderWithAction.Get_Hint: AnsiString;
//#UC START# *5339340603B1_533931C50210get_var*
//#UC END# *5339340603B1_533931C50210get_var*
begin
//#UC START# *5339340603B1_533931C50210get_impl*
 Result := l3Str(inherited Hint);
//#UC END# *5339340603B1_533931C50210get_impl*
end;//TvgReminderWithAction.Get_Hint
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TvgReminderWithAction.Set_Hint(const aValue: AnsiString);
//#UC START# *5339340603B1_533931C50210set_var*
//#UC END# *5339340603B1_533931C50210set_var*
begin
//#UC START# *5339340603B1_533931C50210set_impl*
 inherited Hint := l3CStr(aValue);
//#UC END# *5339340603B1_533931C50210set_impl*
end;//TvgReminderWithAction.Set_Hint
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
function TvgReminderWithAction.Get_Caption: AnsiString;
//#UC START# *5339340D0047_533931C50210get_var*
//#UC END# *5339340D0047_533931C50210get_var*
begin
//#UC START# *5339340D0047_533931C50210get_impl*
 Result := l3Str(inherited Caption);
//#UC END# *5339340D0047_533931C50210get_impl*
end;//TvgReminderWithAction.Get_Caption
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TvgReminderWithAction.Set_Caption(const aValue: AnsiString);
//#UC START# *5339340D0047_533931C50210set_var*
//#UC END# *5339340D0047_533931C50210set_var*
begin
//#UC START# *5339340D0047_533931C50210set_impl*
 inherited Caption := l3CStr(aValue); 
//#UC END# *5339340D0047_533931C50210set_impl*
end;//TvgReminderWithAction.Set_Caption
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
function TvgReminderWithAction.Get_Visible: Boolean;
//#UC START# *5339342C0318_533931C50210get_var*
//#UC END# *5339342C0318_533931C50210get_var*
begin
//#UC START# *5339342C0318_533931C50210get_impl*
 Result := inherited Visible;
//#UC END# *5339342C0318_533931C50210get_impl*
end;//TvgReminderWithAction.Get_Visible
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TvgReminderWithAction.Set_Visible(aValue: Boolean);
//#UC START# *5339342C0318_533931C50210set_var*
//#UC END# *5339342C0318_533931C50210set_var*
begin
//#UC START# *5339342C0318_533931C50210set_impl*
 inherited Visible := aValue;
//#UC END# *5339342C0318_533931C50210set_impl*
end;//TvgReminderWithAction.Set_Visible
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
function TvgReminderWithAction.GetComponent: TComponent;
//#UC START# *533954D202F8_533931C50210_var*
//#UC END# *533954D202F8_533931C50210_var*
begin
//#UC START# *533954D202F8_533931C50210_impl*
 Result := Self;
//#UC END# *533954D202F8_533931C50210_impl*
end;//TvgReminderWithAction.GetComponent
{$IfEnd} //not NoVCM

procedure TvgReminderWithAction.Cleanup;
//#UC START# *479731C50290_533931C50210_var*
//#UC END# *479731C50290_533931C50210_var*
begin
//#UC START# *479731C50290_533931C50210_impl*
 FreeAndNil(f_ActionLink);
 inherited;
//#UC END# *479731C50290_533931C50210_impl*
end;//TvgReminderWithAction.Cleanup

constructor TvgReminderWithAction.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_533931C50210_var*
//#UC END# *47D1602000C6_533931C50210_var*
begin
//#UC START# *47D1602000C6_533931C50210_impl*
 inherited;
//#UC END# *47D1602000C6_533931C50210_impl*
end;//TvgReminderWithAction.Create

procedure TvgReminderWithAction.DoClick(out aHandled: Boolean);
//#UC START# *533949D40354_533931C50210_var*
//#UC END# *533949D40354_533931C50210_var*
begin
//#UC START# *533949D40354_533931C50210_impl*
 aHandled := not Assigned(PopupForm); // вызываем Action только если нет баллона
 if aHandled then
  if Assigned(f_ActionLink) then
   f_ActionLink.Action.Execute;
//#UC END# *533949D40354_533931C50210_impl*
end;//TvgReminderWithAction.DoClick

procedure TvgReminderWithAction.UpdateAction;
//#UC START# *533AA4E9016A_533931C50210_var*
//#UC END# *533AA4E9016A_533931C50210_var*
begin
//#UC START# *533AA4E9016A_533931C50210_impl*
 if Assigned(f_ActionLink) then
  f_ActionLink.Action.Update;
//#UC END# *533AA4E9016A_533931C50210_impl*
end;//TvgReminderWithAction.UpdateAction

//#UC START# *533931C50210impl*
//#UC END# *533931C50210impl*

{$IfEnd} //not NoVGScene

initialization
{$If not defined(NoScripts) AND not defined(NoVGScene)}
// Регистрация TvgReminderWithAction
 TtfwClassRef.Register(TvgReminderWithAction);
{$IfEnd} //not NoScripts AND not NoVGScene

end.