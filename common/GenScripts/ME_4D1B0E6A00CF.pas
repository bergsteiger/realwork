unit K247302160;
 {* [$247302160] }

// ������: "w:\common\components\rtl\Garant\Daily\K247302160.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , TextMericsAfterDeleteTest
 , nevTools
;

type
 TK247302160 = class(TTextMericsAfterDeleteTest)
  {* [$247302160] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetTablePara(const aDocument: InevParaList): InevParaList; override;
    {* ���������� �������� � �������� }
   procedure GetSelectParam(out aStartRow: Integer;
    out aStartCell: Integer;
    out aFinishRow: Integer;
    out aFinishCell: Integer); override;
    {* �������� "����������" ����� ���������. }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK247302160
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK247302160.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.7';
end;//TK247302160.GetFolder

function TK247302160.GetTablePara(const aDocument: InevParaList): InevParaList;
 {* ���������� �������� � �������� }
//#UC START# *4CC818F4022D_4D1B0E6A00CF_var*
//#UC END# *4CC818F4022D_4D1B0E6A00CF_var*
begin
//#UC START# *4CC818F4022D_4D1B0E6A00CF_impl*
 Result := aDocument.Para[6].AsList;
//#UC END# *4CC818F4022D_4D1B0E6A00CF_impl*
end;//TK247302160.GetTablePara

procedure TK247302160.GetSelectParam(out aStartRow: Integer;
 out aStartCell: Integer;
 out aFinishRow: Integer;
 out aFinishCell: Integer);
 {* �������� "����������" ����� ���������. }
//#UC START# *4CC81D4101AC_4D1B0E6A00CF_var*
//#UC END# *4CC81D4101AC_4D1B0E6A00CF_var*
begin
//#UC START# *4CC81D4101AC_4D1B0E6A00CF_impl*
 aStartRow := 7;
 aStartCell := 0;
 aFinishRow := 11;
 aFinishCell := 6;
//#UC END# *4CC81D4101AC_4D1B0E6A00CF_impl*
end;//TK247302160.GetSelectParam

function TK247302160.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4D1B0E6A00CF';
end;//TK247302160.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK247302160.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
