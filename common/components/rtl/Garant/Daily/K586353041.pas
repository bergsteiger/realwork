unit K586353041;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/K586353041.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.11::K586353041
//
// {Requestlink:586353041}
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Daily\TestDefine.inc.pas}

interface

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  EVDtoRTFRender
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK586353041 = class(TEVDtoRTFRender)
  {* [Requestlink:586353041] }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
    {$If defined(nsTest) AND not defined(NotTunedDUnit)}
   function EtalonNeedsComputerName: Boolean; override;
    {$IfEnd} //nsTest AND not NotTunedDUnit
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
   function GetHiddenStylesLength: Integer; override;
   function GetHiddenStyles: THiddenStylesArray; override;
 end;//TK586353041
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TK586353041

function TK586353041.GetFolder: AnsiString;
 {-}
begin
 Result := '7.11';
end;//TK586353041.GetFolder

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
function TK586353041.EtalonNeedsComputerName: Boolean;
//#UC START# *4CA45DAA01BA_54BF953201B0_var*
//#UC END# *4CA45DAA01BA_54BF953201B0_var*
begin
//#UC START# *4CA45DAA01BA_54BF953201B0_impl*
 Result := True;
//#UC END# *4CA45DAA01BA_54BF953201B0_impl*
end;//TK586353041.EtalonNeedsComputerName
{$IfEnd} //nsTest AND not NotTunedDUnit

function TK586353041.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '54BF953201B0';
end;//TK586353041.GetModelElementGUID

function TK586353041.GetHiddenStylesLength: Integer;
//#UC START# *54BF8A5702E9_54BF953201B0_var*
//#UC END# *54BF8A5702E9_54BF953201B0_var*
begin
//#UC START# *54BF8A5702E9_54BF953201B0_impl*
 Result := 5;
//#UC END# *54BF8A5702E9_54BF953201B0_impl*
end;//TK586353041.GetHiddenStylesLength

function TK586353041.GetHiddenStyles: THiddenStylesArray;
//#UC START# *54BF91620371_54BF953201B0_var*
const
 cHidden : array [0..4] of Integer = (-21, -52, -9, -24, -22);
var
 i: Integer;
//#UC END# *54BF91620371_54BF953201B0_var*
begin
//#UC START# *54BF91620371_54BF953201B0_impl*
 SetLength(Result, GetHiddenStylesLength);
 for i := 0 to GetHiddenStylesLength - 1 do
  Result[i] := cHidden[i];
//#UC END# *54BF91620371_54BF953201B0_impl*
end;//TK586353041.GetHiddenStyles

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK586353041.Suite);

end.