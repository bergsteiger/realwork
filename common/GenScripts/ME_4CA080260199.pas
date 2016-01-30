unit K235054362;
 {* [RequestLink:235054362] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K235054362.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , NSRCtoEVDTest
;

type
 TK235054362 = class(TNSRCtoEVDTest)
  {* [RequestLink:235054362] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK235054362
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK235054362.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.6';
end;//TK235054362.GetFolder

function TK235054362.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4CA080260199';
end;//TK235054362.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK235054362.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
