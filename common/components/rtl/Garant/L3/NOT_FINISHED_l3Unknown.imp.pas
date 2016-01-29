{$IfNDef l3Unknown_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "L3"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/L3/NOT_FINISHED_l3Unknown.imp.pas"
// Начат: 2004/09/15 10:01:44
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi Low Level::L3::l3CoreObjects::l3Unknown
//
// В этом классе собираем методы, которые запрещено перекрывать и вызывать напрямую.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define l3Unknown_imp}
 _l3UnknownPrim_Parent_ = _l3Unknown_Parent_;
 {$Include ..\L3\l3UnknownPrim.imp.pas}
 _l3Unknown_ = {mixin} class(_l3UnknownPrim_)
  {* В этом классе собираем методы, которые запрещено перекрывать и вызывать напрямую. }
 public
 // public methods
   class function NewInstance: TObject;
   class procedure FreeInstance;
   class procedure AfterConstruction;
   class procedure BeforeDestruction;
   destructor Destroy;
 end;//_l3Unknown_

{$Else l3Unknown_imp}

{$Include ..\L3\l3UnknownPrim.imp.pas}

// start class _l3Unknown_

class function _l3Unknown_.NewInstance: TObject;
//#UC START# *47913FE900A2_47913F970159_var*
//#UC END# *47913FE900A2_47913F970159_var*
begin
//#UC START# *47913FE900A2_47913F970159_impl*
 assert(false, 'Unknown.NewInstance not implemented');
//#UC END# *47913FE900A2_47913F970159_impl*
end;//_l3Unknown_.NewInstance

class procedure _l3Unknown_.FreeInstance;
//#UC START# *4791403F035A_47913F970159_var*
//#UC END# *4791403F035A_47913F970159_var*
begin
//#UC START# *4791403F035A_47913F970159_impl*
 assert(false, 'Unknown.FreeInstance not implemented');
//#UC END# *4791403F035A_47913F970159_impl*
end;//_l3Unknown_.FreeInstance

class procedure _l3Unknown_.AfterConstruction;
//#UC START# *479140660154_47913F970159_var*
//#UC END# *479140660154_47913F970159_var*
begin
//#UC START# *479140660154_47913F970159_impl*
 assert(false, 'Unknown.AfterConstruction not implemented');
//#UC END# *479140660154_47913F970159_impl*
end;//_l3Unknown_.AfterConstruction

class procedure _l3Unknown_.BeforeDestruction;
//#UC START# *4791407A034E_47913F970159_var*
//#UC END# *4791407A034E_47913F970159_var*
begin
//#UC START# *4791407A034E_47913F970159_impl*
 assert(false, 'Unknown.BeforeDestruction not implemented');
//#UC END# *4791407A034E_47913F970159_impl*
end;//_l3Unknown_.BeforeDestruction

destructor _l3Unknown_.Destroy;
//#UC START# *4791409000A0_47913F970159_var*
//#UC END# *4791409000A0_47913F970159_var*
begin
//#UC START# *4791409000A0_47913F970159_impl*
 assert(false, 'Unknown.Destroy not implemented');
//#UC END# *4791409000A0_47913F970159_impl*
end;//_l3Unknown_.Destroy

{$EndIf l3Unknown_imp}
