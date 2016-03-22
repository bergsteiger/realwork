unit pgFunctionSelectField;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "PG"
// Модуль: "w:/common/components/rtl/Garant/PG/pgFunctionSelectField.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::PG::Provider::TpgFunctionSelectField
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\PG\pgDefine.inc}

interface

{$If defined(UsePostgres)}
uses
  l3ProtoObject,
  daInterfaces
  ;
{$IfEnd} //UsePostgres

{$If defined(UsePostgres)}
type
 TpgFunctionSelectField = class(Tl3ProtoObject, IdaSelectField)
 private
 // private fields
   f_Description : IdaParamDescription;
 protected
 // realized methods
   function Get_Alias: AnsiString;
   function BuildSQLValue: AnsiString;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public methods
   constructor Create(const aDescription: IdaParamDescription); reintroduce;
   class function Make(const aDescription: IdaParamDescription): IdaSelectField; reintroduce;
     {* Сигнатура фабрики TpgFunctionSelectField.Make }
 end;//TpgFunctionSelectField
{$IfEnd} //UsePostgres

implementation

{$If defined(UsePostgres)}

// start class TpgFunctionSelectField

constructor TpgFunctionSelectField.Create(const aDescription: IdaParamDescription);
//#UC START# *567BB5780118_567A8BE7002D_var*
//#UC END# *567BB5780118_567A8BE7002D_var*
begin
//#UC START# *567BB5780118_567A8BE7002D_impl*
 inherited Create;
 f_Description := aDescription;
//#UC END# *567BB5780118_567A8BE7002D_impl*
end;//TpgFunctionSelectField.Create

class function TpgFunctionSelectField.Make(const aDescription: IdaParamDescription): IdaSelectField;
var
 l_Inst : TpgFunctionSelectField;
begin
 l_Inst := Create(aDescription);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TpgFunctionSelectField.Get_Alias: AnsiString;
//#UC START# *555352070022_567A8BE7002Dget_var*
//#UC END# *555352070022_567A8BE7002Dget_var*
begin
//#UC START# *555352070022_567A8BE7002Dget_impl*
 Result := '';
//#UC END# *555352070022_567A8BE7002Dget_impl*
end;//TpgFunctionSelectField.Get_Alias

function TpgFunctionSelectField.BuildSQLValue: AnsiString;
//#UC START# *5608E5A4025F_567A8BE7002D_var*
//#UC END# *5608E5A4025F_567A8BE7002D_var*
begin
//#UC START# *5608E5A4025F_567A8BE7002D_impl*
 Result := f_Description.Name;
//#UC END# *5608E5A4025F_567A8BE7002D_impl*
end;//TpgFunctionSelectField.BuildSQLValue

procedure TpgFunctionSelectField.Cleanup;
//#UC START# *479731C50290_567A8BE7002D_var*
//#UC END# *479731C50290_567A8BE7002D_var*
begin
//#UC START# *479731C50290_567A8BE7002D_impl*
 f_Description := nil;
 inherited;
//#UC END# *479731C50290_567A8BE7002D_impl*
end;//TpgFunctionSelectField.Cleanup

{$IfEnd} //UsePostgres

end.