unit K598136171_Restore;
 {* [RequestLink:598136171] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K598136171_Restore.pas"
// Стереотип: "TestCase"
// Элемент модели: "K598136171_Restore" MUID: (561E7FB00077)
// Имя типа: "TK598136171_Restore"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , UnicodeFormulasToUnicodeConverterTest
;

type
 TK598136171_Restore = class(TUnicodeFormulasToUnicodeConverterTest)
  {* [RequestLink:598136171] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK598136171_Restore
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK598136171_Restore.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.12';
end;//TK598136171_Restore.GetFolder

function TK598136171_Restore.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '561E7FB00077';
end;//TK598136171_Restore.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK598136171_Restore.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
