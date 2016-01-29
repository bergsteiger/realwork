unit ncsSynchroCompatibilityClientTransporter;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "cs"
// ������: "w:/common/components/rtl/Garant/cs/ncsSynchroCompatibilityClientTransporter.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::cs::Messages::TncsSynchroCompatibilityClientTransporter
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
  CsQueryTypes,
  ncsMessageInterfaces,
  ncsSynchroClientTransporter,
  ncsMessage,
  Windows,
  CsCommon
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}
type
 TncsSynchroCompatibilityClientTransporter = class(TncsSynchroClientTransporter)
 private
 // private fields
   f_QueryID : TCsQueryId;
 protected
 // overridden protected methods
   procedure BeforeHandshake; override;
     {* ��������� ������ BeforeHandshake }
 public
 // public methods
   constructor Create(aQueryID: TCsQueryId); reintroduce;
   class function Make(aQueryID: TCsQueryId): IncsClientTransporter; reintroduce;
     {* ��������� ������� TncsSynchroCompatibilityClientTransporter.Make }
 end;//TncsSynchroCompatibilityClientTransporter
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
uses
  CsConst
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}

// start class TncsSynchroCompatibilityClientTransporter

constructor TncsSynchroCompatibilityClientTransporter.Create(aQueryID: TCsQueryId);
//#UC START# *54E33E1A00B4_54E33DBC0063_var*
//#UC END# *54E33E1A00B4_54E33DBC0063_var*
begin
//#UC START# *54E33E1A00B4_54E33DBC0063_impl*
 inherited Create;
 f_QueryID := aQueryID;
//#UC END# *54E33E1A00B4_54E33DBC0063_impl*
end;//TncsSynchroCompatibilityClientTransporter.Create

class function TncsSynchroCompatibilityClientTransporter.Make(aQueryID: TCsQueryId): IncsClientTransporter;
var
 l_Inst : TncsSynchroCompatibilityClientTransporter;
begin
 l_Inst := Create(aQueryID);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

procedure TncsSynchroCompatibilityClientTransporter.BeforeHandshake;
//#UC START# *54E33EA40163_54E33DBC0063_var*
//#UC END# *54E33EA40163_54E33DBC0063_var*
begin
//#UC START# *54E33EA40163_54E33DBC0063_impl*
 IOHandler.WriteInteger(c_CsVersion);
 IOHandler.WriteInteger(Integer(Get_ClientID));
 IOHandler.WriteInteger(Ord(f_QueryID));
 IOHandler.WriteBufferFlush;
//#UC END# *54E33EA40163_54E33DBC0063_impl*
end;//TncsSynchroCompatibilityClientTransporter.BeforeHandshake

{$IfEnd} //not Nemesis

end.