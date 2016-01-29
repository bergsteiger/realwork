unit tfwClassRef;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ScriptEngine$Core"
// ������: "tfwClassRef.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: SimpleClass::Class Shared Delphi Low Level::ScriptEngine$Core::PrimitiveWords::TtfwClassRef
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  tfwRegisterableWordPrim,
  TypInfo,
  tfwScriptingInterfaces
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
type
 TtfwClassRef = class(TtfwRegisterableWordPrim)
 private
 // private fields
   f_Class : TClass;
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
 public
 // public methods
   constructor Create(aClass: TClass); reintroduce;
   class function Register(aClass: TClass): Boolean; overload; 
   class procedure Register(const aClasses: array of TClass); overload; 
 end;//TtfwClassRef
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  SysUtils,
  l3Except,
  l3Base,
  StrUtils,
  tfwTypeModifier,
  tfwScriptingTypes,
  tfwRTTIProperty,
  tfwEnumRegistrator,
  tfwTypeRegistrator
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class TtfwClassRef

constructor TtfwClassRef.Create(aClass: TClass);
//#UC START# *5085292201A0_508528D10384_var*
//#UC END# *5085292201A0_508528D10384_var*
begin
//#UC START# *5085292201A0_508528D10384_impl*
 inherited Create;
 f_Class := aClass;
//#UC END# *5085292201A0_508528D10384_impl*
end;//TtfwClassRef.Create

class function TtfwClassRef.Register(aClass: TClass): Boolean;
//#UC START# *50853350035F_508528D10384_var*

 procedure RegisterProps(aMixIn : Boolean; aClass : TClass); forward;

 function RegisterClass(aClass: TClass): Boolean;
 var
  l_W : TtfwClassRef;
  l_N : AnsiString;
  l_MixIn : Boolean;
 begin//RegisterClass
  Result := true;
  l_N := aClass.ClassName;
  l_MixIn := true;
  if not ANSIStartsStr('_', l_N) then
  // - ���������� �������
  begin
   l_MixIn := false;
   l_W := TtfwClassRef.Create(aClass);
   try
    try
     Result := l_W.RegisterInstance('class::' + l_N);
    except
     on El3DuplicateItem do
      Result := false;
    end;//try..except
   finally
    FreeAndNil(l_W);
   end;//try..finally
  end;//not ANSIStartsStr('_', l_N)
  if Result then
  begin
   RegisterProps(l_MixIn, aClass);
   if not l_MixIn then
    TtfwTypeModifier.RegisterTypeModifier(aClass);
   Register := true; 
  end;//Result
 end;//RegisterClass

 procedure RegisterClassRecursive(aClass: TClass);
 begin
  while (aClass <> nil) do
  begin
   if not RegisterClass(aClass) then
    break;
   aClass := aClass.ClassParent;
  end;//while (aClass <> nil)
 end;

 procedure RegisterProps(aMixIn : Boolean; aClass : TClass);
 var
   I, Count: Integer;
   PropInfo: PPropInfo;
   TempList: PPropList;
   l_Class : TClass;
 begin//RegisterProps
  if (aClass.ClassInfo = nil) then
   Exit;
  Count := GetPropList(aClass.ClassInfo, TempList);
  if Count > 0 then
  try
   for I := 0 to Count - 1 do
   begin
    PropInfo := TempList^[I];
    Case PropInfo^.PropType^.Kind of
     tkEnumeration:
      TtfwEnumRegistrator.RegisterEnum(PropInfo^.PropType^);
     tkInteger:
      TtfwTypeRegistrator.RegisterType(PropInfo^.PropType^);
     tkClass:
     begin
      l_Class := GetTypeData(PropInfo^.PropType^).ClassType;
      if (l_Class <> aClass) then
       RegisterClassRecursive(l_Class);
     end//tkClass
     else
      ;
      // - ������ �� ������
    end;//Case PropInfo^.PropType^.Kind
    if not aMixIn then
     TtfwRTTIProperty.Register(aClass, PropInfo);
   end;//for I
  finally
   FreeMem(TempList);
  end;//try..finally
 end;//RegisterProps

//#UC END# *50853350035F_508528D10384_var*
begin
//#UC START# *50853350035F_508528D10384_impl*
 Result := false;
 if (Self = aClass) then
  Exit;
 RegisterClassRecursive(aClass);
//#UC END# *50853350035F_508528D10384_impl*
end;//TtfwClassRef.Register

class procedure TtfwClassRef.Register(const aClasses: array of TClass);
//#UC START# *53E0F85002E1_508528D10384_var*
var
 l_Index : Integer;
//#UC END# *53E0F85002E1_508528D10384_var*
begin
//#UC START# *53E0F85002E1_508528D10384_impl*
 for l_Index := Low(aClasses) to High(aClasses) do
  Register(aClasses[l_Index]);
//#UC END# *53E0F85002E1_508528D10384_impl*
end;//TtfwClassRef.Register

procedure TtfwClassRef.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_508528D10384_var*
//#UC END# *4DAEEDE10285_508528D10384_var*
begin
//#UC START# *4DAEEDE10285_508528D10384_impl*
 aCtx.rEngine.PushClass(f_Class);
//#UC END# *4DAEEDE10285_508528D10384_impl*
end;//TtfwClassRef.DoDoIt

function TtfwClassRef.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_508528D10384_var*
//#UC END# *551544E2001A_508528D10384_var*
begin
//#UC START# *551544E2001A_508528D10384_impl*
 Result := @tfw_tiClassRef;
//#UC END# *551544E2001A_508528D10384_impl*
end;//TtfwClassRef.GetResultTypeInfo

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� TtfwClassRef
 TtfwClassRef.RegisterClass;
{$IfEnd} //not NoScripts

end.