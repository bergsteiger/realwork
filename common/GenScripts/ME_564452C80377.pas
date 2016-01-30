unit DiffTest;

// ������: "w:\common\components\rtl\Garant\Daily\DiffTest.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NotTunedDUnit)}
 , BaseTest
 {$IfEnd} // NOT Defined(NotTunedDUnit)
;

type
 TDiffTest = class(TBaseTest)
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
  public
   procedure DoIt;
 end;//TDiffTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , l3Diff
 , l3DiffSupport
 , TestFrameWork
 , l3Filer
 , SysUtils
;

procedure TDiffTest.DoIt;
//#UC START# *5644533F0088_564452C80377_var*
var
 l_CompareFunc: Tl3DiffCompareFunc;
 l_ReportProc : Tl3DiffReportProc;
 l_Filer      : Tl3CustomFiler;
 l_Original   : AnsiString;
 l_Changed    : AnsiString;

 function l_Compare(I: Integer; J: Integer): Boolean;
 begin
  Result := l_Original[I+1] = l_Changed[J+1];
 end;

 procedure l_Report(const aRR: Tl3DiffReportRec);
 begin
  case aRR.rOp of
   l3diffSame    : l_Filer.Writeln(' ' + l_Original[aRR.rLeftIdx+1]);
   l3diffDeleted : l_Filer.Writeln('-' + l_Original[aRR.rLeftIdx+1]);
   l3diffAdded   : l_Filer.Writeln('+' + l_Changed[aRR.rRightIdx+1]);
  end;
 end;

//#UC END# *5644533F0088_564452C80377_var*
begin
//#UC START# *5644533F0088_564452C80377_impl*
 l_Original := '���� � ������ ��� ������ ����';
 l_Changed  := '���� � ������ ������ ������� ����';
 l_Filer := FilerForOutput;
 try
  l_Filer.Open;
  l_Filer.Writeln('��������  : ' + l_Original);
  l_Filer.Writeln('����������: ' + l_Changed);
  l_Filer.Writeln('');
  l_CompareFunc := l3L2CF(@l_Compare);
  try
   l_ReportProc := l3L2RP(@l_Report);
   try
    l3DoDiff(Length(l_Original), Length(l_Changed), l_CompareFunc, l_ReportProc);
   finally
    l3FreeRP(l_ReportProc);
   end;
  finally
   l3FreeCF(l_CompareFunc);
  end;
 finally
  FreeAndNil(l_Filer);
 end;
 CheckWithEtalon(FileForOutput, #0);
//#UC END# *5644533F0088_564452C80377_impl*
end;//TDiffTest.DoIt

function TDiffTest.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'Diff';
end;//TDiffTest.GetFolder

function TDiffTest.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '564452C80377';
end;//TDiffTest.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TDiffTest.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
