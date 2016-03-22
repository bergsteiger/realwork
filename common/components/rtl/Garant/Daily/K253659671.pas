unit K253659671;
 {* [$253659671] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K253659671.pas"
// Стереотип: "TestCase"
// Элемент модели: "K253659671" MUID: (4D6CBB42030B)
// Имя типа: "TK253659671"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , ShowBaseSearchTest
;

type
 TK253659671 = class(TShowBaseSearchTest)
  {* [$253659671] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK253659671
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 , Types
 , Messages
 , Windows
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Base
;

function TK253659671.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.7';
end;//TK253659671.GetFolder

function TK253659671.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4D6CBB42030B';
end;//TK253659671.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK253659671.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
