unit K207389888;
 {* [RequestLink:207389888] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K207389888.pas"
// Стереотип: "TestCase"
// Элемент модели: "K207389888" MUID: (4BD95673010B)
// Имя типа: "TK207389888"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoNSRCOldWriterTest
;

type
 TK207389888 = class(TEVDtoNSRCOldWriterTest)
  {* [RequestLink:207389888] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK207389888
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4BD95673010Bimpl_uses*
 //#UC END# *4BD95673010Bimpl_uses*
;

function TK207389888.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.5';
end;//TK207389888.GetFolder

function TK207389888.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4BD95673010B';
end;//TK207389888.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK207389888.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
