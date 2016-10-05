unit VGSceneAndWinControlPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\VGSceneAndWinControlPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "VGSceneAndWinControlPack" MUID: (551D4A0E03DD)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoVGScene) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoVGScene) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , tfwClassLike
 , vgObject
 , tfwScriptingInterfaces
 , TypInfo
 , vg_controls
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
 //#UC START# *551D4A0E03DDimpl_uses*
 //#UC END# *551D4A0E03DDimpl_uses*
;

type
 TkwPopControlFindVGControlByName = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Control:FindVGControlByName }
  private
   function FindVGControlByName(const aCtx: TtfwContext;
    aControl: TWinControl;
    const aName: AnsiString): TvgObject;
    {* Реализация слова скрипта pop:Control:FindVGControlByName }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopControlFindVGControlByName

function TkwPopControlFindVGControlByName.FindVGControlByName(const aCtx: TtfwContext;
 aControl: TWinControl;
 const aName: AnsiString): TvgObject;
 {* Реализация слова скрипта pop:Control:FindVGControlByName }
//#UC START# *551D4AA003A2_551D4AA003A2_47E124E90272_Word_var*

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
 
//#UC END# *551D4AA003A2_551D4AA003A2_47E124E90272_Word_var*
begin
//#UC START# *551D4AA003A2_551D4AA003A2_47E124E90272_Word_impl*
 Result := DoFindWinControl(aControl, aName);
//#UC END# *551D4AA003A2_551D4AA003A2_47E124E90272_Word_impl*
end;//TkwPopControlFindVGControlByName.FindVGControlByName

class function TkwPopControlFindVGControlByName.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Control:FindVGControlByName';
end;//TkwPopControlFindVGControlByName.GetWordNameForRegister

function TkwPopControlFindVGControlByName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvgObject);
end;//TkwPopControlFindVGControlByName.GetResultTypeInfo

function TkwPopControlFindVGControlByName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopControlFindVGControlByName.GetAllParamsCount

function TkwPopControlFindVGControlByName.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TWinControl), @tfw_tiString]);
end;//TkwPopControlFindVGControlByName.ParamsTypes

procedure TkwPopControlFindVGControlByName.DoDoIt(const aCtx: TtfwContext);
var l_aControl: TWinControl;
var l_aName: AnsiString;
begin
 try
  l_aControl := TWinControl(aCtx.rEngine.PopObjAs(TWinControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TWinControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aName := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aName: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(FindVGControlByName(aCtx, l_aControl, l_aName));
end;//TkwPopControlFindVGControlByName.DoDoIt

initialization
 TkwPopControlFindVGControlByName.RegisterInEngine;
 {* Регистрация pop_Control_FindVGControlByName }
{$If NOT Defined(NoVCL)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(TWinControl));
 {* Регистрация типа TWinControl }
{$IfEnd} // NOT Defined(NoVCL)
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvgObject));
 {* Регистрация типа TvgObject }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа AnsiString }
{$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoScripts)

end.
