unit K235866221;
 {* [RequestLink:235866221] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K235866221.pas"
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
 TK235866221 = class(TPreviewTestBefore235875079)
  {* [RequestLink:235866221] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK235866221
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK235866221.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.6';
end;//TK235866221.GetFolder

function TK235866221.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4CA9D1F00347';
end;//TK235866221.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK235866221.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
