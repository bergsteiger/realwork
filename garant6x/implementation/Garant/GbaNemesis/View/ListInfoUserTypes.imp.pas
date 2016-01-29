{$IfNDef ListInfoUserTypes_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/ListInfoUserTypes.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Core::Base Operations::View::Base Forms::ListInfoUserTypes
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define ListInfoUserTypes_imp}
{$If not defined(Admin) AND not defined(Monitorings)}
 _ListInfoUserTypes_ = {abstract form} class(_ListInfoUserTypes_Parent_)
 protected
  procedure MakeControls; override;
 protected
 // protected methods
   procedure LiListInfoQueryClose(aSender: TObject); virtual; abstract;
     {* Обработчик события liListInfo.OnQueryClose }
 end;//_ListInfoUserTypes_
{$Else}

 _ListInfoUserTypes_ = _ListInfoUserTypes_Parent_;

{$IfEnd} //not Admin AND not Monitorings

{$Else ListInfoUserTypes_imp}

{$IfNDef ListInfoUserTypes_imp_impl}
{$Define ListInfoUserTypes_imp_impl}

{$If not defined(Admin) AND not defined(Monitorings)}

var
   { Локализуемые строки liListInfoLocalConstants }
  str_liListInfoCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'liListInfoCaption'; rValue : 'Справка к списку');
   { Заголовок пользовательского типа "Справка к списку" }
  str_liListInfoSettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'liListInfoSettingsCaption'; rValue : 'Список: Справка к списку');
   { Заголовок пользовательского типа "Справка к списку" для настройки панелей инструментов }

// start class _ListInfoUserTypes_

procedure _ListInfoUserTypes_.MakeControls;
begin
 inherited;
 with AddUsertype(liListInfoName,
  str_liListInfoCaption,
  str_liListInfoSettingsCaption,
  true,
  20,
  10,
  '',
  nil,
  nil,
  LiListInfoQueryClose,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(liListInfoName
end;

{$IfEnd} //not Admin AND not Monitorings

{$Else  ListInfoUserTypes_imp_impl}
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_liListInfoCaption
 str_liListInfoCaption.Init;
// Инициализация str_liListInfoSettingsCaption
 str_liListInfoSettingsCaption.Init;
{$IfEnd} //not Admin AND not Monitorings

{$EndIf ListInfoUserTypes_imp_impl}
{$EndIf ListInfoUserTypes_imp}
