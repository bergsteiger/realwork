unit K249336513;
 {* [RequestLink:249336513] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K249336513.pas"
// Стереотип: "TestCase"
// Элемент модели: "K249336513" MUID: (4D2C43E601FC)
// Имя типа: "TK249336513"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , ScrollTest
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TK249336513 = class({$If NOT Defined(NoVCM)}
 TScrollTest
 {$IfEnd} // NOT Defined(NoVCM)
 )
  {* [RequestLink:249336513] }
  protected
   {$If NOT Defined(NoVCM)}
   function WebStyle: Boolean; override;
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK249336513
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
function TK249336513.WebStyle: Boolean;
//#UC START# *4C08CF4300BE_4D2C43E601FC_var*
//#UC END# *4C08CF4300BE_4D2C43E601FC_var*
begin
//#UC START# *4C08CF4300BE_4D2C43E601FC_impl*
 Result := false;
//#UC END# *4C08CF4300BE_4D2C43E601FC_impl*
end;//TK249336513.WebStyle

function TK249336513.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.7';
end;//TK249336513.GetFolder

function TK249336513.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4D2C43E601FC';
end;//TK249336513.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK249336513.Suite);
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
