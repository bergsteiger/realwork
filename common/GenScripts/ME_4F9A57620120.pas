{$IfNDef nsUnknownComponent_imp}

// Модуль: "w:\common\components\gui\Garant\VT\nsUnknownComponent.imp.pas"
// Стереотип: "Impurity"

{$Define nsUnknownComponent_imp}

{$If NOT Defined(NoVGScene) AND NOT Defined(DesignTimeLibrary)}
 _nsUnknownComponent_ = class(_nsUnknownComponent_Parent_{$If NOT Defined(NoVCM)}
 , IvcmSettingsSource
 {$IfEnd} // NOT Defined(NoVCM)
 )
  {* Базовые интерфейсы и методы, которыми обладает каждый компонент проекта Немезис. }
  private
   f_Settings: IvcmSettings;
    {* Поле для свойства Settings }
   f_BaseId: AnsiString;
    {* Поле для свойства BaseId }
  protected
   function CheckSettings: Boolean; virtual;
   procedure LoadSettings; virtual;
   procedure SaveSettings; virtual;
   procedure CheckLoadSettings;
   procedure CheckSaveSettings;
   function pm_GetSettings: IafwSettings;
   procedure pm_SetSettings(const aValue: IafwSettings);
   function pm_GetBaseId: AnsiString;
   procedure pm_SetBaseId(const aValue: AnsiString);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure ClearFields; override;
  public
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

{$Else NOT Defined(NoVGScene) AND NOT Defined(DesignTimeLibrary)}

_nsUnknownComponent_ = _nsUnknownComponent_Parent_;

{$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(DesignTimeLibrary)
{$Else nsUnknownComponent_imp}

{$IfNDef nsUnknownComponent_imp_impl}

{$Define nsUnknownComponent_imp_impl}

{$If NOT Defined(NoVGScene) AND NOT Defined(DesignTimeLibrary)}
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
 {* Функция очистки полей объекта. }
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
begin
 Settings := nil;
 BaseId := '';
 inherited;
end;//_nsUnknownComponent_.ClearFields
{$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(DesignTimeLibrary)

{$EndIf nsUnknownComponent_imp_impl}

{$EndIf nsUnknownComponent_imp}

