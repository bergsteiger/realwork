unit m3NewVersionStream;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "m3$DB"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/m3/m3NewVersionStream.pas"
// Начат: 17.03.2009 20:57
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::m3$DB::m3DB::Tm3NewVersionStream
//
// Поток, создавший новую версию документа
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\m3\m3Define.inc}

interface

uses
  m3DBProxyWriteStream
  ;

type
 Tm3NewVersionStream = class(Tm3DBProxyWriteStream)
  {* Поток, создавший новую версию документа }
 protected
 // overridden property methods
   function pm_GetIsNewVersion: Boolean; override;
 end;//Tm3NewVersionStream

implementation

// start class Tm3NewVersionStream

function Tm3NewVersionStream.pm_GetIsNewVersion: Boolean;
//#UC START# *49BFE6600304_49BFE43D019Fget_var*
//#UC END# *49BFE6600304_49BFE43D019Fget_var*
begin
//#UC START# *49BFE6600304_49BFE43D019Fget_impl*
 Result := true;
//#UC END# *49BFE6600304_49BFE43D019Fget_impl*
end;//Tm3NewVersionStream.pm_GetIsNewVersion

end.