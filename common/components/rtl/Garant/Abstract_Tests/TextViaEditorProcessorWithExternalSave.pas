unit TextViaEditorProcessorWithExternalSave;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Abstract Tests"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/Abstract_Tests/TextViaEditorProcessorWithExternalSave.pas"
// �����: 14.12.2010 16:31
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::Abstract Tests::EditorTests::TTextViaEditorProcessorWithExternalSave
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Abstract_Tests\TestDefine.inc.pas}

interface

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  l3Filer
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
 TTextViaEditorProcessorWithExternalSave = {abstract} class(TTextViaEditorProcessor)
 protected
 // overridden protected methods
    {$If defined(nsTest) AND not defined(NoVCM)}
   procedure Save(aForm: TPrimTextLoadForm); override;
     {* ��������� ����� �� ��������� � ����������� �������� ���� }
    {$IfEnd} //nsTest AND not NoVCM
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 protected
 // protected methods
   procedure DoSave(aForm: TPrimTextLoadForm;
     aFiler: Tl3CustomFiler); virtual; abstract;
 end;//TTextViaEditorProcessorWithExternalSave
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  SysUtils,
  TestFrameWork
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  l3Base,
  evdNativeWriter
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TTextViaEditorProcessorWithExternalSave

{$If defined(nsTest) AND not defined(NoVCM)}
procedure TTextViaEditorProcessorWithExternalSave.Save(aForm: TPrimTextLoadForm);
//#UC START# *4BE12AEE0190_4D0771BA0367_var*
var
 l_F : Tl3CustomFiler;
//#UC END# *4BE12AEE0190_4D0771BA0367_var*
begin
//#UC START# *4BE12AEE0190_4D0771BA0367_impl*
 l_F := FilerForOutput;
 try
  l_F.Open;
  try
   DoSave(aForm, l_F);
  finally
   l_F.Close;
  end;//try..finally
 finally
  FreeAndNil(l_F);
 end;//try..finally
//#UC END# *4BE12AEE0190_4D0771BA0367_impl*
end;//TTextViaEditorProcessorWithExternalSave.Save
{$IfEnd} //nsTest AND not NoVCM

function TTextViaEditorProcessorWithExternalSave.GetFolder: AnsiString;
 {-}
begin
 Result := 'EditorTests';
end;//TTextViaEditorProcessorWithExternalSave.GetFolder

function TTextViaEditorProcessorWithExternalSave.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4D0771BA0367';
end;//TTextViaEditorProcessorWithExternalSave.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.