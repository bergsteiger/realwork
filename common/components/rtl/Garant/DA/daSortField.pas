unit daSortField;

// Модуль: "w:\common\components\rtl\Garant\DA\daSortField.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TdaSortField" MUID: (5680EF290107)

{$Include w:\common\components\rtl\Garant\DA\daDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , daInterfaces
 , daTypes
;

type
 TdaSortField = class(Tl3ProtoObject, IdaSortField)
  private
   f_SelectField: IdaSelectField;
   f_SortOrder: TdaSortOrder;
  protected
   function Get_SelectField: IdaSelectField;
   function Get_SortOrder: TdaSortOrder;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(const aSelectField: IdaSelectField;
    aSortOrder: TdaSortOrder = daTypes.da_soAscending); reintroduce;
   class function Make(const aSelectField: IdaSelectField;
    aSortOrder: TdaSortOrder = daTypes.da_soAscending): IdaSortField; reintroduce;
 end;//TdaSortField

implementation

uses
 l3ImplUses
 //#UC START# *5680EF290107impl_uses*
 //#UC END# *5680EF290107impl_uses*
;

constructor TdaSortField.Create(const aSelectField: IdaSelectField;
 aSortOrder: TdaSortOrder = daTypes.da_soAscending);
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
 aSortOrder: TdaSortOrder = daTypes.da_soAscending): IdaSortField;
var
 l_Inst : TdaSortField;
begin
 l_Inst := Create(aSelectField, aSortOrder);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TdaSortField.Make

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
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_5680EF290107_var*
//#UC END# *479731C50290_5680EF290107_var*
begin
//#UC START# *479731C50290_5680EF290107_impl*
 f_SelectField := nil;
 inherited;
//#UC END# *479731C50290_5680EF290107_impl*
end;//TdaSortField.Cleanup

end.
