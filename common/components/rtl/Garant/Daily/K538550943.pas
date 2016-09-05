unit K538550943;
 {* [Requestlink:538550943] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K538550943.pas"
// Стереотип: "TestCase"
// Элемент модели: "K538550943" MUID: (538DA59D02C2)
// Имя типа: "TK538550943"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK538550943 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:538550943] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK538550943
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *538DA59D02C2impl_uses*
 //#UC END# *538DA59D02C2impl_uses*
;

function TK538550943.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.10';
end;//TK538550943.GetFolder

function TK538550943.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '538DA59D02C2';
end;//TK538550943.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK538550943.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
