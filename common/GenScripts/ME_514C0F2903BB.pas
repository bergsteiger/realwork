unit DOCtoEVDWriterTest;

// Модуль: "w:\common\components\rtl\Garant\Daily\DOCtoEVDWriterTest.pas"
// Стереотип: "TestCase"
// Элемент модели: "DOCtoEVDWriterTest" MUID: (514C0F2903BB)
// Имя типа: "TDOCtoEVDWriterTest"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFReaderTest
;

type
 TDOCtoEVDWriterTest = {abstract} class(TRTFReaderTest)
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
  published
   procedure DoIt;
 end;//TDOCtoEVDWriterTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

procedure TDOCtoEVDWriterTest.DoIt;
//#UC START# *514C0F5E0247_514C0F2903BB_var*
//#UC END# *514C0F5E0247_514C0F2903BB_var*
begin
//#UC START# *514C0F5E0247_514C0F2903BB_impl*
 RTFtoEVD(KPage + '.doc');
//#UC END# *514C0F5E0247_514C0F2903BB_impl*
end;//TDOCtoEVDWriterTest.DoIt

function TDOCtoEVDWriterTest.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'RTF';
end;//TDOCtoEVDWriterTest.GetFolder

function TDOCtoEVDWriterTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '514C0F2903BB';
end;//TDOCtoEVDWriterTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
