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
 end;//TbsWorkJournal
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_TbsWorkJournal: Pointer = nil;
 {* Экземпляр синглетона TbsWorkJournal }

procedure TbsWorkJournalFree;
 {* Метод освобождения экземпляра синглетона TbsWorkJournal }
begin
 IUnknown(g_TbsWorkJournal) := nil;
end;//TbsWorkJournalFree

class function TbsWorkJournal.Make: IbsWorkJournal;
begin
 if (g_TbsWorkJournal = nil) then
 begin
  l3System.AddExitProc(TbsWorkJournalFree);
  IbsWorkJournal(g_TbsWorkJournal) := inherited Make;
 end;
 Result := IbsWorkJournal(g_TbsWorkJournal);
end;//TbsWorkJournal.Make

class function TbsWorkJournal.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TbsWorkJournal <> nil;
end;//TbsWorkJournal.Exists
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
