unit MakeCORunner;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/common/components/MakeCO/MakeCORunner.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::MakeCO::TMakeCORunner
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\MakeCO\MakeCO.inc}

interface

type
 TMakeCORunner = {final} class
 public
 // public methods
   class procedure Run;
 end;//TMakeCORunner

implementation

uses
  SysUtils,
  tfwCOMaker
  ;

// start class TMakeCORunner

class procedure TMakeCORunner.Run;
//#UC START# *55C1F54A0327_55C1F539010F_var*
//#UC END# *55C1F54A0327_55C1F539010F_var*
begin
//#UC START# *55C1F54A0327_55C1F539010F_impl*
 TtfwCOMaker.Make(ParamStr(1));
//#UC END# *55C1F54A0327_55C1F539010F_impl*
end;//TMakeCORunner.Run

end.