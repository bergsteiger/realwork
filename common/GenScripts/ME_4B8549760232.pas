unit NSRCtoMemoryTest;
 {* Тест чтения NSRC в память }

// Модуль: "w:\common\components\rtl\Garant\Daily\NSRCtoMemoryTest.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , NSRCWriterTest
;

type
 TNSRCtoMemoryTest = {abstract} class(TNSRCWriterTest)
  {* Тест чтения NSRC в память }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
  public
   procedure DoIt;
 end;//TNSRCtoMemoryTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

procedure TNSRCtoMemoryTest.DoIt;
//#UC START# *4B8547F30147_4B8549760232_var*
//#UC END# *4B8547F30147_4B8549760232_var*
begin
//#UC START# *4B8547F30147_4B8549760232_impl*
 NSRCtoMemory(KPage + '.nsr');
//#UC END# *4B8547F30147_4B8549760232_impl*
end;//TNSRCtoMemoryTest.DoIt

function TNSRCtoMemoryTest.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'NSRCTests';
end;//TNSRCtoMemoryTest.GetFolder

function TNSRCtoMemoryTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4B8549760232';
end;//TNSRCtoMemoryTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
