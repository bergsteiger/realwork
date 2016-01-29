{$IfNDef PageControlNotification_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/PageControlNotification.imp.pas"
// Начат: 27.01.2009 16:42
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> F1 Core::Base Operations::View::Base Forms::PageControlNotification
//
// Класс для будущей реализации InscPageControlNotification
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define PageControlNotification_imp}
{$If not defined(Admin) AND not defined(Monitorings)}
 _PageControlNotification_ = {mixin} class(_PageControlNotification_Parent_ {$If defined(Nemesis)}, InscPageControlNotification{$IfEnd} //Nemesis
 )
  {* Класс для будущей реализации InscPageControlNotification }
 protected
 // realized methods
   {$If defined(Nemesis)}
   procedure TabActivate;
     {* Cобытие активации вкладки }
   {$IfEnd} //Nemesis
 protected
 // protected methods
   procedure DoTabActivate; virtual; abstract;
     {* Реакция на переключение вкладки }
 end;//_PageControlNotification_
{$Else}

 _PageControlNotification_ = _PageControlNotification_Parent_;

{$IfEnd} //not Admin AND not Monitorings

{$Else PageControlNotification_imp}

{$If not defined(Admin) AND not defined(Monitorings)}

// start class _PageControlNotification_

{$If defined(Nemesis)}
procedure _PageControlNotification_.TabActivate;
//#UC START# *496B781903E3_497F0F17036D_var*
//#UC END# *496B781903E3_497F0F17036D_var*
begin
//#UC START# *496B781903E3_497F0F17036D_impl*
 DoTabActivate;
//#UC END# *496B781903E3_497F0F17036D_impl*
end;//_PageControlNotification_.TabActivate
{$IfEnd} //Nemesis

{$IfEnd} //not Admin AND not Monitorings

{$EndIf PageControlNotification_imp}
