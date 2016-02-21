unit nsPostingsTreeSingle;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\nsPostingsTreeSingle.pas"
// ���������: "SimpleClass"

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
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
   class function Instance: TnsPostingsTreeSingle;
    {* ����� ��������� ���������� ���������� TnsPostingsTreeSingle }
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

class function TnsPostingsTreeSingle.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TnsPostingsTreeSingle <> nil;
end;//TnsPostingsTreeSingle.Exists

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
{$IfEnd} // NOT Defined(Admin)

end.
