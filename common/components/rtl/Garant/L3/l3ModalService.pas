unit l3ModalService;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "L3$AFW"
// ������: "w:/common/components/rtl/Garant/L3/l3ModalService.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Service::Class>> Shared Delphi Low Level::L3$AFW::BatchServices::Tl3ModalService
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

type
 TseModalExecute = (
   se_meUsual
 , se_meInLoop
 , se_meAfterLoop
 );//TseModalExecute

(*
 Ml3ModalService = PureMixIn
   function HasModalWorker: Boolean;
   function ExecuteCurrentModalWorker(aModalExecute: TseModalExecute = se_meUsual): Boolean;
 end;//Ml3ModalService
*)

 Il3ModalService = interface(IUnknown)
  {* ��������� ������� Tl3ModalService }
   ['{138EC31E-59DE-4996-A7C2-234E73119E5C}']
  // Ml3ModalService
   function HasModalWorker: Boolean;
   function ExecuteCurrentModalWorker(aModalExecute: TseModalExecute = se_meUsual): Boolean;
 end;//Il3ModalService

 Tl3ModalService = {final} class(Tl3ProtoObject)
 private
 // private fields
   f_Alien : Il3ModalService;
    {* ���� ��� �������� Alien}
 protected
 // property methods
   procedure pm_SetAlien(const aValue: Il3ModalService);
 public
 // realized methods
   function HasModalWorker: Boolean;
   function ExecuteCurrentModalWorker(aModalExecute: TseModalExecute = se_meUsual): Boolean;
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
   property Alien: Il3ModalService
     write pm_SetAlien;
     {* ������� ���������� ������� Il3ModalService }
 public
 // singleton factory method
   class function Instance: Tl3ModalService;
    {- ���������� ��������� ����������. }
 end;//Tl3ModalService

implementation

uses
  l3Base {a}
  ;


// start class Tl3ModalService

var g_Tl3ModalService : Tl3ModalService = nil;

procedure Tl3ModalServiceFree;
begin
 l3Free(g_Tl3ModalService);
end;

class function Tl3ModalService.Instance: Tl3ModalService;
begin
 if (g_Tl3ModalService = nil) then
 begin
  l3System.AddExitProc(Tl3ModalServiceFree);
  g_Tl3ModalService := Create;
 end;
 Result := g_Tl3ModalService;
end;


procedure Tl3ModalService.pm_SetAlien(const aValue: Il3ModalService);
 {-}
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//Tl3ModalService.pm_SetAlien

class function Tl3ModalService.Exists: Boolean;
 {-}
begin
 Result := g_Tl3ModalService <> nil;
end;//Tl3ModalService.Exists

function Tl3ModalService.HasModalWorker: Boolean;
//#UC START# *553F7345032E_553F71BE03E0_var*
//#UC END# *553F7345032E_553F71BE03E0_var*
begin
//#UC START# *553F7345032E_553F71BE03E0_impl*
 if (f_Alien <> nil) then
  Result := f_Alien.HasModalWorker
 else
  Result := false; 
//#UC END# *553F7345032E_553F71BE03E0_impl*
end;//Tl3ModalService.HasModalWorker

function Tl3ModalService.ExecuteCurrentModalWorker(aModalExecute: TseModalExecute = se_meUsual): Boolean;
//#UC START# *553F8EA30300_553F71BE03E0_var*
//#UC END# *553F8EA30300_553F71BE03E0_var*
begin
//#UC START# *553F8EA30300_553F71BE03E0_impl*
 if (f_Alien <> nil) then
  Result := f_Alien.ExecuteCurrentModalWorker(aModalExecute)
 else
  Result := false; 
//#UC END# *553F8EA30300_553F71BE03E0_impl*
end;//Tl3ModalService.ExecuteCurrentModalWorker

procedure Tl3ModalService.ClearFields;
 {-}
begin
 Alien := nil;
 inherited;
end;//Tl3ModalService.ClearFields

end.