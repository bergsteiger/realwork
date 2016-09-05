unit daBitwiseCondition;

// Модуль: "w:\common\components\rtl\Garant\DA\daBitwiseCondition.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TdaBitwiseCondition" MUID: (57A9AF120166)

{$Include w:\common\components\rtl\Garant\DA\daDefine.inc}

interface

uses
 l3IntfUses
 , daCondition
 , daInterfaces
 , daTypes
;

type
 TdaBitwiseCondition = class(TdaCondition, IdaFieldFromTable, IdaBitwiseCondition)
  private
   f_TableAlias: AnsiString;
   f_Field: IdaFieldDescription;
   f_Operator: TdaBitwiseOperator;
   f_Value: Int64;
  protected
   function Get_TableAlias: AnsiString;
   function Get_Field: IdaFieldDescription;
   function DoBuildSQL(const aHelper: IdaParamListHelper): AnsiString; override;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(const aTableAlias: AnsiString;
    const aField: IdaFieldDescription;
    anOperation: TdaBitwiseOperator;
    aValue: Int64); reintroduce;
   class function Make(const aTableAlias: AnsiString;
    const aField: IdaFieldDescription;
    anOperation: TdaBitwiseOperator;
    aValue: Int64): IdaCondition; reintroduce;
 end;//TdaBitwiseCondition

implementation

uses
 l3ImplUses
 //#UC START# *57A9AF120166impl_uses*
, SysUtils
 //#UC END# *57A9AF120166impl_uses*
;

constructor TdaBitwiseCondition.Create(const aTableAlias: AnsiString;
 const aField: IdaFieldDescription;
 anOperation: TdaBitwiseOperator;
 aValue: Int64);
//#UC START# *57A9AF460222_57A9AF120166_var*
//#UC END# *57A9AF460222_57A9AF120166_var*
begin
//#UC START# *57A9AF460222_57A9AF120166_impl*
 Assert(aField.DataType in da_dtIntegers);
 inherited Create;
 f_TableAlias := aTableAlias;
 f_Field := aField;
 f_Operator := anOperation;
 f_Value := aValue;
//#UC END# *57A9AF460222_57A9AF120166_impl*
end;//TdaBitwiseCondition.Create

class function TdaBitwiseCondition.Make(const aTableAlias: AnsiString;
 const aField: IdaFieldDescription;
 anOperation: TdaBitwiseOperator;
 aValue: Int64): IdaCondition;
var
 l_Inst : TdaBitwiseCondition;
begin
 l_Inst := Create(aTableAlias, aField, anOperation, aValue);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TdaBitwiseCondition.Make

function TdaBitwiseCondition.Get_TableAlias: AnsiString;
//#UC START# *555351D702B3_57A9AF120166get_var*
//#UC END# *555351D702B3_57A9AF120166get_var*
begin
//#UC START# *555351D702B3_57A9AF120166get_impl*
 Result := f_TableAlias;
//#UC END# *555351D702B3_57A9AF120166get_impl*
end;//TdaBitwiseCondition.Get_TableAlias

function TdaBitwiseCondition.Get_Field: IdaFieldDescription;
//#UC START# *555351F500BC_57A9AF120166get_var*
//#UC END# *555351F500BC_57A9AF120166get_var*
begin
//#UC START# *555351F500BC_57A9AF120166get_impl*
 Result := f_Field;
//#UC END# *555351F500BC_57A9AF120166get_impl*
end;//TdaBitwiseCondition.Get_Field

function TdaBitwiseCondition.DoBuildSQL(const aHelper: IdaParamListHelper): AnsiString;
//#UC START# *56408E7F01A1_57A9AF120166_var*
const
  cMap: array [TdaBitwiseOperator] of String = (
   '&', // da_bwAnd
   '|'  // da_bwOr
  );
//#UC END# *56408E7F01A1_57A9AF120166_var*
begin
//#UC START# *56408E7F01A1_57A9AF120166_impl*
 if f_TableAlias <> '' then
  Result := Format('%s.%s', [f_TableAlias, f_Field.SQLName])
 else
  Result := f_Field.SQLName;
 Result := Format('%s %s %s', [Result, cMap[f_Operator], IntToStr(f_Value)]);
//#UC END# *56408E7F01A1_57A9AF120166_impl*
end;//TdaBitwiseCondition.DoBuildSQL

procedure TdaBitwiseCondition.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_57A9AF120166_var*
//#UC END# *479731C50290_57A9AF120166_var*
begin
//#UC START# *479731C50290_57A9AF120166_impl*
 f_Field := nil;
 inherited;
//#UC END# *479731C50290_57A9AF120166_impl*
end;//TdaBitwiseCondition.Cleanup

end.
