unit nscHideField;

// Модуль: "w:\common\components\gui\Garant\Nemesis\nscHideField.pas"
// Стереотип: "GuiControl"
// Элемент модели: "TnscHideField" MUID: (4AC9C67300A2)

{$Include w:\common\components\gui\Garant\Nemesis\nscDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
 , vtHideField
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , afwInterfaces
 , l3ProtoObject
 //#UC START# *4AC9C67300A2intf_uses*
 //#UC END# *4AC9C67300A2intf_uses*
;

type
 _nsUnknownComponentWithIvcmState_Parent_ = TvtHideField;
 {$Include w:\common\components\gui\Garant\VT\nsUnknownComponentWithIvcmState.imp.pas}
 TnscCustomHideField = class(_nsUnknownComponentWithIvcmState_)
  private
   f_SettingId: AnsiString;
  protected
   procedure pm_SetSettingId(const aValue: AnsiString); virtual;
   function MakeSettingId(const aSettingId: AnsiString): AnsiString;
   function SettingIdStored: Boolean;
    {* "Функция определяющая, что свойство SettingId сохраняется" }
   {$If NOT Defined(NoVGScene) AND NOT Defined(DesignTimeLibrary)}
   procedure LoadSettings; override;
   {$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(DesignTimeLibrary)
   {$If NOT Defined(NoVGScene) AND NOT Defined(DesignTimeLibrary)}
   procedure SaveSettings; override;
   {$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(DesignTimeLibrary)
   procedure ClearFields; override;
  public
   {$If NOT Defined(NoVGScene) AND NOT Defined(DesignTimeLibrary)}
   function DoLoadState(const theState: IUnknown;
    aStateType: TvcmStateType): Boolean; override;
   {$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(DesignTimeLibrary)
   {$If NOT Defined(NoVGScene) AND NOT Defined(DesignTimeLibrary)}
   function DoSaveState(out theState: IUnknown;
    aStateType: TvcmStateType): Boolean; override;
   {$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(DesignTimeLibrary)
  public
   property SettingId: AnsiString
    read f_SettingId
    write pm_SetSettingId
    stored SettingIdStored;
 end;//TnscCustomHideField

 InscHideFieldState = interface
  ['{D8BAE182-0965-4D86-91A1-6E1145FB0DAD}']
  function pm_GetState: ThfState;
  procedure pm_SetState(aValue: ThfState);
  property State: ThfState
   read pm_GetState
   write pm_SetState;
 end;//InscHideFieldState

 TnscHideFieldState = class(Tl3ProtoObject, InscHideFieldState)
  private
   f_State: ThfState;
  protected
   function pm_GetState: ThfState;
   procedure pm_SetState(aValue: ThfState);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   class function Make: InscHideFieldState; reintroduce;
  public
   property State: ThfState
    read pm_GetState
    write pm_SetState;
 end;//TnscHideFieldState

 //#UC START# *4AC9C67300A2ci*
 //#UC END# *4AC9C67300A2ci*
 //#UC START# *4AC9C67300A2cit*
 //#UC END# *4AC9C67300A2cit*
 TnscHideField = class(TnscCustomHideField)
 //#UC START# *4AC9C67300A2publ*
  published
   property SettingId;
 //#UC END# *4AC9C67300A2publ*
 end;//TnscHideField
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , SysUtils
 , afwConsts
 //#UC START# *4AC9C67300A2impl_uses*
 //#UC END# *4AC9C67300A2impl_uses*
;

const
 cstidState = 'State';
  {* идентификатор настройки для состояния }

{$Include w:\common\components\gui\Garant\VT\nsUnknownComponentWithIvcmState.imp.pas}

procedure TnscCustomHideField.pm_SetSettingId(const aValue: AnsiString);
//#UC START# *51125768008D_4E732E0B0308set_var*
//#UC END# *51125768008D_4E732E0B0308set_var*
begin
//#UC START# *51125768008D_4E732E0B0308set_impl*
 if f_SettingId <> aValue then
 begin
  f_SettingId := aValue;
  {$IfNDef DesignTimeLibrary}
  CheckLoadSettings;
  {$EndIf DesignTimeLibrary}
 end;
//#UC END# *51125768008D_4E732E0B0308set_impl*
end;//TnscCustomHideField.pm_SetSettingId

function TnscCustomHideField.MakeSettingId(const aSettingId: AnsiString): AnsiString;
//#UC START# *511258C60285_4E732E0B0308_var*
//#UC END# *511258C60285_4E732E0B0308_var*
begin
//#UC START# *511258C60285_4E732E0B0308_impl*
 Result := f_SettingId + g_afwPathSep + aSettingId;
//#UC END# *511258C60285_4E732E0B0308_impl*
end;//TnscCustomHideField.MakeSettingId

function TnscCustomHideField.SettingIdStored: Boolean;
 {* "Функция определяющая, что свойство SettingId сохраняется" }
//#UC START# *704562C84A3F_4E732E0B0308_var*
//#UC END# *704562C84A3F_4E732E0B0308_var*
begin
//#UC START# *704562C84A3F_4E732E0B0308_impl*
 Result := f_SettingId <> '';
//#UC END# *704562C84A3F_4E732E0B0308_impl*
end;//TnscCustomHideField.SettingIdStored

{$If NOT Defined(NoVGScene) AND NOT Defined(DesignTimeLibrary)}
procedure TnscCustomHideField.LoadSettings;
//#UC START# *4F9A5C410274_4E732E0B0308_var*
//#UC END# *4F9A5C410274_4E732E0B0308_var*
begin
//#UC START# *4F9A5C410274_4E732E0B0308_impl*
 if (f_SettingId <> '') and (Settings <> nil) then
  State := ThfState(Settings.LoadInteger(MakeSettingId(cstidState), 
   Ord(State)));
//#UC END# *4F9A5C410274_4E732E0B0308_impl*
end;//TnscCustomHideField.LoadSettings
{$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(DesignTimeLibrary)

{$If NOT Defined(NoVGScene) AND NOT Defined(DesignTimeLibrary)}
procedure TnscCustomHideField.SaveSettings;
//#UC START# *4F9A5C530398_4E732E0B0308_var*
//#UC END# *4F9A5C530398_4E732E0B0308_var*
begin
//#UC START# *4F9A5C530398_4E732E0B0308_impl*
 if (f_SettingId <> '') and (Settings <> nil) then
  Settings.SaveInteger(MakeSettingId(cstidState), Ord(State));
//#UC END# *4F9A5C530398_4E732E0B0308_impl*
end;//TnscCustomHideField.SaveSettings
{$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(DesignTimeLibrary)

{$If NOT Defined(NoVGScene) AND NOT Defined(DesignTimeLibrary)}
function TnscCustomHideField.DoLoadState(const theState: IUnknown;
 aStateType: TvcmStateType): Boolean;
//#UC START# *4F9AB1780087_4E732E0B0308_var*
var
 lState : InscHideFieldState;
 lTemp  : ThfState;
//#UC END# *4F9AB1780087_4E732E0B0308_var*
begin
//#UC START# *4F9AB1780087_4E732E0B0308_impl*
 Result := False;
 // При переходе по истории форма находится на экране, не пропадает
 if Supports(theState, InscHideFieldState, lState) then
 try
  // Текущее
  lTemp := Self.State;
  // Историческое
  Self.State := lState.State;
  // Запомним текущее
  lState.State := lTemp;
  Result := True;
 finally
  lState := nil;
 end;
//#UC END# *4F9AB1780087_4E732E0B0308_impl*
end;//TnscCustomHideField.DoLoadState
{$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(DesignTimeLibrary)

{$If NOT Defined(NoVGScene) AND NOT Defined(DesignTimeLibrary)}
function TnscCustomHideField.DoSaveState(out theState: IUnknown;
 aStateType: TvcmStateType): Boolean;
//#UC START# *4F9AB19F020B_4E732E0B0308_var*
var
 l_State : InscHideFieldState;
//#UC END# *4F9AB19F020B_4E732E0B0308_var*
begin
//#UC START# *4F9AB19F020B_4E732E0B0308_impl*
 Result := True;
 if Assigned(theState) and Supports(theState, InscHideFieldState, l_State) then
 try
  l_State.State := Self.State;
 finally
  l_State := nil;
 end else
 begin
  l_State := TnscHideFieldState.Make;
  try
   l_State.State := Self.State;
   theState := l_State;
  finally
   l_State := nil;
  end;
 end;
//#UC END# *4F9AB19F020B_4E732E0B0308_impl*
end;//TnscCustomHideField.DoSaveState
{$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(DesignTimeLibrary)

procedure TnscCustomHideField.ClearFields;
begin
 SettingId := '';
 inherited;
end;//TnscCustomHideField.ClearFields

class function TnscHideFieldState.Make: InscHideFieldState;
var
 l_Inst : TnscHideFieldState;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnscHideFieldState.Make

function TnscHideFieldState.pm_GetState: ThfState;
//#UC START# *51124F310001_51124F6C00F0get_var*
//#UC END# *51124F310001_51124F6C00F0get_var*
begin
//#UC START# *51124F310001_51124F6C00F0get_impl*
 Result := f_State;
//#UC END# *51124F310001_51124F6C00F0get_impl*
end;//TnscHideFieldState.pm_GetState

procedure TnscHideFieldState.pm_SetState(aValue: ThfState);
//#UC START# *51124F310001_51124F6C00F0set_var*
//#UC END# *51124F310001_51124F6C00F0set_var*
begin
//#UC START# *51124F310001_51124F6C00F0set_impl*
 f_State := aValue;
//#UC END# *51124F310001_51124F6C00F0set_impl*
end;//TnscHideFieldState.pm_SetState

procedure TnscHideFieldState.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_51124F6C00F0_var*
//#UC END# *479731C50290_51124F6C00F0_var*
begin
//#UC START# *479731C50290_51124F6C00F0_impl*
 f_State := hfsShow;
 inherited;
//#UC END# *479731C50290_51124F6C00F0_impl*
end;//TnscHideFieldState.Cleanup

//#UC START# *4AC9C67300A2impl*
//#UC END# *4AC9C67300A2impl*

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TnscCustomHideField);
 {* Регистрация TnscCustomHideField }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TnscHideField);
 {* Регистрация TnscHideField }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(Nemesis)

end.
