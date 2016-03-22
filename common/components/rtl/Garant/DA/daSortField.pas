unit daSortField;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DA"
// Модуль: "w:/common/components/rtl/Garant/DA/daSortField.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::DA::Provider::TdaSortField
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
  daTypes,
  daInterfaces
  ;

type
 TdaSortField = class(Tl3ProtoObject, IdaSortField)
 private
 // private fields
   f_SelectField : IdaSelectField;
   f_SortOrder : TdaSortOrder;
 protected
 // realized methods
   function Get_SelectField: IdaSelectField;
   function Get_SortOrder: TdaSortOrder;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public methods
   constructor Create(const aSelectField: IdaSelectField;
     aSortOrder: TdaSortOrder = da_soAscending); reintroduce;
   class function Make(const aSelectField: IdaSelectField;
     aSortOrder: TdaSortOrder = da_soAscending): IdaSortField; reintroduce;
     {* Сигнатура фабрики TdaSortField.Make }
 end;//TdaSortField

implementation

// start class TdaSortField

constructor TdaSortField.Create(const aSelectField: IdaSelectField;
  aSortOrder: TdaSortOrder = da_soAscending);
//#UC START# *5680EF4703D5_5680EF290107_var*
//#UC END# *5680EF4703D5_5680EF290107_var*
begin
//#UC START# *5680EF4703D5_5680EF290107_impl*
 inherited Create;
 f_SelectField := aSelectField;
 f_SortOrder := aSortOrder;
//#UC END# *5680EF4703D5_5680EF290107_impl*
end;//TdaSortField.Create

class function TdaSortField.Make(const aSelectField: IdaSelectField;
  aSortOrder: TdaSortOrder = da_soAscending): IdaSortField;
var
 l_Inst : TdaSortField;
begin
 l_Inst := Create(aSelectField, aSortOrder);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TdaSortField.Get_SelectField: IdaSelectField;
//#UC START# *5680EEB20163_5680EF290107get_var*
//#UC END# *5680EEB20163_5680EF290107get_var*
begin
//#UC START# *5680EEB20163_5680EF290107get_impl*
 Result := f_SelectField;
//#UC END# *5680EEB20163_5680EF290107get_impl*
end;//TdaSortField.Get_SelectField

function TdaSortField.Get_SortOrder: TdaSortOrder;
//#UC START# *5680EEDA03E3_5680EF290107get_var*
//#UC END# *5680EEDA03E3_5680EF290107get_var*
begin
//#UC START# *5680EEDA03E3_5680EF290107get_impl*
 Result := f_SortOrder;
//#UC END# *5680EEDA03E3_5680EF290107get_impl*
end;//TdaSortField.Get_SortOrder

procedure TdaSortField.Cleanup;
//#UC START# *479731C50290_5680EF290107_var*
//#UC END# *479731C50290_5680EF290107_var*
begin
//#UC START# *479731C50290_5680EF290107_impl*
 f_SelectField := nil;
 inherited;
//#UC END# *479731C50290_5680EF290107_impl*
end;//TdaSortField.Cleanup

end.