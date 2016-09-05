unit caFromClause;

// Модуль: "w:\common\components\rtl\Garant\ComboAccess\caFromClause.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TcaFromClause" MUID: (574D5A9900B6)

{$Include w:\common\components\rtl\Garant\ComboAccess\caDefine.inc}

interface

{$If Defined(UsePostgres) AND Defined(TestComboAccess)}
uses
 l3IntfUses
 , l3ProtoObject
 , daInterfaces
 , daTypes
;

type
 TcaFromClause = class(Tl3ProtoObject, IdaFromClause, IdaJoin, IdaComboAccessFromClauseHelper)
  private
   f_HTClause: IdaFromClause;
   f_PGClause: IdaFromClause;
   f_Factory: IdaTableQueryFactory;
  protected
   function BuildSQLValue(const aHelper: IdaParamListHelper): AnsiString;
   function HasTable(const aTable: IdaTableDescription): Boolean;
   function FindTable(const aTableAlias: AnsiString): IdaFromTable;
   function Get_Left: IdaFromClause;
   function Get_Right: IdaFromClause;
   function Get_Kind: TdaJoinKind;
   function Get_Condition: IdaCondition;
   function SetCondition(const aCondition: IdaCondition): IdaFromClause;
   function Join(const aRight: IdaFromClause;
    aKind: TdaJoinKind): IdaJoin;
   function IsRelationsConditionsValid: Boolean;
   function Get_HTClause: IdaFromClause;
   function Get_PGClause: IdaFromClause;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(const aFactory: IdaTableQueryFactory;
    const aHTClause: IdaFromClause;
    const aPGClause: IdaFromClause); reintroduce;
   class function Make(const aFactory: IdaTableQueryFactory;
    const aHTClause: IdaFromClause;
    const aPGClause: IdaFromClause): IdaJoin; reintroduce;
   procedure IterateTablesF(anAction: daFromClauseIterator_IterateTablesF_Action);
   procedure IterateRelationConditionsF(anAction: daFromClauseIterator_IterateRelationConditionsF_Action);
 end;//TcaFromClause
{$IfEnd} // Defined(UsePostgres) AND Defined(TestComboAccess)

implementation

