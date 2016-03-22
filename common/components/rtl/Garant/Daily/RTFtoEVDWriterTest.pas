unit RTFtoEVDWriterTest;

// ������: "w:\common\components\rtl\Garant\Daily\RTFtoEVDWriterTest.pas"
// ���������: "TestCase"
// ������� ������: "RTFtoEVDWriterTest" MUID: (4C971C2203DD)
// ��� ����: "TRTFtoEVDWriterTest"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFReaderTest
;

type
 TRTFtoEVDWriterTest = {abstract} class(TRTFReaderTest)
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
  published
   procedure DoIt;
 end;//TRTFtoEVDWriterTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

procedure TRTFtoEVDWriterTest.DoIt;
//#UC START# *4C971C540358_4C971C2203DD_var*
//#UC END# *4C971C540358_4C971C2203DD_var*
begin
//#UC START# *4C971C540358_4C971C2203DD_impl*
 RTFtoEVD(KPage + '.rtf');
//#UC END# *4C971C540358_4C971C2203DD_impl*
end;//TRTFtoEVDWriterTest.DoIt

function TRTFtoEVDWriterTest.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'RTF';
end;//TRTFtoEVDWriterTest.GetFolder

function TRTFtoEVDWriterTest.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4C971C2203DD';
end;//TRTFtoEVDWriterTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
