unit msmElementListsService;

// ������: "w:\common\components\gui\Garant\msm\msmElementListsService.pas"
// ���������: "Service"
// ������� ������: "TmsmElementListsService" MUID: (57FE4DA6014A)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 {$If NOT Defined(NoScripts)}
 , tfwScriptingInterfaces
 {$IfEnd} // NOT Defined(NoScripts)
;

 (*
 MmsmElementListsService = interface
  {* �������� ������� TmsmElementListsService }
  procedure RegetLists;
  procedure RegetViewedListsFor(aWord: TtfwWord;
   const aListName: AnsiString);
 end;//MmsmElementListsService
 *)

type
 ImsmElementListsService = interface
  {* ��������� ������� TmsmElementListsService }
  procedure RegetLists;
  procedure RegetViewedListsFor(aWord: TtfwWord;
   const aListName: AnsiString);
 end;//ImsmElementListsService

 TmsmElementListsService = {final} class(Tl3ProtoObject)
  private
   f_Alien: ImsmElementListsService;
    {* ������� ���������� ������� ImsmElementListsService }
  protected
   procedure pm_SetAlien(const aValue: ImsmElementListsService);
   procedure ClearFields; override;
  public
   procedure RegetLists;
   procedure RegetViewedListsFor(aWord: TtfwWord;
    const aListName: AnsiString);
   class function Instance: TmsmElementListsService;
    {* ����� ��������� ���������� ���������� TmsmElementListsService }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
  public
   property Alien: ImsmElementListsService
    write pm_SetAlien;
    {* ������� ���������� ������� ImsmElementListsService }
 end;//TmsmElementListsService

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
 //#UC START# *57FE4DA6014Aimpl_uses*
 //#UC END# *57FE4DA6014Aimpl_uses*
;

var g_TmsmElementListsService: TmsmElementListsService = nil;
 {* ��������� ���������� TmsmElementListsService }

procedure TmsmElementListsServiceFree;
 {* ����� ������������ ���������� ���������� TmsmElementListsService }
begin
 l3Free(g_TmsmElementListsService);
end;//TmsmElementListsServiceFree

procedure TmsmElementListsService.pm_SetAlien(const aValue: ImsmElementListsService);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//TmsmElementListsService.pm_SetAlien

procedure TmsmElementListsService.RegetLists;
//#UC START# *57FE4DCD02F8_57FE4DA6014A_var*
//#UC END# *57FE4DCD02F8_57FE4DA6014A_var*
begin
//#UC START# *57FE4DCD02F8_57FE4DA6014A_impl*
 if (f_Alien <> nil) then
  f_Alien.RegetLists;
//#UC END# *57FE4DCD02F8_57FE4DA6014A_impl*
end;//TmsmElementListsService.RegetLists

procedure TmsmElementListsService.RegetViewedListsFor(aWord: TtfwWord;
 const aListName: AnsiString);
//#UC START# *57FF6A5703D7_57FE4DA6014A_var*
//#UC END# *57FF6A5703D7_57FE4DA6014A_var*
begin
//#UC START# *57FF6A5703D7_57FE4DA6014A_impl*
 if (f_Alien <> nil) then
  f_Alien.RegetViewedListsFor(aWord, aListName);
//#UC END# *57FF6A5703D7_57FE4DA6014A_impl*
end;//TmsmElementListsService.RegetViewedListsFor

class function TmsmElementListsService.Instance: TmsmElementListsService;
 {* ����� ��������� ���������� ���������� TmsmElementListsService }
begin
 if (g_TmsmElementListsService = nil) then
 begin
  l3System.AddExitProc(TmsmElementListsServiceFree);
  g_TmsmElementListsService := Create;
 end;
 Result := g_TmsmElementListsService;
end;//TmsmElementListsService.Instance

class function TmsmElementListsService.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TmsmElementListsService <> nil;
end;//TmsmElementListsService.Exists

procedure TmsmElementListsService.ClearFields;
begin
 Alien := nil;
 inherited;
end;//TmsmElementListsService.ClearFields

end.
