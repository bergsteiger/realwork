unit WikiToEVDWriterTest;

// Модуль: "w:\common\components\rtl\Garant\Daily\WikiToEVDWriterTest.pas"
// Стереотип: "TestCase"
// Элемент модели: "WikiToEVDWriterTest" MUID: (4D6BE6F801DF)
// Имя типа: "TWikiToEVDWriterTest"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , WikiReaderTest
;

type
 TWikiToEVDWriterTest = {abstract} class(TWikiReaderTest)
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
  published
   procedure DoIt;
 end;//TWikiToEVDWriterTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

procedure TWikiToEVDWriterTest.DoIt;
//#UC START# *4D6BE7160392_4D6BE6F801DF_var*
//#UC END# *4D6BE7160392_4D6BE6F801DF_var*
begin
//#UC START# *4D6BE7160392_4D6BE6F801DF_impl*
 WikiToEVD(KPage + '.wiki');
//#UC END# *4D6BE7160392_4D6BE6F801DF_impl*
end;//TWikiToEVDWriterTest.DoIt

function TWikiToEVDWriterTest.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'Wiki';
end;//TWikiToEVDWriterTest.GetFolder

function TWikiToEVDWriterTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4D6BE6F801DF';
end;//TWikiToEVDWriterTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
