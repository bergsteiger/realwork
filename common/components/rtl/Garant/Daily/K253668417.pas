unit K253668417;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "DailyTest"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/Daily/K253668417.pas"
// �����: 16.02.2011 17:43
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.7::K253668417
//
// {RequestLink:253668417}
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
  RTFtoEVDWriterTest
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK253668417 = class(TRTFtoEVDWriterTest)
  {* [RequestLink:253668417] }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function GetEnablePictures: Boolean; override;
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK253668417
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TK253668417

function TK253668417.GetFolder: AnsiString;
 {-}
begin
 Result := '7.7';
end;//TK253668417.GetFolder

function TK253668417.GetEnablePictures: Boolean;
//#UC START# *4D5BE2F500AD_4D5BE28703A0_var*
//#UC END# *4D5BE2F500AD_4D5BE28703A0_var*
begin
//#UC START# *4D5BE2F500AD_4D5BE28703A0_impl*
 Result := true;
//#UC END# *4D5BE2F500AD_4D5BE28703A0_impl*
end;//TK253668417.GetEnablePictures

function TK253668417.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4D5BE28703A0';
end;//TK253668417.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK253668417.Suite);

end.