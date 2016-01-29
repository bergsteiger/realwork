{$IfNDef ContentsUserTypes_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/ContentsUserTypes.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Core::Base Operations::View::Base Forms::ContentsUserTypes
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define ContentsUserTypes_imp}
{$If not defined(Admin) AND not defined(Monitorings)}
 _ContentsUserTypes_ = {abstract form} class(_ContentsUserTypes_Parent_)
 protected
  procedure MakeControls; override;
 end;//_ContentsUserTypes_
{$Else}

 _ContentsUserTypes_ = _ContentsUserTypes_Parent_;

{$IfEnd} //not Admin AND not Monitorings

{$Else ContentsUserTypes_imp}

{$IfNDef ContentsUserTypes_imp_impl}
{$Define ContentsUserTypes_imp_impl}

{$If not defined(Admin) AND not defined(Monitorings)}

var
   { Локализуемые строки utContentsLocalConstants }
  str_utContentsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utContentsCaption'; rValue : 'Структура документа');
   { Заголовок пользовательского типа "Структура документа" }
  str_utContentsSettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utContentsSettingsCaption'; rValue : 'Документ: Структура (вкладка)');
   { Заголовок пользовательского типа "Структура документа" для настройки панелей инструментов }

var
   { Локализуемые строки utDrugContentsLocalConstants }
  str_utDrugContentsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utDrugContentsCaption'; rValue : 'Структура препарата');
   { Заголовок пользовательского типа "Структура препарата" }
  str_utDrugContentsSettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utDrugContentsSettingsCaption'; rValue : 'Препарат: Структура (вкладка)');
   { Заголовок пользовательского типа "Структура препарата" для настройки панелей инструментов }

// start class _ContentsUserTypes_

procedure _ContentsUserTypes_.MakeControls;
begin
 inherited;
 with AddUsertype(utContentsName,
  str_utContentsCaption,
  str_utContentsSettingsCaption,
  true,
  66,
  40,
  '',
  nil,
  nil,
  nil,
  vcm_ccEnable) do
 begin
 end;//with AddUsertype(utContentsName
 with AddUsertype(utDrugContentsName,
  str_utDrugContentsCaption,
  str_utDrugContentsSettingsCaption,
  true,
  66,
  40,
  '',
  nil,
  nil,
  nil,
  vcm_ccEnable) do
 begin
 end;//with AddUsertype(utDrugContentsName
end;

{$IfEnd} //not Admin AND not Monitorings

{$Else  ContentsUserTypes_imp_impl}
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_utContentsCaption
 str_utContentsCaption.Init;
// Инициализация str_utContentsSettingsCaption
 str_utContentsSettingsCaption.Init;
// Инициализация str_utDrugContentsCaption
 str_utDrugContentsCaption.Init;
// Инициализация str_utDrugContentsSettingsCaption
 str_utDrugContentsSettingsCaption.Init;
{$IfEnd} //not Admin AND not Monitorings

{$EndIf ContentsUserTypes_imp_impl}
{$EndIf ContentsUserTypes_imp}
