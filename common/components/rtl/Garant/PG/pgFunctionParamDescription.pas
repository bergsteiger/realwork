unit pgFunctionParamDescription;

// Модуль: "w:\common\components\rtl\Garant\PG\pgFunctionParamDescription.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TpgFunctionParamDescription" MUID: (5671531301DB)

{$Include w:\common\components\rtl\Garant\PG\pgDefine.inc}

interface

{$If Defined(UsePostgres)}
uses
 l3IntfUses
 , l3ProtoObject
 , daInterfaces
 , daTypes
;

type
 TpgFunctionParamDescription = class(Tl3ProtoObject, IdaParamDescription)
  private
   f_Name: AnsiString;
   f_DataType: TdaDataType;
   f_ParamType: TdaParamType;
   f_Size: Integer;
  protected
   function Get_Name: AnsiString;
   function Get_DataType: TdaDataType;
   function Get_Size: Integer;
   function Get_ParamType: TdaParamType;
  public
   constructor Create(const aName: AnsiString;
    aDataType: TdaDataType;
    aSize: Integer;
    aParamType: TdaParamType); reintroduce;
   class function Make(const aName: AnsiString;
    aDataType: TdaDataType;
    aSize: Integer;
    aParamType: TdaParamType): IdaParamDescription; reintroduce;
 end;//TpgFunctionParamDescription
{$IfEnd} // Defined(UsePostgres)

implementation

{$If Defined(UsePostgres)}
uses
 l3ImplUses
;

constructor TpgFunctionParamDescription.Create(const aName: AnsiString;
 aDataType: TdaDataType;
 aSize: Integer;
 aParamType: TdaParamType);
//#UC START# *56715338023C_5671531301DB_var*
//#UC END# *56715338023C_5671531301DB_var*
begin
//#UC START# *56715338023C_5671531301DB_impl*
 inherited Create;
 f_Name := aName;
 f_DataType := aDataType;
 f_ParamType := aParamType;
 f_Size := aSize;
//#UC END# *56715338023C_5671531301DB_impl*
end;//TpgFunctionParamDescription.Create

class function TpgFunctionParamDescription.Make(const aName: AnsiString;
 aDataType: TdaDataType;
 aSize: Integer;
 aParamType: TdaParamType): IdaParamDescription;
var
 l_Inst : TpgFunctionParamDescription;
begin
 l_Inst := Create(aName, aDataType, aSize, aParamType);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TpgFunctionParamDescription.Make

function TpgFunctionParamDescription.Get_Name: AnsiString;
//#UC START# *5555C5620242_5671531301DBget_var*
//#UC END# *5555C5620242_5671531301DBget_var*
begin
//#UC START# *5555C5620242_5671531301DBget_impl*
 Result := f_Name;
//#UC END# *5555C5620242_5671531301DBget_impl*
end;//TpgFunctionParamDescription.Get_Name

function TpgFunctionParamDescription.Get_DataType: TdaDataType;
//#UC START# *5555C57C023A_5671531301DBget_var*
//#UC END# *5555C57C023A_5671531301DBget_var*
begin
//#UC START# *5555C57C023A_5671531301DBget_impl*
 Result := f_DataType;
//#UC END# *5555C57C023A_5671531301DBget_impl*
end;//TpgFunctionParamDescription.Get_DataType

function TpgFunctionParamDescription.Get_Size: Integer;
//#UC START# *5555C5AB0144_5671531301DBget_var*
//#UC END# *5555C5AB0144_5671531301DBget_var*
begin
//#UC START# *5555C5AB0144_5671531301DBget_impl*
 Result := f_Size;
//#UC END# *5555C5AB0144_5671531301DBget_impl*
end;//TpgFunctionParamDescription.Get_Size

function TpgFunctionParamDescription.Get_ParamType: TdaParamType;
//#UC START# *56725D45021B_5671531301DBget_var*
//#UC END# *56725D45021B_5671531301DBget_var*
begin
//#UC START# *56725D45021B_5671531301DBget_impl*
 Result := f_ParamType;
//#UC END# *56725D45021B_5671531301DBget_impl*
end;//TpgFunctionParamDescription.Get_ParamType
{$IfEnd} // Defined(UsePostgres)

end.
