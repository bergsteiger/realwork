unit K211879983;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "DailyTest"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/Daily/K211879983.pas"
// �����: 14.05.2010 14:55
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.5::K211879983
//
// {RequestLink:211879983}
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
  Classes
  {$If defined(nsTest) AND not defined(NotTunedDUnit)}
  ,
  BaseTest
  {$IfEnd} //nsTest AND not NotTunedDUnit
  
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK211879983 = class(TBaseTest)
  {* [RequestLink:211879983] }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 published
 // published methods
   procedure DoIt;
 end;//TK211879983
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  l3String,
  l3Base,
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TK211879983

procedure TK211879983.DoIt;
//#UC START# *4BED2C510339_4BED2BFE0092_var*
const
 S = '���������';
 SS = '���';
const
 WS : WideString = '���������';
 WSS : WideString = '���';
//#UC END# *4BED2C510339_4BED2BFE0092_var*
begin
//#UC START# *4BED2C510339_4BED2BFE0092_impl*
 StartTimer;
 try
  Check(l3Pos(l3PCharLen(AnsiString(S)), l3PCharLen(AnsiString(SS))) = 3);
  Check(l3Pos(l3PCharLen(WS), l3PCharLen(WSS)) = 3);
  Check(l3Pos(l3PCharLen(WS), l3PCharLen(AnsiString(SS))) = 3);
  Check(l3Pos(l3PCharLen(AnsiString(S)), l3PCharLen(WSS)) = 3);
 finally
  StopTimer;
 end;//try..finally
//#UC END# *4BED2C510339_4BED2BFE0092_impl*
end;//TK211879983.DoIt

function TK211879983.GetFolder: AnsiString;
 {-}
begin
 Result := '7.5';
end;//TK211879983.GetFolder

function TK211879983.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4BED2BFE0092';
end;//TK211879983.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK211879983.Suite);

end.