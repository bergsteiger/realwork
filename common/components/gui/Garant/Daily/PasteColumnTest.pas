unit PasteColumnTest;
 {* ���� ����������� � ������� �� ������ ������� � ������������ �������. }

// ������: "w:\common\components\gui\Garant\Daily\PasteColumnTest.pas"
// ���������: "TestCase"
// ������� ������: "TPasteColumnTest" MUID: (4C88AA1A00AB)

{$Include w:\common\components\gui\sdotDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , TextViaEditorProcessor
 , PrimTextLoad_Form
;

type
 TPasteColumnTest = {abstract} class(TTextViaEditorProcessor)
  {* ���� ����������� � ������� �� ������ ������� � ������������ �������. }
  protected
   procedure Process(aForm: TPrimTextLoadForm); override;
    {* ���������� ������� ��������� ������ }
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TPasteColumnTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

implementation

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 {$If Defined(k2ForEditor)}
 , evCursorTools
 {$IfEnd} // Defined(k2ForEditor)
 , nevTools
 , l3Base
 , TestFrameWork
 , vcmBase
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 //#UC START# *4C88AA1A00ABimpl_uses*
 //#UC END# *4C88AA1A00ABimpl_uses*
;

procedure TPasteColumnTest.Process(aForm: TPrimTextLoadForm);
 {* ���������� ������� ��������� ������ }
//#UC START# *4BE13147032C_4C88AA1A00AB_var*
var
 l_Selection : InevSelection;
//#UC END# *4BE13147032C_4C88AA1A00AB_var*
begin
//#UC START# *4BE13147032C_4C88AA1A00AB_impl*
 l_Selection := aForm.Text.Selection;
 if (l_Selection <> nil) then
 begin
  evSelectTableColumn(l_Selection, aForm.Text.Document.Para[0].AsList, 0);
  aForm.Text.Copy;
  evSelectTableColumn(l_Selection, aForm.Text.Document.Para[2].AsList, 0);
  aForm.Text.Paste;
  l3System.ClearClipboard;
 end; // if (l_Selection <> nil) then
//#UC END# *4BE13147032C_4C88AA1A00AB_impl*
end;//TPasteColumnTest.Process

function TPasteColumnTest.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'Everest';
end;//TPasteColumnTest.GetFolder

function TPasteColumnTest.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4C88AA1A00AB';
end;//TPasteColumnTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

end.
