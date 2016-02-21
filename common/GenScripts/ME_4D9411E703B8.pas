unit WrongSearchTest;
 {* Поиск строки не должен проходить. }

// Модуль: "w:\common\components\rtl\Garant\Abstract_Tests\WrongSearchTest.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\rtl\Garant\Abstract_Tests\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , SearchAndReplaceTest
 {$IfEnd} // NOT Defined(NoVCM)
 , nevTools
 , evTypes
 {$If NOT Defined(NoVCM)}
 , PrimTextLoad_Form
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TWrongSearchTest = {abstract} class(TSearchAndReplaceTest)
  {* Поиск строки не должен проходить. }
  protected
   {$If NOT Defined(NoVCM)}
   procedure Process(aForm: TPrimTextLoadForm); override;
    {* Собственно процесс обработки текста }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function Replacer: IevReplacer; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function Options: TevSearchOptionSet; override;
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TWrongSearchTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , evExcept
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
procedure TWrongSearchTest.Process(aForm: TPrimTextLoadForm);
 {* Собственно процесс обработки текста }
//#UC START# *4BE13147032C_4D9411E703B8_var*
//#UC END# *4BE13147032C_4D9411E703B8_var*
begin
//#UC START# *4BE13147032C_4D9411E703B8_impl*
 try
  inherited Process(aForm);
  Check(False);
 except
  on EevSearchFailed do Check(True);
 end;
//#UC END# *4BE13147032C_4D9411E703B8_impl*
end;//TWrongSearchTest.Process
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TWrongSearchTest.Replacer: IevReplacer;
//#UC START# *4C288BFC002C_4D9411E703B8_var*
//#UC END# *4C288BFC002C_4D9411E703B8_var*
begin
//#UC START# *4C288BFC002C_4D9411E703B8_impl*
 Result := nil;
//#UC END# *4C288BFC002C_4D9411E703B8_impl*
end;//TWrongSearchTest.Replacer
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TWrongSearchTest.Options: TevSearchOptionSet;
//#UC START# *4C288CC60231_4D9411E703B8_var*
//#UC END# *4C288CC60231_4D9411E703B8_var*
begin
//#UC START# *4C288CC60231_4D9411E703B8_impl*
 Result := [ev_soGlobal]
//#UC END# *4C288CC60231_4D9411E703B8_impl*
end;//TWrongSearchTest.Options
{$IfEnd} // NOT Defined(NoVCM)

function TWrongSearchTest.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'EditorTests';
end;//TWrongSearchTest.GetFolder

function TWrongSearchTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4D9411E703B8';
end;//TWrongSearchTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
