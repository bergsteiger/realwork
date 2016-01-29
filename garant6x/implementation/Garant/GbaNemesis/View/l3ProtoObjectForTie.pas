unit l3ProtoObjectForTie;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/l3ProtoObjectForTie.pas"
// Начат: 24.09.2010 16:31
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Core::Base Operations::View::ContextSearchInEVDDocument::Tl3ProtoObjectForTie
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3ProtoObject
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 Tl3ProtoObjectForTie = class(Tl3ProtoObject)
 protected
 // protected methods
   function DontUseMe: Pointer;
 end;//Tl3ProtoObjectForTie
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}

// start class Tl3ProtoObjectForTie

function Tl3ProtoObjectForTie.DontUseMe: Pointer;
//#UC START# *4C9C9A2E017F_4C9C9A0603D6_var*
//#UC END# *4C9C9A2E017F_4C9C9A0603D6_var*
begin
//#UC START# *4C9C9A2E017F_4C9C9A0603D6_impl*
 Result := nil;
 Assert(false);
//#UC END# *4C9C9A2E017F_4C9C9A0603D6_impl*
end;//Tl3ProtoObjectForTie.DontUseMe

{$IfEnd} //not Admin AND not Monitorings

end.