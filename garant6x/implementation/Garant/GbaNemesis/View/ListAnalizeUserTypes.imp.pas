{$IfNDef ListAnalizeUserTypes_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/ListAnalizeUserTypes.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Core::Base Operations::View::Base Forms::ListAnalizeUserTypes
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define ListAnalizeUserTypes_imp}
{$If not defined(Admin) AND not defined(Monitorings)}
 _ListAnalizeUserTypes_ = {abstract form} class(_ListAnalizeUserTypes_Parent_)
 protected
  procedure MakeControls; override;
 end;//_ListAnalizeUserTypes_
{$Else}

 _ListAnalizeUserTypes_ = _ListAnalizeUserTypes_Parent_;

{$IfEnd} //not Admin AND not Monitorings

{$Else ListAnalizeUserTypes_imp}

{$IfNDef ListAnalizeUserTypes_imp_impl}
{$Define ListAnalizeUserTypes_imp_impl}

{$If not defined(Admin) AND not defined(Monitorings)}

var
   { Локализуемые строки AnalizeLocalConstants }
  str_AnalizeCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'AnalizeCaption'; rValue : 'Анализ списка');
   { Заголовок пользовательского типа "Анализ списка" }

// start class _ListAnalizeUserTypes_

procedure _ListAnalizeUserTypes_.MakeControls;
begin
 inherited;
 with AddUsertype(AnalizeName,
  str_AnalizeCaption,
  str_AnalizeCaption,
  false,
  202,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccDisable) do
 begin
 end;//with AddUsertype(AnalizeName
end;

{$IfEnd} //not Admin AND not Monitorings

{$Else  ListAnalizeUserTypes_imp_impl}
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_AnalizeCaption
 str_AnalizeCaption.Init;
{$IfEnd} //not Admin AND not Monitorings

{$EndIf ListAnalizeUserTypes_imp_impl}
{$EndIf ListAnalizeUserTypes_imp}
