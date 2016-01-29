unit vcmStringIDExHelper;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM"
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/vcmStringIDExHelper.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::VCM::Implementation::vcmStringIDExHelper
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  l3ProtoObject,
  l3StringIDEx,
  l3Interfaces
  ;

type
 TvcmStringIDExHelper = {final} class(Tl3ProtoObject, Il3StringIDExHelper)
 public
 // realized methods
   procedure Init(var theStr: Tl3StringIDEx);
   function AsCStr(const aStr: Tl3StringIDEx): Il3CString;
   function AsStr(const aStr: Tl3StringIDEx): AnsiString;
 public
 // public methods
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 public
 // singleton factory method
   class function Instance: TvcmStringIDExHelper;
    {- возвращает экземпляр синглетона. }
 end;//TvcmStringIDExHelper
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}
uses
  l3Base {a},
  vcmBase
  ;


// start class TvcmStringIDExHelper

var g_TvcmStringIDExHelper : TvcmStringIDExHelper = nil;

procedure TvcmStringIDExHelperFree;
begin
 l3Free(g_TvcmStringIDExHelper);
end;

class function TvcmStringIDExHelper.Instance: TvcmStringIDExHelper;
begin
 if (g_TvcmStringIDExHelper = nil) then
 begin
  l3System.AddExitProc(TvcmStringIDExHelperFree);
  g_TvcmStringIDExHelper := Create;
 end;
 Result := g_TvcmStringIDExHelper;
end;


class function TvcmStringIDExHelper.Exists: Boolean;
 {-}
begin
 Result := g_TvcmStringIDExHelper <> nil;
end;//TvcmStringIDExHelper.Exists

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
{$IfEnd} //not NoVCM

initialization
{$If not defined(NoVCM)}
// Регистрация TvcmStringIDExHelper
 Tl3StringIDExHelper.Instance.Alien := TvcmStringIDExHelper.Instance;
{$IfEnd} //not NoVCM

end.