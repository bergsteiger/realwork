{$IfNDef DocumentWithFlashUserTypes_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/DocumentWithFlashUserTypes.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Core::Base Operations::View::Base Forms::DocumentWithFlashUserTypes
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define DocumentWithFlashUserTypes_imp}
{$If not defined(Admin) AND not defined(Monitorings)}
 _DocumentWithFlashUserTypes_ = {abstract form} class(_DocumentWithFlashUserTypes_Parent_)
 protected
  procedure MakeControls; override;
 end;//_DocumentWithFlashUserTypes_
{$Else}

 _DocumentWithFlashUserTypes_ = _DocumentWithFlashUserTypes_Parent_;

{$IfEnd} //not Admin AND not Monitorings

{$Else DocumentWithFlashUserTypes_imp}

{$IfNDef DocumentWithFlashUserTypes_imp_impl}
{$Define DocumentWithFlashUserTypes_imp_impl}

{$If not defined(Admin) AND not defined(Monitorings)}

var
   { Локализуемые строки dwftMainLocalConstants }
  str_dwftMainCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dwftMainCaption'; rValue : 'Схема');
   { Заголовок пользовательского типа "Схема" }

var
   { Локализуемые строки dwftSynchroLocalConstants }
  str_dwftSynchroCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dwftSynchroCaption'; rValue : 'Схема (синхронный просмотр)');
   { Заголовок пользовательского типа "Схема (синхронный просмотр)" }
  str_dwftSynchroSettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dwftSynchroSettingsCaption'; rValue : 'Синхронный просмотр: Схема');
   { Заголовок пользовательского типа "Схема (синхронный просмотр)" для настройки панелей инструментов }

// start class _DocumentWithFlashUserTypes_

procedure _DocumentWithFlashUserTypes_.MakeControls;
begin
 inherited;
 with AddUsertype(dwftMainName,
  str_dwftMainCaption,
  str_dwftMainCaption,
  true,
  21,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(dwftMainName
 with AddUsertype(dwftSynchroName,
  str_dwftSynchroCaption,
  str_dwftSynchroSettingsCaption,
  true,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(dwftSynchroName
end;

{$IfEnd} //not Admin AND not Monitorings

{$Else  DocumentWithFlashUserTypes_imp_impl}
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_dwftMainCaption
 str_dwftMainCaption.Init;
// Инициализация str_dwftSynchroCaption
 str_dwftSynchroCaption.Init;
// Инициализация str_dwftSynchroSettingsCaption
 str_dwftSynchroSettingsCaption.Init;
{$IfEnd} //not Admin AND not Monitorings

{$EndIf DocumentWithFlashUserTypes_imp_impl}
{$EndIf DocumentWithFlashUserTypes_imp}
