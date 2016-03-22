unit DOCtoEVDWriterTest;

// ������: "w:\common\components\rtl\Garant\Daily\DOCtoEVDWriterTest.pas"
// ���������: "TestCase"
// ������� ������: "DOCtoEVDWriterTest" MUID: (514C0F2903BB)
// ��� ����: "TDOCtoEVDWriterTest"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFReaderTest
;

type
 TDOCtoEVDWriterTest = {abstract} class(TRTFReaderTest)
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
  published
   procedure DoIt;
 end;//TDOCtoEVDWriterTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

procedure TDOCtoEVDWriterTest.DoIt;
//#UC START# *514C0F5E0247_514C0F2903BB_var*
//#UC END# *514C0F5E0247_514C0F2903BB_var*
begin
//#UC START# *514C0F5E0247_514C0F2903BB_impl*
 RTFtoEVD(KPage + '.doc');
//#UC END# *514C0F5E0247_514C0F2903BB_impl*
end;//TDOCtoEVDWriterTest.DoIt

function TDOCtoEVDWriterTest.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'RTF';
end;//TDOCtoEVDWriterTest.GetFolder

function TDOCtoEVDWriterTest.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '514C0F2903BB';
end;//TDOCtoEVDWriterTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
