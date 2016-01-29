unit EVDtoEVDWriterTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "DailyTest"
// ������: "w:/common/components/rtl/Garant/Daily/EVDtoEVDWriterTest.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::EVD::EVDtoEVDWriterTest
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
  EVDWriterTest
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TEVDtoEVDWriterTest = {abstract} class(TEVDWriterTest)
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 published
 // published methods
   procedure DoIt;
 end;//TEVDtoEVDWriterTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TEVDtoEVDWriterTest

procedure TEVDtoEVDWriterTest.DoIt;
//#UC START# *4C07B5F90205_4C07B5E300F2_var*
//#UC END# *4C07B5F90205_4C07B5E300F2_var*
begin
//#UC START# *4C07B5F90205_4C07B5E300F2_impl*
 EVDtoEVD(KPage + '.evd');
//#UC END# *4C07B5F90205_4C07B5E300F2_impl*
end;//TEVDtoEVDWriterTest.DoIt

function TEVDtoEVDWriterTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'EVD';
end;//TEVDtoEVDWriterTest.GetFolder

function TEVDtoEVDWriterTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C07B5E300F2';
end;//TEVDtoEVDWriterTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.