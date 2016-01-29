unit nscStatusBarItemDef;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Nemesis"
// Модуль: "w:/common/components/gui/Garant/Nemesis/nscStatusBarItemDef.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For F1::Nemesis::StatusBar::TnscStatusBarItemDef
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Nemesis\nscDefine.inc}

interface

{$If defined(Nemesis)}
uses
  l3Interfaces,
  l3CacheableBase,
  nscNewInterfaces,
  nscStatusBarOperationDefsList
  ;
{$IfEnd} //Nemesis

{$If defined(Nemesis)}
type
 TnscStatusBarItemDef = class(Tl3CacheableBase, InscStatusBarItemDef)
 private
 // private fields
   f_ShowCaption : Boolean;
   f_Caption : Il3CString;
   f_UseTooltip : Boolean;
   f_RequireAutoPopup : Boolean;
   f_AutoPopupTimeout : Cardinal;
   f_ToolTipKind : TnscToolTipKind;
   f_Enabled : Boolean;
   f_SubscribedList : TnscStatusBarOperationDefsList;
 protected
 // realized methods
   function Get_Caption: Il3CString;
   function Get_UseToolTip: Boolean;
   function Get_RequireAutoPopup: Boolean;
   function Get_AutoPopupTimeout: Cardinal;
   function Get_TootTipKind: TnscToolTipKind;
   function Get_ShowCaption: Boolean;
   function Get_Enabled: Boolean;
   procedure Set_Enabled(aValue: Boolean);
   function Get_SubscribedList: InscStatusBarItemDefsList;
   procedure SubscribeOnNotification(const aServer: InscStatusBarItemDef);
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public methods
   constructor Create(aShowCaption: Boolean;
     const aCaption: Il3CString;
     aUseTooltip: Boolean;
     aRequireAutoPopup: Boolean;
     anAutoPopupTimeout: Cardinal;
     aToolTipKind: TnscToolTipKind); reintroduce;
   class function Make(aShowCaption: Boolean;
     const aCaption: Il3CString;
     aUseTooltip: Boolean;
     aRequireAutoPopup: Boolean;
     anAutoPopupTimeout: Cardinal;
     aToolTipKind: TnscToolTipKind): InscStatusBarItemDef; reintroduce;
     {* Сигнатура фабрики TnscStatusBarItemDef.Make }
 end;//TnscStatusBarItemDef
{$IfEnd} //Nemesis

implementation

{$If defined(Nemesis)}
uses
  l3Base
  ;
{$IfEnd} //Nemesis

{$If defined(Nemesis)}

// start class TnscStatusBarItemDef

constructor TnscStatusBarItemDef.Create(aShowCaption: Boolean;
  const aCaption: Il3CString;
  aUseTooltip: Boolean;
  aRequireAutoPopup: Boolean;
  anAutoPopupTimeout: Cardinal;
  aToolTipKind: TnscToolTipKind);
//#UC START# *4FEC3D23013F_4FEC3C34003F_var*
//#UC END# *4FEC3D23013F_4FEC3C34003F_var*
begin
//#UC START# *4FEC3D23013F_4FEC3C34003F_impl*
 inherited Create;
 f_ShowCaption := aShowCaption;
 f_Caption := aCaption;
 f_UseToolTip := aUseToolTip;
 f_RequireAutoPopup := aRequireAutoPopup;
 f_AutoPopupTimeout := anAutoPopupTimeout;
 f_ToolTipKind := aToolTipKind;
 f_Enabled := False;
//#UC END# *4FEC3D23013F_4FEC3C34003F_impl*
end;//TnscStatusBarItemDef.Create

class function TnscStatusBarItemDef.Make(aShowCaption: Boolean;
  const aCaption: Il3CString;
  aUseTooltip: Boolean;
  aRequireAutoPopup: Boolean;
  anAutoPopupTimeout: Cardinal;
  aToolTipKind: TnscToolTipKind): InscStatusBarItemDef;
var
 l_Inst : TnscStatusBarItemDef;
begin
 l_Inst := Create(aShowCaption, aCaption, aUseTooltip, aRequireAutoPopup, anAutoPopupTimeout, aToolTipKind);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TnscStatusBarItemDef.Get_Caption: Il3CString;
//#UC START# *4980370D001D_4FEC3C34003Fget_var*
//#UC END# *4980370D001D_4FEC3C34003Fget_var*
begin
//#UC START# *4980370D001D_4FEC3C34003Fget_impl*
 Result := f_Caption;
//#UC END# *4980370D001D_4FEC3C34003Fget_impl*
end;//TnscStatusBarItemDef.Get_Caption

function TnscStatusBarItemDef.Get_UseToolTip: Boolean;
//#UC START# *4980371E0167_4FEC3C34003Fget_var*
//#UC END# *4980371E0167_4FEC3C34003Fget_var*
begin
//#UC START# *4980371E0167_4FEC3C34003Fget_impl*
 Result := f_UseTooltip;
