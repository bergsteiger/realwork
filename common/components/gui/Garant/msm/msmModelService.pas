unit msmModelService;

// ������: "w:\common\components\gui\Garant\msm\msmModelService.pas"
// ���������: "Service"
// ������� ������: "TmsmModelService" MUID: (57E538DB0262)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
;

 (*
 MmsmModelService = interface
  {* �������� ������� TmsmModelService }
  function ModelRoot: AnsiString;
  procedure SetModelRoot(const aValue: AnsiString);
 end;//MmsmModelService
 *)

type
 ImsmModelService = interface
  {* ��������� ������� TmsmModelService }
  function ModelRoot: AnsiString;
  procedure SetModelRoot(const aValue: AnsiString);
 end;//ImsmModelService

 TmsmModelService = {final} class(Tl3ProtoObject)
  private
   f_ModelRoot: AnsiString;
   f_Alien: ImsmModelService;
    {* ������� ���������� ������� ImsmModelService }
  protected
   procedure pm_SetAlien(const aValue: ImsmModelService);
   procedure ClearFields; override;
  public
   function ModelRoot: AnsiString;
   procedure SetModelRoot(const aValue: AnsiString);
   class function Instance: TmsmModelService;
    {* ����� ��������� ���������� ���������� TmsmModelService }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
  public
   property Alien: ImsmModelService
    write pm_SetAlien;
    {* ������� ���������� ������� ImsmModelService }
 end;//TmsmModelService

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , msmModelServicePack
 {$IfEnd} // NOT Defined(NoScripts)
 , SysUtils
 , l3Base
 //#UC START# *57E538DB0262impl_uses*
 //#UC END# *57E538DB0262impl_uses*
;

var g_TmsmModelService: TmsmModelService = nil;
 {* ��������� ���������� TmsmModelService }

procedure TmsmModelServiceFree;
 {* ����� ������������ ���������� ���������� TmsmModelService }
begin
 l3Free(g_TmsmModelService);
end;//TmsmModelServiceFree

procedure TmsmModelService.pm_SetAlien(const aValue: ImsmModelService);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//TmsmModelService.pm_SetAlien

function TmsmModelService.ModelRoot: AnsiString;
//#UC START# *57E5392F0101_57E538DB0262_var*
//#UC END# *57E5392F0101_57E538DB0262_var*
begin
//#UC START# *57E5392F0101_57E538DB0262_impl*
 if (f_Alien <> nil) then
  Result := f_Alien.ModelRoot
 else
  Result := f_ModelRoot; 
//#UC END# *57E5392F0101_57E538DB0262_impl*
end;//TmsmModelService.ModelRoot

procedure TmsmModelService.SetModelRoot(const aValue: AnsiString);
//#UC START# *57E5393C00B8_57E538DB0262_var*
//#UC END# *57E5393C00B8_57E538DB0262_var*
begin
//#UC START# *57E5393C00B8_57E538DB0262_impl*
 if (f_Alien <> nil) then
  f_Alien.SetModelRoot(aValue)
 else
  f_ModelRoot := aValue; 
//#UC END# *57E5393C00B8_57E538DB0262_impl*
end;//TmsmModelService.SetModelRoot

class function TmsmModelService.Instance: TmsmModelService;
 {* ����� ��������� ���������� ���������� TmsmModelService }
begin
 if (g_TmsmModelService = nil) then
 begin
  l3System.AddExitProc(TmsmModelServiceFree);
  g_TmsmModelService := Create;
 end;
 Result := g_TmsmModelService;
end;//TmsmModelService.Instance

class function TmsmModelService.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TmsmModelService <> nil;
end;//TmsmModelService.Exists

procedure TmsmModelService.ClearFields;
begin
 Alien := nil;
 inherited;
end;//TmsmModelService.ClearFields

end.
