unit kwVTControlsPack;

// ������: "w:\common\components\rtl\Garant\ScriptEngine\kwVTControlsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "kwVTControlsPack" MUID: (4F6096D500C3)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwGlobalKeyWord
 , DragData
 , tfwScriptingInterfaces
 , TypInfo
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TkwDDSupportGetState = {final} class(TtfwGlobalKeyWord)
  {* ����� ������� DDSupport:GetState
[panel]���������� ������ ��������� DDSupport
������: 
[code]
DDSupport:GetState
[code][panel]
*��� ����������:* TDragDataState
*������:*
[code]
TDragDataState VAR l_TDragDataState
 DDSupport:GetState >>> l_TDragDataState
[code]  }
  private
   function DDSupport_GetState(const aCtx: TtfwContext): TDragDataState;
    {* ���������� ����� ������� DDSupport:GetState }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwDDSupportGetState

function TkwDDSupportGetState.DDSupport_GetState(const aCtx: TtfwContext): TDragDataState;
 {* ���������� ����� ������� DDSupport:GetState }
//#UC START# *7A2DDC297C52_765DA382B537_var*
//#UC END# *7A2DDC297C52_765DA382B537_var*
begin
//#UC START# *7A2DDC297C52_765DA382B537_impl*
 Result := TDragDataSupport.Instance.DragState; 
//#UC END# *7A2DDC297C52_765DA382B537_impl*
end;//TkwDDSupportGetState.DDSupport_GetState

procedure TkwDDSupportGetState.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushInt(Ord(DDSupport_GetState(aCtx)));
end;//TkwDDSupportGetState.DoDoIt

function TkwDDSupportGetState.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TDragDataState);
end;//TkwDDSupportGetState.GetResultTypeInfo

function TkwDDSupportGetState.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwDDSupportGetState.GetAllParamsCount

function TkwDDSupportGetState.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwDDSupportGetState.ParamsTypes

class function TkwDDSupportGetState.GetWordNameForRegister: AnsiString;
begin
 Result := 'DDSupport:GetState';
end;//TkwDDSupportGetState.GetWordNameForRegister

initialization
 TkwDDSupportGetState.RegisterInEngine;
 {* ����������� DDSupport_GetState }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TDragDataState));
 {* ����������� ���� TDragDataState }
{$IfEnd} // NOT Defined(NoScripts)

end.
