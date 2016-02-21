unit K260442347;
 {* [$260442347] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K260442347.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoNSRCWriterTest
;

type
 TK260442347 = class(TEVDtoNSRCWriterTest)
  {* [$260442347] }
  protected
   function IsNSRCPlus: Boolean; override;
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK260442347
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK260442347.IsNSRCPlus: Boolean;
//#UC START# *4B8545CC03D2_4DB0266702AF_var*
//#UC END# *4B8545CC03D2_4DB0266702AF_var*
begin
//#UC START# *4B8545CC03D2_4DB0266702AF_impl*
 Result := False;
//#UC END# *4B8545CC03D2_4DB0266702AF_impl*
end;//TK260442347.IsNSRCPlus

function TK260442347.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'NSRC 7.7';
end;//TK260442347.GetFolder

function TK260442347.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4DB0266702AF';
end;//TK260442347.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK260442347.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
