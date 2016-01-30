unit daFromTable;

// Модуль: "w:\common\components\rtl\Garant\DA\daFromTable.pas"
// Стереотип: "SimpleClass"

{$Include daDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , daInterfaces
;

type
 TdaFromTable = class(Tl3ProtoObject, IdaFromTable)
  private
   f_Table: IdaTableDescription;
    {* Поле для свойства Table }
   f_Prepared: Boolean;
    {* Поле для свойства Prepared }
   f_TableAlias: AnsiString;
    {* Поле для свойства TableAlias }
  protected
   procedure pm_SetPrepared(aValue: Boolean); virtual;
   function Get_TableAlias: AnsiString;
   function Get_Table: IdaTableDescription;
   function BuildSQLValue: AnsiString;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(const aTable: IdaTableDescription;
    const anAlias: AnsiString = ''); reintroduce; virtual;
   class function Make(const aTable: IdaTableDescription;
    const anAlias: AnsiString = ''): IdaFromTable; reintroduce;
  protected
   property Table: IdaTableDescription
    read f_Table;
   property Prepared: Boolean
    read f_Prepared
    write pm_SetPrepared;
   property TableAlias: AnsiString
    read f_TableAlias;
 end;//TdaFromTable

implementation

uses
 l3ImplUses
 , daScheme
 , SysUtils
;

procedure TdaFromTable.pm_SetPrepared(aValue: Boolean);
//#UC START# *55FFB1C600AB_55FFB14A031Cset_var*
//#UC END# *55FFB1C600AB_55FFB14A031Cset_var*
begin
//#UC START# *55FFB1C600AB_55FFB14A031Cset_impl*
 f_Prepared := aValue;
//#UC END# *55FFB1C600AB_55FFB14A031Cset_impl*
end;//TdaFromTable.pm_SetPrepared

constructor TdaFromTable.Create(const aTable: IdaTableDescription;
 const anAlias: AnsiString = '');
//#UC START# *55530BE50143_55FFB14A031C_var*
//#UC END# *55530BE50143_55FFB14A031C_var*
begin
//#UC START# *55530BE50143_55FFB14A031C_impl*
 inherited Create;
 f_TableAlias := anAlias;
 f_Table := aTable;
//#UC END# *55530BE50143_55FFB14A031C_impl*
end;//TdaFromTable.Create

class function TdaFromTable.Make(const aTable: IdaTableDescription;
 const anAlias: AnsiString = ''): IdaFromTable;
var
 l_Inst : TdaFromTable;
begin
 l_Inst := Create(aTable, anAlias);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TdaFromTable.Make

function TdaFromTable.Get_TableAlias: AnsiString;
//#UC START# *5553634C0218_55FFB14A031Cget_var*
//#UC END# *5553634C0218_55FFB14A031Cget_var*
begin
//#UC START# *5553634C0218_55FFB14A031Cget_impl*
 Result := f_TableAlias;
//#UC END# *5553634C0218_55FFB14A031Cget_impl*
end;//TdaFromTable.Get_TableAlias

function TdaFromTable.Get_Table: IdaTableDescription;
//#UC START# *555363590242_55FFB14A031Cget_var*
//#UC END# *555363590242_55FFB14A031Cget_var*
begin
//#UC START# *555363590242_55FFB14A031Cget_impl*
 Result := f_Table;
//#UC END# *555363590242_55FFB14A031Cget_impl*
end;//TdaFromTable.Get_Table

function TdaFromTable.BuildSQLValue: AnsiString;
//#UC START# *5608E5F20118_55FFB14A031C_var*
//#UC END# *5608E5F20118_55FFB14A031C_var*
begin
//#UC START# *5608E5F20118_55FFB14A031C_impl*
 Result := 'archi.' + f_Table.Name;
 if f_TableAlias <> '' then
  Result := Result + ' ' + f_TableAlias;
//#UC END# *5608E5F20118_55FFB14A031C_impl*
end;//TdaFromTable.BuildSQLValue

procedure TdaFromTable.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_55FFB14A031C_var*
//#UC END# *479731C50290_55FFB14A031C_var*
begin
//#UC START# *479731C50290_55FFB14A031C_impl*
 Assert(not Prepared);
 f_Table := nil;
 inherited;
//#UC END# *479731C50290_55FFB14A031C_impl*
end;//TdaFromTable.Cleanup

end.
