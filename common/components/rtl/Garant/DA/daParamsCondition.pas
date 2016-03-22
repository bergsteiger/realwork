unit daParamsCondition;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DA"
// Модуль: "w:/common/components/rtl/Garant/DA/daParamsCondition.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::DA::Provider::TdaParamsCondition
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\DA\daDefine.inc}

interface

uses
  daTypes,
  daInterfaces,
  daCondition
  ;

type
 TdaParamsCondition = class(TdaCondition, IdaFieldFromTable, IdaParamDescription, IdaAtomicCondition)
 private
 // private fields
   f_Field : IdaFieldDescription;
   f_TableAlias : AnsiString;
   f_ParamName : AnsiString;
   f_Operation : TdaCompareOperation;
 private
 // private methods
   function AddCaseInsensetive(const aStr: AnsiString): AnsiString;
 protected
 // realized methods
   function Get_TableAlias: AnsiString;
   function Get_Field: IdaFieldDescription;
   function Get_Name: AnsiString;
   function Get_DataType: TdaDataType;
   function Get_Size: Integer;
   function Get_Operation: TdaCompareOperation;
   function DoBuildSQL(const aHelper: IdaParamListHelper): AnsiString; override;
   function Get_ParamType: TdaParamType;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public methods
   constructor Create(const aTableAlias: AnsiString;
     const aField: IdaFieldDescription;
     anOperation: TdaCompareOperation;
     const aParamName: AnsiString); reintroduce;
   class function Make(const aTableAlias: AnsiString;
     const aField: IdaFieldDescription;
     anOperation: TdaCompareOperation;
     const aParamName: AnsiString): IdaCondition; reintroduce;
     {* Сигнатура фабрики TdaParamsCondition.Make }
 end;//TdaParamsCondition

implementation

uses
  l3Base,
  SysUtils
  ;

// start class TdaParamsCondition

function TdaParamsCondition.AddCaseInsensetive(const aStr: AnsiString): AnsiString;
//#UC START# *562DE57001BE_5551DD0F02A1_var*
//#UC END# *562DE57001BE_5551DD0F02A1_var*
begin
//#UC START# *562DE57001BE_5551DD0F02A1_impl*
 if f_Field.DataType = da_dtChar then
  Result := Format('UPPER(%s)', [aStr])
 else
  Result := aStr;
//#UC END# *562DE57001BE_5551DD0F02A1_impl*
end;//TdaParamsCondition.AddCaseInsensetive

constructor TdaParamsCondition.Create(const aTableAlias: AnsiString;
  const aField: IdaFieldDescription;
  anOperation: TdaCompareOperation;
  const aParamName: AnsiString);
//#UC START# *5552FC6E01D4_5551DD0F02A1_var*
//#UC END# *5552FC6E01D4_5551DD0F02A1_var*
begin
//#UC START# *5552FC6E01D4_5551DD0F02A1_impl*
 inherited Create;
 f_Field := aField;
 f_TableAlias := aTableAlias;
 f_ParamName := aParamName;
 f_Operation := anOperation;
//#UC END# *5552FC6E01D4_5551DD0F02A1_impl*
end;//TdaParamsCondition.Create

class function TdaParamsCondition.Make(const aTableAlias: AnsiString;
  const aField: IdaFieldDescription;
  anOperation: TdaCompareOperation;
  const aParamName: AnsiString): IdaCondition;
var
 l_Inst : TdaParamsCondition;
begin
 l_Inst := Create(aTableAlias, aField, anOperation, aParamName);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TdaParamsCondition.Get_TableAlias: AnsiString;
//#UC START# *555351D702B3_5551DD0F02A1get_var*
//#UC END# *555351D702B3_5551DD0F02A1get_var*
begin
//#UC START# *555351D702B3_5551DD0F02A1get_impl*
 Result := f_TableAlias;
//#UC END# *555351D702B3_5551DD0F02A1get_impl*
end;//TdaParamsCondition.Get_TableAlias

function TdaParamsCondition.Get_Field: IdaFieldDescription;
//#UC START# *555351F500BC_5551DD0F02A1get_var*
//#UC END# *555351F500BC_5551DD0F02A1get_var*
begin
//#UC START# *555351F500BC_5551DD0F02A1get_impl*
 Result := f_Field;
