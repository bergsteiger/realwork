unit bsWorkJournal;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "WorkJournal"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/WorkJournal/bsWorkJournal.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 �������� ����������::WorkJournal::WorkJournal::WorkJournalImpl::TbsWorkJournal
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  WorkJournalInterfaces,
  bsWorkJournalPrim
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TbsWorkJournal = class(TbsWorkJournalPrim)
 public
 // public methods
   class function Make: IbsWorkJournal; reintroduce;
   class function Exists: Boolean;
     {* ��������� ������ ��������� ���������� ��� ��� }
 end;//TbsWorkJournal
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3Base {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TbsWorkJournal

var g_TbsWorkJournal : Pointer = nil;

procedure TbsWorkJournalFree;
begin
 IUnknown(g_TbsWorkJournal) := nil;
end;


class function TbsWorkJournal.Make: IbsWorkJournal;
begin
 if (g_TbsWorkJournal = nil) then
 begin
  l3System.AddExitProc(TbsWorkJournalFree);
  IbsWorkJournal(g_TbsWorkJournal) := inherited Make;
 end;
 Result := IbsWorkJournal(g_TbsWorkJournal);
end;

class function TbsWorkJournal.Exists: Boolean;
 {-}
begin
 Result := g_TbsWorkJournal <> nil;
end;//TbsWorkJournal.Exists

{$IfEnd} //not Admin AND not Monitorings

end.