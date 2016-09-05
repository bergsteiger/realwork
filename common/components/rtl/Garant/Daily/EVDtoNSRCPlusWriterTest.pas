unit EVDtoNSRCPlusWriterTest;
 {* Тест записи в NSRC+ }

// Модуль: "w:\common\components\rtl\Garant\Daily\EVDtoNSRCPlusWriterTest.pas"
// Стереотип: "TestCase"
// Элемент модели: "TEVDtoNSRCPlusWriterTest" MUID: (4B853E7501DF)

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoNSRCWriterTest
;

type
 TEVDtoNSRCPlusWriterTest = {abstract} class(TEVDtoNSRCWriterTest)
  {* Тест записи в NSRC+ }
  protected
   function IsNSRCPlus: Boolean; override;
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TEVDtoNSRCPlusWriterTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4B853E7501DFimpl_uses*
 //#UC END# *4B853E7501DFimpl_uses*
;

function TEVDtoNSRCPlusWriterTest.IsNSRCPlus: Boolean;
//#UC START# *4B8545CC03D2_4B853E7501DF_var*
//#UC END# *4B8545CC03D2_4B853E7501DF_var*
begin
//#UC START# *4B8545CC03D2_4B853E7501DF_impl*
 Result := true;
//#UC END# *4B8545CC03D2_4B853E7501DF_impl*
end;//TEVDtoNSRCPlusWriterTest.IsNSRCPlus

function TEVDtoNSRCPlusWriterTest.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'NSRCTests';
end;//TEVDtoNSRCPlusWriterTest.GetFolder

function TEVDtoNSRCPlusWriterTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4B853E7501DF';
end;//TEVDtoNSRCPlusWriterTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
