unit l3EtalonsService;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "L3$AFW"
// ������: "w:/common/components/rtl/Garant/L3/l3EtalonsService.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Service::Class>> Shared Delphi Low Level::L3$AFW::EtalonsServices::Tl3EtalonsService
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\L3\l3Define.inc}

interface

uses
  l3ProtoObject
  ;

(*
 Ml3EtalonsService = PureMixIn
  {* �������� ������� Tl3EtalonsService }
 end;//Ml3EtalonsService
*)

type
 Il3EtalonsService = interface(IUnknown)
  {* ��������� ������� Tl3EtalonsService }
   ['{61640207-46D1-41DC-A087-0DC7D620B901}']
  // Ml3EtalonsService
 end;//Il3EtalonsService

 Tl3EtalonsService = {final} class(Tl3ProtoObject)
 private
 // private fields
   f_EtalonNeedsComputerName : Boolean;
    {* ���� ��� �������� EtalonNeedsComputerName}
   f_EtalonNeedsOSName : Boolean;
    {* ���� ��� �������� EtalonNeedsOSName}
  {$If defined(XE)}
   f_EtalonNeedsXE : Boolean;
    {* ���� ��� �������� EtalonNeedsXE}
  {$IfEnd} //XE
   f_EtalonNeeds64 : Boolean;
    {* ���� ��� �������� EtalonNeeds64}
   f_Alien : Il3EtalonsService;
    {* ���� ��� �������� Alien}
 protected
 // property methods
   {$If defined(XE)}

   {$IfEnd} //XE
   procedure pm_SetAlien(const aValue: Il3EtalonsService);
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* ��������� ������ ClearFields }
 public
 // public methods
   class function Exists: Boolean;
     {* ��������� ������ ��������� ���������� ��� ��� }
 public
 // public properties
   property EtalonNeedsComputerName: Boolean
     read f_EtalonNeedsComputerName
     write f_EtalonNeedsComputerName;
   property EtalonNeedsOSName: Boolean
     read f_EtalonNeedsOSName
     write f_EtalonNeedsOSName;
   {$If defined(XE)}
   property EtalonNeedsXE: Boolean
     read f_EtalonNeedsXE
     write f_EtalonNeedsXE;
   {$IfEnd} //XE
   property EtalonNeeds64: Boolean
     read f_EtalonNeeds64
     write f_EtalonNeeds64;
   property Alien: Il3EtalonsService
     write pm_SetAlien;
     {* ������� ���������� ������� Il3EtalonsService }
 public
 // singleton factory method
   class function Instance: Tl3EtalonsService;
    {- ���������� ��������� ����������. }
 end;//Tl3EtalonsService

implementation

uses
  l3Base {a}
  ;


// start class Tl3EtalonsService

var g_Tl3EtalonsService : Tl3EtalonsService = nil;

procedure Tl3EtalonsServiceFree;
begin
 l3Free(g_Tl3EtalonsService);
end;

class function Tl3EtalonsService.Instance: Tl3EtalonsService;
begin
 if (g_Tl3EtalonsService = nil) then
 begin
  l3System.AddExitProc(Tl3EtalonsServiceFree);
  g_Tl3EtalonsService := Create;
 end;
 Result := g_Tl3EtalonsService;
end;


procedure Tl3EtalonsService.pm_SetAlien(const aValue: Il3EtalonsService);
 {-}
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//Tl3EtalonsService.pm_SetAlien

class function Tl3EtalonsService.Exists: Boolean;
 {-}
begin
 Result := g_Tl3EtalonsService <> nil;
end;//Tl3EtalonsService.Exists

procedure Tl3EtalonsService.ClearFields;
 {-}
begin
 Alien := nil;
 inherited;
end;//Tl3EtalonsService.ClearFields

end.