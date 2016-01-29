{$IfNDef FiltersUserTypes_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Common/Forms/FiltersUserTypes.imp.pas"
// Начат: 16.03.2011 18:08
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Core::Common::View::Common::FiltersUserTypes
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define FiltersUserTypes_imp}
{$If not defined(Admin) AND not defined(Monitorings)}
 _FiltersUserTypes_ = {abstract form} class(_FiltersUserTypes_Parent_)
 protected
  procedure MakeControls; override;
 end;//_FiltersUserTypes_
{$Else}

 _FiltersUserTypes_ = _FiltersUserTypes_Parent_;

{$IfEnd} //not Admin AND not Monitorings

{$Else FiltersUserTypes_imp}

{$IfNDef FiltersUserTypes_imp_impl}
{$Define FiltersUserTypes_imp_impl}

{$If not defined(Admin) AND not defined(Monitorings)}

var
   { Локализуемые строки utFiltersLocalConstants }
  str_utFiltersCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utFiltersCaption'; rValue : 'Фильтры');
   { Заголовок пользовательского типа "Фильтры" }
  str_utFiltersSettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utFiltersSettingsCaption'; rValue : 'Фильтры (вкладка)');
   { Заголовок пользовательского типа "Фильтры" для настройки панелей инструментов }

// start class _FiltersUserTypes_

procedure _FiltersUserTypes_.MakeControls;
begin
 inherited;
 with AddUsertype(utFiltersName,
  str_utFiltersCaption,
  str_utFiltersSettingsCaption,
  true,
  40,
  50,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(utFiltersName
end;

{$IfEnd} //not Admin AND not Monitorings

{$Else  FiltersUserTypes_imp_impl}
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_utFiltersCaption
 str_utFiltersCaption.Init;
// Инициализация str_utFiltersSettingsCaption
 str_utFiltersSettingsCaption.Init;
{$IfEnd} //not Admin AND not Monitorings

{$EndIf FiltersUserTypes_imp_impl}
{$EndIf FiltersUserTypes_imp}
