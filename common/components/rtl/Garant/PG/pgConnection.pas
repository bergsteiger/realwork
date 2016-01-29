unit pgConnection;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "PG"
// Модуль: "w:/common/components/rtl/Garant/PG/pgConnection.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::PG::Provider::TpgConnection
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\PG\pgDefine.inc}

interface

{$If defined(UsePostgres)}
uses
  l3ProtoObject,
  LibPQ,
  pgDataProviderParams
  ;
{$IfEnd} //UsePostgres

{$If defined(UsePostgres)}
type
 TpgConnection = class(Tl3ProtoObject)
 private
 // private fields
   f_Handle : PPGconn;
    {* Поле для свойства Handle}
 private
 // private methods
   function BuildConnectString(aParams: TpgDataProviderParams): AnsiString;
 public
 // public methods
   procedure Connect(aParams: TpgDataProviderParams);
   procedure Disconnect;
   function Connected: Boolean;
 public
 // public properties
   property Handle: PPGconn
     read f_Handle;
 end;//TpgConnection
{$IfEnd} //UsePostgres

implementation

{$If defined(UsePostgres)}
uses
  SysUtils,
  pgInterfaces
  ;
{$IfEnd} //UsePostgres

{$If defined(UsePostgres)}

// start class TpgConnection

function TpgConnection.BuildConnectString(aParams: TpgDataProviderParams): AnsiString;
//#UC START# *55F7BAE0023F_55F6875803A8_var*
//#UC END# *55F7BAE0023F_55F6875803A8_var*
begin
//#UC START# *55F7BAE0023F_55F6875803A8_impl*
 Result := Format('postgresql://postgres:admin@%s:%d/archi?client_encoding=WIN1251', [aParams.DataServerHostName, aParams.DataServerPort]);
//#UC END# *55F7BAE0023F_55F6875803A8_impl*
end;//TpgConnection.BuildConnectString

procedure TpgConnection.Connect(aParams: TpgDataProviderParams);
//#UC START# *55F68CE401CB_55F6875803A8_var*
var
 l_Message: AnsiString;
//#UC END# *55F68CE401CB_55F6875803A8_var*
begin
//#UC START# *55F68CE401CB_55F6875803A8_impl*
  f_Handle := PQconnectdb(PAnsiChar(BuildConnectString(aParams)));
  if PQstatus(f_Handle) <> CONNECTION_OK then
  begin
   l_Message := PQerrorMessage(f_Handle);
   PQfinish(f_Handle);
   f_Handle := nil;
   raise EPgError.Create(l_Message);
  end;
//#UC END# *55F68CE401CB_55F6875803A8_impl*
end;//TpgConnection.Connect

procedure TpgConnection.Disconnect;
//#UC START# *55F68CFA009F_55F6875803A8_var*
var
 l_Message: AnsiString;
//#UC END# *55F68CFA009F_55F6875803A8_var*
begin
//#UC START# *55F68CFA009F_55F6875803A8_impl*
 if Assigned(f_Handle) then
 begin
  try
   if PQstatus(f_Handle) <> CONNECTION_OK then
    raise EPgError.Create(PQerrorMessage(f_Handle))
  finally
   PQfinish(f_Handle);
   f_Handle := nil;
  end;
 end;
//#UC END# *55F68CFA009F_55F6875803A8_impl*
end;//TpgConnection.Disconnect

function TpgConnection.Connected: Boolean;
//#UC START# *55F68D160072_55F6875803A8_var*
//#UC END# *55F68D160072_55F6875803A8_var*
begin
//#UC START# *55F68D160072_55F6875803A8_impl*
 Result := Assigned(f_Handle);
//#UC END# *55F68D160072_55F6875803A8_impl*
end;//TpgConnection.Connected

{$IfEnd} //UsePostgres

end.