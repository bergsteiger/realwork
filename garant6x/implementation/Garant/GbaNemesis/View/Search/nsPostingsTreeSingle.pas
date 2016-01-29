unit nsPostingsTreeSingle;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View$Strange"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Search/nsPostingsTreeSingle.pas"
// �����: 31.10.2011 17:46
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Common For Shell And Monitoring::Search::View$Strange::Search::TnsPostingsTreeSingle
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin)}
uses
  nsPostingsLine
  ;
{$IfEnd} //not Admin

{$If not defined(Admin)}
type
 TnsPostingsTreeSingle = {final} class(TnsPostingsTree)
 public
 // public methods
   class function Exists: Boolean;
     {* ��������� ������ ��������� ���������� ��� ��� }
 public
 // singleton factory method
   class function Instance: TnsPostingsTreeSingle;
    {- ���������� ��������� ����������. }
 end;//TnsPostingsTreeSingle
{$IfEnd} //not Admin

implementation

{$If not defined(Admin)}
uses
  l3Base {a}
  ;
{$IfEnd} //not Admin

{$If not defined(Admin)}


// start class TnsPostingsTreeSingle

var g_TnsPostingsTreeSingle : TnsPostingsTreeSingle = nil;

procedure TnsPostingsTreeSingleFree;
begin
 l3Free(g_TnsPostingsTreeSingle);
end;

class function TnsPostingsTreeSingle.Instance: TnsPostingsTreeSingle;
begin
 if (g_TnsPostingsTreeSingle = nil) then
 begin
  l3System.AddExitProc(TnsPostingsTreeSingleFree);
  g_TnsPostingsTreeSingle := Create;
 end;
 Result := g_TnsPostingsTreeSingle;
end;


class function TnsPostingsTreeSingle.Exists: Boolean;
 {-}
begin
 Result := g_TnsPostingsTreeSingle <> nil;
end;//TnsPostingsTreeSingle.Exists

{$IfEnd} //not Admin

end.