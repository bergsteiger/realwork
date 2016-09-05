unit K361038156;
 {* [RequestLink:361038156] }

// Модуль: "w:\common\components\rtl\Garant\Archi_Tests\K361038156.pas"
// Стереотип: "TestCase"
// Элемент модели: "K361038156" MUID: (4FA138AB0003)
// Имя типа: "TK361038156"

{$Include w:\common\components\rtl\Garant\Archi_Tests\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , ArchiStorageTest
;

type
 TK361038156 = class(TArchiStorageTest)
  {* [RequestLink:361038156] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK361038156
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4FA138AB0003impl_uses*
 //#UC END# *4FA138AB0003impl_uses*
;

function TK361038156.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'Storage';
end;//TK361038156.GetFolder

function TK361038156.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4FA138AB0003';
end;//TK361038156.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK361038156.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
