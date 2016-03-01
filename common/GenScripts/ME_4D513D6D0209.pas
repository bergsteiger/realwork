unit InsertPictureTest;
 {* ���� ������� �������� � �����. }

// ������: "w:\common\components\rtl\Garant\Abstract_Tests\InsertPictureTest.pas"
// ���������: "TestCase"

{$Include w:\common\components\rtl\Garant\Abstract_Tests\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , TextViaEditorProcessor
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , PrimTextLoad_Form
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 _CursorMover_Parent_ = TTextViaEditorProcessor;
 {$Include w:\common\components\gui\Garant\Everest\EditorUsers\CursorMover.imp.pas}
 TInsertPictureTest = {abstract} class(_CursorMover_)
  {* ���� ������� �������� � �����. }
  protected
   {$If NOT Defined(NoVCM)}
   procedure Process(aForm: TPrimTextLoadForm); override;
    {* ���������� ������� ��������� ������ }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TInsertPictureTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , nevPersistentDocumentContainer
 , nevInternalInterfaces
 , l3Interfaces
 , evExtFormat
 , l3Base
 , TestFrameWork
 , evMsgCode
 , evOp
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
;

{$Include w:\common\components\gui\Garant\Everest\EditorUsers\CursorMover.imp.pas}

{$If NOT Defined(NoVCM)}
procedure TInsertPictureTest.Process(aForm: TPrimTextLoadForm);
 {* ���������� ������� ��������� ������ }
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
{$IfEnd} // NOT Defined(NoVCM)

function TInsertPictureTest.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'EditorTests';
end;//TInsertPictureTest.GetFolder

function TInsertPictureTest.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4D513D6D0209';
end;//TInsertPictureTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
