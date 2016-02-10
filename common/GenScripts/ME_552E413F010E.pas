unit SpinEditWordsPack;

// ������: "w:\common\components\rtl\Garant\ScriptEngine\SpinEditWordsPack.pas"
// ���������: "ScriptKeywordsPack"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , vtSpinEdit
 , tfwPropertyLike
 , tfwScriptingInterfaces
 , tfwTypeInfo
 , TypInfo
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TkwPopSpinEditValue = {final} class(TtfwPropertyLike)
  {* ����� ������� pop:SpinEdit:Value
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aSpinEdit pop:SpinEdit:Value >>> l_Integer
[code]  }
  private
   function Value(const aCtx: TtfwContext;
    aSpinEdit: TvtSpinEdit): Integer;
    {* ���������� ����� ������� pop:SpinEdit:Value }
  protected
   class procedure DoSetValue(aSpinEdit: TvtSpinEdit;
    aValue: Integer);
    {* ����� ��������� �������� �������� Value }
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopSpinEditValue

function TkwPopSpinEditValue.Value(const aCtx: TtfwContext;
 aSpinEdit: TvtSpinEdit): Integer;
 {* ���������� ����� ������� pop:SpinEdit:Value }
//#UC START# *7366517D8188_0F40F0279E11_var*
//#UC END# *7366517D8188_0F40F0279E11_var*
begin
//#UC START# *7366517D8188_0F40F0279E11_impl*
 Result := aSpinEdit.AsInteger;
//#UC END# *7366517D8188_0F40F0279E11_impl*
end;//TkwPopSpinEditValue.Value

class procedure TkwPopSpinEditValue.DoSetValue(aSpinEdit: TvtSpinEdit;
 aValue: Integer);
 {* ����� ��������� �������� �������� Value }
//#UC START# *A9BA2BCEA197_0F40F0279E11_var*
//#UC END# *A9BA2BCEA197_0F40F0279E11_var*
begin
//#UC START# *A9BA2BCEA197_0F40F0279E11_impl*
 aSpinEdit.AsInteger := aValue;
//#UC END# *A9BA2BCEA197_0F40F0279E11_impl*
end;//TkwPopSpinEditValue.DoSetValue

procedure TkwPopSpinEditValue.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_0F40F0279E11_var*
//#UC END# *4DAEEDE10285_0F40F0279E11_var*
begin
//#UC START# *4DAEEDE10285_0F40F0279E11_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_0F40F0279E11_impl*
end;//TkwPopSpinEditValue.DoDoIt

class function TkwPopSpinEditValue.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:SpinEdit:Value';
end;//TkwPopSpinEditValue.GetWordNameForRegister

procedure TkwPopSpinEditValue.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_0F40F0279E11_var*
//#UC END# *52D00B00031A_0F40F0279E11_var*
begin
//#UC START# *52D00B00031A_0F40F0279E11_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_0F40F0279E11_impl*
end;//TkwPopSpinEditValue.SetValuePrim

function TkwPopSpinEditValue.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwPopSpinEditValue.GetResultTypeInfo

function TkwPopSpinEditValue.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopSpinEditValue.GetAllParamsCount

function TkwPopSpinEditValue.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_0F40F0279E11_var*
//#UC END# *5617F4D00243_0F40F0279E11_var*
begin
//#UC START# *5617F4D00243_0F40F0279E11_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_0F40F0279E11_impl*
end;//TkwPopSpinEditValue.ParamsTypes

initialization
 TkwPopSpinEditValue.RegisterInEngine;
 {* ����������� pop_SpinEdit_Value }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtSpinEdit));
 {* ����������� ���� TvtSpinEdit }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
 {* ����������� ���� Integer }
{$IfEnd} // NOT Defined(NoScripts)

end.
