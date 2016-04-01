unit nsPostingsTreeSingle;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\nsPostingsTreeSingle.pas"
// ���������: "SimpleClass"
// ������� ������: "TnsPostingsTreeSingle" MUID: (4AAF9400011C)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , nsPostingsLine
;

type
 TnsPostingsTreeSingle = {final} class(TnsPostingsTree)
  public
   class function Instance: TnsPostingsTreeSingle;
    {* ����� ��������� ���������� ���������� TnsPostingsTreeSingle }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
 end;//TnsPostingsTreeSingle
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_TnsPostingsTreeSingle: TnsPostingsTreeSingle = nil;
 {* ��������� ���������� TnsPostingsTreeSingle }

procedure TnsPostingsTreeSingleFree;
 {* ����� ������������ ���������� ���������� TnsPostingsTreeSingle }
begin
 l3Free(g_TnsPostingsTreeSingle);
end;//TnsPostingsTreeSingleFree

class function TnsPostingsTreeSingle.Instance: TnsPostingsTreeSingle;
 {* ����� ��������� ���������� ���������� TnsPostingsTreeSingle }
begin
 if (g_TnsPostingsTreeSingle = nil) then
 begin
  l3System.AddExitProc(TnsPostingsTreeSingleFree);
  g_TnsPostingsTreeSingle := Create;
 end;
 Result := g_TnsPostingsTreeSingle;
end;//TnsPostingsTreeSingle.Instance

class function TnsPostingsTreeSingle.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TnsPostingsTreeSingle <> nil;
end;//TnsPostingsTreeSingle.Exists
{$IfEnd} // NOT Defined(Admin)

end.
