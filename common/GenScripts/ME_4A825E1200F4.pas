unit bsWorkJournal;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\WorkJournal\bsWorkJournal.pas"
// Стереотип: "SimpleClass"

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
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: TbsWorkJournal;
    {* Метод получения экземпляра синглетона TbsWorkJournal }
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
 {* Экземпляр синглетона TbsWorkJournal }

procedure TbsWorkJournalFree;
 {* Метод освобождения экземпляра синглетона TbsWorkJournal }
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
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TbsWorkJournal <> nil;
end;//TbsWorkJournal.Exists

class function TbsWorkJournal.Instance: TbsWorkJournal;
 {* Метод получения экземпляра синглетона TbsWorkJournal }
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
