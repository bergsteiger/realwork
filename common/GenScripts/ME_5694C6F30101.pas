unit K615679638;
 {* [Requestlink:615679638] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K615679638.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK615679638 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:615679638] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
   function TreatExceptionAsSuccess: Boolean; override;
 end;//TK615679638
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK615679638.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.12';
end;//TK615679638.GetFolder

function TK615679638.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '5694C6F30101';
end;//TK615679638.GetModelElementGUID

function TK615679638.TreatExceptionAsSuccess: Boolean;
//#UC START# *51406117007F_5694C6F30101_var*
//#UC END# *51406117007F_5694C6F30101_var*
begin
//#UC START# *51406117007F_5694C6F30101_impl*
 Result := True;
//#UC END# *51406117007F_5694C6F30101_impl*
end;//TK615679638.TreatExceptionAsSuccess

initialization
 TestFramework.RegisterTest(TK615679638.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
