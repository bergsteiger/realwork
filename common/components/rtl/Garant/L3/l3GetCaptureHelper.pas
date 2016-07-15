unit l3GetCaptureHelper;

// Модуль: "w:\common\components\rtl\Garant\L3\l3GetCaptureHelper.pas"
// Стереотип: "Service"
// Элемент модели: "Tl3GetCaptureHelper" MUID: (55226C5F035A)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

{$If NOT Defined(NoVCL)}
uses
 l3IntfUses
 , l3ProtoObject
 , Classes
;

 (*
 Ml3GetCaptureHelper = interface
  {* Контракт сервиса Tl3GetCaptureHelper }
  function GetCapture: TComponent;
 end;//Ml3GetCaptureHelper
 *)

type
 Il3GetCaptureHelper = interface
  {* Интерфейс сервиса Tl3GetCaptureHelper }
  function GetCapture: TComponent;
 end;//Il3GetCaptureHelper

 Tl3GetCaptureHelper = {final} class(Tl3ProtoObject)
  private
   f_Alien: Il3GetCaptureHelper;
    {* Внешняя реализация сервиса Il3GetCaptureHelper }
  protected
   procedure pm_SetAlien(const aValue: Il3GetCaptureHelper);
   procedure ClearFields; override;
  public
   function GetCapture: TComponent;
   class function Instance: Tl3GetCaptureHelper;
    {* Метод получения экземпляра синглетона Tl3GetCaptureHelper }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
  public
   property Alien: Il3GetCaptureHelper
    write pm_SetAlien;
    {* Внешняя реализация сервиса Il3GetCaptureHelper }
 end;//Tl3GetCaptureHelper
{$IfEnd} // NOT Defined(NoVCL)

implementation

{$If NOT Defined(NoVCL)}
uses
 l3ImplUses
 , Controls
 , SysUtils
 , l3Base
;

var g_Tl3GetCaptureHelper: Tl3GetCaptureHelper = nil;
 {* Экземпляр синглетона Tl3GetCaptureHelper }

procedure Tl3GetCaptureHelperFree;
 {* Метод освобождения экземпляра синглетона Tl3GetCaptureHelper }
begin
 l3Free(g_Tl3GetCaptureHelper);
end;//Tl3GetCaptureHelperFree

procedure Tl3GetCaptureHelper.pm_SetAlien(const aValue: Il3GetCaptureHelper);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//Tl3GetCaptureHelper.pm_SetAlien

function Tl3GetCaptureHelper.GetCapture: TComponent;
//#UC START# *FC96CEF34C46_55226C5F035A_var*
//#UC END# *FC96CEF34C46_55226C5F035A_var*
begin
//#UC START# *FC96CEF34C46_55226C5F035A_impl*
 if Assigned(f_Alien) then
  Result := f_Alien.GetCapture
 else
  Result := GetCaptureControl;
//#UC END# *FC96CEF34C46_55226C5F035A_impl*
end;//Tl3GetCaptureHelper.GetCapture

class function Tl3GetCaptureHelper.Instance: Tl3GetCaptureHelper;
 {* Метод получения экземпляра синглетона Tl3GetCaptureHelper }
begin
 if (g_Tl3GetCaptureHelper = nil) then
 begin
  l3System.AddExitProc(Tl3GetCaptureHelperFree);
  g_Tl3GetCaptureHelper := Create;
 end;
 Result := g_Tl3GetCaptureHelper;
end;//Tl3GetCaptureHelper.Instance

class function Tl3GetCaptureHelper.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tl3GetCaptureHelper <> nil;
end;//Tl3GetCaptureHelper.Exists

procedure Tl3GetCaptureHelper.ClearFields;
begin
 Alien := nil;
 inherited;
end;//Tl3GetCaptureHelper.ClearFields
{$IfEnd} // NOT Defined(NoVCL)

end.
