unit pgFunctionSelectField;

// Модуль: "w:\common\components\rtl\Garant\PG\pgFunctionSelectField.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\PG\pgDefine.inc}

interface

{$If Defined(UsePostgres)}
uses
 l3IntfUses
 , l3ProtoObject
 , daInterfaces
;

type
 TpgFunctionSelectField = class(Tl3ProtoObject, IdaSelectField)
  private
   f_Description: IdaParamDescription;
  protected
   function Get_Alias: AnsiString;
   function BuildSQLValue: AnsiString;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(const aDescription: IdaParamDescription); reintroduce;
   class function Make(const aDescription: IdaParamDescription): IdaSelectField; reintroduce;
 end;//TpgFunctionSelectField
{$IfEnd} // Defined(UsePostgres)

implementation

{$If Defined(UsePostgres)}
uses
 l3ImplUses
;

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
end;//TpgFunctionSelectField.Make

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
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_567A8BE7002D_var*
//#UC END# *479731C50290_567A8BE7002D_var*
begin
//#UC START# *479731C50290_567A8BE7002D_impl*
 f_Description := nil;
 inherited;
//#UC END# *479731C50290_567A8BE7002D_impl*
end;//TpgFunctionSelectField.Cleanup
{$IfEnd} // Defined(UsePostgres)

end.
