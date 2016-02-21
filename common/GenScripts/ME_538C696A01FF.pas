unit K540160887;
 {* [Requestlink:538550781] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K540160887.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWithiddenTextExtractor
;

type
 TK540160887 = class(TRTFtoEVDWithiddenTextExtractor)
  {* [Requestlink:538550781] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK540160887
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK540160887.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.10';
end;//TK540160887.GetFolder

function TK540160887.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '538C696A01FF';
end;//TK540160887.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK540160887.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
