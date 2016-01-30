unit bsWorkJournal;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\WorkJournal\bsWorkJournal.pas"
// ���������: "SimpleClass"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , bsWorkJournalPrim
 , WorkJournalInterfaces
;

type
 TbsWorkJournal = class(TbsWorkJournalPrim)
  public
   class function Make: IbsWorkJournal; reintroduce;
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
   class function Instance: TbsWorkJournal;
    {* ����� ��������� ���������� ���������� TbsWorkJournal }
 end;//TbsWorkJournal
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_TbsWorkJournal: TbsWorkJournal = nil;
 {* ��������� ���������� TbsWorkJournal }

procedure TbsWorkJournalFree;
 {* ����� ������������ ���������� ���������� TbsWorkJournal }
begin
 l3Free(g_TbsWorkJournal);
end;//TbsWorkJournalFree

class function TbsWorkJournal.Make: IbsWorkJournal;
var
 l_Inst : TbsWorkJournal;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TbsWorkJournal.Make

class function TbsWorkJournal.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TbsWorkJournal <> nil;
end;//TbsWorkJournal.Exists

class function TbsWorkJournal.Instance: TbsWorkJournal;
 {* ����� ��������� ���������� ���������� TbsWorkJournal }
begin
 if (g_TbsWorkJournal = nil) then
 begin
  l3System.AddExitProc(TbsWorkJournalFree);
  g_TbsWorkJournal := Create;
 end;
 Result := g_TbsWorkJournal;
end;//TbsWorkJournal.Instance
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
