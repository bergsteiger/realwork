unit K622418668;
 {* [Requestlink:622418668] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K622418668.pas"
// Стереотип: "TestCase"
// Элемент модели: "K622418668" MUID: (572B0C270341)
// Имя типа: "TK622418668"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK622418668 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:622418668] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK622418668
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK622418668.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.12';
end;//TK622418668.GetFolder

function TK622418668.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '572B0C270341';
end;//TK622418668.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK622418668.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
