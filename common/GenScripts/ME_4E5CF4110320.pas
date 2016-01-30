unit K280006084;
 {* [RequestLink:280006084] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K280006084.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , PreviewTest
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TK280006084 = class(TPreviewTest)
  {* [RequestLink:280006084] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK280006084
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK280006084.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.7 Lulin';
end;//TK280006084.GetFolder

function TK280006084.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4E5CF4110320';
end;//TK280006084.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK280006084.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