//#UC END# *4980371E0167_4FEC3C34003Fget_impl*
end;//TnscStatusBarItemDef.Get_UseToolTip

function TnscStatusBarItemDef.Get_RequireAutoPopup: Boolean;
//#UC START# *4980372D0191_4FEC3C34003Fget_var*
//#UC END# *4980372D0191_4FEC3C34003Fget_var*
begin
//#UC START# *4980372D0191_4FEC3C34003Fget_impl*
 Result := f_RequireAutoPopup;
//#UC END# *4980372D0191_4FEC3C34003Fget_impl*
end;//TnscStatusBarItemDef.Get_RequireAutoPopup

function TnscStatusBarItemDef.Get_AutoPopupTimeout: Cardinal;
//#UC START# *4980373B02B6_4FEC3C34003Fget_var*
//#UC END# *4980373B02B6_4FEC3C34003Fget_var*
begin
//#UC START# *4980373B02B6_4FEC3C34003Fget_impl*
 Result := f_AutoPopupTimeout;
//#UC END# *4980373B02B6_4FEC3C34003Fget_impl*
end;//TnscStatusBarItemDef.Get_AutoPopupTimeout

function TnscStatusBarItemDef.Get_TootTipKind: TnscToolTipKind;
//#UC START# *4980374B0266_4FEC3C34003Fget_var*
//#UC END# *4980374B0266_4FEC3C34003Fget_var*
begin
//#UC START# *4980374B0266_4FEC3C34003Fget_impl*
 Result := f_TooltipKind;
//#UC END# *4980374B0266_4FEC3C34003Fget_impl*
end;//TnscStatusBarItemDef.Get_TootTipKind

function TnscStatusBarItemDef.Get_ShowCaption: Boolean;
//#UC START# *4ADC59C6003B_4FEC3C34003Fget_var*
//#UC END# *4ADC59C6003B_4FEC3C34003Fget_var*
begin
//#UC START# *4ADC59C6003B_4FEC3C34003Fget_impl*
 Result := f_ShowCaption;
//#UC END# *4ADC59C6003B_4FEC3C34003Fget_impl*
end;//TnscStatusBarItemDef.Get_ShowCaption

function TnscStatusBarItemDef.Get_Enabled: Boolean;
//#UC START# *4BCEAF1A00EE_4FEC3C34003Fget_var*
//#UC END# *4BCEAF1A00EE_4FEC3C34003Fget_var*
begin
//#UC START# *4BCEAF1A00EE_4FEC3C34003Fget_impl*
 Result := f_Enabled;
//#UC END# *4BCEAF1A00EE_4FEC3C34003Fget_impl*
end;//TnscStatusBarItemDef.Get_Enabled

procedure TnscStatusBarItemDef.Set_Enabled(aValue: Boolean);
//#UC START# *4BCEAF1A00EE_4FEC3C34003Fset_var*
//#UC END# *4BCEAF1A00EE_4FEC3C34003Fset_var*
begin
//#UC START# *4BCEAF1A00EE_4FEC3C34003Fset_impl*
 f_Enabled := aValue;
//#UC END# *4BCEAF1A00EE_4FEC3C34003Fset_impl*
end;//TnscStatusBarItemDef.Set_Enabled

function TnscStatusBarItemDef.Get_SubscribedList: InscStatusBarItemDefsList;
//#UC START# *5060385E0190_4FEC3C34003Fget_var*
//#UC END# *5060385E0190_4FEC3C34003Fget_var*
begin
//#UC START# *5060385E0190_4FEC3C34003Fget_impl*
 Result := f_SubscribedList;
//#UC END# *5060385E0190_4FEC3C34003Fget_impl*
end;//TnscStatusBarItemDef.Get_SubscribedList

procedure TnscStatusBarItemDef.SubscribeOnNotification(const aServer: InscStatusBarItemDef);
//#UC START# *5060388903AB_4FEC3C34003F_var*
//#UC END# *5060388903AB_4FEC3C34003F_var*
begin
//#UC START# *5060388903AB_4FEC3C34003F_impl*
 if not Assigned(f_SubscribedList) then
  f_SubscribedList := TnscStatusBarOperationDefsList.Create;
 f_SubscribedList.Add(aServer);
//#UC END# *5060388903AB_4FEC3C34003F_impl*
end;//TnscStatusBarItemDef.SubscribeOnNotification

procedure TnscStatusBarItemDef.Cleanup;
//#UC START# *479731C50290_4FEC3C34003F_var*
//#UC END# *479731C50290_4FEC3C34003F_var*
begin
//#UC START# *479731C50290_4FEC3C34003F_impl*
 f_Caption := nil;
 l3Free(f_SubscribedList);
 inherited; 
//#UC END# *479731C50290_4FEC3C34003F_impl*
end;//TnscStatusBarItemDef.Cleanup

{$IfEnd} //Nemesis

end.