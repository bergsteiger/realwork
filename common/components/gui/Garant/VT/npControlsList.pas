unit npControlsList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "VT$WithVCM"
// ������: "w:/common/components/gui/Garant/VT/npControlsList.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VT$WithVCM::vtNavigator::TnpControlsList
//
// ������ ����������� �� �����, �� ������� ���� ����������� ����������.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\VT\vtDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  npControlsListPrim
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
type
 TnpControlsList = class(TnpControlsListPrim)
  {* ������ ����������� �� �����, �� ������� ���� ����������� ����������. }
 public
 // public methods
   class function Exists: Boolean;
     {* ��������� ������ ��������� ���������� ��� ��� }
 public
 // singleton factory method
   class function Instance: TnpControlsList;
    {- ���������� ��������� ����������. }
 end;//TnpControlsList
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}
uses
  l3Base {a}
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}


// start class TnpControlsList

var g_TnpControlsList : TnpControlsList = nil;

procedure TnpControlsListFree;
begin
 l3Free(g_TnpControlsList);
end;

class function TnpControlsList.Instance: TnpControlsList;
begin
 if (g_TnpControlsList = nil) then
 begin
  l3System.AddExitProc(TnpControlsListFree);
  g_TnpControlsList := Create;
 end;
 Result := g_TnpControlsList;
end;


class function TnpControlsList.Exists: Boolean;
 {-}
begin
 Result := g_TnpControlsList <> nil;
end;//TnpControlsList.Exists

{$IfEnd} //not NoVCM

end.