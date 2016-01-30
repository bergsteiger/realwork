unit l3ScreenService;

// ������: "w:\common\components\rtl\Garant\L3\l3ScreenService.pas"
// ���������: "Service"

{$Include l3Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3InternalInterfaces
;

 (*
 Ml3ScreenService = interface
  {* �������� ������� Tl3ScreenService }
  function IC: Il3InfoCanvas;
 end;//Ml3ScreenService
 *)

type
 Il3ScreenService = interface
  {* ��������� ������� Tl3ScreenService }
  ['{2ADD24A4-6629-417A-9825-E326572364B7}']
  function IC: Il3InfoCanvas;
 end;//Il3ScreenService

 Tl3ScreenService = {final} class(Tl3ProtoObject)
  private
   f_Alien: Il3ScreenService;
    {* ���� ��� �������� Alien }
  protected
   procedure pm_SetAlien(const aValue: Il3ScreenService);
   procedure ClearFields; override;
  public
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
   function IC: Il3InfoCanvas;
   class function Instance: Tl3ScreenService;
    {* ����� ��������� ���������� ���������� Tl3ScreenService }
  public
   property Alien: Il3ScreenService
    write pm_SetAlien;
    {* ������� ���������� ������� Il3ScreenService }
 end;//Tl3ScreenService

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_Tl3ScreenService: Tl3ScreenService = nil;
 {* ��������� ���������� Tl3ScreenService }

procedure Tl3ScreenServiceFree;
 {* ����� ������������ ���������� ���������� Tl3ScreenService }
begin
 l3Free(g_Tl3ScreenService);
end;//Tl3ScreenServiceFree

procedure Tl3ScreenService.pm_SetAlien(const aValue: Il3ScreenService);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//Tl3ScreenService.pm_SetAlien

class function Tl3ScreenService.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_Tl3ScreenService <> nil;
end;//Tl3ScreenService.Exists

function Tl3ScreenService.IC: Il3InfoCanvas;
//#UC START# *88066E5D0414_556EE57803CD_var*
//#UC END# *88066E5D0414_556EE57803CD_var*
begin
//#UC START# *88066E5D0414_556EE57803CD_impl*
 if (f_Alien <> nil) then
  Result := f_Alien.IC
 else
  Result := nil; 
//#UC END# *88066E5D0414_556EE57803CD_impl*
end;//Tl3ScreenService.IC

class function Tl3ScreenService.Instance: Tl3ScreenService;
 {* ����� ��������� ���������� ���������� Tl3ScreenService }
begin
 if (g_Tl3ScreenService = nil) then
 begin
  l3System.AddExitProc(Tl3ScreenServiceFree);
  g_Tl3ScreenService := Create;
 end;
 Result := g_Tl3ScreenService;
end;//Tl3ScreenService.Instance

procedure Tl3ScreenService.ClearFields;
begin
 Alien := nil;
 inherited;
end;//Tl3ScreenService.ClearFields

end.
