unit K460275638;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "DailyTest"
// ������: "w:/common/components/rtl/Garant/Daily/K460275638.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::RegExp::TK460275638
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
  RegExpTest,
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK460275638 = class(TRegExpTest)
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 public
 // overridden public methods
   class function Suite: ITestSuite; override;
 end;//TK460275638
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  K460275638Suite
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TK460275638

function TK460275638.GetFolder: AnsiString;
 {-}
begin
 Result := 'RegExp';
end;//TK460275638.GetFolder

function TK460275638.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '51BB006C01A6';
end;//TK460275638.GetModelElementGUID

class function TK460275638.Suite: ITestSuite;
//#UC START# *4EA553E901DB_51BB006C01A6_var*
//#UC END# *4EA553E901DB_51BB006C01A6_var*
begin
//#UC START# *4EA553E901DB_51BB006C01A6_impl*
 Result := TK460275638Suite.Create(Self);
//#UC END# *4EA553E901DB_51BB006C01A6_impl*
end;//TK460275638.Suite

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK460275638.Suite);

end.