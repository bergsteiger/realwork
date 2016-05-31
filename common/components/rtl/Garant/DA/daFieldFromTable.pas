unit daFieldFromTable;

// Модуль: "w:\common\components\rtl\Garant\DA\daFieldFromTable.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TdaFieldFromTable" MUID: (574C12B400EA)

{$Include w:\common\components\rtl\Garant\DA\daDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , daInterfaces
;

type
 TdaFieldFromTable = class(Tl3ProtoObject, IdaFieldFromTable)
  private
   f_TableAlias: AnsiString;
   f_Field: IdaFieldDescription;
  protected
   function Get_TableAlias: AnsiString;
   function Get_Field: IdaFieldDescription;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(const aTableAlias: AnsiString;
    const aField: IdaFieldDescription); reintroduce;
   class function Make(const aTableAlias: AnsiString;
    const aField: IdaFieldDescription): IdaFieldFromTable; reintroduce;
 end;//TdaFieldFromTable

implementation

uses
 l3ImplUses
;

constructor TdaFieldFromTable.Create(const aTableAlias: AnsiString;
 const aField: IdaFieldDescription);
//#UC START# *574C12D70130_574C12B400EA_var*
//#UC END# *574C12D70130_574C12B400EA_var*
begin
//#UC START# *574C12D70130_574C12B400EA_impl*
 inherited Create;
 f_TableAlias := aTableAlias;
 f_Field := aField;
//#UC END# *574C12D70130_574C12B400EA_impl*
end;//TdaFieldFromTable.Create

class function TdaFieldFromTable.Make(const aTableAlias: AnsiString;
 const aField: IdaFieldDescription): IdaFieldFromTable;
var
 l_Inst : TdaFieldFromTable;
begin
 l_Inst := Create(aTableAlias, aField);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TdaFieldFromTable.Make

function TdaFieldFromTable.Get_TableAlias: AnsiString;
//#UC START# *555351D702B3_574C12B400EAget_var*
//#UC END# *555351D702B3_574C12B400EAget_var*
begin
//#UC START# *555351D702B3_574C12B400EAget_impl*
 Result := f_TableAlias;
//#UC END# *555351D702B3_574C12B400EAget_impl*
end;//TdaFieldFromTable.Get_TableAlias

function TdaFieldFromTable.Get_Field: IdaFieldDescription;
//#UC START# *555351F500BC_574C12B400EAget_var*
//#UC END# *555351F500BC_574C12B400EAget_var*
begin
//#UC START# *555351F500BC_574C12B400EAget_impl*
 Result := f_Field;
//#UC END# *555351F500BC_574C12B400EAget_impl*
end;//TdaFieldFromTable.Get_Field

procedure TdaFieldFromTable.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_574C12B400EA_var*
//#UC END# *479731C50290_574C12B400EA_var*
begin
//#UC START# *479731C50290_574C12B400EA_impl*
 f_Field := nil;
 inherited;
//#UC END# *479731C50290_574C12B400EA_impl*
end;//TdaFieldFromTable.Cleanup

end.
