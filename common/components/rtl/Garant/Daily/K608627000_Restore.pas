unit K608627000_Restore;
 {* [RequestLink:608627000] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K608627000_Restore.pas"
// Стереотип: "TestCase"
// Элемент модели: "K608627000_Restore" MUID: (561E7F570187)
// Имя типа: "TK608627000_Restore"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , UnicodeFormulasToUnicodeConverterTest
;

type
 TK608627000_Restore = class(TUnicodeFormulasToUnicodeConverterTest)
  {* [RequestLink:608627000] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK608627000_Restore
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *561E7F570187impl_uses*
 //#UC END# *561E7F570187impl_uses*
;

function TK608627000_Restore.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.12';
end;//TK608627000_Restore.GetFolder

function TK608627000_Restore.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '561E7F570187';
end;//TK608627000_Restore.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK608627000_Restore.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
