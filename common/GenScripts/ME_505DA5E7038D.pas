{$IfNDef nscStatusBarItemNotification_imp}

// Модуль: "w:\common\components\gui\Garant\Nemesis\nscStatusBarItemNotification.imp.pas"
// Стереотип: "GUIControlMixIn"

{$Define nscStatusBarItemNotification_imp}

{$If Defined(Nemesis)}
const
 cStatusbarItemSize = 20;

 //#UC START# *505DA5E7038Dci*
 //#UC END# *505DA5E7038Dci*
 //#UC START# *505DA5E7038Dcit*
type 
 //#UC END# *505DA5E7038Dcit*
 _nscStatusBarItemNotification_ = class(_nscStatusBarItemNotification_Parent_, InscStatusBarItem)
  private
   f_NotificationClients: TnscStatusBarItemsList;
   f_ItemDef: InscStatusBarItemDef;
    {* Поле для свойства ItemDef }
  private
   procedure CMVisibleChanged(var aMessage: TMessage); message CM_VISIBLECHANGED;
  protected
   procedure Subscribe(const aClient: InscStatusBarItem);
   procedure Unsubscribe(const aClient: InscStatusBarItem);
   procedure SendNotificationToClients(aNotificationType: TnscStatusBarItemNotificationType);
   procedure Notify(const aSender: InscStatusBarItem;
    aNotificationType: TnscStatusBarItemNotificationType);
   function Get_Visible: Boolean;
   function Get_NotificationClients: Pointer;
   function Get_ItemDef: InscStatusBarItemDef;
   procedure Set_ItemDef(const aValue: InscStatusBarItemDef);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure ClearFields; override;
  public
   property ItemDef: InscStatusBarItemDef
    read f_ItemDef
    write f_ItemDef;
 //#UC START# *505DA5E7038Dpubl*
 //#UC END# *505DA5E7038Dpubl*
 end;//_nscStatusBarItemNotification_

{$Else Defined(Nemesis)}

_nscStatusBarItemNotification_ = _nscStatusBarItemNotification_Parent_;

{$IfEnd} // Defined(Nemesis)
{$Else nscStatusBarItemNotification_imp}

{$IfNDef nscStatusBarItemNotification_imp_impl}

{$Define nscStatusBarItemNotification_imp_impl}

{$If Defined(Nemesis)}
procedure _nscStatusBarItemNotification_.CMVisibleChanged(var aMessage: TMessage);
//#UC START# *506022500317_505DA5E7038D_var*
//#UC END# *506022500317_505DA5E7038D_var*
begin
//#UC START# *506022500317_505DA5E7038D_impl*
 SendNotificationToClients(sbintVisibleChanged);
//#UC END# *506022500317_505DA5E7038D_impl*
end;//_nscStatusBarItemNotification_.CMVisibleChanged

procedure _nscStatusBarItemNotification_.Subscribe(const aClient: InscStatusBarItem);
//#UC START# *505DA97101BB_505DA5E7038D_var*
//#UC END# *505DA97101BB_505DA5E7038D_var*
begin
//#UC START# *505DA97101BB_505DA5E7038D_impl*
 if not Assigned(f_NotificationClients) then
  f_NotificationClients := TnscStatusBarItemsList.Create;
 if f_NotificationClients.IndexOf(aClient) < 0 then
  f_NotificationClients.Add(aClient);
//#UC END# *505DA97101BB_505DA5E7038D_impl*
end;//_nscStatusBarItemNotification_.Subscribe

procedure _nscStatusBarItemNotification_.Unsubscribe(const aClient: InscStatusBarItem);
//#UC START# *505DA9AF003E_505DA5E7038D_var*
//#UC END# *505DA9AF003E_505DA5E7038D_var*
begin
//#UC START# *505DA9AF003E_505DA5E7038D_impl*
 f_NotificationClients.Remove(aClient);
//#UC END# *505DA9AF003E_505DA5E7038D_impl*
end;//_nscStatusBarItemNotification_.Unsubscribe

