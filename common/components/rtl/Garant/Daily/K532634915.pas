unit K532634915;
 {* [Requestlink:532634915] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K532634915.pas"
// Стереотип: "TestCase"
// Элемент модели: "K532634915" MUID: (5369D1DB0248)
// Имя типа: "TK532634915"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoNSRCWriterTest
;

type
 TK532634915 = class(TEVDtoNSRCWriterTest)
  {* [Requestlink:532634915] }
  protected
   function IsNSRCPlus: Boolean; override;
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK532634915
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *5369D1DB0248impl_uses*
 //#UC END# *5369D1DB0248impl_uses*
;

function TK532634915.IsNSRCPlus: Boolean;
//#UC START# *4B8545CC03D2_5369D1DB0248_var*
//#UC END# *4B8545CC03D2_5369D1DB0248_var*
begin
//#UC START# *4B8545CC03D2_5369D1DB0248_impl*
 Result := False;
//#UC END# *4B8545CC03D2_5369D1DB0248_impl*
end;//TK532634915.IsNSRCPlus

function TK532634915.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'NSRC 7.7';
end;//TK532634915.GetFolder

function TK532634915.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '5369D1DB0248';
end;//TK532634915.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK532634915.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
