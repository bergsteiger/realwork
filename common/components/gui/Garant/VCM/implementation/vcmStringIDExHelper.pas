unit vcmStringIDExHelper;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\vcmStringIDExHelper.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "vcmStringIDExHelper" MUID: (55714DD30399)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , l3ProtoObject
 , l3StringIDEx
 , l3Interfaces
;

type
 TvcmStringIDExHelper = {final} class(Tl3ProtoObject, Il3StringIDExHelper)
  public
   function AsCStr(const aStr: Tl3StringIDEx): Il3CString;
   function AsStr(const aStr: Tl3StringIDEx): AnsiString;
   procedure Init(var theStr: Tl3StringIDEx);
   class function Instance: TvcmStringIDExHelper;
    {* Метод получения экземпляра синглетона TvcmStringIDExHelper }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TvcmStringIDExHelper
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , vcmBase
 , l3Base
 , SysUtils
 //#UC START# *55714DD30399impl_uses*
 //#UC END# *55714DD30399impl_uses*
;

var g_TvcmStringIDExHelper: TvcmStringIDExHelper = nil;
 {* Экземпляр синглетона TvcmStringIDExHelper }

procedure TvcmStringIDExHelperFree;
 {* Метод освобождения экземпляра синглетона TvcmStringIDExHelper }
begin
 l3Free(g_TvcmStringIDExHelper);
end;//TvcmStringIDExHelperFree

function TvcmStringIDExHelper.AsCStr(const aStr: Tl3StringIDEx): Il3CString;
//#UC START# *201B50E5979A_4B98D9FD038B_var*
//#UC END# *201B50E5979A_4B98D9FD038B_var*
begin
//#UC START# *201B50E5979A_4B98D9FD038B_impl*
 {$IfDef IsVCMProject}
 if (aStr.rS = -1) OR aStr.rLocalized then
  Result := l3CStr(aStr.rValue)
 else
  Result := vcmCStr(aStr);
 {$Else  IsVCMProject}
 Result := l3CStr(aStr.rValue);
 {$EndIf IsVCMProject}
//#UC END# *201B50E5979A_4B98D9FD038B_impl*
end;//TvcmStringIDExHelper.AsCStr

function TvcmStringIDExHelper.AsStr(const aStr: Tl3StringIDEx): AnsiString;
//#UC START# *74E80608E1B4_4B98D9FD038B_var*
//#UC END# *74E80608E1B4_4B98D9FD038B_var*
begin
//#UC START# *74E80608E1B4_4B98D9FD038B_impl*
 {$If Defined(DesignTimeLibrary) OR not Defined(IsVCMProject)}
 Result := aStr.rValue;
 {$Else}
 if (aStr.rS = -1) OR aStr.rLocalized then
  Result := aStr.rValue
 else
  Result := vcmConstString(aStr);
 {$IfEnd}
//#UC END# *74E80608E1B4_4B98D9FD038B_impl*
end;//TvcmStringIDExHelper.AsStr

procedure TvcmStringIDExHelper.Init(var theStr: Tl3StringIDEx);
//#UC START# *071573E75439_4B98D9FD038B_var*
//#UC END# *071573E75439_4B98D9FD038B_var*
begin
//#UC START# *071573E75439_4B98D9FD038B_impl*
 {$If Defined(IsVCMProject) OR Defined(DesignTimeLibrary)}
 inherited;
 if (theStr.rValue <> '') then
  vcmInitConstString(theStr);
 {$Else}
 theStr.rS := -1;
 {$IfEnd}
//#UC END# *071573E75439_4B98D9FD038B_impl*
end;//TvcmStringIDExHelper.Init

class function TvcmStringIDExHelper.Instance: TvcmStringIDExHelper;
 {* Метод получения экземпляра синглетона TvcmStringIDExHelper }
begin
 if (g_TvcmStringIDExHelper = nil) then
 begin
  l3System.AddExitProc(TvcmStringIDExHelperFree);
  g_TvcmStringIDExHelper := Create;
 end;
 Result := g_TvcmStringIDExHelper;
end;//TvcmStringIDExHelper.Instance

class function TvcmStringIDExHelper.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TvcmStringIDExHelper <> nil;
end;//TvcmStringIDExHelper.Exists

initialization
 Tl3StringIDExHelper.Instance.Alien := TvcmStringIDExHelper.Instance;
 {* Регистрация TvcmStringIDExHelper }
{$IfEnd} // NOT Defined(NoVCM)

end.
