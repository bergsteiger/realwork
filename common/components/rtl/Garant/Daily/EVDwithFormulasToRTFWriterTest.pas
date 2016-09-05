unit EVDwithFormulasToRTFWriterTest;
 {* Тест преобразования EVD с формулами в RTF }

// Модуль: "w:\common\components\rtl\Garant\Daily\EVDwithFormulasToRTFWriterTest.pas"
// Стереотип: "TestCase"
// Элемент модели: "EVDwithFormulasToRTFWriterTest" MUID: (4CA616760108)
// Имя типа: "TEVDwithFormulasToRTFWriterTest"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoRTFWriterTest
;

type
 TEVDwithFormulasToRTFWriterTest = {abstract} class(TEVDtoRTFWriterTest)
  {* Тест преобразования EVD с формулами в RTF }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   {$If NOT Defined(NotTunedDUnit)}
   function EtalonNeedsComputerName: Boolean; override;
   {$IfEnd} // NOT Defined(NotTunedDUnit)
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TEVDwithFormulasToRTFWriterTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4CA616760108impl_uses*
 //#UC END# *4CA616760108impl_uses*
;

function TEVDwithFormulasToRTFWriterTest.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'RTF';
end;//TEVDwithFormulasToRTFWriterTest.GetFolder

{$If NOT Defined(NotTunedDUnit)}
function TEVDwithFormulasToRTFWriterTest.EtalonNeedsComputerName: Boolean;
//#UC START# *4CA45DAA01BA_4CA616760108_var*
//#UC END# *4CA45DAA01BA_4CA616760108_var*
begin
//#UC START# *4CA45DAA01BA_4CA616760108_impl*
 Result := true;
//#UC END# *4CA45DAA01BA_4CA616760108_impl*
end;//TEVDwithFormulasToRTFWriterTest.EtalonNeedsComputerName
{$IfEnd} // NOT Defined(NotTunedDUnit)

function TEVDwithFormulasToRTFWriterTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4CA616760108';
end;//TEVDwithFormulasToRTFWriterTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
