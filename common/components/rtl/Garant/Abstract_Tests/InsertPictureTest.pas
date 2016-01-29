unit InsertPictureTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Abstract Tests"
// Модуль: "w:/common/components/rtl/Garant/Abstract_Tests/InsertPictureTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::Abstract Tests::EditorTests::TInsertPictureTest
//
// Тест вставки картинки в текст.
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
  
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  PrimTextLoad_Form
  {$IfEnd} //nsTest AND not NoVCM
  
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 _CursorMover_Parent_ = TTextViaEditorProcessor;
 {$Include w:\common\components\gui\Garant\Everest\EditorUsers\CursorMover.imp.pas}
 TInsertPictureTest = {abstract} class(_CursorMover_)
  {* Тест вставки картинки в текст. }
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
 end;//TInsertPictureTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  nevPersistentDocumentContainer,
  nevInternalInterfaces,
  l3Interfaces,
  evExtFormat,
  l3Base,
  TestFrameWork,
  evMsgCode,
  evOp
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
  
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

{$Include w:\common\components\gui\Garant\Everest\EditorUsers\CursorMover.imp.pas}

// start class TInsertPictureTest

{$If defined(nsTest) AND not defined(NoVCM)}
procedure TInsertPictureTest.Process(aForm: TPrimTextLoadForm);
//#UC START# *4BE13147032C_4D513D6D0209_var*
var
 l_Reader: Tk2CustomReader;
//#UC END# *4BE13147032C_4D513D6D0209_var*
begin
//#UC START# *4BE13147032C_4D513D6D0209_impl*
 aForm.Text.Selection.Cursor.Move(aForm.Text.View, ev_ocParaDown);
 l_Reader := nil;
 evGetReaderProc(Self, CF_HDROP, l_Reader, FileFromCurrent(KPage + '.jpg'));
 try
  aForm.Text.TextSource.DocumentContainer.TagWriter.WriteTagEx(aForm.Text.View, l_Reader, aForm.Text.Selection.Cursor);
 finally
  l3Free(l_Reader);
 end;
//#UC END# *4BE13147032C_4D513D6D0209_impl*
end;//TInsertPictureTest.Process
{$IfEnd} //nsTest AND not NoVCM

function TInsertPictureTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'EditorTests';
end;//TInsertPictureTest.GetFolder

function TInsertPictureTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4D513D6D0209';
end;//TInsertPictureTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.