unit RTFtoEVDWriterTest;

// Модуль: "w:\common\components\rtl\Garant\Daily\RTFtoEVDWriterTest.pas"
// Стереотип: "TestCase"
// Элемент модели: "RTFtoEVDWriterTest" MUID: (4C971C2203DD)
// Имя типа: "TRTFtoEVDWriterTest"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFReaderTest
;

type
 TRTFtoEVDWriterTest = {abstract} class(TRTFReaderTest)
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
  published
   procedure DoIt;
 end;//TRTFtoEVDWriterTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

procedure TRTFtoEVDWriterTest.DoIt;
//#UC START# *4C971C540358_4C971C2203DD_var*
//#UC END# *4C971C540358_4C971C2203DD_var*
begin
//#UC START# *4C971C540358_4C971C2203DD_impl*
 RTFtoEVD(KPage + '.rtf');
//#UC END# *4C971C540358_4C971C2203DD_impl*
end;//TRTFtoEVDWriterTest.DoIt

function TRTFtoEVDWriterTest.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'RTF';
end;//TRTFtoEVDWriterTest.GetFolder

function TRTFtoEVDWriterTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4C971C2203DD';
end;//TRTFtoEVDWriterTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
