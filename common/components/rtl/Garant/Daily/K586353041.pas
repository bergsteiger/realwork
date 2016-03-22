unit K586353041;
 {* [Requestlink:586353041] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K586353041.pas"
// Стереотип: "TestCase"
// Элемент модели: "K586353041" MUID: (54BF953201B0)
// Имя типа: "TK586353041"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoRTFRender
;

type
 TK586353041 = class(TEVDtoRTFRender)
  {* [Requestlink:586353041] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   {$If NOT Defined(NotTunedDUnit)}
   function EtalonNeedsComputerName: Boolean; override;
   {$IfEnd} // NOT Defined(NotTunedDUnit)
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
   function GetHiddenStylesLength: Integer; override;
   function GetHiddenStyles: THiddenStylesArray; override;
 end;//TK586353041
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK586353041.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.11';
end;//TK586353041.GetFolder

{$If NOT Defined(NotTunedDUnit)}
function TK586353041.EtalonNeedsComputerName: Boolean;
//#UC START# *4CA45DAA01BA_54BF953201B0_var*
//#UC END# *4CA45DAA01BA_54BF953201B0_var*
begin
//#UC START# *4CA45DAA01BA_54BF953201B0_impl*
 Result := True;
//#UC END# *4CA45DAA01BA_54BF953201B0_impl*
end;//TK586353041.EtalonNeedsComputerName
{$IfEnd} // NOT Defined(NotTunedDUnit)

function TK586353041.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
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

initialization
 TestFramework.RegisterTest(TK586353041.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
