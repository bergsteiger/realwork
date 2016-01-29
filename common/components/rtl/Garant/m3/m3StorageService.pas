unit m3StorageService;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "m3$DB"
// ������: "w:/common/components/rtl/Garant/m3/m3StorageService.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Service::Class>> Shared Delphi For Archi::m3$DB::m3DB::Tm3StorageService
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\m3\m3Define.inc}

interface

uses
  l3ProtoObject,
  SyncObjs
  ;

(*
 Mm3StorageService = PureMixIn
  {* �������� ������� Tm3StorageService }
   function UseSplitted: Boolean;
   function SetUseSplitted(aValue: Boolean): Boolean;
 end;//Mm3StorageService
*)

type
 Im3StorageService = interface(IUnknown)
  {* ��������� ������� Tm3StorageService }
   ['{1743FF3C-E36C-4C66-BDD4-9CA1C4601983}']
  // Mm3StorageService
   function UseSplitted: Boolean;
   function SetUseSplitted(aValue: Boolean): Boolean;
 end;//Im3StorageService

 _l3CriticalSectionHolder_Parent_ = Tl3ProtoObject;
 {$Include w:\common\components\rtl\Garant\L3\l3CriticalSectionHolder.imp.pas}
 Tm3StorageService = {final} class(_l3CriticalSectionHolder_)
 private
 // private fields
   f_UseSplitted : Boolean;
   f_Alien : Im3StorageService;
    {* ���� ��� �������� Alien}
 protected
 // property methods
   procedure pm_SetAlien(const aValue: Im3StorageService);
 public
 // realized methods
   function UseSplitted: Boolean;
   function SetUseSplitted(aValue: Boolean): Boolean;
 protected
 // overridden protected methods
   procedure InitFields; override;
   procedure ClearFields; override;
     {* ��������� ������ ClearFields }
 public
 // public methods
   class function Exists: Boolean;
     {* ��������� ������ ��������� ���������� ��� ��� }
 public
 // public properties
   property Alien: Im3StorageService
     write pm_SetAlien;
     {* ������� ���������� ������� Im3StorageService }
 public
 // singleton factory method
   class function Instance: Tm3StorageService;
    {- ���������� ��������� ����������. }
 end;//Tm3StorageService

implementation

uses
  l3Base {a},
  SysUtils
  ;


// start class Tm3StorageService

var g_Tm3StorageService : Tm3StorageService = nil;

procedure Tm3StorageServiceFree;
begin
 l3Free(g_Tm3StorageService);
end;

class function Tm3StorageService.Instance: Tm3StorageService;
begin
 if (g_Tm3StorageService = nil) then
 begin
  l3System.AddExitProc(Tm3StorageServiceFree);
  g_Tm3StorageService := Create;
 end;
 Result := g_Tm3StorageService;
end;


{$Include w:\common\components\rtl\Garant\L3\l3CriticalSectionHolder.imp.pas}

// start class Tm3StorageService

procedure Tm3StorageService.pm_SetAlien(const aValue: Im3StorageService);
 {-}
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//Tm3StorageService.pm_SetAlien

class function Tm3StorageService.Exists: Boolean;
 {-}
begin
 Result := g_Tm3StorageService <> nil;
end;//Tm3StorageService.Exists

function Tm3StorageService.UseSplitted: Boolean;
//#UC START# *AA9D589FDBFC_5551C8670144_var*
//#UC END# *AA9D589FDBFC_5551C8670144_var*
begin
//#UC START# *AA9D589FDBFC_5551C8670144_impl*
 Lock;
 try
  if (f_Alien <> nil) then
   Result := f_Alien.UseSplitted
  else
   Result := f_UseSplitted;
 finally
  Unlock;
 end;//try..finally
//#UC END# *AA9D589FDBFC_5551C8670144_impl*
end;//Tm3StorageService.UseSplitted

function Tm3StorageService.SetUseSplitted(aValue: Boolean): Boolean;
//#UC START# *FEF2A1107807_5551C8670144_var*
//#UC END# *FEF2A1107807_5551C8670144_var*
begin
//#UC START# *FEF2A1107807_5551C8670144_impl*
 Lock;
 try
  if (f_Alien <> nil) then
   Result := f_Alien.SetUseSplitted(aValue)
  else
  begin
   Result := f_UseSplitted;
   f_UseSplitted := aValue;
  end;//f_Alien <> nil
 finally
  Unlock;
 end;//try..finally
//#UC END# *FEF2A1107807_5551C8670144_impl*
end;//Tm3StorageService.SetUseSplitted

procedure Tm3StorageService.InitFields;
//#UC START# *47A042E100E2_5551C8670144_var*
//#UC END# *47A042E100E2_5551C8670144_var*
begin
//#UC START# *47A042E100E2_5551C8670144_impl*
 inherited;
 f_UseSplitted := true;
//#UC END# *47A042E100E2_5551C8670144_impl*
end;//Tm3StorageService.InitFields

procedure Tm3StorageService.ClearFields;
 {-}
begin
 Alien := nil;
 inherited;
end;//Tm3StorageService.ClearFields

end.