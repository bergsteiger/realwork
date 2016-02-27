unit pgDataProviderParams;

// Модуль: "w:\common\components\rtl\Garant\PG\pgDataProviderParams.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\PG\pgDefine.inc}

interface

{$If Defined(UsePostgres)}
uses
 l3IntfUses
 , daDataProviderParams
 , k2Base
;

type
 TpgDataProviderParams = class(TdaDataProviderParams)
  protected
   function pm_GetDataServerHostName: AnsiString;
   procedure pm_SetDataServerHostName(const aValue: AnsiString);
   function pm_GetDataServerPort: Integer;
   procedure pm_SetDataServerPort(aValue: Integer);
  public
   class function GetTaggedDataType: Tk2Type; override;
   procedure AssignParams(aParams: TdaDataProviderParams); override;
  public
   property DataServerHostName: AnsiString
    read pm_GetDataServerHostName
    write pm_SetDataServerHostName;
   property DataServerPort: Integer
    read pm_GetDataServerPort
    write pm_SetDataServerPort;
 end;//TpgDataProviderParams
{$IfEnd} // Defined(UsePostgres)

implementation

{$If Defined(UsePostgres)}
uses
 l3ImplUses
 , PostgresProviderParams_Const
;

function TpgDataProviderParams.pm_GetDataServerHostName: AnsiString;
//#UC START# *E83633B0ED06_55D6CFA5009Eget_var*
//#UC END# *E83633B0ED06_55D6CFA5009Eget_var*
begin
//#UC START# *E83633B0ED06_55D6CFA5009Eget_impl*
 !!! Needs to be implemented !!!
//#UC END# *E83633B0ED06_55D6CFA5009Eget_impl*
end;//TpgDataProviderParams.pm_GetDataServerHostName

procedure TpgDataProviderParams.pm_SetDataServerHostName(const aValue: AnsiString);
//#UC START# *E83633B0ED06_55D6CFA5009Eset_var*
//#UC END# *E83633B0ED06_55D6CFA5009Eset_var*
begin
//#UC START# *E83633B0ED06_55D6CFA5009Eset_impl*
 !!! Needs to be implemented !!!
//#UC END# *E83633B0ED06_55D6CFA5009Eset_impl*
end;//TpgDataProviderParams.pm_SetDataServerHostName

function TpgDataProviderParams.pm_GetDataServerPort: Integer;
//#UC START# *1BA3D1428743_55D6CFA5009Eget_var*
//#UC END# *1BA3D1428743_55D6CFA5009Eget_var*
begin
//#UC START# *1BA3D1428743_55D6CFA5009Eget_impl*
 !!! Needs to be implemented !!!
//#UC END# *1BA3D1428743_55D6CFA5009Eget_impl*
end;//TpgDataProviderParams.pm_GetDataServerPort

procedure TpgDataProviderParams.pm_SetDataServerPort(aValue: Integer);
//#UC START# *1BA3D1428743_55D6CFA5009Eset_var*
//#UC END# *1BA3D1428743_55D6CFA5009Eset_var*
begin
//#UC START# *1BA3D1428743_55D6CFA5009Eset_impl*
 !!! Needs to be implemented !!!
//#UC END# *1BA3D1428743_55D6CFA5009Eset_impl*
end;//TpgDataProviderParams.pm_SetDataServerPort

class function TpgDataProviderParams.GetTaggedDataType: Tk2Type;
//#UC START# *53AC03EE01FD_55D6CFA5009E_var*
//#UC END# *53AC03EE01FD_55D6CFA5009E_var*
begin
//#UC START# *53AC03EE01FD_55D6CFA5009E_impl*
 !!! Needs to be implemented !!!
//#UC END# *53AC03EE01FD_55D6CFA5009E_impl*
end;//TpgDataProviderParams.GetTaggedDataType

procedure TpgDataProviderParams.AssignParams(aParams: TdaDataProviderParams);
//#UC START# *553A37E902C9_55D6CFA5009E_var*
//#UC END# *553A37E902C9_55D6CFA5009E_var*
begin
//#UC START# *553A37E902C9_55D6CFA5009E_impl*
 inherited;
 if aParams is TpgDataProviderParams then
 begin
  DataServerHostName := TpgDataProviderParams(aParams).DataServerHostName;
  DataServerPort := TpgDataProviderParams(aParams).DataServerPort;
 end;
//#UC END# *553A37E902C9_55D6CFA5009E_impl*
end;//TpgDataProviderParams.AssignParams
{$IfEnd} // Defined(UsePostgres)

end.
