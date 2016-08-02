unit TestDocumentList;

// ������: "w:\common\components\rtl\Garant\DUnitTuning\TestDocumentList.pas"
// ���������: "SimpleClass"
// ������� ������: "TTestDocumentList" MUID: (5279D2EA02DE)

{$Include w:\common\components\rtl\Garant\DUnitTuning\tfwDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NotTunedDUnit)}
uses
 l3IntfUses
 , l3StringList
;

type
 TTestDocumentList = class(Tl3StringList)
  public
   class function Exists: Boolean;
   class function Instance: TTestDocumentList;
    {* ����� ��������� ���������� ���������� TTestDocumentList }
 end;//TTestDocumentList
{$IfEnd} // Defined(nsTest) AND NOT Defined(NotTunedDUnit)

implementation

{$If Defined(nsTest) AND NOT Defined(NotTunedDUnit)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_TTestDocumentList: TTestDocumentList = nil;
 {* ��������� ���������� TTestDocumentList }

procedure TTestDocumentListFree;
 {* ����� ������������ ���������� ���������� TTestDocumentList }
begin
 l3Free(g_TTestDocumentList);
end;//TTestDocumentListFree

class function TTestDocumentList.Exists: Boolean;
begin
 Result := g_TTestDocumentList <> nil;
end;//TTestDocumentList.Exists

class function TTestDocumentList.Instance: TTestDocumentList;
 {* ����� ��������� ���������� ���������� TTestDocumentList }
begin
 if (g_TTestDocumentList = nil) then
 begin
  l3System.AddExitProc(TTestDocumentListFree);
  g_TTestDocumentList := Create;
 end;
 Result := g_TTestDocumentList;
end;//TTestDocumentList.Instance
{$IfEnd} // Defined(nsTest) AND NOT Defined(NotTunedDUnit)

end.
