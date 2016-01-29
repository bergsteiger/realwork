unit CsQueryRequesterTool;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "cs"
// ������: "w:/common/components/rtl/Garant/cs/CsQueryRequesterTool.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::cs::ClientSide::TCsQueryRequesterTool
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\cs\CsDefine.inc}

interface

{$If not defined(Nemesis)}
uses
  CsCommon,
  CsDataPipe,
  CsQueryTypes,
  CsQueryRequester
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}
type
 TCsQueryRequesterTool = class
 public
 // public methods
   class function ExecuteQuery(aQueryId: TCsQueryId;
     aClientID: TCsClientId;
     aPipe: TCsDataPipe;
     aQueryProc: TCsQueryProc;
     aWrite2Log: Boolean): Boolean;
 end;//TCsQueryRequesterTool
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
uses
  l3Base,
  CsConst,
  TypInfo
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}

// start class TCsQueryRequesterTool

class function TCsQueryRequesterTool.ExecuteQuery(aQueryId: TCsQueryId;
  aClientID: TCsClientId;
  aPipe: TCsDataPipe;
  aQueryProc: TCsQueryProc;
  aWrite2Log: Boolean): Boolean;
//#UC START# *538DA34E03C3_538DA33503D9_var*
//#UC END# *538DA34E03C3_538DA33503D9_var*
begin
//#UC START# *538DA34E03C3_538DA33503D9_impl*
 aPipe.WriteInteger(Integer(c_CsVersion));
 aPipe.WriteInteger(Integer(aClientID));
 aPipe.WriteInteger(Integer(Ord(aQueryId)));

 if aWrite2Log then
  l3System.Msg2Log('��������: %s'#13#10, [GetEnumName(TypeInfo(TcsQueryID), ord(aQueryID))]);
 if Assigned(aQueryProc) then
 begin
  aQueryProc(aPipe);
  Result := true;
 end//Assigned(aQueryProc)
 else
 begin
  Result := false;
  if aQUeryID <> qtLogout then
   l3System.Msg2Log('CsQueryRequesterTool - �� ����� ����������');
 end;
//#UC END# *538DA34E03C3_538DA33503D9_impl*
end;//TCsQueryRequesterTool.ExecuteQuery

{$IfEnd} //not Nemesis

end.