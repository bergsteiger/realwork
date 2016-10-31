unit l3DispatcherHelper;

// ������: "w:\common\components\rtl\Garant\L3\l3DispatcherHelper.pas"
// ���������: "Service"
// ������� ������: "Tl3DispatcherHelper" MUID: (5501A3AE02AA)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
;

 (*
 Ml3DispatcherHelper = interface
  {* �������� ������� Tl3DispatcherHelper }
  procedure ClearHistory;
 end;//Ml3DispatcherHelper
 *)

type
 Il3DispatcherHelper = interface
  {* ��������� ������� Tl3DispatcherHelper }
  procedure ClearHistory;
 end;//Il3DispatcherHelper

 Tl3DispatcherHelper = {final} class(Tl3ProtoObject)
  private
   f_Alien: Il3DispatcherHelper;
    {* ������� ���������� ������� Il3DispatcherHelper }
  protected
   procedure pm_SetAlien(const aValue: Il3DispatcherHelper);
   procedure ClearFields; override;
  public
   procedure ClearHistory;
   class function Instance: Tl3DispatcherHelper;
    {* ����� ��������� ���������� ���������� Tl3DispatcherHelper }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
  public
   property Alien: Il3DispatcherHelper
    write pm_SetAlien;
    {* ������� ���������� ������� Il3DispatcherHelper }
 end;//Tl3DispatcherHelper

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
 //#UC START# *5501A3AE02AAimpl_uses*
 //#UC END# *5501A3AE02AAimpl_uses*
;

var g_Tl3DispatcherHelper: Tl3DispatcherHelper = nil;
 {* ��������� ���������� Tl3DispatcherHelper }

procedure Tl3DispatcherHelperFree;
 {* ����� ������������ ���������� ���������� Tl3DispatcherHelper }
begin
 l3Free(g_Tl3DispatcherHelper);
end;//Tl3DispatcherHelperFree

procedure Tl3DispatcherHelper.pm_SetAlien(const aValue: Il3DispatcherHelper);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//Tl3DispatcherHelper.pm_SetAlien

procedure Tl3DispatcherHelper.ClearHistory;
//#UC START# *55069D5903C8_5501A3AE02AA_var*
//#UC END# *55069D5903C8_5501A3AE02AA_var*
begin
//#UC START# *55069D5903C8_5501A3AE02AA_impl*
 if (f_Alien <> nil) then
  f_Alien.ClearHistory;
//#UC END# *55069D5903C8_5501A3AE02AA_impl*
end;//Tl3DispatcherHelper.ClearHistory

class function Tl3DispatcherHelper.Instance: Tl3DispatcherHelper;
 {* ����� ��������� ���������� ���������� Tl3DispatcherHelper }
begin
 if (g_Tl3DispatcherHelper = nil) then
 begin
  l3System.AddExitProc(Tl3DispatcherHelperFree);
  g_Tl3DispatcherHelper := Create;
 end;
 Result := g_Tl3DispatcherHelper;
end;//Tl3DispatcherHelper.Instance

class function Tl3DispatcherHelper.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_Tl3DispatcherHelper <> nil;
end;//Tl3DispatcherHelper.Exists

procedure Tl3DispatcherHelper.ClearFields;
begin
 Alien := nil;
 inherited;
end;//Tl3DispatcherHelper.ClearFields

end.
