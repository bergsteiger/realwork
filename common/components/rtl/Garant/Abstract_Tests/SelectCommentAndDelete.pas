unit SelectCommentAndDelete;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Abstract Tests"
// Модуль: "w:/common/components/rtl/Garant/Abstract_Tests/SelectCommentAndDelete.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::Abstract Tests::EditorTests::TSelectCommentAndDelete
//
// Выделить комментарий и удалить.
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
  TextViaEditorProcessor
  {$IfEnd} //nsTest AND not NoVCM
  ,
  evCustomEditorWindow
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  PrimTextLoad_Form
  {$IfEnd} //nsTest AND not NoVCM
  
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 _SelectOperation_Parent_ = TTextViaEditorProcessor;
 {$Include w:\common\components\gui\Garant\Everest\EditorUsers\SelectOperation.imp.pas}
 TSelectCommentAndDelete = {abstract} class(_SelectOperation_)
  {* Выделить комментарий и удалить. }
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
 end;//TSelectCommentAndDelete
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork,
  evTypes
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

{$Include w:\common\components\gui\Garant\Everest\EditorUsers\SelectOperation.imp.pas}

// start class TSelectCommentAndDelete

{$If defined(nsTest) AND not defined(NoVCM)}
procedure TSelectCommentAndDelete.Process(aForm: TPrimTextLoadForm);
//#UC START# *4BE13147032C_4DD5FF50028A_var*
//#UC END# *4BE13147032C_4DD5FF50028A_var*
begin
//#UC START# *4BE13147032C_4DD5FF50028A_impl*
 SelectPara(aForm.Text);
 aForm.Text.Range.Delete;
//#UC END# *4BE13147032C_4DD5FF50028A_impl*
end;//TSelectCommentAndDelete.Process
{$IfEnd} //nsTest AND not NoVCM

function TSelectCommentAndDelete.GetFolder: AnsiString;
 {-}
begin
 Result := 'EditorTests';
end;//TSelectCommentAndDelete.GetFolder

function TSelectCommentAndDelete.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4DD5FF50028A';
end;//TSelectCommentAndDelete.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.