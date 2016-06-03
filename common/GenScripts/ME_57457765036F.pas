unit daJoin;

// Модуль: "w:\common\components\rtl\Garant\DA\daJoin.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TdaJoin" MUID: (57457765036F)

{$Include w:\common\components\rtl\Garant\DA\daDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , daInterfaces
 , daTypes
;

type
 TdaJoin = class(Tl3ProtoObject, IdaFromClause, IdaJoin)
  private
   f_Left: IdaFromClause;
   f_Factory: IdaTableQueryFactory;
   f_Condition: IdaCondition;
   f_Kind: TdaJoinKind;
   f_Right: IdaFromClause;
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
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(const aFactory: IdaTableQueryFactory;
    const aLeft: IdaFromClause;
    const aRight: IdaFromClause;
    aKind: TdaJoinKind); reintroduce;
   class function Make(const aFactory: IdaTableQueryFactory;
    const aLeft: IdaFromClause;
    const aRight: IdaFromClause;
    aKind: TdaJoinKind): IdaJoin; reintroduce;
   procedure IterateTablesF(anAction: daFromClauseIterator_IterateTablesF_Action);
   procedure IterateRelationConditionsF(anAction: daFromClauseIterator_IterateRelationConditionsF_Action);
 end;//TdaJoin

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
;

constructor TdaJoin.Create(const aFactory: IdaTableQueryFactory;
 const aLeft: IdaFromClause;
 const aRight: IdaFromClause;
 aKind: TdaJoinKind);
//#UC START# *5745778600BC_57457765036F_var*
//#UC END# *5745778600BC_57457765036F_var*
begin
//#UC START# *5745778600BC_57457765036F_impl*
 inherited Create;
 f_Factory := aFactory;
 f_Left := aLeft;
 f_Right := aRight;
 f_Kind := aKind;
//#UC END# *5745778600BC_57457765036F_impl*
end;//TdaJoin.Create

class function TdaJoin.Make(const aFactory: IdaTableQueryFactory;
 const aLeft: IdaFromClause;
 const aRight: IdaFromClause;
 aKind: TdaJoinKind): IdaJoin;
var
 l_Inst : TdaJoin;
begin
 l_Inst := Create(aFactory, aLeft, aRight, aKind);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TdaJoin.Make

function TdaJoin.BuildSQLValue(const aHelper: IdaParamListHelper): AnsiString;
//#UC START# *5608E5F20118_57457765036F_var*
const
 cMap: array [TdaJoinKind] of String = (
  'INNER JOIN', // da_jkInner
  'LEFT OUTER JOIN', // da_jkLeftOuter
  'RIGHT OUTER JOIN', // da_jkRightOuter
  'FULL OUTER JOIN' // da_jkFullOuter
 );
//#UC END# *5608E5F20118_57457765036F_var*
begin
//#UC START# *5608E5F20118_57457765036F_impl*
 Result := Format('%s %s %s on (%s)', [f_Left.BuildSQLValue(aHelper), cMap[f_Kind], f_Right.BuildSQLValue(aHelper), f_Condition.BuildSQLValue(aHelper)]);
//#UC END# *5608E5F20118_57457765036F_impl*
end;//TdaJoin.BuildSQLValue

function TdaJoin.HasTable(const aTable: IdaTableDescription): Boolean;
//#UC START# *57442BFD03BE_57457765036F_var*
//#UC END# *57442BFD03BE_57457765036F_var*
begin
//#UC START# *57442BFD03BE_57457765036F_impl*
 Result := (f_Left as IdaFromClause).HasTable(aTable);
 if not Result then
  Result := (f_Right as IdaFromClause).HasTable(aTable);
//#UC END# *57442BFD03BE_57457765036F_impl*
end;//TdaJoin.HasTable

function TdaJoin.FindTable(const aTableAlias: AnsiString): IdaFromTable;
//#UC START# *5744366C003B_57457765036F_var*
//#UC END# *5744366C003B_57457765036F_var*
begin
//#UC START# *5744366C003B_57457765036F_impl*
 Result := (f_Left as IdaFromClause).FindTable(ATableAlias);
 if Result = nil then
  Result := (f_Right as IdaFromClause).FindTable(ATableAlias);
//#UC END# *5744366C003B_57457765036F_impl*
end;//TdaJoin.FindTable

procedure TdaJoin.IterateTablesF(anAction: daFromClauseIterator_IterateTablesF_Action);
//#UC START# *574443A401BE_57457765036F_var*
var
 Hack : Pointer absolute anAction;
 l_Continue: Boolean;

 function DoIt(const anItem: IdaFromTable): Boolean;
 begin
  Result := anAction(anItem);
  if not Result then
   l_Continue := False;
 end;
 
//#UC END# *574443A401BE_57457765036F_var*
begin
//#UC START# *574443A401BE_57457765036F_impl*
 try
  l_Continue := True;
  f_Left.IterateTablesF(L2daFromClauseIteratorIterateTablesFAction(@DoIt));
  if l_Continue then
   f_Right.IterateTablesF(anAction);
 finally
  l3FreeLocalStub(Hack);
 end;//try..finally
//#UC END# *574443A401BE_57457765036F_impl*
end;//TdaJoin.IterateTablesF

function TdaJoin.Get_Left: IdaFromClause;
//#UC START# *57456F6B01D2_57457765036Fget_var*
//#UC END# *57456F6B01D2_57457765036Fget_var*
begin
//#UC START# *57456F6B01D2_57457765036Fget_impl*
 Result := f_Left;
//#UC END# *57456F6B01D2_57457765036Fget_impl*
end;//TdaJoin.Get_Left

function TdaJoin.Get_Right: IdaFromClause;
//#UC START# *57456F800124_57457765036Fget_var*
//#UC END# *57456F800124_57457765036Fget_var*
begin
//#UC START# *57456F800124_57457765036Fget_impl*
 Result := f_Right;
//#UC END# *57456F800124_57457765036Fget_impl*
end;//TdaJoin.Get_Right

function TdaJoin.Get_Kind: TdaJoinKind;
//#UC START# *5745700A0180_57457765036Fget_var*
//#UC END# *5745700A0180_57457765036Fget_var*
begin
//#UC START# *5745700A0180_57457765036Fget_impl*
 Result := f_Kind;
//#UC END# *5745700A0180_57457765036Fget_impl*
end;//TdaJoin.Get_Kind

function TdaJoin.Get_Condition: IdaCondition;
//#UC START# *5745702503A6_57457765036Fget_var*
//#UC END# *5745702503A6_57457765036Fget_var*
begin
//#UC START# *5745702503A6_57457765036Fget_impl*
 Result := f_Condition;
//#UC END# *5745702503A6_57457765036Fget_impl*
end;//TdaJoin.Get_Condition

function TdaJoin.SetCondition(const aCondition: IdaCondition): IdaFromClause;
//#UC START# *574570520193_57457765036F_var*
//#UC END# *574570520193_57457765036F_var*
begin
//#UC START# *574570520193_57457765036F_impl*
 f_Condition := aCondition;
 Assert(IsRelationsConditionsValid);
//#UC END# *574570520193_57457765036F_impl*
end;//TdaJoin.SetCondition

function TdaJoin.Join(const aRight: IdaFromClause;
 aKind: TdaJoinKind): IdaJoin;
//#UC START# *574570790329_57457765036F_var*
//#UC END# *574570790329_57457765036F_var*
begin
//#UC START# *574570790329_57457765036F_impl*
 Result := f_Factory.MakeJoin(Self, aRight, aKind);
//#UC END# *574570790329_57457765036F_impl*
end;//TdaJoin.Join

function TdaJoin.IsRelationsConditionsValid: Boolean;
//#UC START# *57480BE20140_57457765036F_var*

 function lp_ProcessCondition(const anItem: IdaCondition): Boolean;
 var
  l_Field: IdaFieldFromTable;
 begin
  Result := True;
  if Supports(anItem, IdaFieldFromTable, l_Field) then
   Assert(HasTable(l_Field.Field.Table));
 end;

//#UC END# *57480BE20140_57457765036F_var*
begin
//#UC START# *57480BE20140_57457765036F_impl*
 Assert(Assigned(f_Condition));
 Result := f_Left.IsRelationsConditionsValid;
 if Result then
 begin
  Result := f_Right.IsRelationsConditionsValid;
  if Result then
   f_Condition.IterateF(L2DaConditionIteratorIterateAction(@lp_ProcessCondition));
 end;
//#UC END# *57480BE20140_57457765036F_impl*
end;//TdaJoin.IsRelationsConditionsValid

procedure TdaJoin.IterateRelationConditionsF(anAction: daFromClauseIterator_IterateRelationConditionsF_Action);
//#UC START# *574824090133_57457765036F_var*

var
 Hack : Pointer absolute anAction;
 l_Continue: Boolean;

 function lp_ProcessCondition(const anItem: IdaCondition): Boolean;
 var
  l_Field: IdaFieldFromTable;
 begin
  Result := anAction(anItem);
  if not Result then
   l_Continue := False;
 end;

 function DoIt(const anItem: IdaCondition): Boolean;
 begin
  Result := anAction(anItem);
  if not Result then
   l_Continue := False;
 end;

//#UC END# *574824090133_57457765036F_var*
begin
//#UC START# *574824090133_57457765036F_impl*
 try
  l_Continue := True;
  f_Left.IterateRelationConditionsF(L2daFromClauseIteratorIterateRelationConditionsFAction(@DoIt));
  if l_Continue then
  begin
   f_Right.IterateRelationConditionsF(L2daFromClauseIteratorIterateRelationConditionsFAction(@DoIt));
   if l_Continue then
    f_Condition.IterateF(L2DaConditionIteratorIterateAction(@lp_ProcessCondition));
  end;
 finally
  l3FreeLocalStub(Hack);
 end;
//#UC END# *574824090133_57457765036F_impl*
end;//TdaJoin.IterateRelationConditionsF

procedure TdaJoin.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_57457765036F_var*
//#UC END# *479731C50290_57457765036F_var*
begin
//#UC START# *479731C50290_57457765036F_impl*
 f_Condition := nil;
 f_Left := nil;
 f_Right := nil;
 f_Factory := nil;
 inherited Cleanup;
//#UC END# *479731C50290_57457765036F_impl*
end;//TdaJoin.Cleanup

end.
