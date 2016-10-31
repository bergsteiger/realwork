unit dt_LinkServerService;

// ������: "w:\common\components\rtl\Garant\DT\dt_LinkServerService.pas"
// ���������: "ServiceImplementation"
// ������� ������: "Tdt_LinkServerService" MUID: (57EB6297000B)

{$Include w:\common\components\rtl\Garant\DT\DtDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , l3ProtoObject
 , daLinkServerService
 , daTypes
;

type
 Tdt_LinkServerService = {final} class(Tl3ProtoObject, IdaLinkServerService)
  public
   procedure ChangeSubID(aFamilyID: TdaFamilyID;
    aDocID: TdaDocID;
    anOldSubID: TdaSubID;
    aNewSubID: TdaSubID);
   class function Instance: Tdt_LinkServerService;
    {* ����� ��������� ���������� ���������� Tdt_LinkServerService }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
 end;//Tdt_LinkServerService
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , dt_LinkServ
 , SysUtils
 , l3Base
 //#UC START# *57EB6297000Bimpl_uses*
 //#UC END# *57EB6297000Bimpl_uses*
;

var g_Tdt_LinkServerService: Tdt_LinkServerService = nil;
 {* ��������� ���������� Tdt_LinkServerService }

procedure Tdt_LinkServerServiceFree;
 {* ����� ������������ ���������� ���������� Tdt_LinkServerService }
begin
 l3Free(g_Tdt_LinkServerService);
end;//Tdt_LinkServerServiceFree

procedure Tdt_LinkServerService.ChangeSubID(aFamilyID: TdaFamilyID;
 aDocID: TdaDocID;
 anOldSubID: TdaSubID;
 aNewSubID: TdaSubID);
//#UC START# *57EB60BD0052_57EB6297000B_var*
//#UC END# *57EB60BD0052_57EB6297000B_var*
begin
//#UC START# *57EB60BD0052_57EB6297000B_impl*
 LinkServer(aFamilyID).SubTbl.ChangeSubID(aDocID, anOldSubID, aNewSubID); // ������� ��-�� ��������� SUBID � ������������
//#UC END# *57EB60BD0052_57EB6297000B_impl*
end;//Tdt_LinkServerService.ChangeSubID

class function Tdt_LinkServerService.Instance: Tdt_LinkServerService;
 {* ����� ��������� ���������� ���������� Tdt_LinkServerService }
begin
 if (g_Tdt_LinkServerService = nil) then
 begin
  l3System.AddExitProc(Tdt_LinkServerServiceFree);
  g_Tdt_LinkServerService := Create;
 end;
 Result := g_Tdt_LinkServerService;
end;//Tdt_LinkServerService.Instance

class function Tdt_LinkServerService.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_Tdt_LinkServerService <> nil;
end;//Tdt_LinkServerService.Exists

initialization
 TdaLinkServerService.Instance.Alien := Tdt_LinkServerService.Instance;
 {* ����������� Tdt_LinkServerService }
{$IfEnd} // NOT Defined(Nemesis)

end.
