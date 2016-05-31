unit daJoinCondition;

// Модуль: "w:\common\components\rtl\Garant\DA\daJoinCondition.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TdaJoinCondition" MUID: (574BF18D0334)

{$Include w:\common\components\rtl\Garant\DA\daDefine.inc}

interface

uses
 l3IntfUses
 , daCondition
 , daInterfaces
;

type
 TdaJoinCondition = class(TdaCondition, IdaJoinCondition)
  private
   f_Left: IdaFieldFromTable;
   f_Right: IdaFieldFromTable;
  protected
   function DoBuildSQL(const aHelper: IdaParamListHelper): AnsiString; override;
   function Get_Left: IdaFieldFromTable;
   function Get_Right: IdaFieldFromTable;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(const aLeftTableAlias: AnsiString;
    const aLeftField: IdaFieldDescription;
    const aRightTableAlias: AnsiString;
    const aRightField: IdaFieldDescription); reintroduce;
   class function Make(const aLeftTableAlias: AnsiString;
    const aLeftField: IdaFieldDescription;
    const aRightTableAlias: AnsiString;
    const aRightField: IdaFieldDescription): IdaCondition; reintroduce;
 end;//TdaJoinCondition

implementation

uses
 l3ImplUses
 , daFieldFromTable
 , SysUtils
;

constructor TdaJoinCondition.Create(const aLeftTableAlias: AnsiString;
 const aLeftField: IdaFieldDescription;
 const aRightTableAlias: AnsiString;
 const aRightField: IdaFieldDescription);
//#UC START# *574BF1E70240_574BF18D0334_var*
//#UC END# *574BF1E70240_574BF18D0334_var*
begin
//#UC START# *574BF1E70240_574BF18D0334_impl*
 inherited Create;
 f_Left := TdaFieldFromTable.Make(aLeftTableAlias, aLeftField);
 f_Right := TdaFieldFromTable.Make(aRightTableAlias, aRightField);
//#UC END# *574BF1E70240_574BF18D0334_impl*
end;//TdaJoinCondition.Create

class function TdaJoinCondition.Make(const aLeftTableAlias: AnsiString;
 const aLeftField: IdaFieldDescription;
 const aRightTableAlias: AnsiString;
 const aRightField: IdaFieldDescription): IdaCondition;
var
 l_Inst : TdaJoinCondition;
begin
 l_Inst := Create(aLeftTableAlias, aLeftField, aRightTableAlias, aRightField);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TdaJoinCondition.Make

function TdaJoinCondition.DoBuildSQL(const aHelper: IdaParamListHelper): AnsiString;
//#UC START# *56408E7F01A1_574BF18D0334_var*
//#UC END# *56408E7F01A1_574BF18D0334_var*
begin
//#UC START# *56408E7F01A1_574BF18D0334_impl*
 Result := Format('%s.%s = %s.%s', [f_Left.TableAlias, f_Left.Field.SQLName, f_Right.TableAlias, f_Right.Field.SQLName]);
//#UC END# *56408E7F01A1_574BF18D0334_impl*
end;//TdaJoinCondition.DoBuildSQL

function TdaJoinCondition.Get_Left: IdaFieldFromTable;
//#UC START# *574BF119004B_574BF18D0334get_var*
//#UC END# *574BF119004B_574BF18D0334get_var*
begin
//#UC START# *574BF119004B_574BF18D0334get_impl*
 Result := f_Left;
//#UC END# *574BF119004B_574BF18D0334get_impl*
end;//TdaJoinCondition.Get_Left

function TdaJoinCondition.Get_Right: IdaFieldFromTable;
//#UC START# *574BF1300180_574BF18D0334get_var*
//#UC END# *574BF1300180_574BF18D0334get_var*
begin
//#UC START# *574BF1300180_574BF18D0334get_impl*
 Result := f_Right;
//#UC END# *574BF1300180_574BF18D0334get_impl*
end;//TdaJoinCondition.Get_Right

procedure TdaJoinCondition.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_574BF18D0334_var*
//#UC END# *479731C50290_574BF18D0334_var*
begin
//#UC START# *479731C50290_574BF18D0334_impl*
 f_Left := nil;
 f_Right := nil;
 inherited;
//#UC END# *479731C50290_574BF18D0334_impl*
end;//TdaJoinCondition.Cleanup

end.
