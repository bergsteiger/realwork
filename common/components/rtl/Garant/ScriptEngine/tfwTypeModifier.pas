unit tfwTypeModifier;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwTypeModifier.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TtfwTypeModifier" MUID: (5571AC8301BE)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwModifier
 , TypInfo
 , tfwTypeInfo
;

type
 TtfwClassModifier = class(TkwModifier)
  private
   f_Class: TClass;
  protected
   function pm_GetModifier: TtfwTypeInfo; override;
   class function ReallyNeedRegister: Boolean; override;
  public
   constructor Create(aClass: TClass); reintroduce;
 end;//TtfwClassModifier

 TtfwTypeModifier = class(TkwModifier)
  private
   f_TypeInfo: PTypeInfo;
  protected
   function pm_GetModifier: TtfwTypeInfo; override;
   class function ReallyNeedRegister: Boolean; override;
  public
   class function RegisterTypeModifier(aTypeInfo: PTypeInfo): Boolean; overload;
   constructor Create(aTypeInfo: PTypeInfo); reintroduce;
   class function RegisterTypeModifier(aClass: TClass): Boolean; overload;
 end;//TtfwTypeModifier
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , SysUtils
 //#UC START# *5571AC8301BEimpl_uses*
 //#UC END# *5571AC8301BEimpl_uses*
;

constructor TtfwClassModifier.Create(aClass: TClass);
//#UC START# *557555A801C1_55755516000B_var*
//#UC END# *557555A801C1_55755516000B_var*
begin
//#UC START# *557555A801C1_55755516000B_impl*
 inherited Create;
 f_Class := aClass;
//#UC END# *557555A801C1_55755516000B_impl*
end;//TtfwClassModifier.Create

function TtfwClassModifier.pm_GetModifier: TtfwTypeInfo;
//#UC START# *4DCACED80361_55755516000Bget_var*
//#UC END# *4DCACED80361_55755516000Bget_var*
begin
//#UC START# *4DCACED80361_55755516000Bget_impl*
 {$IfDef seTypeCheck}
 Result := TtfwTypeInfo_C(f_Class);
 {$Else  seTypeCheck}
 Result := TtfwTypeInfo_C(TypeInfo(TObject));
 {$EndIf seTypeCheck}
//#UC END# *4DCACED80361_55755516000Bget_impl*
end;//TtfwClassModifier.pm_GetModifier

class function TtfwClassModifier.ReallyNeedRegister: Boolean;
//#UC START# *4DC2E05B03DD_55755516000B_var*
//#UC END# *4DC2E05B03DD_55755516000B_var*
begin
//#UC START# *4DC2E05B03DD_55755516000B_impl*
 Result := false;
//#UC END# *4DC2E05B03DD_55755516000B_impl*
end;//TtfwClassModifier.ReallyNeedRegister

class function TtfwTypeModifier.RegisterTypeModifier(aTypeInfo: PTypeInfo): Boolean;
//#UC START# *5571B1010311_5571AC8301BE_var*
var
 l_W : TtfwTypeModifier;
//#UC END# *5571B1010311_5571AC8301BE_var*
begin
//#UC START# *5571B1010311_5571AC8301BE_impl*
 Result := false;
 if (aTypeInfo = nil) then
  Exit;
 l_W := Create(aTypeInfo);
 try
  Result := l_W.RegisterInstance(aTypeInfo.Name);
 finally
  FreeAndNil(l_W);
 end;//try..finally
//#UC END# *5571B1010311_5571AC8301BE_impl*
end;//TtfwTypeModifier.RegisterTypeModifier

constructor TtfwTypeModifier.Create(aTypeInfo: PTypeInfo);
//#UC START# *5571B317010B_5571AC8301BE_var*
//#UC END# *5571B317010B_5571AC8301BE_var*
begin
//#UC START# *5571B317010B_5571AC8301BE_impl*
 inherited Create;
 f_TypeInfo := aTypeInfo;
//#UC END# *5571B317010B_5571AC8301BE_impl*
end;//TtfwTypeModifier.Create

class function TtfwTypeModifier.RegisterTypeModifier(aClass: TClass): Boolean;
//#UC START# *5575557101EC_5571AC8301BE_var*
var
 l_CI : PTypeInfo;
 l_CM : TtfwClassModifier;
//#UC END# *5575557101EC_5571AC8301BE_var*
begin
//#UC START# *5575557101EC_5571AC8301BE_impl*
 l_CI := aClass.ClassInfo;
 if (l_CI <> nil) then
  Result := RegisterTypeModifier(l_CI)
 else
 begin
  l_CM := TtfwClassModifier.Create(aClass);
  try
   Result := l_CM.RegisterInstance(aClass.ClassName);
  finally
   FreeAndNil(l_CM);
  end;//try..finally
 end;//l_CI <> nil
//#UC END# *5575557101EC_5571AC8301BE_impl*
end;//TtfwTypeModifier.RegisterTypeModifier

function TtfwTypeModifier.pm_GetModifier: TtfwTypeInfo;
//#UC START# *4DCACED80361_5571AC8301BEget_var*
//#UC END# *4DCACED80361_5571AC8301BEget_var*
begin
//#UC START# *4DCACED80361_5571AC8301BEget_impl*
 Assert(f_TypeInfo <> nil);
 Result := TtfwTypeInfo_C(f_TypeInfo);
//#UC END# *4DCACED80361_5571AC8301BEget_impl*
end;//TtfwTypeModifier.pm_GetModifier

class function TtfwTypeModifier.ReallyNeedRegister: Boolean;
//#UC START# *4DC2E05B03DD_5571AC8301BE_var*
//#UC END# *4DC2E05B03DD_5571AC8301BE_var*
begin
//#UC START# *4DC2E05B03DD_5571AC8301BE_impl*
 Result := false;
//#UC END# *4DC2E05B03DD_5571AC8301BE_impl*
end;//TtfwTypeModifier.ReallyNeedRegister

initialization
 TtfwClassModifier.RegisterInEngine;
 {* Регистрация TtfwClassModifier }
 TtfwTypeModifier.RegisterInEngine;
 {* Регистрация TtfwTypeModifier }
{$IfEnd} // NOT Defined(NoScripts)

end.
