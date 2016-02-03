unit K617055896;
 {* [Requestlink:617055896] - вложенная таблица спрятана в ячейке с обычной шириной. }

// Модуль: "w:\common\components\rtl\Garant\Daily\K617055896.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK617055896 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:617055896] - вложенная таблица спрятана в ячейке с обычной шириной. }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK617055896
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK617055896.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.12';
end;//TK617055896.GetFolder

function TK617055896.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '56B1AE9A00C6';
end;//TK617055896.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK617055896.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
