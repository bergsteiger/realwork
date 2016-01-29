unit k2Tag;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "K2"
// Модуль: "w:/common/components/rtl/Garant/K2/k2Tag.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::K2::k2PrimObjects::Tk2Tag
//
// Базовый тег
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\K2\k2Define.inc}

interface

uses
  l3Variant
  ;

type
 Tk2Tag = {abstract} class(Tl3Tag)
  {* Базовый тег }
 protected
 // overridden protected methods
   function GetIsOrd: Boolean; override;
 end;//Tk2Tag

implementation

// start class Tk2Tag

function Tk2Tag.GetIsOrd: Boolean;
//#UC START# *532AE8F2009A_5319C00B0313_var*
//#UC END# *532AE8F2009A_5319C00B0313_var*
begin
//#UC START# *532AE8F2009A_5319C00B0313_impl*
 Result := false;
//#UC END# *532AE8F2009A_5319C00B0313_impl*
end;//Tk2Tag.GetIsOrd

end.