unit K217686256;
 {* [RequestLink:217686256] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K217686256.pas"
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
 TK217686256 = class(TPreviewTestBefore235875079)
  {* [RequestLink:217686256] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK217686256
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK217686256.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.5';
end;//TK217686256.GetFolder

function TK217686256.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4C0FAC3503AC';
end;//TK217686256.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK217686256.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
