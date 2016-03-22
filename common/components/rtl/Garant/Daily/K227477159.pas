unit K227477159;
 {* [$227477159] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K227477159.pas"
// Стереотип: "TestCase"
// Элемент модели: "K227477159" MUID: (4C45569C0111)
// Имя типа: "TK227477159"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , ScrollBackByLineTest
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TK227477159 = class(TScrollBackByLineTest)
  {* [$227477159] }
  protected
   {$If NOT Defined(NoVCM)}
   function MaxHeight: Integer; override;
    {* Если возвращается не 0, то будет организован цикл подбора высоты от FormExtent.Y до MaxHeight }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK227477159
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
;

{$If NOT Defined(NoVCM)}
function TK227477159.MaxHeight: Integer;
 {* Если возвращается не 0, то будет организован цикл подбора высоты от FormExtent.Y до MaxHeight }
//#UC START# *4C0E56F000A4_4C45569C0111_var*
//#UC END# *4C0E56F000A4_4C45569C0111_var*
begin
//#UC START# *4C0E56F000A4_4C45569C0111_impl*
 Result := 12;
//#UC END# *4C0E56F000A4_4C45569C0111_impl*
end;//TK227477159.MaxHeight

function TK227477159.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.6';
end;//TK227477159.GetFolder

function TK227477159.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4C45569C0111';
end;//TK227477159.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK227477159.Suite);
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
