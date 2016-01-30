unit K213713115;
 {* [$213713115] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K213713115.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , PreviewTestBefore235875079
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TK213713115 = class(TPreviewTestBefore235875079)
  {* [$213713115] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK213713115
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK213713115.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.5';
end;//TK213713115.GetFolder

function TK213713115.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4BF25356037B';
end;//TK213713115.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK213713115.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
