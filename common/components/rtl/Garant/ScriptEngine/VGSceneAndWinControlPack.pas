unit VGSceneAndWinControlPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ScriptEngine$VG"
// ������: "VGSceneAndWinControlPack.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: ScriptKeywordsPack::Class Shared Delphi::ScriptEngine$VG::VGSceneWords::VGSceneAndWinControlPack
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts) AND not defined(NoVGScene)}
uses
  Classes
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  ,
  vgObject,
  tfwScriptingInterfaces,
  tfwClassLike
  ;

{$IfEnd} //not NoScripts AND not NoVGScene

implementation

{$If not defined(NoScripts) AND not defined(NoVGScene)}
uses
  vg_controls,
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
 TkwPopControlFindVGControlByName = {final scriptword} class(TtfwClassLike)
  {* ����� ������� pop:Control:FindVGControlByName
*��� ����������:* TvgObject
*������:*
[code]
OBJECT VAR l_TvgObject
 aName aControl pop:Control:FindVGControlByName >>> l_TvgObject
[code]  }
 private
 // private methods
   function FindVGControlByName(const aCtx: TtfwContext;
    aControl: TWinControl;
    const aName: AnsiString): TvgObject;
     {* ���������� ����� ������� pop:Control:FindVGControlByName }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopControlFindVGControlByName

// start class TkwPopControlFindVGControlByName

function TkwPopControlFindVGControlByName.FindVGControlByName(const aCtx: TtfwContext;
  aControl: TWinControl;
  const aName: AnsiString): TvgObject;
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
 {-}
var
 l_aControl : TWinControl;
 l_aName : AnsiString;
begin
 try
  l_aControl := TWinControl(aCtx.rEngine.PopObjAs(TWinControl));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aControl: TWinControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aName := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aName: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((FindVGControlByName(aCtx, l_aControl, l_aName)));
end;//TkwPopControlFindVGControlByName.DoDoIt

class function TkwPopControlFindVGControlByName.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Control:FindVGControlByName';
end;//TkwPopControlFindVGControlByName.GetWordNameForRegister

function TkwPopControlFindVGControlByName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvgObject);
end;//TkwPopControlFindVGControlByName.GetResultTypeInfo

function TkwPopControlFindVGControlByName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwPopControlFindVGControlByName.GetAllParamsCount

function TkwPopControlFindVGControlByName.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TWinControl), TypeInfo(AnsiString)]);
end;//TkwPopControlFindVGControlByName.ParamsTypes
{$IfEnd} //not NoScripts AND not NoVGScene

initialization
{$If not defined(NoScripts) AND not defined(NoVGScene)}
// ����������� pop_Control_FindVGControlByName
 TkwPopControlFindVGControlByName.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVGScene
{$If not defined(NoScripts) AND not defined(NoVGScene)}
// ����������� ���� TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not NoScripts AND not NoVGScene
{$If not defined(NoScripts) AND not defined(NoVGScene)}
// ����������� ���� TWinControl
 TtfwTypeRegistrator.RegisterType(TypeInfo(TWinControl));
{$IfEnd} //not NoScripts AND not NoVGScene
{$If not defined(NoScripts) AND not defined(NoVGScene)}
// ����������� ���� String
 TtfwTypeRegistrator.RegisterType(TypeInfo(AnsiString));
{$IfEnd} //not NoScripts AND not NoVGScene
{$If not defined(NoScripts) AND not defined(NoVGScene)}
// ����������� ���� TvgObject
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvgObject));
{$IfEnd} //not NoScripts AND not NoVGScene

end.