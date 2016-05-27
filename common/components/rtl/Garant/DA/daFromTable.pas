unit daFromTable;

// Модуль: "w:\common\components\rtl\Garant\DA\daFromTable.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TdaFromTable" MUID: (55FFB14A031C)

{$Include w:\common\components\rtl\Garant\DA\daDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , daInterfaces
;

type
 TdaFromTable = class(Tl3ProtoObject, IdaFromTable, IdaFromClause)
  private
   f_Table: IdaTableDescription;
   f_Prepared: Boolean;
   f_TableAlias: AnsiString;
  protected
   procedure pm_SetPrepared(aValue: Boolean); virtual;
   function Get_TableAlias: AnsiString;
   function Get_Table: IdaTableDescription;
   function BuildSQLValue: AnsiString;
   function HasTable(const aTable: IdaTableDescription): Boolean;
   function FindTable(const aTableAlias: AnsiString): IdaFromTable;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(const aTable: IdaTableDescription;
    const anAlias: AnsiString = ''); reintroduce; virtual;
   class function Make(const aTable: IdaTableDescription;
    const anAlias: AnsiString = ''): IdaFromClause; reintroduce;
   procedure IterateTablesF(anAction: daFromClauseIterator_IterateTablesF_Action);
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
 , l3Base
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
 const anAlias: AnsiString = ''): IdaFromClause;
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
 Result := Format('%s.%s', [TdaScheme.Instance.CheckScheme(f_Table.Scheme), f_Table.SQLName]);
 if f_TableAlias <> '' then
  Result := Result + ' ' + f_TableAlias;
//#UC END# *5608E5F20118_55FFB14A031C_impl*
end;//TdaFromTable.BuildSQLValue

function TdaFromTable.HasTable(const aTable: IdaTableDescription): Boolean;
//#UC START# *57442BFD03BE_55FFB14A031C_var*
//#UC END# *57442BFD03BE_55FFB14A031C_var*
begin
//#UC START# *57442BFD03BE_55FFB14A031C_impl*
 Result := f_Table = aTable;
//#UC END# *57442BFD03BE_55FFB14A031C_impl*
end;//TdaFromTable.HasTable

function TdaFromTable.FindTable(const aTableAlias: AnsiString): IdaFromTable;
//#UC START# *5744366C003B_55FFB14A031C_var*
//#UC END# *5744366C003B_55FFB14A031C_var*
begin
//#UC START# *5744366C003B_55FFB14A031C_impl*
 if AnsiSameText(aTableAlias, f_TableAlias) then
  Result := Self
 else
  Result := nil;
//#UC END# *5744366C003B_55FFB14A031C_impl*
end;//TdaFromTable.FindTable

procedure TdaFromTable.IterateTablesF(anAction: daFromClauseIterator_IterateTablesF_Action);
//#UC START# *574443A401BE_55FFB14A031C_var*
//#UC END# *574443A401BE_55FFB14A031C_var*
begin
//#UC START# *574443A401BE_55FFB14A031C_impl*
 !!! Needs to be implemented !!!
//#UC END# *574443A401BE_55FFB14A031C_impl*
end;//TdaFromTable.IterateTablesF

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
