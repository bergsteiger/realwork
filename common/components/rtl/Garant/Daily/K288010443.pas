unit K288010443;
 {* [RequestLink:288010443] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K288010443.pas"
// Стереотип: "TestCase"
// Элемент модели: "K288010443" MUID: (4E8304550222)
// Имя типа: "TK288010443"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoNSRCPlusWriterTest
;

type
 TK288010443 = class(TEVDtoNSRCPlusWriterTest)
  {* [RequestLink:288010443] }
  protected
   function AcceptBadPictureFormat: Boolean; override;
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK288010443
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4E8304550222impl_uses*
 //#UC END# *4E8304550222impl_uses*
;

function TK288010443.AcceptBadPictureFormat: Boolean;
//#UC START# *4E8317EF02C7_4E8304550222_var*
//#UC END# *4E8317EF02C7_4E8304550222_var*
begin
//#UC START# *4E8317EF02C7_4E8304550222_impl*
 Result := true;
//#UC END# *4E8317EF02C7_4E8304550222_impl*
end;//TK288010443.AcceptBadPictureFormat

function TK288010443.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.7 Lulin';
end;//TK288010443.GetFolder

function TK288010443.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4E8304550222';
end;//TK288010443.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK288010443.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
