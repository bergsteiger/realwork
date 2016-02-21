unit EVDWriterTest;

// ������: "w:\common\components\rtl\Garant\Daily\EVDWriterTest.pas"
// ���������: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , WriterTest
 , evdNativeReader
;

type
 TEVDWriterTest = {abstract} class(TWriterTest)
  protected
   procedure EVDtoEVD(const aFileName: AnsiString);
   function UseFullEVDReader: Boolean; virtual;
    {* ������������ �� ������ evdReader (� ������� ������ ����) }
   function DisableParserLog: Boolean; virtual;
    {* ��������� ������� �������� � ��� }
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TEVDWriterTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 , SysUtils
 , evEvdRd
 , l3Parser
;

procedure TEVDWriterTest.EVDtoEVD(const aFileName: AnsiString);
var l_Reader: TevdNativeReader;
//#UC START# *4C07B67A02C1_4C07B5C100E8_var*
var
 l_DisableParserLog : Boolean;
//#UC END# *4C07B67A02C1_4C07B5C100E8_var*
begin
//#UC START# *4C07B67A02C1_4C07B5C100E8_impl*
 if UseFullEVDReader then
  l_Reader := TevCustomEvdReader.Make(FileFromCurrent(aFileName))
 else
  l_Reader := TevdNativeReader.Make(FileFromCurrent(aFileName));
 try
  l_DisableParserLog := DisableParserLog;
  if l_DisableParserLog then
   Inc(g_DisableParserLog);
  try
   SomeFormatToEVD(l_Reader);
  finally
   if l_DisableParserLog then
    Dec(g_DisableParserLog);
  end;//try..finally
 finally
  FreeAndNil(l_Reader);
 end;//try..finally
//#UC END# *4C07B67A02C1_4C07B5C100E8_impl*
end;//TEVDWriterTest.EVDtoEVD

function TEVDWriterTest.UseFullEVDReader: Boolean;
 {* ������������ �� ������ evdReader (� ������� ������ ����) }
//#UC START# *4C1B2B0203A2_4C07B5C100E8_var*
//#UC END# *4C1B2B0203A2_4C07B5C100E8_var*
begin
//#UC START# *4C1B2B0203A2_4C07B5C100E8_impl*
 Result := false;
//#UC END# *4C1B2B0203A2_4C07B5C100E8_impl*
end;//TEVDWriterTest.UseFullEVDReader

function TEVDWriterTest.DisableParserLog: Boolean;
 {* ��������� ������� �������� � ��� }
//#UC START# *4C1B47BA03AC_4C07B5C100E8_var*
//#UC END# *4C1B47BA03AC_4C07B5C100E8_var*
begin
//#UC START# *4C1B47BA03AC_4C07B5C100E8_impl*
 Result := false;
//#UC END# *4C1B47BA03AC_4C07B5C100E8_impl*
end;//TEVDWriterTest.DisableParserLog

function TEVDWriterTest.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'EVD';
end;//TEVDWriterTest.GetFolder

function TEVDWriterTest.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4C07B5C100E8';
end;//TEVDWriterTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
