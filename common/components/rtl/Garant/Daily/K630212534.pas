unit K630212534;
 {* [Requestlink:630212534] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K630212534.pas"
// Стереотип: "TestCase"
// Элемент модели: "K630212534" MUID: (57DB9CDE034A)
// Имя типа: "TK630212534"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoRTFRender
;

type
 TK630212534 = class(TEVDtoRTFRender)
  {* [Requestlink:630212534] }
  protected
   function GetHiddenStylesLength: Integer; override;
   function GetHiddenStyles: THiddenStylesArray; override;
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK630212534
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *57DB9CDE034Aimpl_uses*
 //#UC END# *57DB9CDE034Aimpl_uses*
;

function TK630212534.GetHiddenStylesLength: Integer;
//#UC START# *54BF8A5702E9_57DB9CDE034A_var*
//#UC END# *54BF8A5702E9_57DB9CDE034A_var*
begin
//#UC START# *54BF8A5702E9_57DB9CDE034A_impl*
 Result := 1;
//#UC END# *54BF8A5702E9_57DB9CDE034A_impl*
end;//TK630212534.GetHiddenStylesLength

function TK630212534.GetHiddenStyles: THiddenStylesArray;
//#UC START# *54BF91620371_57DB9CDE034A_var*
const
 cHidden : array [0..0] of Integer = (-21);
var
 i: Integer;
//#UC END# *54BF91620371_57DB9CDE034A_var*
begin
//#UC START# *54BF91620371_57DB9CDE034A_impl*
 SetLength(Result, GetHiddenStylesLength);
 for i := 0 to GetHiddenStylesLength - 1 do
  Result[i] := cHidden[i];
//#UC END# *54BF91620371_57DB9CDE034A_impl*
end;//TK630212534.GetHiddenStyles

function TK630212534.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '8.0';
end;//TK630212534.GetFolder

function TK630212534.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '57DB9CDE034A';
end;//TK630212534.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK630212534.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
