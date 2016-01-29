unit ExcludedTestsFolders;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "DUnitTuning"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/DUnitTuning/ExcludedTestsFolders.pas"
// �����: 17.09.2010 19:16
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Testing Framework::DUnitTuning::Source::TExcludedTestsFolders
//
// ����� ������ ����������� �� �������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\DUnitTuning\tfwDefine.inc}

interface

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
uses
  l3StringList
  ;
{$IfEnd} //nsTest AND not NotTunedDUnit

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
type
 TExcludedTestsFolders = class(Tl3StringList)
  {* ����� ������ ����������� �� ������� }
 public
 // public methods
   class function Exists: Boolean;
 public
 // singleton factory method
   class function Instance: TExcludedTestsFolders;
    {- ���������� ��������� ����������. }
 end;//TExcludedTestsFolders
{$IfEnd} //nsTest AND not NotTunedDUnit

implementation

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
uses
  l3Base {a}
  ;
{$IfEnd} //nsTest AND not NotTunedDUnit

{$If defined(nsTest) AND not defined(NotTunedDUnit)}


// start class TExcludedTestsFolders

var g_TExcludedTestsFolders : TExcludedTestsFolders = nil;

procedure TExcludedTestsFoldersFree;
begin
 l3Free(g_TExcludedTestsFolders);
end;

class function TExcludedTestsFolders.Instance: TExcludedTestsFolders;
begin
 if (g_TExcludedTestsFolders = nil) then
 begin
  l3System.AddExitProc(TExcludedTestsFoldersFree);
  g_TExcludedTestsFolders := Create;
 end;
 Result := g_TExcludedTestsFolders;
end;


class function TExcludedTestsFolders.Exists: Boolean;
//#UC START# *4C938674023A_4C9386230151_var*
//#UC END# *4C938674023A_4C9386230151_var*
begin
//#UC START# *4C938674023A_4C9386230151_impl*
 Result := (g_TExcludedTestsFolders <> nil);
//#UC END# *4C938674023A_4C9386230151_impl*
end;//TExcludedTestsFolders.Exists

{$IfEnd} //nsTest AND not NotTunedDUnit

end.