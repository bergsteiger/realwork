unit K589860215;
 {* [Requestlink:589860215] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K589860215.pas"
// Стереотип: "TestCase"
// Элемент модели: "K589860215" MUID: (54EECC4D02C8)
// Имя типа: "TK589860215"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK589860215 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:589860215] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetEnablePictures: Boolean; override;
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK589860215
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK589860215.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.11';
end;//TK589860215.GetFolder

function TK589860215.GetEnablePictures: Boolean;
//#UC START# *4D5BE2F500AD_54EECC4D02C8_var*
//#UC END# *4D5BE2F500AD_54EECC4D02C8_var*
begin
//#UC START# *4D5BE2F500AD_54EECC4D02C8_impl*
 Result := True;
//#UC END# *4D5BE2F500AD_54EECC4D02C8_impl*
end;//TK589860215.GetEnablePictures

function TK589860215.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '54EECC4D02C8';
end;//TK589860215.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK589860215.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
