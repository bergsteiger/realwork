unit K289933577;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "OldEverest"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/OldEverest/K289933577.pas"
// �����: 03.10.2011 19:03
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests For Old Everest::OldEverest::OldEverest::K289933577
//
// {RequestLink:289933577}
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\common\components\OldEverestTestsDefine.inc}

interface

{$If defined(nsTest)}
uses
  Classes
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  ScrollTest
  {$IfEnd} //nsTest AND not NoVCM
  
  ;
{$IfEnd} //nsTest

{$If defined(nsTest)}
type
 TK289933577 = class(TScrollTest)
  {* [RequestLink:289933577] }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK289933577
{$IfEnd} //nsTest

implementation

{$If defined(nsTest)}
uses
  TestFrameWork
  ;
{$IfEnd} //nsTest

{$If defined(nsTest)}

// start class TK289933577

function TK289933577.GetFolder: AnsiString;
 {-}
begin
 Result := 'OldEverest';
end;//TK289933577.GetFolder

function TK289933577.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4E89CE9C003F';
end;//TK289933577.GetModelElementGUID

{$IfEnd} //nsTest

initialization
 TestFramework.RegisterTest(TK289933577.Suite);

end.