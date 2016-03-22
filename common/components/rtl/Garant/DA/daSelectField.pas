unit daSelectField;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DA"
// Модуль: "w:/common/components/rtl/Garant/DA/daSelectField.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::DA::Provider::TdaSelectField
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\DA\daDefine.inc}

interface

uses
  l3ProtoObject,
  daInterfaces
  ;

type
 TdaSelectField = class(Tl3ProtoObject, IdaSelectField, IdaFieldFromTable)
 private
 // private fields
   f_Alias : AnsiString;
   f_TableAlias : AnsiString;
   f_Field : IdaFieldDescription;
 protected
 // realized methods
   function Get_TableAlias: AnsiString;
   function Get_Field: IdaFieldDescription;
   function Get_Alias: AnsiString;
   function BuildSQLValue: AnsiString;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public methods
   constructor Create(const aTableAlias: AnsiString;
     const aField: IdaFieldDescription;
     const anAlias: AnsiString = ''); reintroduce; virtual;
   class function Make(const aTableAlias: AnsiString;
     const aField: IdaFieldDescription;
     const anAlias: AnsiString = ''): IdaSelectField; reintroduce;
     {* Сигнатура фабрики TdaSelectField.Make }
 end;//TdaSelectField

implementation

// start class TdaSelectField

constructor TdaSelectField.Create(const aTableAlias: AnsiString;
  const aField: IdaFieldDescription;
  const anAlias: AnsiString = '');
//#UC START# *5551F6DC02D0_5551DCD200EE_var*
//#UC END# *5551F6DC02D0_5551DCD200EE_var*
begin
//#UC START# *5551F6DC02D0_5551DCD200EE_impl*
 inherited Create;
 if anAlias = '' then
  f_Alias := aField.SQLName
 else
  f_Alias := anAlias;
 f_TableAlias := f_TableALias;
 f_Field := aField;
//#UC END# *5551F6DC02D0_5551DCD200EE_impl*
end;//TdaSelectField.Create

class function TdaSelectField.Make(const aTableAlias: AnsiString;
  const aField: IdaFieldDescription;
  const anAlias: AnsiString = ''): IdaSelectField;
var
 l_Inst : TdaSelectField;
begin
 l_Inst := Create(aTableAlias, aField, anAlias);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TdaSelectField.Get_TableAlias: AnsiString;
//#UC START# *555351D702B3_5551DCD200EEget_var*
//#UC END# *555351D702B3_5551DCD200EEget_var*
begin
//#UC START# *555351D702B3_5551DCD200EEget_impl*
 Result := f_TableAlias;
 if Result <> '' then
  Result := Result + '.';
//#UC END# *555351D702B3_5551DCD200EEget_impl*
end;//TdaSelectField.Get_TableAlias

function TdaSelectField.Get_Field: IdaFieldDescription;
//#UC START# *555351F500BC_5551DCD200EEget_var*
//#UC END# *555351F500BC_5551DCD200EEget_var*
begin
//#UC START# *555351F500BC_5551DCD200EEget_impl*
 Result := f_Field;
//#UC END# *555351F500BC_5551DCD200EEget_impl*
end;//TdaSelectField.Get_Field

function TdaSelectField.Get_Alias: AnsiString;
//#UC START# *555352070022_5551DCD200EEget_var*
//#UC END# *555352070022_5551DCD200EEget_var*
begin
//#UC START# *555352070022_5551DCD200EEget_impl*
 Result := f_Alias;
//#UC END# *555352070022_5551DCD200EEget_impl*
end;//TdaSelectField.Get_Alias

function TdaSelectField.BuildSQLValue: AnsiString;
//#UC START# *5608E5A4025F_5551DCD200EE_var*
//#UC END# *5608E5A4025F_5551DCD200EE_var*
begin
//#UC START# *5608E5A4025F_5551DCD200EE_impl*
 Result := f_Field.SQLName;
 if f_Alias <> '' then
  Result := Result + ' as ' + f_Alias;
 if f_TableAlias <> '' then
  Result := f_TableAlias + '.' + Result;
//#UC END# *5608E5A4025F_5551DCD200EE_impl*
end;//TdaSelectField.BuildSQLValue

procedure TdaSelectField.Cleanup;
//#UC START# *479731C50290_5551DCD200EE_var*
//#UC END# *479731C50290_5551DCD200EE_var*
begin
//#UC START# *479731C50290_5551DCD200EE_impl*
 f_Field := nil;
 inherited;
//#UC END# *479731C50290_5551DCD200EE_impl*
end;//TdaSelectField.Cleanup

end.