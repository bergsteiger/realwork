unit ScrollParamsTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Abstract Tests"
// Модуль: "w:/common/components/rtl/Garant/Abstract_Tests/ScrollParamsTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::Abstract Tests::EditorTests::TScrollParamsTest
//
// Тесты для провкрки параметров скроллера при прокрутке и переходе по сабам документа.
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
  ScrollerParamsTestPrim,
  Types
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  PrimTextLoad_Form
  {$IfEnd} //nsTest AND not NoVCM
  
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TScrollParamsTest = {abstract} class(TScrollerParamsTestPrim)
  {* Тесты для провкрки параметров скроллера при прокрутке и переходе по сабам документа. }
 protected
 // realized methods
   {$If defined(nsTest) AND not defined(NoVCM)}
   procedure Process(aForm: TPrimTextLoadForm); override;
     {* Собственно процесс обработки текста }
   {$IfEnd} //nsTest AND not NoVCM
 protected
 // overridden protected methods
   {$If defined(nsTest) AND not defined(NoVCM)}
   function FormExtent: TPoint; override;
     {* Размеры формы }
   {$IfEnd} //nsTest AND not NoVCM
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 protected
 // protected methods
   function GetSubNumber: Integer; virtual;
 end;//TScrollParamsTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
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

// start class TScrollParamsTest

function TScrollParamsTest.GetSubNumber: Integer;
//#UC START# *4D7211F7018C_4D7210300201_var*
//#UC END# *4D7211F7018C_4D7210300201_var*
begin
//#UC START# *4D7211F7018C_4D7210300201_impl*
 Result := 1;
//#UC END# *4D7211F7018C_4D7210300201_impl*
end;//TScrollParamsTest.GetSubNumber

{$If defined(nsTest) AND not defined(NoVCM)}
procedure TScrollParamsTest.Process(aForm: TPrimTextLoadForm);
//#UC START# *4BE13147032C_4D7210300201_var*
//#UC END# *4BE13147032C_4D7210300201_var*
begin
//#UC START# *4BE13147032C_4D7210300201_impl*
 with aForm.Text do
  TextSource.DocumentContainer.SubList.Sub[GetSubNumber].Select(Selection);
//#UC END# *4BE13147032C_4D7210300201_impl*
end;//TScrollParamsTest.Process
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
function TScrollParamsTest.FormExtent: TPoint;
//#UC START# *4C08CF700318_4D7210300201_var*
//#UC END# *4C08CF700318_4D7210300201_var*
begin
//#UC START# *4C08CF700318_4D7210300201_impl*
 Result.X := 1000;
 Result.Y := 750;
//#UC END# *4C08CF700318_4D7210300201_impl*
end;//TScrollParamsTest.FormExtent
{$IfEnd} //nsTest AND not NoVCM

function TScrollParamsTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'EditorTests';
end;//TScrollParamsTest.GetFolder

function TScrollParamsTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4D7210300201';
end;//TScrollParamsTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.