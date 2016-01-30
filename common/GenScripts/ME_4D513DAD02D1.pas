unit K252524029;
 {* [$252524029] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K252524029.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , InsertPictureTest
;

type
 TK252524029 = class(TInsertPictureTest)
  {* [$252524029] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK252524029
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK252524029.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.7';
end;//TK252524029.GetFolder

function TK252524029.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4D513DAD02D1';
end;//TK252524029.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK252524029.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
