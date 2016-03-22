unit daFieldParamDescription;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DA"
// Модуль: "w:/common/components/rtl/Garant/DA/daFieldParamDescription.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::DA::Provider::TdaFieldParamDescription
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
  daInterfaces,
  daTypes
  ;

type
 TdaFieldParamDescription = class(Tl3ProtoObject, IdaParamDescription)
 private
 // private fields
   f_Description : IdaFieldDescription;
 protected
 // realized methods
   function Get_Name: AnsiString;
   function Get_DataType: TdaDataType;
   function Get_Size: Integer;
   function Get_ParamType: TdaParamType;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public methods
   constructor Create(const aFieldDescription: IdaFieldDescription); reintroduce;
   class function Make(const aFieldDescription: IdaFieldDescription): IdaParamDescription; reintroduce;
     {* Сигнатура фабрики TdaFieldParamDescription.Make }
 end;//TdaFieldParamDescription

implementation

// start class TdaFieldParamDescription

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
end;

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
//#UC START# *479731C50290_566E71FA000F_var*
//#UC END# *479731C50290_566E71FA000F_var*
begin
//#UC START# *479731C50290_566E71FA000F_impl*
 f_Description := nil;
 inherited;
//#UC END# *479731C50290_566E71FA000F_impl*
end;//TdaFieldParamDescription.Cleanup

end.