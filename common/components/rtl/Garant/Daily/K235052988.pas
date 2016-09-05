unit K235052988;
 {* [RequestLink:235052988]. }

// Модуль: "w:\common\components\rtl\Garant\Daily\K235052988.pas"
// Стереотип: "TestCase"
// Элемент модели: "K235052988" MUID: (4C971C9E0204)
// Имя типа: "TK235052988"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK235052988 = class(TRTFtoEVDWriterTest)
  {* [RequestLink:235052988]. }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK235052988
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4C971C9E0204impl_uses*
 //#UC END# *4C971C9E0204impl_uses*
;

function TK235052988.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.6';
end;//TK235052988.GetFolder

function TK235052988.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4C971C9E0204';
end;//TK235052988.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK235052988.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
