unit K471764286;
 {* [RequestLink:471764286] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K471764286.pas"
// Стереотип: "TestCase"
// Элемент модели: "K471764286" MUID: (51E6B82203DE)
// Имя типа: "TK471764286"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoNSRCPlusWriterTest
;

type
 TK471764286 = class(TEVDtoNSRCPlusWriterTest)
  {* [RequestLink:471764286] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK471764286
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *51E6B82203DEimpl_uses*
 //#UC END# *51E6B82203DEimpl_uses*
;

function TK471764286.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.9';
end;//TK471764286.GetFolder

function TK471764286.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '51E6B82203DE';
end;//TK471764286.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK471764286.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
