unit nsWindowsList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "UserInteraction"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/VCM/UserInteraction/nsWindowsList.pas"
// �����: 19.10.2009 15:46
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Operations::OfficeLike::UserInteraction::WindowsListSupport::TnsWindowsList
//
// ����� ����������� ������� ����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\common\components\gui\sdoDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  nsWindowsListPrim
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
type
 TnsWindowsList = class(TnsWindowsListPrim)
  {* ����� ����������� ������� ���� }
 public
 // public methods
   class function Exists: Boolean;
     {* ��������� ������ ��������� ���������� ��� ��� }
 public
 // singleton factory method
   class function Instance: TnsWindowsList;
    {- ���������� ��������� ����������. }
 end;//TnsWindowsList
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}
uses
  l3Base {a}
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}


// start class TnsWindowsList

var g_TnsWindowsList : TnsWindowsList = nil;

procedure TnsWindowsListFree;
begin
 l3Free(g_TnsWindowsList);
end;

class function TnsWindowsList.Instance: TnsWindowsList;
begin
 if (g_TnsWindowsList = nil) then
 begin
  l3System.AddExitProc(TnsWindowsListFree);
  g_TnsWindowsList := Create;
 end;
 Result := g_TnsWindowsList;
end;


class function TnsWindowsList.Exists: Boolean;
 {-}
begin
 Result := g_TnsWindowsList <> nil;
end;//TnsWindowsList.Exists

{$IfEnd} //not NoVCM

end.