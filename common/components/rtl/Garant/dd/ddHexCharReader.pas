unit ddHexCharReader;
 {* Читает только шестнадцатиричные символы из потока. Если они представлены в верхнем регистре - переводит в нижний. Всякий мусор пропускает. }

// Модуль: "w:\common\components\rtl\Garant\dd\ddHexCharReader.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TddHexCharReader" MUID: (5604FA0C031A)

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , l3CharSkipper
;

type
 TddHexCharReader = class(Tl3CharSkipper)
  {* Читает только шестнадцатиричные символы из потока. Если они представлены в верхнем регистре - переводит в нижний. Всякий мусор пропускает. }
  public
   function GetChar: AnsiChar; override;
 end;//TddHexCharReader

implementation

uses
 l3ImplUses
 //#UC START# *5604FA0C031Aimpl_uses*
 //#UC END# *5604FA0C031Aimpl_uses*
;

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
