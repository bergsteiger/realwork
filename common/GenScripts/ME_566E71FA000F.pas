unit daFieldParamDescription;

// Модуль: "w:\common\components\rtl\Garant\DA\daFieldParamDescription.pas"
// Стереотип: "SimpleClass"

{$Include daDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , daInterfaces
 , daTypes
;

type
 TdaFieldParamDescription = class(Tl3ProtoObject, IdaParamDescription)
  private
   f_Description: IdaFieldDescription;
  protected
   function Get_Name: AnsiString;
   function Get_DataType: TdaDataType;
   function Get_Size: Integer;
   function Get_ParamType: TdaParamType;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(const aFieldDescription: IdaFieldDescription); reintroduce;
   class function Make(const aFieldDescription: IdaFieldDescription): IdaParamDescription; reintroduce;
 end;//TdaFieldParamDescription

implementation

uses
 l3ImplUses
;

constructor TdaFieldParamDescription.Create(const aFieldDescription: IdaFieldDescription);
//#UC START# *566E721A02B9_566E71FA000F_var*
//#UC END# *566E721A02B9_566E71FA000F_var*
begin
//#UC START# *566E721A02B9_566E71FA000F_impl*
 inherited Create;
 f_Description := aFieldDescription;
//#UC END# *566E721A02B9_566E71FA000F_impl*
end;//TdaFieldParamDescription.Create

class function TdaFieldParamDescription.Make(const aFieldDescription: IdaFieldDescription): IdaParamDescription;
var
 l_Inst : TdaFieldParamDescription;
begin
 l_Inst := Create(aFieldDescription);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TdaFieldParamDescription.Make

function TdaFieldParamDescription.Get_Name: AnsiString;
//#UC START# *5555C5620242_566E71FA000Fget_var*
//#UC END# *5555C5620242_566E71FA000Fget_var*
begin
//#UC START# *5555C5620242_566E71FA000Fget_impl*
 Result := f_Description.SQLName;
//#UC END# *5555C5620242_566E71FA000Fget_impl*
end;//TdaFieldParamDescription.Get_Name

function TdaFieldParamDescription.Get_DataType: TdaDataType;
//#UC START# *5555C57C023A_566E71FA000Fget_var*
//#UC END# *5555C57C023A_566E71FA000Fget_var*
begin
//#UC START# *5555C57C023A_566E71FA000Fget_impl*
 Result := f_Description.DataType;
//#UC END# *5555C57C023A_566E71FA000Fget_impl*
end;//TdaFieldParamDescription.Get_DataType

function TdaFieldParamDescription.Get_Size: Integer;
//#UC START# *5555C5AB0144_566E71FA000Fget_var*
//#UC END# *5555C5AB0144_566E71FA000Fget_var*
begin
//#UC START# *5555C5AB0144_566E71FA000Fget_impl*
 Result := f_Description.SIze;
//#UC END# *5555C5AB0144_566E71FA000Fget_impl*
end;//TdaFieldParamDescription.Get_Size

function TdaFieldParamDescription.Get_ParamType: TdaParamType;
//#UC START# *56725D45021B_566E71FA000Fget_var*
//#UC END# *56725D45021B_566E71FA000Fget_var*
begin
//#UC START# *56725D45021B_566E71FA000Fget_impl*
 Result := da_ptInput;
//#UC END# *56725D45021B_566E71FA000Fget_impl*
end;//TdaFieldParamDescription.Get_ParamType

procedure TdaFieldParamDescription.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_566E71FA000F_var*
//#UC END# *479731C50290_566E71FA000F_var*
begin
//#UC START# *479731C50290_566E71FA000F_impl*
 f_Description := nil;
 inherited;
//#UC END# *479731C50290_566E71FA000F_impl*
end;//TdaFieldParamDescription.Cleanup

end.
