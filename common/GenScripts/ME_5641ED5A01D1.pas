unit daSubQueryCondition;

// Модуль: "w:\common\components\rtl\Garant\DA\daSubQueryCondition.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TdaSubQueryCondition" MUID: (5641ED5A01D1)

{$Include w:\common\components\rtl\Garant\DA\daDefine.inc}

interface

uses
 l3IntfUses
 , daCondition
 , daInterfaces
;

type
 TdaSubQueryCondition = class(TdaCondition)
  private
   f_TableAlias: AnsiString;
   f_Field: IdaFieldDescription;
   f_SubQuery: IdaTabledQuery;
  protected
   function DoBuildSQL(const aHelper: IdaParamListHelper): AnsiString; override;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(const aTableAlias: AnsiString;
    const aField: IdaFieldDescription;
    const aQuery: IdaTabledQuery); reintroduce;
   class function Make(const aTableAlias: AnsiString;
    const aField: IdaFieldDescription;
    const aQuery: IdaTabledQuery): IdaCondition; reintroduce;
   procedure Iterate(anAction: daConditionIterator_Iterate_Action); override;
 end;//TdaSubQueryCondition

implementation

uses
 l3ImplUses
 , SysUtils
;

constructor TdaSubQueryCondition.Create(const aTableAlias: AnsiString;
 const aField: IdaFieldDescription;
 const aQuery: IdaTabledQuery);
//#UC START# *5641ED7401B8_5641ED5A01D1_var*
//#UC END# *5641ED7401B8_5641ED5A01D1_var*
begin
//#UC START# *5641ED7401B8_5641ED5A01D1_impl*
 inherited Create;
 f_TableAlias := aTableAlias;
 f_Field := aField;
 f_SubQuery := aQuery;
//#UC END# *5641ED7401B8_5641ED5A01D1_impl*
end;//TdaSubQueryCondition.Create

class function TdaSubQueryCondition.Make(const aTableAlias: AnsiString;
 const aField: IdaFieldDescription;
 const aQuery: IdaTabledQuery): IdaCondition;
var
 l_Inst : TdaSubQueryCondition;
begin
 l_Inst := Create(aTableAlias, aField, aQuery);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TdaSubQueryCondition.Make

procedure TdaSubQueryCondition.Iterate(anAction: daConditionIterator_Iterate_Action);
//#UC START# *56F3AB4F0096_5641ED5A01D1_var*
//#UC END# *56F3AB4F0096_5641ED5A01D1_var*
begin
//#UC START# *56F3AB4F0096_5641ED5A01D1_impl*
 !!! Needs to be implemented !!!
//#UC END# *56F3AB4F0096_5641ED5A01D1_impl*
end;//TdaSubQueryCondition.Iterate

function TdaSubQueryCondition.DoBuildSQL(const aHelper: IdaParamListHelper): AnsiString;
//#UC START# *56408E7F01A1_5641ED5A01D1_var*
//#UC END# *56408E7F01A1_5641ED5A01D1_var*
begin
//#UC START# *56408E7F01A1_5641ED5A01D1_impl*
 if f_TableAlias <> '' then
  Result := Format('%s.%s', [f_TableAlias, f_Field.SQLName])
 else
  Result := f_Field.SQLName;
 Result := Format('%s in (%s)', [Result, f_SubQuery.BuildSQLValue(aHelper)]);
//#UC END# *56408E7F01A1_5641ED5A01D1_impl*
end;//TdaSubQueryCondition.DoBuildSQL

procedure TdaSubQueryCondition.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_5641ED5A01D1_var*
//#UC END# *479731C50290_5641ED5A01D1_var*
begin
//#UC START# *479731C50290_5641ED5A01D1_impl*
 f_Field := nil;
 f_SubQuery := nil;
 inherited;
//#UC END# *479731C50290_5641ED5A01D1_impl*
end;//TdaSubQueryCondition.Cleanup

end.
