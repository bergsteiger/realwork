unit EVDtoRTFWriterTest;
 {* Тест преобразования EVD в RTF }

// Модуль: "w:\common\components\rtl\Garant\Daily\EVDtoRTFWriterTest.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFWriterTest
;

type
 TEVDtoRTFWriterTest = {abstract} class(TRTFWriterTest)
  {* Тест преобразования EVD в RTF }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
  public
   procedure DoIt;
 end;//TEVDtoRTFWriterTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

procedure TEVDtoRTFWriterTest.DoIt;
//#UC START# *4BACF19600F5_4BACF173038C_var*
//#UC END# *4BACF19600F5_4BACF173038C_var*
begin
//#UC START# *4BACF19600F5_4BACF173038C_impl*
 EVDtoRTF(KPage + '.evd', true);
//#UC END# *4BACF19600F5_4BACF173038C_impl*
end;//TEVDtoRTFWriterTest.DoIt

function TEVDtoRTFWriterTest.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'RTF';
end;//TEVDtoRTFWriterTest.GetFolder

function TEVDtoRTFWriterTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4BACF173038C';
end;//TEVDtoRTFWriterTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
