unit InsertStreamTest;
 {* ���� ������� � �������� ������ ��� ������ InsertStream }

// ������: "w:\common\components\rtl\Garant\Daily\InsertStreamTest.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , TextViaEditorProcessorWithNavigate
 , evCustomEditorWindow
 , l3Variant
;

type
 TInsertStreamTest = {abstract} class(TTextViaEditorProcessorWithNavigate)
  {* ���� ������� � �������� ������ ��� ������ InsertStream }
  protected
   function TextForInsert: AnsiString; virtual; abstract;
    {* ����� ��� ������� }
   procedure DoProcess(aText: TevCustomEditorWindow;
    const anOp: Il3OpPack); override;
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TInsertStreamTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , l3Interfaces
 , l3Memory
 , SysUtils
 , TestFrameWork
;

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
 {* ����� � ������� ������ ���� }
begin
 Result := 'EditorTests';
end;//TInsertStreamTest.GetFolder

function TInsertStreamTest.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4C4FDC620374';
end;//TInsertStreamTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
