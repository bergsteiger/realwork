unit pgDataProviderParams;

// Модуль: "w:\common\components\rtl\Garant\PG\pgDataProviderParams.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TpgDataProviderParams" MUID: (55D6CFA5009E)

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
   procedure AssignParams(aParams: TdaDataProviderParams); override;
   class function GetTaggedDataType: Tk2Type; override;
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
 //#UC START# *55D6CFA5009Eimpl_uses*
 //#UC END# *55D6CFA5009Eimpl_uses*
;

function TpgDataProviderParams.pm_GetDataServerHostName: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrDataServerHostName]);
end;//TpgDataProviderParams.pm_GetDataServerHostName

procedure TpgDataProviderParams.pm_SetDataServerHostName(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrDataServerHostName, nil] := (aValue);
end;//TpgDataProviderParams.pm_SetDataServerHostName

function TpgDataProviderParams.pm_GetDataServerPort: Integer;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.IntA[k2_attrDataServerPort]);
end;//TpgDataProviderParams.pm_GetDataServerPort

procedure TpgDataProviderParams.pm_SetDataServerPort(aValue: Integer);
begin
 TaggedData.IntW[k2_attrDataServerPort, nil] := (aValue);
end;//TpgDataProviderParams.pm_SetDataServerPort

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

class function TpgDataProviderParams.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typPostgresProviderParams;
end;//TpgDataProviderParams.GetTaggedDataType
{$IfEnd} // Defined(UsePostgres)

end.
