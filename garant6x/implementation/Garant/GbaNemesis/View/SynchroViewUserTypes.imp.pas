{$IfNDef SynchroViewUserTypes_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/SynchroViewUserTypes.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Core::Base Operations::View::Base Forms::SynchroViewUserTypes
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define SynchroViewUserTypes_imp}
{$If not defined(Admin) AND not defined(Monitorings)}
 _SynchroViewUserTypes_ = {abstract form} class(_SynchroViewUserTypes_Parent_)
 protected
  procedure MakeControls; override;
 protected
 // protected methods
   procedure SvSynchroViewQueryClose(aSender: TObject); virtual; abstract;
     {* Обработчик события svSynchroView.OnQueryClose }
 end;//_SynchroViewUserTypes_
{$Else}

 _SynchroViewUserTypes_ = _SynchroViewUserTypes_Parent_;

{$IfEnd} //not Admin AND not Monitorings

{$Else SynchroViewUserTypes_imp}

{$IfNDef SynchroViewUserTypes_imp_impl}
{$Define SynchroViewUserTypes_imp_impl}

{$If not defined(Admin) AND not defined(Monitorings)}

var
   { Локализуемые строки svSynchroViewLocalConstants }
  str_svSynchroViewCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'svSynchroViewCaption'; rValue : 'Синхронный просмотр');
   { Заголовок пользовательского типа "Синхронный просмотр" }

// start class _SynchroViewUserTypes_

procedure _SynchroViewUserTypes_.MakeControls;
begin
 inherited;
 with AddUsertype(svSynchroViewName,
  str_svSynchroViewCaption,
  str_svSynchroViewCaption,
  false,
  84,
  20,
  '',
  nil,
  nil,
  SvSynchroViewQueryClose,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(svSynchroViewName
end;

{$IfEnd} //not Admin AND not Monitorings

{$Else  SynchroViewUserTypes_imp_impl}
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_svSynchroViewCaption
 str_svSynchroViewCaption.Init;
{$IfEnd} //not Admin AND not Monitorings

{$EndIf SynchroViewUserTypes_imp_impl}
{$EndIf SynchroViewUserTypes_imp}
