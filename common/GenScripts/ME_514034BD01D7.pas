unit K434763341;
 {* [RequestLink:434763341] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K434763341.pas"
// Стереотип: "TestCase"
// Элемент модели: "K434763341" MUID: (514034BD01D7)
// Имя типа: "TK434763341"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK434763341 = class(TRTFtoEVDWriterTest)
  {* [RequestLink:434763341] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
   function TreatExceptionAsSuccess: Boolean; override;
 end;//TK434763341
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK434763341.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.8';
end;//TK434763341.GetFolder

function TK434763341.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '514034BD01D7';
end;//TK434763341.GetModelElementGUID

function TK434763341.TreatExceptionAsSuccess: Boolean;
//#UC START# *51406117007F_514034BD01D7_var*
//#UC END# *51406117007F_514034BD01D7_var*
begin
//#UC START# *51406117007F_514034BD01D7_impl*
 Result := True;
//#UC END# *51406117007F_514034BD01D7_impl*
end;//TK434763341.TreatExceptionAsSuccess

initialization
 TestFramework.RegisterTest(TK434763341.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
