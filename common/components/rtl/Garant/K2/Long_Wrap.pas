unit Long_Wrap;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "K2"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/K2/Long_Wrap.pas"
// Начат: 07.09.1998 12:46
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Wrapper::Class>> Shared Delphi::K2::Standard::WLong
//
// WLong
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\K2\k2Define.inc}

interface

uses
  k2Base,
  l3Variant
  ;

type
 WLong = class(Wk2Atom)
  {* WLong }
 protected
 // overridden protected methods
   function AsString(A: Tl3Variant): AnsiString; override;
 end;//WLong

implementation

uses
  SysUtils,
  l3Const
  ;

// start class WLong

function WLong.AsString(A: Tl3Variant): AnsiString;
//#UC START# *484CCE970073_4849423C0299_var*
//#UC END# *484CCE970073_4849423C0299_var*
begin
//#UC START# *484CCE970073_4849423C0299_impl*
 if A.IsNull then
  Result := ''
 else
  Result := IntToStr(A.AsLong);
//#UC END# *484CCE970073_4849423C0299_impl*
end;//WLong.AsString

end.