//#UC END# *555351F500BC_5551DD0F02A1get_impl*
end;//TdaParamsCondition.Get_Field

function TdaParamsCondition.Get_Name: AnsiString;
//#UC START# *5555C5620242_5551DD0F02A1get_var*
//#UC END# *5555C5620242_5551DD0F02A1get_var*
begin
//#UC START# *5555C5620242_5551DD0F02A1get_impl*
 Result := f_ParamName;
//#UC END# *5555C5620242_5551DD0F02A1get_impl*
end;//TdaParamsCondition.Get_Name

function TdaParamsCondition.Get_DataType: TdaDataType;
//#UC START# *5555C57C023A_5551DD0F02A1get_var*
//#UC END# *5555C57C023A_5551DD0F02A1get_var*
begin
//#UC START# *5555C57C023A_5551DD0F02A1get_impl*
 Result := f_Field.DataType;
//#UC END# *5555C57C023A_5551DD0F02A1get_impl*
end;//TdaParamsCondition.Get_DataType

function TdaParamsCondition.Get_Size: Integer;
//#UC START# *5555C5AB0144_5551DD0F02A1get_var*
//#UC END# *5555C5AB0144_5551DD0F02A1get_var*
begin
//#UC START# *5555C5AB0144_5551DD0F02A1get_impl*
 Result := f_Field.Size;
//#UC END# *5555C5AB0144_5551DD0F02A1get_impl*
end;//TdaParamsCondition.Get_Size

function TdaParamsCondition.Get_Operation: TdaCompareOperation;
//#UC START# *555D9A290122_5551DD0F02A1get_var*
//#UC END# *555D9A290122_5551DD0F02A1get_var*
begin
//#UC START# *555D9A290122_5551DD0F02A1get_impl*
 Result := f_Operation;
//#UC END# *555D9A290122_5551DD0F02A1get_impl*
end;//TdaParamsCondition.Get_Operation

function TdaParamsCondition.DoBuildSQL(const aHelper: IdaParamListHelper): AnsiString;
//#UC START# *56408E7F01A1_5551DD0F02A1_var*
const
  cMap: array [da_copEqual..da_copNotEqual] of String = (
   '=',  // da_copEqual
   '>=', // da_copGreaterOrEqual
   '<=', // da_copLessOrEqual
   '<>'  // da_copNotEqual
  );
//#UC END# *56408E7F01A1_5551DD0F02A1_var*
begin
//#UC START# *56408E7F01A1_5551DD0F02A1_impl*
 case f_Operation of
  da_copEqual,
  da_copGreaterOrEqual,
  da_copLessOrEqual,
  da_copNotEqual:
  begin
   if f_TableAlias <> '' then
    Result := AddCaseInsensetive(Format('%s.%s', [f_TableAlias, f_Field.SQLName]))
   else
    Result := AddCaseInsensetive(f_Field.SQLName);
   Result := Format('%s %s %s', [Result, cMap[f_Operation], AddCaseInsensetive(aHelper.GetParamCode(f_ParamName))]);
  end;
 else
  Assert(False);
 end;
//#UC END# *56408E7F01A1_5551DD0F02A1_impl*
end;//TdaParamsCondition.DoBuildSQL

function TdaParamsCondition.Get_ParamType: TdaParamType;
//#UC START# *56725D45021B_5551DD0F02A1get_var*
//#UC END# *56725D45021B_5551DD0F02A1get_var*
begin
//#UC START# *56725D45021B_5551DD0F02A1get_impl*
 Result := da_ptInput;
//#UC END# *56725D45021B_5551DD0F02A1get_impl*
end;//TdaParamsCondition.Get_ParamType

procedure TdaParamsCondition.Cleanup;
//#UC START# *479731C50290_5551DD0F02A1_var*
//#UC END# *479731C50290_5551DD0F02A1_var*
begin
//#UC START# *479731C50290_5551DD0F02A1_impl*
 f_Field := nil;
 inherited;
//#UC END# *479731C50290_5551DD0F02A1_impl*
end;//TdaParamsCondition.Cleanup

end.