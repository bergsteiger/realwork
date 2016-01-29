unit NOT_FINISHED_dt_User;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "DT"
// ������: "w:/common/components/rtl/Garant/DT/NOT_FINISHED_dt_User.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi For Archi::DT::Users::dt_User
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ���� ���� ������������ ������ ��� �������������, � �� ��� ����������. !

{$Include ..\DT\DtDefine.inc}

interface

{$If not defined(Nemesis)}
type
 TUserManager = class
 public
 // public methods
   class function Exists: Boolean;
     {* ��������� ������ ��������� ���������� ��� ��� }
 public
 // singleton factory method
   class function Instance: TUserManager;
    {- ���������� ��������� ����������. }
 end;//TUserManager

var UserManager : TUserManager;
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
uses
  l3Base {a}
  ;


// start class TUserManager

var g_TUserManager : TUserManager = nil;

procedure TUserManagerFree;
begin
 l3Free(g_TUserManager);
end;

class function TUserManager.Instance: TUserManager;
begin
 if (g_TUserManager = nil) then
 begin
  l3System.AddExitProc(TUserManagerFree);
  g_TUserManager := Create;
 end;
 Result := g_TUserManager;
end;


class function TUserManager.Exists: Boolean;
 {-}
begin
 Result := g_TUserManager <> nil;
end;//TUserManager.Exists
{$IfEnd} //not Nemesis

end.