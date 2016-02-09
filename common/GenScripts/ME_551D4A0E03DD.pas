unit VGSceneAndWinControlPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\VGSceneAndWinControlPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoVGScene) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , vgObject
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
;
{$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoVGScene) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , vg_controls
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TkwPopControlFindVGControlByName = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Control:FindVGControlByName
*Тип результата:* TvgObject
*Пример:*
[code]
OBJECT VAR l_TvgObject
 aName aControl pop:Control:FindVGControlByName >>> l_TvgObject
[code]  }
  private
   function FindVGControlByName(const aCtx: TtfwContext;
    aControl: TWinControl;
    const aName: AnsiString): TvgObject;
    {* Реализация слова скрипта pop:Control:FindVGControlByName }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopControlFindVGControlByName

function TkwPopControlFindVGControlByName.FindVGControlByName(const aCtx: TtfwContext;
 aControl: TWinControl;
 const aName: AnsiString): TvgObject;
 {* Реализация слова скрипта pop:Control:FindVGControlByName }
//#UC START# *687CE4789741_BAFBA1D026AA_var*

 function DoFindVGObject(aVgControl: TvgObject; const aName: AnsiString): TvgObject;
 var
  I: Integer;
 begin
  if SameText(aVgControl.Name, aName) or
     ((aVgControl is TvgTextControl) and
      SameText((aVgControl as TvgTextControl).Text, aName)) then
  begin
   Result := aVgControl;
   Exit;
  end else
   Result := nil;
  for I := 0 to aVgControl.ChildrenCount - 1 do
  begin
   Result := DoFindVGObject(aVgControl.Children[I], aName);
   if Assigned(Result) then
    Exit;
  end;
 end;

 function DoFindWinControl(aControl: TWinControl; const aName: AnsiString): TvgObject;
 var
  I: Integer;
 begin
  for I := 0 to aControl.ControlCount - 1 do
   if aControl.Controls[I] is TWinControl then
   begin
    Result := DoFindWinControl(aControl.Controls[I] as TWinControl, aName);
    if Assigned(Result) then
     Exit;
   end;
   
  for I := 0 to aControl.ComponentCount - 1 do
   if aControl.Components[I] is TvgObject then
   begin
    Result := DoFindVGObject(aControl.Components[I] as TvgObject, aName);
    if Assigned(Result) then
     Exit;
   end else
   if aControl.Components[I] is TWinControl then
   begin
    Result := DoFindWinControl(aControl.Components[I] as TWinControl, aName);
    if Assigned(Result) then
     Exit;
   end;
  Result := nil;
 end;
 
//#UC END# *687CE4789741_BAFBA1D026AA_var*
begin
//#UC START# *687CE4789741_BAFBA1D026AA_impl*
 Result := DoFindWinControl(aControl, aName);
//#UC END# *687CE4789741_BAFBA1D026AA_impl*
end;//TkwPopControlFindVGControlByName.FindVGControlByName

procedure TkwPopControlFindVGControlByName.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_BAFBA1D026AA_var*
//#UC END# *4DAEEDE10285_BAFBA1D026AA_var*
begin
//#UC START# *4DAEEDE10285_BAFBA1D026AA_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_BAFBA1D026AA_impl*
end;//TkwPopControlFindVGControlByName.DoDoIt

class function TkwPopControlFindVGControlByName.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Control:FindVGControlByName';
end;//TkwPopControlFindVGControlByName.GetWordNameForRegister

function TkwPopControlFindVGControlByName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_BAFBA1D026AA_var*
//#UC END# *551544E2001A_BAFBA1D026AA_var*
begin
//#UC START# *551544E2001A_BAFBA1D026AA_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_BAFBA1D026AA_impl*
end;//TkwPopControlFindVGControlByName.GetResultTypeInfo

function TkwPopControlFindVGControlByName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopControlFindVGControlByName.GetAllParamsCount

function TkwPopControlFindVGControlByName.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_BAFBA1D026AA_var*
//#UC END# *5617F4D00243_BAFBA1D026AA_var*
begin
//#UC START# *5617F4D00243_BAFBA1D026AA_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_BAFBA1D026AA_impl*
end;//TkwPopControlFindVGControlByName.ParamsTypes

initialization
 TkwPopControlFindVGControlByName.RegisterInEngine;
 {* Регистрация pop_Control_FindVGControlByName }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TWinControl));
 {* Регистрация типа TWinControl }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа String }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvgObject));
 {* Регистрация типа TvgObject }
{$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoScripts)

end.
