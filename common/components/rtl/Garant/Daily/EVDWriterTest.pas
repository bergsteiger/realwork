unit EVDWriterTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "DailyTest"
// ������: "w:/common/components/rtl/Garant/Daily/EVDWriterTest.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::EVD::EVDWriterTest
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
  evdNativeReader,
  WriterTest
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TEVDWriterTest = {abstract} class(TWriterTest)
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 protected
 // protected methods
   procedure EVDtoEVD(const aFileName: AnsiString);
   function UseFullEVDReader: Boolean; virtual;
     {* ������������ �� ������ evdReader (� ������� ������ ����) }
   function DisableParserLog: Boolean; virtual;
     {* ��������� ������� �������� � ��� }
 end;//TEVDWriterTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  SysUtils,
  evEvdRd,
  l3Parser,
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TEVDWriterTest

procedure TEVDWriterTest.EVDtoEVD(const aFileName: AnsiString);
//#UC START# *4C07B67A02C1_4C07B5C100E8_var*
var
 l_DisableParserLog : Boolean;
//#UC END# *4C07B67A02C1_4C07B5C100E8_var*
var
 l_Reader : TevdNativeReader;
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
//#UC START# *4C1B2B0203A2_4C07B5C100E8_var*
//#UC END# *4C1B2B0203A2_4C07B5C100E8_var*
begin
//#UC START# *4C1B2B0203A2_4C07B5C100E8_impl*
 Result := false;
//#UC END# *4C1B2B0203A2_4C07B5C100E8_impl*
end;//TEVDWriterTest.UseFullEVDReader

function TEVDWriterTest.DisableParserLog: Boolean;
//#UC START# *4C1B47BA03AC_4C07B5C100E8_var*
//#UC END# *4C1B47BA03AC_4C07B5C100E8_var*
begin
//#UC START# *4C1B47BA03AC_4C07B5C100E8_impl*
 Result := false;
//#UC END# *4C1B47BA03AC_4C07B5C100E8_impl*
end;//TEVDWriterTest.DisableParserLog

function TEVDWriterTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'EVD';
end;//TEVDWriterTest.GetFolder

function TEVDWriterTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C07B5C100E8';
end;//TEVDWriterTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.