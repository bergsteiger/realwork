unit K235052899;
 {* [RequestLink:235052899]. }

// Модуль: "w:\common\components\rtl\Garant\Daily\K235052899.pas"
// Стереотип: "TestCase"
// Элемент модели: "K235052899" MUID: (4C9395B90345)
// Имя типа: "TK235052899"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDwithFormulasToRTFWriterTest
;

type
 TK235052899 = class(TEVDwithFormulasToRTFWriterTest)
  {* [RequestLink:235052899]. }
  protected
   {$If Defined(XE) AND NOT Defined(NotTunedDUnit)}
   function EtalonNeedsXE: Boolean; override;
   {$IfEnd} // Defined(XE) AND NOT Defined(NotTunedDUnit)
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK235052899
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4C9395B90345impl_uses*
 //#UC END# *4C9395B90345impl_uses*
;

{$If Defined(XE) AND NOT Defined(NotTunedDUnit)}
function TK235052899.EtalonNeedsXE: Boolean;
//#UC START# *51AF49E5001B_4C9395B90345_var*
//#UC END# *51AF49E5001B_4C9395B90345_var*
begin
//#UC START# *51AF49E5001B_4C9395B90345_impl*
 Result := true;
//#UC END# *51AF49E5001B_4C9395B90345_impl*
end;//TK235052899.EtalonNeedsXE
{$IfEnd} // Defined(XE) AND NOT Defined(NotTunedDUnit)

function TK235052899.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.6';
end;//TK235052899.GetFolder

function TK235052899.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4C9395B90345';
end;//TK235052899.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK235052899.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
