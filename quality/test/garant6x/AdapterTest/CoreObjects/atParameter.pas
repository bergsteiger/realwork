unit atParameter;

// Модуль: "w:\quality\test\garant6x\AdapterTest\CoreObjects\atParameter.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TatParameter" MUID: (48086D7103BE)

interface

uses
 l3IntfUses
 , l3_Base
 , SysUtils
;

const
 INVALID_DEFAULT_VALUE = '{70802953-4F65-4867-856A-ED08CCB25A4D}';

type
 ECanNotCast = class(Exception)
 end;//ECanNotCast

 EHasNotSet = class(Exception)
 end;//EHasNotSet

 TatParameter = class(Tl3_Base)
  private
   f_Data: Variant;
   f_DefaultValue: Variant;
   f_IsSet: Boolean;
  protected
   function pm_GetAsStr: AnsiString;
   procedure pm_SetAsStr(const aValue: AnsiString);
   function pm_GetAsInt: Integer;
   procedure pm_SetAsInt(aValue: Integer);
   function pm_GetAsBool: Boolean;
   procedure pm_SetAsBool(aValue: Boolean);
   function pm_GetIsDefaultSet: Boolean;
   function pm_GetValue: Variant; virtual;
   procedure pm_SetValue(const aValue: Variant); virtual;
  public
   constructor Create(const defaultValue: AnsiString); reintroduce; overload;
   constructor Create; reintroduce; overload;
  protected
   property Value: Variant
    read pm_GetValue
    write pm_SetValue;
  public
   property IsSet: Boolean
    read f_IsSet;
   property AsStr: AnsiString
    read pm_GetAsStr
    write pm_SetAsStr;
   property AsInt: Integer
    read pm_GetAsInt
    write pm_SetAsInt;
   property AsBool: Boolean
    read pm_GetAsBool
    write pm_SetAsBool;
   property IsDefaultSet: Boolean
    read pm_GetIsDefaultSet;
 end;//TatParameter

implementation

uses
 l3ImplUses
 , Variants
 {$If NOT Defined(NoScripts)}
 , TtfwTypeRegistrator_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *48086D7103BEimpl_uses*
 //#UC END# *48086D7103BEimpl_uses*
;

function TatParameter.pm_GetAsStr: AnsiString;
//#UC START# *48086E50016E_48086D7103BEget_var*
//#UC END# *48086E50016E_48086D7103BEget_var*
begin
//#UC START# *48086E50016E_48086D7103BEget_impl*
    Result := Value;
//#UC END# *48086E50016E_48086D7103BEget_impl*
end;//TatParameter.pm_GetAsStr

procedure TatParameter.pm_SetAsStr(const aValue: AnsiString);
//#UC START# *48086E50016E_48086D7103BEset_var*
//#UC END# *48086E50016E_48086D7103BEset_var*
begin
//#UC START# *48086E50016E_48086D7103BEset_impl*
 Value := aValue;
//#UC END# *48086E50016E_48086D7103BEset_impl*
end;//TatParameter.pm_SetAsStr

function TatParameter.pm_GetAsInt: Integer;
//#UC START# *48086E620187_48086D7103BEget_var*
//#UC END# *48086E620187_48086D7103BEget_var*
begin
//#UC START# *48086E620187_48086D7103BEget_impl*
    try
      Result := Value;
    except
      on EVariantTypeCastError do
        raise ECanNotCast.CreateFmt('%s не может быть преобразовано в целое!', [f_Data]);
      else
        raise;
    end;
//#UC END# *48086E620187_48086D7103BEget_impl*
end;//TatParameter.pm_GetAsInt

procedure TatParameter.pm_SetAsInt(aValue: Integer);
//#UC START# *48086E620187_48086D7103BEset_var*
//#UC END# *48086E620187_48086D7103BEset_var*
begin
//#UC START# *48086E620187_48086D7103BEset_impl*
 Value := aValue;
//#UC END# *48086E620187_48086D7103BEset_impl*
end;//TatParameter.pm_SetAsInt

function TatParameter.pm_GetAsBool: Boolean;
//#UC START# *48086E7003BC_48086D7103BEget_var*
//#UC END# *48086E7003BC_48086D7103BEget_var*
begin
//#UC START# *48086E7003BC_48086D7103BEget_impl*
    try
      Result := Value;
    except
      on EVariantTypeCastError do
        raise ECanNotCast.CreateFmt('%s не может быть преобразовано в логическое!', [f_Data]);
      else
        raise;
    end;
//#UC END# *48086E7003BC_48086D7103BEget_impl*
end;//TatParameter.pm_GetAsBool

procedure TatParameter.pm_SetAsBool(aValue: Boolean);
//#UC START# *48086E7003BC_48086D7103BEset_var*
//#UC END# *48086E7003BC_48086D7103BEset_var*
begin
//#UC START# *48086E7003BC_48086D7103BEset_impl*
 Value := aValue;
//#UC END# *48086E7003BC_48086D7103BEset_impl*
end;//TatParameter.pm_SetAsBool

function TatParameter.pm_GetIsDefaultSet: Boolean;
//#UC START# *48086E860284_48086D7103BEget_var*
//#UC END# *48086E860284_48086D7103BEget_var*
begin
//#UC START# *48086E860284_48086D7103BEget_impl*
    Result := f_DefaultValue <> INVALID_DEFAULT_VALUE;
//#UC END# *48086E860284_48086D7103BEget_impl*
end;//TatParameter.pm_GetIsDefaultSet

function TatParameter.pm_GetValue: Variant;
//#UC START# *48086F180372_48086D7103BEget_var*
//#UC END# *48086F180372_48086D7103BEget_var*
begin
//#UC START# *48086F180372_48086D7103BEget_impl*
    if (NOT IsSet) then
    begin
      if NOT IsDefaultSet then
        raise EHasNotSet.Create('Параметр не инициализирован!')
      else
        Result := f_DefaultValue;
    end
    else
      Result := f_Data;
//#UC END# *48086F180372_48086D7103BEget_impl*
end;//TatParameter.pm_GetValue

procedure TatParameter.pm_SetValue(const aValue: Variant);
//#UC START# *48086F180372_48086D7103BEset_var*
//#UC END# *48086F180372_48086D7103BEset_var*
begin
//#UC START# *48086F180372_48086D7103BEset_impl*
    f_Data := aValue;
    f_IsSet := (VarType(aValue) <> varEmpty);
//#UC END# *48086F180372_48086D7103BEset_impl*
end;//TatParameter.pm_SetValue

constructor TatParameter.Create(const defaultValue: AnsiString);
//#UC START# *48086E280256_48086D7103BE_var*
//#UC END# *48086E280256_48086D7103BE_var*
begin
//#UC START# *48086E280256_48086D7103BE_impl*
    inherited Create;
    f_DefaultValue := defaultValue;
//#UC END# *48086E280256_48086D7103BE_impl*
end;//TatParameter.Create

constructor TatParameter.Create;
//#UC START# *48086E3F0109_48086D7103BE_var*
//#UC END# *48086E3F0109_48086D7103BE_var*
begin
//#UC START# *48086E3F0109_48086D7103BE_impl*
    inherited Create;
    f_DefaultValue := INVALID_DEFAULT_VALUE;
//#UC END# *48086E3F0109_48086D7103BE_impl*
end;//TatParameter.Create

initialization
{$If NOT Defined(NoScripts)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(ECanNotCast));
 {* Регистрация типа ECanNotCast }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(EHasNotSet));
 {* Регистрация типа EHasNotSet }
{$IfEnd} // NOT Defined(NoScripts)

end.
