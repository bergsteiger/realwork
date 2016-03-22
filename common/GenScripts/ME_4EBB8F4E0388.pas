unit K297705917;
 {* [RequestLink:297705917] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K297705917.pas"
// Стереотип: "TestCase"
// Элемент модели: "K297705917" MUID: (4EBB8F4E0388)
// Имя типа: "TK297705917"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , AllChildreCountTest
;

type
 TK297705917 = class(TAllChildreCountTest)
  {* [RequestLink:297705917] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK297705917
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Base
;

function TK297705917.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.7';
end;//TK297705917.GetFolder

function TK297705917.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4EBB8F4E0388';
end;//TK297705917.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK297705917.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
