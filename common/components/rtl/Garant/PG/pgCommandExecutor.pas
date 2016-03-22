unit pgCommandExecutor;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "PG"
// ������: "w:/common/components/rtl/Garant/PG/pgCommandExecutor.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::PG::Provider::TpgCommandExecutor
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\PG\pgDefine.inc}

interface

{$If defined(UsePostgres)}
uses
  l3ProtoObject,
  pgConnection
  ;
{$IfEnd} //UsePostgres

{$If defined(UsePostgres)}
type
 TpgCommandExecutor = class(Tl3ProtoObject)
 private
 // private fields
   f_Connection : TpgConnection;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* ������� ������� ����� �������. }
 public
 // public methods
   constructor Create(aConnection: TpgConnection); reintroduce;
   procedure Execute(const aCommand: AnsiString);
 end;//TpgCommandExecutor
{$IfEnd} //UsePostgres

implementation

{$If defined(UsePostgres)}
uses
  SysUtils,
  LibPQ,
  pgUtils
  ;
{$IfEnd} //UsePostgres

{$If defined(UsePostgres)}

// start class TpgCommandExecutor

constructor TpgCommandExecutor.Create(aConnection: TpgConnection);
//#UC START# *5694BA880236_5694BA3500C4_var*
//#UC END# *5694BA880236_5694BA3500C4_var*
begin
//#UC START# *5694BA880236_5694BA3500C4_impl*
 inherited Create;
 aConnection.SetRefTo(f_Connection);
//#UC END# *5694BA880236_5694BA3500C4_impl*
end;//TpgCommandExecutor.Create

procedure TpgCommandExecutor.Execute(const aCommand: AnsiString);
//#UC START# *5694BA4A0323_5694BA3500C4_var*
var
 l_Result: PPGResult;
//#UC END# *5694BA4A0323_5694BA3500C4_var*
begin
//#UC START# *5694BA4A0323_5694BA3500C4_impl*
 l_Result := PQexec(f_Connection.Handle, PAnsiChar(aCommand));
 try
  pgCheckStatus(l_Result);
 finally
  PQclear(l_Result);
 end;
//#UC END# *5694BA4A0323_5694BA3500C4_impl*
end;//TpgCommandExecutor.Execute

procedure TpgCommandExecutor.Cleanup;
//#UC START# *479731C50290_5694BA3500C4_var*
//#UC END# *479731C50290_5694BA3500C4_var*
begin
//#UC START# *479731C50290_5694BA3500C4_impl*
 FreeAndNil(f_Connection);
 inherited;
//#UC END# *479731C50290_5694BA3500C4_impl*
end;//TpgCommandExecutor.Cleanup

{$IfEnd} //UsePostgres

end.