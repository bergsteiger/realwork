unit tfwCompiledAxiomaticsRes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ScriptEngine$Core"
// ������: "tfwCompiledAxiomaticsRes.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: SimpleClass::Class Shared Delphi Low Level::ScriptEngine$Core::ScriptedAxiomatics::TtfwCompiledAxiomaticsRes
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  l3StringList
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
type
 TtfwCompiledAxiomaticsRes = class(Tl3StringList)
 public
 // public methods
   class function Exists: Boolean;
     {* ��������� ������ ��������� ���������� ��� ��� }
 public
 // singleton factory method
   class function Instance: TtfwCompiledAxiomaticsRes;
    {- ���������� ��������� ����������. }
 end;//TtfwCompiledAxiomaticsRes
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  l3Base {a}
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}


// start class TtfwCompiledAxiomaticsRes

var g_TtfwCompiledAxiomaticsRes : TtfwCompiledAxiomaticsRes = nil;

procedure TtfwCompiledAxiomaticsResFree;
begin
 l3Free(g_TtfwCompiledAxiomaticsRes);
end;

class function TtfwCompiledAxiomaticsRes.Instance: TtfwCompiledAxiomaticsRes;
begin
 if (g_TtfwCompiledAxiomaticsRes = nil) then
 begin
  l3System.AddExitProc(TtfwCompiledAxiomaticsResFree);
  g_TtfwCompiledAxiomaticsRes := Create;
 end;
 Result := g_TtfwCompiledAxiomaticsRes;
end;


class function TtfwCompiledAxiomaticsRes.Exists: Boolean;
 {-}
begin
 Result := g_TtfwCompiledAxiomaticsRes <> nil;
end;//TtfwCompiledAxiomaticsRes.Exists

{$IfEnd} //not NoScripts

end.