{$If Defined(UsePostgres) AND Defined(TestComboAccess)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
 //#UC START# *574D5A9900B6impl_uses*
 //#UC END# *574D5A9900B6impl_uses*
;

constructor TcaFromClause.Create(const aFactory: IdaTableQueryFactory;
 const aHTClause: IdaFromClause;
 const aPGClause: IdaFromClause);
//#UC START# *574D5AFE0110_574D5A9900B6_var*
//#UC END# *574D5AFE0110_574D5A9900B6_var*
begin
//#UC START# *574D5AFE0110_574D5A9900B6_impl*
 inherited Create;
 f_HTClause := aHTCLause;
 f_PGClause := aPGClause;
 f_Factory := aFactory;
//#UC END# *574D5AFE0110_574D5A9900B6_impl*
end;//TcaFromClause.Create

class function TcaFromClause.Make(const aFactory: IdaTableQueryFactory;
 const aHTClause: IdaFromClause;
 const aPGClause: IdaFromClause): IdaJoin;
var
 l_Inst : TcaFromClause;
begin
 l_Inst := Create(aFactory, aHTClause, aPGClause);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TcaFromClause.Make

function TcaFromClause.BuildSQLValue(const aHelper: IdaParamListHelper): AnsiString;
//#UC START# *5608E5F20118_574D5A9900B6_var*
//#UC END# *5608E5F20118_574D5A9900B6_var*
begin
//#UC START# *5608E5F20118_574D5A9900B6_impl*
 Result := f_HTClause.BuildSQLValue(aHelper);
 Assert(Result = f_PGClause.BuildSQLValue(aHelper));
//#UC END# *5608E5F20118_574D5A9900B6_impl*
end;//TcaFromClause.BuildSQLValue

function TcaFromClause.HasTable(const aTable: IdaTableDescription): Boolean;
//#UC START# *57442BFD03BE_574D5A9900B6_var*
//#UC END# *57442BFD03BE_574D5A9900B6_var*
begin
//#UC START# *57442BFD03BE_574D5A9900B6_impl*
 Result := f_HTClause.HasTable(aTable);
 Assert(Result = f_PGClause.HasTable(aTable));
//#UC END# *57442BFD03BE_574D5A9900B6_impl*
end;//TcaFromClause.HasTable

function TcaFromClause.FindTable(const aTableAlias: AnsiString): IdaFromTable;
//#UC START# *5744366C003B_574D5A9900B6_var*
//#UC END# *5744366C003B_574D5A9900B6_var*
begin
//#UC START# *5744366C003B_574D5A9900B6_impl*
 Result := f_HTClause.FindTable(aTableAlias);
 Assert(Result = f_PGClause.FindTable(aTableAlias));
//#UC END# *5744366C003B_574D5A9900B6_impl*
end;//TcaFromClause.FindTable

procedure TcaFromClause.IterateTablesF(anAction: daFromClauseIterator_IterateTablesF_Action);
//#UC START# *574443A401BE_574D5A9900B6_var*
//#UC END# *574443A401BE_574D5A9900B6_var*
begin
//#UC START# *574443A401BE_574D5A9900B6_impl*
 f_HTClause.IterateTablesF(anAction);
//!! !!! Needs to be implemented !!! Что с PGClause;
//#UC END# *574443A401BE_574D5A9900B6_impl*
end;//TcaFromClause.IterateTablesF

function TcaFromClause.Get_Left: IdaFromClause;
//#UC START# *57456F6B01D2_574D5A9900B6get_var*
var
 l_HTJoin: IdaJoin;
 l_PGJoin: IdaJoin;
//#UC END# *57456F6B01D2_574D5A9900B6get_var*
begin
//#UC START# *57456F6B01D2_574D5A9900B6get_impl*
 if Supports(f_HTClause, IdaJoin, l_HTJoin) and Supports(f_PGClause, IdaJoin, l_PGJoin) then
  Result := TcaFromClause.Make(f_Factory, l_HTJoin.Left, l_PGJoin.Left) as IdaFromClause
 else
  Result := nil;
//#UC END# *57456F6B01D2_574D5A9900B6get_impl*
end;//TcaFromClause.Get_Left

function TcaFromClause.Get_Right: IdaFromClause;
//#UC START# *57456F800124_574D5A9900B6get_var*
var
 l_HTJoin: IdaJoin;
 l_PGJoin: IdaJoin;
//#UC END# *57456F800124_574D5A9900B6get_var*
begin
//#UC START# *57456F800124_574D5A9900B6get_impl*
 if Supports(f_HTClause, IdaJoin, l_HTJoin) and Supports(f_PGClause, IdaJoin, l_PGJoin) then
  Result := TcaFromClause.Make(f_Factory, l_HTJoin.Right, l_PGJoin.Right) as IdaFromClause
 else
  Result := nil;
//#UC END# *57456F800124_574D5A9900B6get_impl*
end;//TcaFromClause.Get_Right

function TcaFromClause.Get_Kind: TdaJoinKind;
//#UC START# *5745700A0180_574D5A9900B6get_var*
var
 l_HTJoin: IdaJoin;
 l_PGJoin: IdaJoin;
//#UC END# *5745700A0180_574D5A9900B6get_var*
begin
//#UC START# *5745700A0180_574D5A9900B6get_impl*
 if Supports(f_HTClause, IdaJoin, l_HTJoin) and Supports(f_PGClause, IdaJoin, l_PGJoin) then
 begin
  Result := l_HTJoin.Kind;
  Assert(Result = l_PGJoin.Kind);
 end
 else
  Result := da_jkInner;
//#UC END# *5745700A0180_574D5A9900B6get_impl*
end;//TcaFromClause.Get_Kind

function TcaFromClause.Get_Condition: IdaCondition;
//#UC START# *5745702503A6_574D5A9900B6get_var*
var
 l_HTJoin: IdaJoin;
//#UC END# *5745702503A6_574D5A9900B6get_var*
begin
//#UC START# *5745702503A6_574D5A9900B6get_impl*
 if Supports(f_HTClause, IdaJoin, l_HTJoin) then
  Result := l_HTJoin.Condition
 else
  Result := nil;
//#UC END# *5745702503A6_574D5A9900B6get_impl*
end;//TcaFromClause.Get_Condition

function TcaFromClause.SetCondition(const aCondition: IdaCondition): IdaFromClause;
//#UC START# *574570520193_574D5A9900B6_var*
var
 l_HTJoin: IdaJoin;
 l_PGJoin: IdaJoin;
//#UC END# *574570520193_574D5A9900B6_var*
begin
//#UC START# *574570520193_574D5A9900B6_impl*
 if Supports(f_HTClause, IdaJoin, l_HTJoin) and Supports(f_PGClause, IdaJoin, l_PGJoin) then
 begin
  l_HTJoin.SetCondition(aCondition);
  l_PGJoin.SetCondition(aCondition);
  Result := Self;
 end;
//#UC END# *574570520193_574D5A9900B6_impl*
end;//TcaFromClause.SetCondition

function TcaFromClause.Join(const aRight: IdaFromClause;
 aKind: TdaJoinKind): IdaJoin;
//#UC START# *574570790329_574D5A9900B6_var*
//#UC END# *574570790329_574D5A9900B6_var*
begin
//#UC START# *574570790329_574D5A9900B6_impl*
 Result := f_Factory.MakeJoin(Self, aRight, aKind);
//#UC END# *574570790329_574D5A9900B6_impl*
end;//TcaFromClause.Join

function TcaFromClause.IsRelationsConditionsValid: Boolean;
//#UC START# *57480BE20140_574D5A9900B6_var*
//#UC END# *57480BE20140_574D5A9900B6_var*
begin
//#UC START# *57480BE20140_574D5A9900B6_impl*
 Result := f_HTClause.IsRelationsConditionsValid;
 Assert(Result = f_PGClause.IsRelationsConditionsValid);
//#UC END# *57480BE20140_574D5A9900B6_impl*
end;//TcaFromClause.IsRelationsConditionsValid

procedure TcaFromClause.IterateRelationConditionsF(anAction: daFromClauseIterator_IterateRelationConditionsF_Action);
//#UC START# *574824090133_574D5A9900B6_var*
//#UC END# *574824090133_574D5A9900B6_var*
begin
//#UC START# *574824090133_574D5A9900B6_impl*
 f_HTClause.IterateRelationConditionsF(anAction);
//!! !!! Needs to be implemented !!! Что с PGClause;
//#UC END# *574824090133_574D5A9900B6_impl*
end;//TcaFromClause.IterateRelationConditionsF

function TcaFromClause.Get_HTClause: IdaFromClause;
//#UC START# *574D5A4C0298_574D5A9900B6get_var*
//#UC END# *574D5A4C0298_574D5A9900B6get_var*
begin
//#UC START# *574D5A4C0298_574D5A9900B6get_impl*
 Result := f_HTClause;
//#UC END# *574D5A4C0298_574D5A9900B6get_impl*
end;//TcaFromClause.Get_HTClause

function TcaFromClause.Get_PGClause: IdaFromClause;
//#UC START# *574D5A61018D_574D5A9900B6get_var*
//#UC END# *574D5A61018D_574D5A9900B6get_var*
begin
//#UC START# *574D5A61018D_574D5A9900B6get_impl*
 Result := f_PGClause;
//#UC END# *574D5A61018D_574D5A9900B6get_impl*
end;//TcaFromClause.Get_PGClause

procedure TcaFromClause.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_574D5A9900B6_var*
//#UC END# *479731C50290_574D5A9900B6_var*
begin
//#UC START# *479731C50290_574D5A9900B6_impl*
 f_HTClause := nil;
 f_PGClause := nil;
 f_Factory := nil;;
 inherited;
//#UC END# *479731C50290_574D5A9900B6_impl*
end;//TcaFromClause.Cleanup
{$IfEnd} // Defined(UsePostgres) AND Defined(TestComboAccess)

end.
