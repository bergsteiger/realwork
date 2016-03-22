unit ddHexCharReader;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "dd"
// Модуль: "w:/common/components/rtl/Garant/dd/ddHexCharReader.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::dd::ddCommon::TddHexCharReader
//
// Читает только шестнадцатиричные символы из потока. Если они представлены в верхнем регистре -
// переводит в нижний. Всякий мусор пропускает.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\dd\ddDefine.inc}

interface

uses
  l3CharSkipper
  ;

type
 TddHexCharReader = class(Tl3CharSkipper)
  {* Читает только шестнадцатиричные символы из потока. Если они представлены в верхнем регистре - переводит в нижний. Всякий мусор пропускает. }
 public
 // overridden public methods
   function GetChar: AnsiChar; override;
 end;//TddHexCharReader

implementation

// start class TddHexCharReader

function TddHexCharReader.GetChar: AnsiChar;
//#UC START# *5604FBB600CF_5604FA0C031A_var*
const
 csUpperHex = ['A'..'F'];
 csAllownCharSet = ['0'..'f'] + csUpperHex;
 carConvert2Low: array['A'..'F'] of AnsiChar = ('a', 'b', 'c', 'd', 'e', 'f');
//#UC END# *5604FBB600CF_5604FA0C031A_var*
begin
//#UC START# *5604FBB600CF_5604FA0C031A_impl*
 repeat
  Result := inherited GetChar;
  if (Result in csAllownCharSet) then
  begin
   if Result in csUpperHex then
    Result := carConvert2Low[Result];
   Break; 
  end; // if (Result in csAllownCharSet) then
 until EOL;
//#UC END# *5604FBB600CF_5604FA0C031A_impl*
end;//TddHexCharReader.GetChar

end.