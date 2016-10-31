unit daLinkServerService;

// ������: "w:\common\components\rtl\Garant\DA\daLinkServerService.pas"
// ���������: "Service"
// ������� ������: "TdaLinkServerService" MUID: (57EB5FD6006A)

{$Include w:\common\components\rtl\Garant\DA\daDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , daTypes
;

 (*
 MdaLinkServerService = interface
  {* �������� ������� TdaLinkServerService }
  procedure ChangeSubID(aFamilyID: TdaFamilyID;
   aDocID: TdaDocID;
   anOldSubID: TdaSubID;
   aNewSubID: TdaSubID);
 end;//MdaLinkServerService
 *)

type
 IdaLinkServerService = interface
  {* ��������� ������� TdaLinkServerService }
  procedure ChangeSubID(aFamilyID: TdaFamilyID;
   aDocID: TdaDocID;
   anOldSubID: TdaSubID;
   aNewSubID: TdaSubID);
 end;//IdaLinkServerService

 TdaLinkServerService = {final} class(Tl3ProtoObject)
  private
   f_Alien: IdaLinkServerService;
    {* ������� ���������� ������� IdaLinkServerService }
  protected
   procedure pm_SetAlien(const aValue: IdaLinkServerService);
   procedure ClearFields; override;
  public
   procedure ChangeSubID(aFamilyID: TdaFamilyID;
    aDocID: TdaDocID;
    anOldSubID: TdaSubID;
    aNewSubID: TdaSubID);
   class function Instance: TdaLinkServerService;
    {* ����� ��������� ���������� ���������� TdaLinkServerService }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
  public
   property Alien: IdaLinkServerService
    write pm_SetAlien;
    {* ������� ���������� ������� IdaLinkServerService }
 end;//TdaLinkServerService

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
 //#UC START# *57EB5FD6006Aimpl_uses*
 //#UC END# *57EB5FD6006Aimpl_uses*
;

var g_TdaLinkServerService: TdaLinkServerService = nil;
 {* ��������� ���������� TdaLinkServerService }

procedure TdaLinkServerServiceFree;
 {* ����� ������������ ���������� ���������� TdaLinkServerService }
begin
 l3Free(g_TdaLinkServerService);
end;//TdaLinkServerServiceFree

procedure TdaLinkServerService.pm_SetAlien(const aValue: IdaLinkServerService);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//TdaLinkServerService.pm_SetAlien

procedure TdaLinkServerService.ChangeSubID(aFamilyID: TdaFamilyID;
 aDocID: TdaDocID;
 anOldSubID: TdaSubID;
 aNewSubID: TdaSubID);
//#UC START# *57EB60BD0052_57EB5FD6006A_var*
//#UC END# *57EB60BD0052_57EB5FD6006A_var*
begin
//#UC START# *57EB60BD0052_57EB5FD6006A_impl*
 if Assigned(f_Alien) then
  f_Alien.ChangeSubID(aFamilyID, aDocID, anOldSubID, aNewSubID);
//#UC END# *57EB60BD0052_57EB5FD6006A_impl*
end;//TdaLinkServerService.ChangeSubID

class function TdaLinkServerService.Instance: TdaLinkServerService;
 {* ����� ��������� ���������� ���������� TdaLinkServerService }
begin
 if (g_TdaLinkServerService = nil) then
 begin
  l3System.AddExitProc(TdaLinkServerServiceFree);
  g_TdaLinkServerService := Create;
 end;
 Result := g_TdaLinkServerService;
end;//TdaLinkServerService.Instance

class function TdaLinkServerService.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TdaLinkServerService <> nil;
end;//TdaLinkServerService.Exists

procedure TdaLinkServerService.ClearFields;
begin
 Alien := nil;
 inherited;
end;//TdaLinkServerService.ClearFields

end.
