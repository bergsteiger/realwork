unit daSubQueryCondition;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DA"
// Модуль: "w:/common/components/rtl/Garant/DA/daSubQueryCondition.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::DA::Provider::TdaSubQueryCondition
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\DA\daDefine.inc}

interface

uses
  daInterfaces,
  daCondition
  ;

type
 TdaSubQueryCondition = class(TdaCondition)
 private
 // private fields
   f_TableAlias : AnsiString;
   f_Field : IdaFieldDescription;
   f_SubQuery : IdaTabledQuery;
 protected
 // realized methods
   function DoBuildSQL(const aHelper: IdaParamListHelper): AnsiString; override;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public methods
   constructor Create(const aTableAlias: AnsiString;
     const aField: IdaFieldDescription;
     const aQuery: IdaTabledQuery); reintroduce;
   class function Make(const aTableAlias: AnsiString;
     const aField: IdaFieldDescription;
     const aQuery: IdaTabledQuery): IdaCondition; reintroduce;
     {* Сигнатура фабрики TdaSubQueryCondition.Make }
 end;//TdaSubQueryCondition

implementation

uses
  l3Base,
  SysUtils
  ;

// start class TdaSubQueryCondition

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
end;

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