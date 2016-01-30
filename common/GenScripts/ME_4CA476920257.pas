unit K235864191;
 {* [RequestLink:235864191] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K235864191.pas"
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
 TK235864191 = class(TPreviewTestBefore235875079)
  {* [RequestLink:235864191] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK235864191
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK235864191.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.6';
end;//TK235864191.GetFolder

function TK235864191.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4CA476920257';
end;//TK235864191.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK235864191.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
