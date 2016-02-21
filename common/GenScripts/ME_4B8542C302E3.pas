unit EVDtoBothNSRCWriterTest;
 {* Тест записи в NSRC+ и NSRC }

// Модуль: "w:\common\components\rtl\Garant\Daily\EVDtoBothNSRCWriterTest.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoNSRCPlusWriterTest
;

type
 TEVDtoBothNSRCWriterTest = {abstract} class(TEVDtoNSRCPlusWriterTest)
  {* Тест записи в NSRC+ и NSRC }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
  public
   procedure ToOldNSRC;
 end;//TEVDtoBothNSRCWriterTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

procedure TEVDtoBothNSRCWriterTest.ToOldNSRC;
//#UC START# *4B8543040166_4B8542C302E3_var*
//#UC END# *4B8543040166_4B8542C302E3_var*
begin
//#UC START# *4B8543040166_4B8542C302E3_impl*
 EVDtoNSRC(KPage + '.evd', false);
//#UC END# *4B8543040166_4B8542C302E3_impl*
end;//TEVDtoBothNSRCWriterTest.ToOldNSRC

function TEVDtoBothNSRCWriterTest.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'NSRCTests';
end;//TEVDtoBothNSRCWriterTest.GetFolder

function TEVDtoBothNSRCWriterTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4B8542C302E3';
end;//TEVDtoBothNSRCWriterTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
