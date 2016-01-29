unit k2AtomicTag;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "K2"
// Модуль: "w:/common/components/rtl/Garant/K2/k2AtomicTag.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::K2::k2CoreObjects::Tk2AtomicTag
//
// Базовый атомарный тег
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\K2\k2Define.inc}

interface

uses
  k2NotStructuredTag,
  l3Interfaces
  ;

type
 Rk2AtomicTag = class of Tk2AtomicTag;

 Tk2AtomicTag = {abstract} class(Tk2NotStructuredTag)
  {* Базовый атомарный тег }
 protected
 // overridden protected methods
   function GetAsPCharLen: Tl3WString; override;
   function GetAsLong: Integer; override;
   function GetAsString: AnsiString; override;
   function GetIsOrd: Boolean; override;
 protected
 // protected fields
   f_Value : Integer;
 end;//Tk2AtomicTag

implementation

uses
  l3String,
  k2Base
  ;

// start class Tk2AtomicTag

function Tk2AtomicTag.GetAsPCharLen: Tl3WString;
//#UC START# *47A869BB02DE_53207C0102F8_var*
//#UC END# *47A869BB02DE_53207C0102F8_var*
begin
//#UC START# *47A869BB02DE_53207C0102F8_impl*
 Result := l3PCharLen(AsString);
//#UC END# *47A869BB02DE_53207C0102F8_impl*
end;//Tk2AtomicTag.GetAsPCharLen

function Tk2AtomicTag.GetAsLong: Integer;
//#UC START# *5326D7B603A3_53207C0102F8_var*
//#UC END# *5326D7B603A3_53207C0102F8_var*
begin
//#UC START# *5326D7B603A3_53207C0102F8_impl*
 Result := f_Value;
//#UC END# *5326D7B603A3_53207C0102F8_impl*
end;//Tk2AtomicTag.GetAsLong

function Tk2AtomicTag.GetAsString: AnsiString;
//#UC START# *5329CD1A020E_53207C0102F8_var*
//#UC END# *5329CD1A020E_53207C0102F8_var*
begin
//#UC START# *5329CD1A020E_53207C0102F8_impl*
 Result := Tk2Type(Self.TagType).Wrapper.AsString(Self);
//#UC END# *5329CD1A020E_53207C0102F8_impl*
end;//Tk2AtomicTag.GetAsString

function Tk2AtomicTag.GetIsOrd: Boolean;
//#UC START# *532AE8F2009A_53207C0102F8_var*
//#UC END# *532AE8F2009A_53207C0102F8_var*
begin
//#UC START# *532AE8F2009A_53207C0102F8_impl*
 Result := true;
//#UC END# *532AE8F2009A_53207C0102F8_impl*
end;//Tk2AtomicTag.GetIsOrd

end.