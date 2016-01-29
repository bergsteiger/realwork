unit nscHideField;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Nemesis"
// Модуль: "w:/common/components/gui/Garant/Nemesis/nscHideField.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<GuiControl::Class>> Shared Delphi For F1::Nemesis::Grid::TnscHideField
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
  l3ProtoObject,
  vtHideField
  {$If not defined(NoVCM)}
  ,
  vcmExternalInterfaces
  {$IfEnd} //not NoVCM
  ,
  afwInterfaces
  ;
{$IfEnd} //Nemesis

{$If defined(Nemesis)}
type
 _nsUnknownComponentWithIvcmState_Parent_ = TvtHideField;
{$Include w:\common\components\gui\Garant\VT\nsUnknownComponentWithIvcmState.imp.pas}
 TnscCustomHideField = class(_nsUnknownComponentWithIvcmState_)
 private
 // private fields
   f_SettingId : AnsiString;
    {* Поле для свойства SettingId}
 protected
 // property methods
   procedure pm_SetSettingId(const aValue: AnsiString); virtual;
 protected
 // overridden protected methods
   {$If not defined(DesignTimeLibrary) AND not defined(NoVGScene)}
   procedure LoadSettings; override;
   {$IfEnd} //not DesignTimeLibrary AND not NoVGScene
   {$If not defined(DesignTimeLibrary) AND not defined(NoVGScene)}
   procedure SaveSettings; override;
   {$IfEnd} //not DesignTimeLibrary AND not NoVGScene
 public
 // overridden public methods
   {$If not defined(DesignTimeLibrary) AND not defined(NoVGScene)}
   function DoLoadState(const theState: IUnknown;
    aStateType: TvcmStateType): Boolean; override;
   {$IfEnd} //not DesignTimeLibrary AND not NoVGScene
   {$If not defined(DesignTimeLibrary) AND not defined(NoVGScene)}
   function DoSaveState(out theState: IUnknown;
    aStateType: TvcmStateType): Boolean; override;
   {$IfEnd} //not DesignTimeLibrary AND not NoVGScene
 protected
 // protected methods
   function MakeSettingId(const aSettingId: AnsiString): AnsiString;
   function SettingIdStored: Boolean;
     {* "Функция определяющая, что свойство SettingId сохраняется" }
 public
 // public properties
   property SettingId: AnsiString
     read f_SettingId
     write pm_SetSettingId
     stored SettingIdStored;
 end;//TnscCustomHideField

 InscHideFieldState = interface(IUnknown)
   ['{D8BAE182-0965-4D86-91A1-6E1145FB0DAD}']
   function pm_GetState: ThfState;
   procedure pm_SetState(aValue: ThfState);
   property State: ThfState
     read pm_GetState
     write pm_SetState;
 end;//InscHideFieldState

 TnscHideFieldState = class(Tl3ProtoObject, InscHideFieldState)
 private
 // private fields
   f_State : ThfState;
    {* Поле для свойства State}
 protected
 // realized methods
   function pm_GetState: ThfState;
   procedure pm_SetState(aValue: ThfState);
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public methods
   class function Make: InscHideFieldState; reintroduce;
 public
 // public properties
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
{$IfEnd} //Nemesis

implementation

{$If defined(Nemesis)}
uses
  SysUtils,
  afwConsts
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  ;
{$IfEnd} //Nemesis

{$If defined(Nemesis)}

{$Include w:\common\components\gui\Garant\VT\nsUnknownComponentWithIvcmState.imp.pas}

const
    { TnscHideField const }
   cstidState = 'State';
    { идентификатор настройки для состояния }

// start class TnscCustomHideField

function TnscCustomHideField.MakeSettingId(const aSettingId: AnsiString): AnsiString;
//#UC START# *511258C60285_4E732E0B0308_var*
//#UC END# *511258C60285_4E732E0B0308_var*
begin
//#UC START# *511258C60285_4E732E0B0308_impl*
 Result := f_SettingId + g_afwPathSep + aSettingId;
//#UC END# *511258C60285_4E732E0B0308_impl*
end;//TnscCustomHideField.MakeSettingId

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

function TnscCustomHideField.SettingIdStored: Boolean;
//#UC START# *704562C84A3F_4E732E0B0308_var*
//#UC END# *704562C84A3F_4E732E0B0308_var*
begin
//#UC START# *704562C84A3F_4E732E0B0308_impl*
 Result := f_SettingId <> '';
//#UC END# *704562C84A3F_4E732E0B0308_impl*
end;//TnscCustomHideField.SettingIdStored

{$If not defined(DesignTimeLibrary) AND not defined(NoVGScene)}
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
{$IfEnd} //not DesignTimeLibrary AND not NoVGScene

{$If not defined(DesignTimeLibrary) AND not defined(NoVGScene)}
procedure TnscCustomHideField.SaveSettings;
//#UC START# *4F9A5C530398_4E732E0B0308_var*
//#UC END# *4F9A5C530398_4E732E0B0308_var*
begin
//#UC START# *4F9A5C530398_4E732E0B0308_impl*
 if (f_SettingId <> '') and (Settings <> nil) then
  Settings.SaveInteger(MakeSettingId(cstidState), Ord(State));
//#UC END# *4F9A5C530398_4E732E0B0308_impl*
end;//TnscCustomHideField.SaveSettings
{$IfEnd} //not DesignTimeLibrary AND not NoVGScene

{$If not defined(DesignTimeLibrary) AND not defined(NoVGScene)}
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
{$IfEnd} //not DesignTimeLibrary AND not NoVGScene

{$If not defined(DesignTimeLibrary) AND not defined(NoVGScene)}
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
{$IfEnd} //not DesignTimeLibrary AND not NoVGScene
// start class TnscHideFieldState

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
end;

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

{$IfEnd} //Nemesis

initialization
{$If defined(Nemesis) AND not defined(NoScripts)}
// Регистрация TnscCustomHideField
 TtfwClassRef.Register(TnscCustomHideField);
{$IfEnd} //Nemesis AND not NoScripts
{$If defined(Nemesis) AND not defined(NoScripts)}
// Регистрация TnscHideField
 TtfwClassRef.Register(TnscHideField);
{$IfEnd} //Nemesis AND not NoScripts

end.