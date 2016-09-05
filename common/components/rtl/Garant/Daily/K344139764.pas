unit K344139764;
 {* [RequestLink:344139764] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K344139764.pas"
// Стереотип: "TestCase"
// Элемент модели: "K344139764" MUID: (4F60B8740219)
// Имя типа: "TK344139764"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , PreviewTest
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TK344139764 = class({$If NOT Defined(NoVCM)}
 TPreviewTest
 {$IfEnd} // NOT Defined(NoVCM)
 )
  {* [RequestLink:344139764] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK344139764
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
 //#UC START# *4F60B8740219impl_uses*
 //#UC END# *4F60B8740219impl_uses*
;

{$If NOT Defined(NoVCM)}
function TK344139764.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.7 Lulin';
end;//TK344139764.GetFolder

function TK344139764.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4F60B8740219';
end;//TK344139764.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK344139764.Suite);
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
