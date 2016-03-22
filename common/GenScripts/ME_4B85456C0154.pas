unit EVDtoNSRCWriterTest;
 {* Тест записи из EVD в NSRC }

// Модуль: "w:\common\components\rtl\Garant\Daily\EVDtoNSRCWriterTest.pas"
// Стереотип: "TestCase"
// Элемент модели: "TEVDtoNSRCWriterTest" MUID: (4B85456C0154)

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , NSRCWriterTest
;

type
 TEVDtoNSRCWriterTest = {abstract} class(TNSRCWriterTest)
  {* Тест записи из EVD в NSRC }
  protected
   function IsNSRCPlus: Boolean; virtual; abstract;
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
  published
   procedure DoIt;
 end;//TEVDtoNSRCWriterTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 , l3Except
;

procedure TEVDtoNSRCWriterTest.DoIt;
//#UC START# *4B853EA60332_4B85456C0154_var*
//#UC END# *4B853EA60332_4B85456C0154_var*
begin
//#UC START# *4B853EA60332_4B85456C0154_impl*
(* try*)
  EVDtoNSRC(KPage + '.evd', IsNSRCPlus);
(* except
  on E : El3BadPictureFormat do
   if not AcceptBadPictureFormat then
    raise;
 end;//try..except*)
//#UC END# *4B853EA60332_4B85456C0154_impl*
end;//TEVDtoNSRCWriterTest.DoIt

function TEVDtoNSRCWriterTest.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'NSRCTests';
end;//TEVDtoNSRCWriterTest.GetFolder

function TEVDtoNSRCWriterTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4B85456C0154';
end;//TEVDtoNSRCWriterTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
