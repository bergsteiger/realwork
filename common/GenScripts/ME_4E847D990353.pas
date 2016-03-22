unit HTMLtoEVDWriterTest;

// ������: "w:\common\components\rtl\Garant\Daily\HTMLtoEVDWriterTest.pas"
// ���������: "TestCase"
// ������� ������: "HTMLtoEVDWriterTest" MUID: (4E847D990353)
// ��� ����: "THTMLtoEVDWriterTest"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , WriterTest
 , ddHTMLReader
;

type
 THTMLtoEVDWriterTest = {abstract} class(TWriterTest)
  protected
   procedure HTMLtoEVD(const aFileName: AnsiString);
   procedure TuningReader(aHTMLReader: TddHTMLReader); virtual;
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//THTMLtoEVDWriterTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 , SysUtils
;

procedure THTMLtoEVDWriterTest.HTMLtoEVD(const aFileName: AnsiString);
//#UC START# *4E847EEE02DB_4E847D990353_var*
var
 l_Reader : TddHTMLReader;
//#UC END# *4E847EEE02DB_4E847D990353_var*
begin
//#UC START# *4E847EEE02DB_4E847D990353_impl*
 l_Reader := TddHTMLReader.Make(FileFromCurrent(aFileName));
 TuningReader(l_Reader);
 try
  SomeFormatToEVD(l_Reader);
 finally
  FreeAndNil(l_Reader);
 end;//try..finally
//#UC END# *4E847EEE02DB_4E847D990353_impl*
end;//THTMLtoEVDWriterTest.HTMLtoEVD

procedure THTMLtoEVDWriterTest.TuningReader(aHTMLReader: TddHTMLReader);
//#UC START# *56A613A30375_4E847D990353_var*
//#UC END# *56A613A30375_4E847D990353_var*
begin
//#UC START# *56A613A30375_4E847D990353_impl*
 
//#UC END# *56A613A30375_4E847D990353_impl*
end;//THTMLtoEVDWriterTest.TuningReader

function THTMLtoEVDWriterTest.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'HTML';
end;//THTMLtoEVDWriterTest.GetFolder

function THTMLtoEVDWriterTest.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4E847D990353';
end;//THTMLtoEVDWriterTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
