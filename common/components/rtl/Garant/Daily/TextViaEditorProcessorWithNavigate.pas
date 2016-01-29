unit TextViaEditorProcessorWithNavigate;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/Daily/TextViaEditorProcessorWithNavigate.pas"
// Начат: 16.09.2010 17:00
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::EditorTests::TTextViaEditorProcessorWithNavigate
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Daily\TestDefine.inc.pas}

interface

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  evCustomEditorWindow
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  TextViaEditorProcessor
  {$IfEnd} //nsTest AND not NoVCM
  ,
  l3Variant
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  PrimTextLoad_Form
  {$IfEnd} //nsTest AND not NoVCM
  
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 _Navigator_Parent_ = TTextViaEditorProcessor;
 {$Include w:\common\components\gui\Garant\Everest\EditorUsers\Navigator.imp.pas}
 TTextViaEditorProcessorWithNavigate = {abstract} class(_Navigator_)
 protected
 // realized methods
   {$If defined(nsTest) AND not defined(NoVCM)}
   procedure Process(aForm: TPrimTextLoadForm); override;
     {* Собственно процесс обработки текста }
   {$IfEnd} //nsTest AND not NoVCM
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 protected
 // protected methods
   procedure DoProcess(aText: TevCustomEditorWindow;
    const anOp: Il3OpPack); virtual; abstract;
 end;//TTextViaEditorProcessorWithNavigate
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

{$Include w:\common\components\gui\Garant\Everest\EditorUsers\Navigator.imp.pas}

// start class TTextViaEditorProcessorWithNavigate

{$If defined(nsTest) AND not defined(NoVCM)}
procedure TTextViaEditorProcessorWithNavigate.Process(aForm: TPrimTextLoadForm);
//#UC START# *4BE13147032C_4C9214C80098_var*
var
 l_Op : Il3OpPack;
//#UC END# *4BE13147032C_4C9214C80098_var*
begin
//#UC START# *4BE13147032C_4C9214C80098_impl*
 with aForm.Text do
 begin
  l_Op := StartOp;
  try
   Navigate(aForm.Text, l_Op);
   DoProcess(aForm.Text, l_Op);
  finally
   l_Op := nil;
  end;//try..finally
 end;//with aForm.Text
//#UC END# *4BE13147032C_4C9214C80098_impl*
end;//TTextViaEditorProcessorWithNavigate.Process
{$IfEnd} //nsTest AND not NoVCM

function TTextViaEditorProcessorWithNavigate.GetFolder: AnsiString;
 {-}
begin
 Result := 'EditorTests';
end;//TTextViaEditorProcessorWithNavigate.GetFolder

function TTextViaEditorProcessorWithNavigate.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C9214C80098';
end;//TTextViaEditorProcessorWithNavigate.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.