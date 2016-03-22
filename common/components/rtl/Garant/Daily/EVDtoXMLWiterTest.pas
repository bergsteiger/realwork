unit EVDtoXMLWiterTest;

// Модуль: "w:\common\components\rtl\Garant\Daily\EVDtoXMLWiterTest.pas"
// Стереотип: "TestCase"
// Элемент модели: "EVDtoXMLWiterTest" MUID: (503632E400D2)
// Имя типа: "TEVDtoXMLWiterTest"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , XMLWriterTest
;

type
 TEVDtoXMLWiterTest = {abstract} class(TXMLWriterTest)
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
  published
   procedure DoIt;
 end;//TEVDtoXMLWiterTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

procedure TEVDtoXMLWiterTest.DoIt;
//#UC START# *5036347502D4_503632E400D2_var*
//#UC END# *5036347502D4_503632E400D2_var*
begin
//#UC START# *5036347502D4_503632E400D2_impl*
 EVDtoXML(KPage + '.evd');
//#UC END# *5036347502D4_503632E400D2_impl*
end;//TEVDtoXMLWiterTest.DoIt

function TEVDtoXMLWiterTest.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'XML';
end;//TEVDtoXMLWiterTest.GetFolder

function TEVDtoXMLWiterTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '503632E400D2';
end;//TEVDtoXMLWiterTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
