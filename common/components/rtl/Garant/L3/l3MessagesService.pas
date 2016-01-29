unit l3MessagesService;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "L3$AFW"
// ������: "w:/common/components/rtl/Garant/L3/l3MessagesService.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Service::Class>> Shared Delphi Low Level::L3$AFW::AFWServices::Tl3MessagesService
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
 Ml3MessagesService = PureMixIn
  {* �������� ������� Tl3MessagesService }
   procedure ProcessMessages;
 end;//Ml3MessagesService
*)

type
 Il3MessagesService = interface(IUnknown)
  {* ��������� ������� Tl3MessagesService }
   ['{8169CB3B-D3C5-412F-82E9-1473799C89FD}']
  // Ml3MessagesService
   procedure ProcessMessages;
 end;//Il3MessagesService

 Tl3MessagesService = {final} class(Tl3ProtoObject)
 private
 // private fields
   f_Alien : Il3MessagesService;
    {* ���� ��� �������� Alien}
 protected
 // property methods
   procedure pm_SetAlien(const aValue: Il3MessagesService);
 public
 // realized methods
   procedure ProcessMessages;
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
   property Alien: Il3MessagesService
     write pm_SetAlien;
     {* ������� ���������� ������� Il3MessagesService }
 public
 // singleton factory method
   class function Instance: Tl3MessagesService;
    {- ���������� ��������� ����������. }
 end;//Tl3MessagesService

implementation

uses
  l3Base {a}
  ;


// start class Tl3MessagesService

var g_Tl3MessagesService : Tl3MessagesService = nil;

procedure Tl3MessagesServiceFree;
begin
 l3Free(g_Tl3MessagesService);
end;

class function Tl3MessagesService.Instance: Tl3MessagesService;
begin
 if (g_Tl3MessagesService = nil) then
 begin
  l3System.AddExitProc(Tl3MessagesServiceFree);
  g_Tl3MessagesService := Create;
 end;
 Result := g_Tl3MessagesService;
end;


procedure Tl3MessagesService.pm_SetAlien(const aValue: Il3MessagesService);
 {-}
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//Tl3MessagesService.pm_SetAlien

class function Tl3MessagesService.Exists: Boolean;
 {-}
begin
 Result := g_Tl3MessagesService <> nil;
end;//Tl3MessagesService.Exists

procedure Tl3MessagesService.ProcessMessages;
//#UC START# *B6C92677BBF7_5506D3B202FA_var*
//#UC END# *B6C92677BBF7_5506D3B202FA_var*
begin
//#UC START# *B6C92677BBF7_5506D3B202FA_impl*
 if (f_Alien <> nil) then
  f_Alien.ProcessMessages;
//#UC END# *B6C92677BBF7_5506D3B202FA_impl*
end;//Tl3MessagesService.ProcessMessages

procedure Tl3MessagesService.ClearFields;
 {-}
begin
 Alien := nil;
 inherited;
end;//Tl3MessagesService.ClearFields

end.