unit pgDataProviderParams;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "PG"
// Модуль: "w:/common/components/rtl/Garant/PG/pgDataProviderParams.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::PG::Provider::TpgDataProviderParams
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
  daDataProviderParams,
  k2Base
  ;
{$IfEnd} //UsePostgres

{$If defined(UsePostgres)}
type
 TpgDataProviderParams = class(TdaDataProviderParams)
 protected
 // property methods
   function pm_GetDataServerHostName: AnsiString;
   procedure pm_SetDataServerHostName(const aValue: AnsiString);
   function pm_GetDataServerPort: Integer;
   procedure pm_SetDataServerPort(aValue: Integer);
 protected
 // overridden protected methods
   class function GetTaggedDataType: Tk2Type; override;
 public
 // overridden public methods
   procedure AssignParams(aParams: TdaDataProviderParams); override;
 public
 // public properties
   property DataServerHostName: AnsiString
     read pm_GetDataServerHostName
     write pm_SetDataServerHostName;
   property DataServerPort: Integer
     read pm_GetDataServerPort
     write pm_SetDataServerPort;
 end;//TpgDataProviderParams
{$IfEnd} //UsePostgres

implementation

{$If defined(UsePostgres)}
uses
  PostgresProviderParams_Const
  ;
{$IfEnd} //UsePostgres

{$If defined(UsePostgres)}

// start class TpgDataProviderParams

function TpgDataProviderParams.pm_GetDataServerHostName: AnsiString;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrDataServerHostName]);
end;//TpgDataProviderParams.pm_GetDataServerHostName

procedure TpgDataProviderParams.pm_SetDataServerHostName(const aValue: AnsiString);
 {-}
begin
 TaggedData.StrW[k2_attrDataServerHostName, nil] := (aValue);
end;//TpgDataProviderParams.pm_SetDataServerHostName

function TpgDataProviderParams.pm_GetDataServerPort: Integer;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.IntA[k2_attrDataServerPort]);
end;//TpgDataProviderParams.pm_GetDataServerPort

procedure TpgDataProviderParams.pm_SetDataServerPort(aValue: Integer);
 {-}
begin
 TaggedData.IntW[k2_attrDataServerPort, nil] := (aValue);
end;//TpgDataProviderParams.pm_SetDataServerPort

class function TpgDataProviderParams.GetTaggedDataType: Tk2Type;
 {-}
begin
 Result := k2_typPostgresProviderParams;
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

{$IfEnd} //UsePostgres

end.