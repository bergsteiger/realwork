{$IfNDef nsUnknownComponent_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VT$Rem"
// Модуль: "w:/common/components/gui/Garant/VT/nsUnknownComponent.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi::VT$Rem::NewReminders::nsUnknownComponent
//
// Базовые интерфейсы и методы, которыми обладает каждый компонент проекта Немезис.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define nsUnknownComponent_imp}
{$If not defined(DesignTimeLibrary) AND not defined(NoVGScene)}
 _nsUnknownComponent_ = {mixin} class(_nsUnknownComponent_Parent_ {$If not defined(NoVCM)}, IvcmSettingsSource{$IfEnd} //not NoVCM
 )
  {* Базовые интерфейсы и методы, которыми обладает каждый компонент проекта Немезис. }
 private
 // private fields
   f_Settings : IvcmSettings;
    {* Поле для свойства Settings}
   f_BaseId : AnsiString;
    {* Поле для свойства BaseId}
 protected
 // realized methods
   function pm_GetSettings: IafwSettings;
   procedure pm_SetSettings(const aValue: IafwSettings);
   function pm_GetBaseId: AnsiString;
   procedure pm_SetBaseId(const aValue: AnsiString);
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 protected
 // protected methods
   function CheckSettings: Boolean; virtual;
     {* проверяет все ли есть для сохранения в настройки. }
   procedure LoadSettings; virtual;
   procedure SaveSettings; virtual;
   procedure CheckLoadSettings;
   procedure CheckSaveSettings;
 public
 // public properties
   property Settings: IvcmSettings
     read pm_GetSettings
     write pm_SetSettings;
     {* базовый идентификатор настройки. Используется как первая часть пути
           для идентификаторов настроек }
   property BaseId: AnsiString
     read pm_GetBaseId
     write pm_SetBaseId;
     {* интерфейс для записи/чтения настроек }
 end;//_nsUnknownComponent_
{$Else}

 _nsUnknownComponent_ = _nsUnknownComponent_Parent_;

{$IfEnd} //not DesignTimeLibrary AND not NoVGScene

{$Else nsUnknownComponent_imp}

{$If not defined(DesignTimeLibrary) AND not defined(NoVGScene)}

// start class _nsUnknownComponent_

function _nsUnknownComponent_.CheckSettings: Boolean;
//#UC START# *4F9A5C0C01F7_4F9A57620120_var*
//#UC END# *4F9A5C0C01F7_4F9A57620120_var*
begin
//#UC START# *4F9A5C0C01F7_4F9A57620120_impl*
 Result := Assigned(f_Settings);
//#UC END# *4F9A5C0C01F7_4F9A57620120_impl*
end;//_nsUnknownComponent_.CheckSettings

procedure _nsUnknownComponent_.LoadSettings;
//#UC START# *4F9A5C410274_4F9A57620120_var*
//#UC END# *4F9A5C410274_4F9A57620120_var*
begin
//#UC START# *4F9A5C410274_4F9A57620120_impl*
 //abstract
//#UC END# *4F9A5C410274_4F9A57620120_impl*
end;//_nsUnknownComponent_.LoadSettings

procedure _nsUnknownComponent_.SaveSettings;
//#UC START# *4F9A5C530398_4F9A57620120_var*
//#UC END# *4F9A5C530398_4F9A57620120_var*
begin
//#UC START# *4F9A5C530398_4F9A57620120_impl*
 //abstract
//#UC END# *4F9A5C530398_4F9A57620120_impl*
end;//_nsUnknownComponent_.SaveSettings

procedure _nsUnknownComponent_.CheckLoadSettings;
//#UC START# *4F9A5C720010_4F9A57620120_var*
//#UC END# *4F9A5C720010_4F9A57620120_var*
begin
//#UC START# *4F9A5C720010_4F9A57620120_impl*
 if CheckSettings then
  LoadSettings;
//#UC END# *4F9A5C720010_4F9A57620120_impl*
end;//_nsUnknownComponent_.CheckLoadSettings

procedure _nsUnknownComponent_.CheckSaveSettings;
//#UC START# *4F9A5C8103C2_4F9A57620120_var*
//#UC END# *4F9A5C8103C2_4F9A57620120_var*
begin
//#UC START# *4F9A5C8103C2_4F9A57620120_impl*
 if CheckSettings then
  SaveSettings;
//#UC END# *4F9A5C8103C2_4F9A57620120_impl*
end;//_nsUnknownComponent_.CheckSaveSettings

function _nsUnknownComponent_.pm_GetSettings: IafwSettings;
//#UC START# *473DA149020D_4F9A57620120get_var*
//#UC END# *473DA149020D_4F9A57620120get_var*
begin
//#UC START# *473DA149020D_4F9A57620120get_impl*
 Result := f_Settings;
//#UC END# *473DA149020D_4F9A57620120get_impl*
end;//_nsUnknownComponent_.pm_GetSettings

procedure _nsUnknownComponent_.pm_SetSettings(const aValue: IafwSettings);
//#UC START# *473DA149020D_4F9A57620120set_var*
//#UC END# *473DA149020D_4F9A57620120set_var*
begin
//#UC START# *473DA149020D_4F9A57620120set_impl*
 f_Settings := aValue;
 CheckLoadSettings;
//#UC END# *473DA149020D_4F9A57620120set_impl*
end;//_nsUnknownComponent_.pm_SetSettings

function _nsUnknownComponent_.pm_GetBaseId: AnsiString;
//#UC START# *473DA15800E2_4F9A57620120get_var*
//#UC END# *473DA15800E2_4F9A57620120get_var*
begin
//#UC START# *473DA15800E2_4F9A57620120get_impl*
 Result := f_BaseId;
//#UC END# *473DA15800E2_4F9A57620120get_impl*
end;//_nsUnknownComponent_.pm_GetBaseId

procedure _nsUnknownComponent_.pm_SetBaseId(const aValue: AnsiString);
//#UC START# *473DA15800E2_4F9A57620120set_var*
//#UC END# *473DA15800E2_4F9A57620120set_var*
begin
//#UC START# *473DA15800E2_4F9A57620120set_impl*
 if f_BaseId <> aValue then
 begin
  f_BaseId := aValue;
  CheckLoadSettings;
 end;
//#UC END# *473DA15800E2_4F9A57620120set_impl*
end;//_nsUnknownComponent_.pm_SetBaseId

procedure _nsUnknownComponent_.Cleanup;
//#UC START# *479731C50290_4F9A57620120_var*
//#UC END# *479731C50290_4F9A57620120_var*
begin
//#UC START# *479731C50290_4F9A57620120_impl*
 CheckSaveSettings;
 f_Settings := nil;
 inherited;
//#UC END# *479731C50290_4F9A57620120_impl*
end;//_nsUnknownComponent_.Cleanup

procedure _nsUnknownComponent_.ClearFields;
 {-}
begin
 {$If not defined(DesignTimeLibrary) AND not defined(NoVGScene)}
 Settings := nil;
 {$IfEnd} //not DesignTimeLibrary AND not NoVGScene
 inherited;
end;//_nsUnknownComponent_.ClearFields

{$IfEnd} //not DesignTimeLibrary AND not NoVGScene

{$EndIf nsUnknownComponent_imp}
