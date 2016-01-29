unit k2NotStructuredTag;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "K2"
// Модуль: "w:/common/components/rtl/Garant/K2/k2NotStructuredTag.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::K2::k2PrimObjects::Tk2NotStructuredTag
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\K2\k2Define.inc}

interface

uses
  k2Tag,
  l3Variant
  ;

type
 Tk2NotStructuredTag = {abstract} class(Tk2Tag, Il3TagRef)
 protected
 // overridden protected methods
   function GetAsRef: Il3TagRef; override;
 end;//Tk2NotStructuredTag

implementation

uses
  k2NullTagImpl
  ;

// start class Tk2NotStructuredTag

function Tk2NotStructuredTag.GetAsRef: Il3TagRef;
//#UC START# *53568FCA01E8_533E8F8D0334_var*
//#UC END# *53568FCA01E8_533E8F8D0334_var*
begin
//#UC START# *53568FCA01E8_533E8F8D0334_impl*
 Result := Self;
//#UC END# *53568FCA01E8_533E8F8D0334_impl*
end;//Tk2NotStructuredTag.GetAsRef

end.