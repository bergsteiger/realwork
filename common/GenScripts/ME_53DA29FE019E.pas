unit K558957526;
 {* [Requestlink:558957526] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K558957526.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoRTFRender
;

type
 TK558957526 = class(TEVDtoRTFRender)
  {* [Requestlink:558957526] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
   function TreatExceptionAsSuccess: Boolean; override;
 end;//TK558957526
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK558957526.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.10';
end;//TK558957526.GetFolder

function TK558957526.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '53DA29FE019E';
end;//TK558957526.GetModelElementGUID

function TK558957526.TreatExceptionAsSuccess: Boolean;
//#UC START# *53DA3E0C019A_53DA29FE019E_var*
//#UC END# *53DA3E0C019A_53DA29FE019E_var*
begin
//#UC START# *53DA3E0C019A_53DA29FE019E_impl*
 Result := True;
//#UC END# *53DA3E0C019A_53DA29FE019E_impl*
end;//TK558957526.TreatExceptionAsSuccess

initialization
 TestFramework.RegisterTest(TK558957526.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