procedure _nscStatusBarItemNotification_.SendNotificationToClients(aNotificationType: TnscStatusBarItemNotificationType);
//#UC START# *505DA9D50000_505DA5E7038D_var*
var
 I: Integer;
//#UC END# *505DA9D50000_505DA5E7038D_var*
begin
//#UC START# *505DA9D50000_505DA5E7038D_impl*
 if Assigned(f_NotificationClients) then
  for I := 0 to f_NotificationClients.Count - 1 do
   f_NotificationClients[I].Notify(Self, aNotificationType);
//#UC END# *505DA9D50000_505DA5E7038D_impl*
end;//_nscStatusBarItemNotification_.SendNotificationToClients

procedure _nscStatusBarItemNotification_.Notify(const aSender: InscStatusBarItem;
 aNotificationType: TnscStatusBarItemNotificationType);
//#UC START# *505DCA6603AA_505DA5E7038D_var*
//#UC END# *505DCA6603AA_505DA5E7038D_var*
begin
//#UC START# *505DCA6603AA_505DA5E7038D_impl*
 case aNotificationType of
  sbintVisibleChanged: Visible := aSender.Visible;
 end;
//#UC END# *505DCA6603AA_505DA5E7038D_impl*
end;//_nscStatusBarItemNotification_.Notify

function _nscStatusBarItemNotification_.Get_Visible: Boolean;
//#UC START# *505DD53B0349_505DA5E7038Dget_var*
//#UC END# *505DD53B0349_505DA5E7038Dget_var*
begin
//#UC START# *505DD53B0349_505DA5E7038Dget_impl*
 Result := inherited Visible;
//#UC END# *505DD53B0349_505DA5E7038Dget_impl*
end;//_nscStatusBarItemNotification_.Get_Visible

function _nscStatusBarItemNotification_.Get_NotificationClients: Pointer;
//#UC START# *505DDE8F02A1_505DA5E7038Dget_var*
//#UC END# *505DDE8F02A1_505DA5E7038Dget_var*
begin
//#UC START# *505DDE8F02A1_505DA5E7038Dget_impl*
 Result := f_NotificationClients;
//#UC END# *505DDE8F02A1_505DA5E7038Dget_impl*
end;//_nscStatusBarItemNotification_.Get_NotificationClients

function _nscStatusBarItemNotification_.Get_ItemDef: InscStatusBarItemDef;
//#UC START# *50603D930238_505DA5E7038Dget_var*
//#UC END# *50603D930238_505DA5E7038Dget_var*
begin
//#UC START# *50603D930238_505DA5E7038Dget_impl*
 Result := f_ItemDef;
//#UC END# *50603D930238_505DA5E7038Dget_impl*
end;//_nscStatusBarItemNotification_.Get_ItemDef

procedure _nscStatusBarItemNotification_.Set_ItemDef(const aValue: InscStatusBarItemDef);
//#UC START# *50603D930238_505DA5E7038Dset_var*
//#UC END# *50603D930238_505DA5E7038Dset_var*
begin
//#UC START# *50603D930238_505DA5E7038Dset_impl*
 f_ItemDef := aValue;
//#UC END# *50603D930238_505DA5E7038Dset_impl*
end;//_nscStatusBarItemNotification_.Set_ItemDef

procedure _nscStatusBarItemNotification_.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_505DA5E7038D_var*
//#UC END# *479731C50290_505DA5E7038D_var*
begin
//#UC START# *479731C50290_505DA5E7038D_impl*
 l3Free(f_NotificationClients);
 f_ItemDef := nil;
 inherited;
//#UC END# *479731C50290_505DA5E7038D_impl*
end;//_nscStatusBarItemNotification_.Cleanup

procedure _nscStatusBarItemNotification_.ClearFields;
begin
 ItemDef := nil;
 inherited;
end;//_nscStatusBarItemNotification_.ClearFields

//#UC START# *505DA5E7038Dimpl*
//#UC END# *505DA5E7038Dimpl*
{$IfEnd} // Defined(Nemesis)

{$EndIf nscStatusBarItemNotification_imp_impl}

{$EndIf nscStatusBarItemNotification_imp}

