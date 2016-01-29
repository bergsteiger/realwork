unit WrongSearchTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Abstract Tests"
// Модуль: "w:/common/components/rtl/Garant/Abstract_Tests/WrongSearchTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::Abstract Tests::EditorTests::TWrongSearchTest
//
// Поиск строки не должен проходить.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Abstract_Tests\TestDefine.inc.pas}

interface

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  Classes
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  SearchAndReplaceTest
  {$IfEnd} //nsTest AND not NoVCM
  
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  PrimTextLoad_Form
  {$IfEnd} //nsTest AND not NoVCM
  ,
  nevTools,
  evTypes
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TWrongSearchTest = {abstract} class(TSearchAndReplaceTest)
  {* Поиск строки не должен проходить. }
 protected
 // overridden protected methods
   {$If defined(nsTest) AND not defined(NoVCM)}
   procedure Process(aForm: TPrimTextLoadForm); override;
     {* Собственно процесс обработки текста }
   {$IfEnd} //nsTest AND not NoVCM
   {$If defined(nsTest) AND not defined(NoVCM)}
   function Replacer: IevReplacer; override;
   {$IfEnd} //nsTest AND not NoVCM
   {$If defined(nsTest) AND not defined(NoVCM)}
   function Options: TevSearchOptionSet; override;
   {$IfEnd} //nsTest AND not NoVCM
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TWrongSearchTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  evExcept,
  TestFrameWork
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  ,
  SysUtils
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  l3Base
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TWrongSearchTest

{$If defined(nsTest) AND not defined(NoVCM)}
procedure TWrongSearchTest.Process(aForm: TPrimTextLoadForm);
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
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
function TWrongSearchTest.Replacer: IevReplacer;
//#UC START# *4C288BFC002C_4D9411E703B8_var*
//#UC END# *4C288BFC002C_4D9411E703B8_var*
begin
//#UC START# *4C288BFC002C_4D9411E703B8_impl*
 Result := nil;
//#UC END# *4C288BFC002C_4D9411E703B8_impl*
end;//TWrongSearchTest.Replacer
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
function TWrongSearchTest.Options: TevSearchOptionSet;
//#UC START# *4C288CC60231_4D9411E703B8_var*
//#UC END# *4C288CC60231_4D9411E703B8_var*
begin
//#UC START# *4C288CC60231_4D9411E703B8_impl*
 Result := [ev_soGlobal]
//#UC END# *4C288CC60231_4D9411E703B8_impl*
end;//TWrongSearchTest.Options
{$IfEnd} //nsTest AND not NoVCM

function TWrongSearchTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'EditorTests';
end;//TWrongSearchTest.GetFolder

function TWrongSearchTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4D9411E703B8';
end;//TWrongSearchTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.