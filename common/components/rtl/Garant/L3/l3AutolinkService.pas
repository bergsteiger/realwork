unit l3AutolinkService;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "L3$AFW"
// ������: "w:/common/components/rtl/Garant/L3/l3AutolinkService.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Service::Class>> Shared Delphi Low Level::L3$AFW::AutoLink::Tl3AutolinkService
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\L3\l3Define.inc}

interface

uses
  l3ProtoObject,
  l3Variant
  ;

(*
 Ml3AutolinkService = PureMixIn
  {* �������� ������� Tl3AutolinkService }
   function GetAutolinkFilter: Ik2TagGenerator;
   procedure CleanAutolinkFilter;
 end;//Ml3AutolinkService
*)

type
 Il3AutolinkService = interface(IUnknown)
  {* ��������� ������� Tl3AutolinkService }
   ['{6E9C4C64-C96E-4FC1-958E-50CF81CED3E9}']
  // Ml3AutolinkService
   function GetAutolinkFilter: Ik2TagGenerator;
   procedure CleanAutolinkFilter;
 end;//Il3AutolinkService

 Tl3AutolinkService = {final} class(Tl3ProtoObject)
 private
 // private fields
   f_Alien : Il3AutolinkService;
    {* ���� ��� �������� Alien}
 protected
 // property methods
   procedure pm_SetAlien(const aValue: Il3AutolinkService);
 public
 // realized methods
   function GetAutolinkFilter: Ik2TagGenerator;
   procedure CleanAutolinkFilter;
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
   property Alien: Il3AutolinkService
     write pm_SetAlien;
     {* ������� ���������� ������� Il3AutolinkService }
 public
 // singleton factory method
   class function Instance: Tl3AutolinkService;
    {- ���������� ��������� ����������. }
 end;//Tl3AutolinkService

implementation

uses
  l3Base {a}
  {$If not defined(NoScripts)}
  ,
  AutolinkFilterWordsPack
  {$IfEnd} //not NoScripts
  
  ;


// start class Tl3AutolinkService

var g_Tl3AutolinkService : Tl3AutolinkService = nil;

procedure Tl3AutolinkServiceFree;
begin
 l3Free(g_Tl3AutolinkService);
end;

class function Tl3AutolinkService.Instance: Tl3AutolinkService;
begin
 if (g_Tl3AutolinkService = nil) then
 begin
  l3System.AddExitProc(Tl3AutolinkServiceFree);
  g_Tl3AutolinkService := Create;
 end;
 Result := g_Tl3AutolinkService;
end;


procedure Tl3AutolinkService.pm_SetAlien(const aValue: Il3AutolinkService);
 {-}
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//Tl3AutolinkService.pm_SetAlien

class function Tl3AutolinkService.Exists: Boolean;
 {-}
begin
 Result := g_Tl3AutolinkService <> nil;
end;//Tl3AutolinkService.Exists

function Tl3AutolinkService.GetAutolinkFilter: Ik2TagGenerator;
//#UC START# *27BE83734EFD_552BF69B039B_var*
//#UC END# *27BE83734EFD_552BF69B039B_var*
begin
//#UC START# *27BE83734EFD_552BF69B039B_impl*
 if (f_Alien <> nil) then
  Result := f_Alien.GetAutolinkFilter
 else
  Result := nil; 
//#UC END# *27BE83734EFD_552BF69B039B_impl*
end;//Tl3AutolinkService.GetAutolinkFilter

procedure Tl3AutolinkService.CleanAutolinkFilter;
//#UC START# *A18BB0B1A222_552BF69B039B_var*
//#UC END# *A18BB0B1A222_552BF69B039B_var*
begin
//#UC START# *A18BB0B1A222_552BF69B039B_impl*
 if (f_Alien <> nil) then
  f_Alien.CleanAutolinkFilter;
//#UC END# *A18BB0B1A222_552BF69B039B_impl*
end;//Tl3AutolinkService.CleanAutolinkFilter

procedure Tl3AutolinkService.ClearFields;
 {-}
begin
 Alien := nil;
 inherited;
end;//Tl3AutolinkService.ClearFields

end.