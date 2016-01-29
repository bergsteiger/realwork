{$IfNDef evStyleTableListenerPrim_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/evStyleTableListenerPrim.imp.pas"
// Начат: 29.06.2009 10:11
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi::Everest::StyleTable::evStyleTableListenerPrim
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define evStyleTableListenerPrim_imp}
{$If not defined(DesignTimeLibrary)}
 _evStyleTableListenerPrim_ = {mixin} class(_evStyleTableListenerPrim_Parent_, IafwStyleTableSpy)
 protected
 // realized methods
   procedure StyleTableChanged;
     {* таблица стилей изменилась. }
 protected
 // overridden protected methods
   procedure InitFields; override;
 protected
 // protected methods
   procedure DoStyleTableChanged; virtual; abstract;
   function NeedListen: Boolean; virtual;
     {* Нужно ли подписываться к таблице стилей (может мы уже подписались) }
   function AtEnd: Boolean; virtual;
     {* Подписываться в конец списка подписчиков }
 end;//_evStyleTableListenerPrim_
{$Else}

 _evStyleTableListenerPrim_ = _evStyleTableListenerPrim_Parent_;

{$IfEnd} //not DesignTimeLibrary

{$Else evStyleTableListenerPrim_imp}

{$If not defined(DesignTimeLibrary)}

// start class _evStyleTableListenerPrim_

function _evStyleTableListenerPrim_.NeedListen: Boolean;
//#UC START# *4A485DBE0293_4A485B0D0223_var*
//#UC END# *4A485DBE0293_4A485B0D0223_var*
begin
//#UC START# *4A485DBE0293_4A485B0D0223_impl*
 Result := true;
//#UC END# *4A485DBE0293_4A485B0D0223_impl*
end;//_evStyleTableListenerPrim_.NeedListen

function _evStyleTableListenerPrim_.AtEnd: Boolean;
//#UC START# *4A4867A20049_4A485B0D0223_var*
//#UC END# *4A4867A20049_4A485B0D0223_var*
begin
//#UC START# *4A4867A20049_4A485B0D0223_impl*
 Result := true;
//#UC END# *4A4867A20049_4A485B0D0223_impl*
end;//_evStyleTableListenerPrim_.AtEnd

procedure _evStyleTableListenerPrim_.StyleTableChanged;
//#UC START# *467D2CB10135_4A485B0D0223_var*
//#UC END# *467D2CB10135_4A485B0D0223_var*
begin
//#UC START# *467D2CB10135_4A485B0D0223_impl*
 DoStyleTableChanged;
//#UC END# *467D2CB10135_4A485B0D0223_impl*
end;//_evStyleTableListenerPrim_.StyleTableChanged

procedure _evStyleTableListenerPrim_.InitFields;
//#UC START# *47A042E100E2_4A485B0D0223_var*
//#UC END# *47A042E100E2_4A485B0D0223_var*
begin
//#UC START# *47A042E100E2_4A485B0D0223_impl*
 inherited;
 if NeedListen then
  evAddStyleTableSpy(Self, false, AtEnd);
//#UC END# *47A042E100E2_4A485B0D0223_impl*
end;//_evStyleTableListenerPrim_.InitFields

{$IfEnd} //not DesignTimeLibrary

{$EndIf evStyleTableListenerPrim_imp}
