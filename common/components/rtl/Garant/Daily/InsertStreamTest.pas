unit InsertStreamTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "DailyTest"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/Daily/InsertStreamTest.pas"
// �����: 28.07.2010 11:30
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::EditorTests::TInsertStreamTest
//
// ���� ������� � �������� ������ ��� ������ InsertStream
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Daily\TestDefine.inc.pas}

interface

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TextViaEditorProcessorWithNavigate,
  evCustomEditorWindow,
  l3Variant
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TInsertStreamTest = {abstract} class(TTextViaEditorProcessorWithNavigate)
  {* ���� ������� � �������� ������ ��� ������ InsertStream }
 protected
 // realized methods
   procedure DoProcess(aText: TevCustomEditorWindow;
    const anOp: Il3OpPack); override;
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 protected
 // protected methods
   function TextForInsert: AnsiString; virtual; abstract;
     {* ����� ��� ������� }
 end;//TInsertStreamTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  l3Interfaces,
  l3Memory,
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
  l3Base
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TInsertStreamTest

procedure TInsertStreamTest.DoProcess(aText: TevCustomEditorWindow;
  const anOp: Il3OpPack);
//#UC START# *4C9214F6002C_4C4FDC620374_var*
var
 l_Stream : Tl3ConstMemoryStream;
 l_Text   : AnsiString;
//#UC END# *4C9214F6002C_4C4FDC620374_var*
begin
//#UC START# *4C9214F6002C_4C4FDC620374_impl*
 with aText do
 begin
  l_Text := TextForInsert;
  l_Stream := Tl3ConstMemoryStream.Create(PAnsiChar(l_Text), Length(l_Text));
  try
   Selection.Text.Modify.InsertStream(View, l_Stream, CF_Text, anOp);
  finally
   FreeAndNil(l_Stream);
  end;//try..finally
 end;//with aText
//#UC END# *4C9214F6002C_4C4FDC620374_impl*
end;//TInsertStreamTest.DoProcess

function TInsertStreamTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'EditorTests';
end;//TInsertStreamTest.GetFolder

function TInsertStreamTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C4FDC620374';
end;//TInsertStreamTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.