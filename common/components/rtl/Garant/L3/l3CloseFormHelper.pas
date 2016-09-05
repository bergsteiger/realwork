unit l3CloseFormHelper;

// Модуль: "w:\common\components\rtl\Garant\L3\l3CloseFormHelper.pas"
// Стереотип: "Service"
// Элемент модели: "Tl3CloseFormHelper" MUID: (55014D810077)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

{$If NOT Defined(NoVCL)}
uses
 l3IntfUses
 , l3ProtoObject
 , Controls
;

 (*
 Ml3CloseFormHelper = interface
  {* Контракт сервиса Tl3CloseFormHelper }
  function Close(aControl: TWinControl): Boolean;
 end;//Ml3CloseFormHelper
 *)

type
 Il3CloseFormHelper = interface
  {* Интерфейс сервиса Tl3CloseFormHelper }
  function Close(aControl: TWinControl): Boolean;
 end;//Il3CloseFormHelper

 Tl3CloseFormHelper = {final} class(Tl3ProtoObject)
  private
   f_Alien: Il3CloseFormHelper;
    {* Внешняя реализация сервиса Il3CloseFormHelper }
  protected
   procedure pm_SetAlien(const aValue: Il3CloseFormHelper);
   procedure ClearFields; override;
  public
   function Close(aControl: TWinControl): Boolean;
   class function Instance: Tl3CloseFormHelper;
    {* Метод получения экземпляра синглетона Tl3CloseFormHelper }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
  public
   property Alien: Il3CloseFormHelper
    write pm_SetAlien;
    {* Внешняя реализация сервиса Il3CloseFormHelper }
 end;//Tl3CloseFormHelper
{$IfEnd} // NOT Defined(NoVCL)

implementation

{$If NOT Defined(NoVCL)}
uses
 l3ImplUses
 , Forms
 , SysUtils
 , l3Base
 //#UC START# *55014D810077impl_uses*
 //#UC END# *55014D810077impl_uses*
;

var g_Tl3CloseFormHelper: Tl3CloseFormHelper = nil;
 {* Экземпляр синглетона Tl3CloseFormHelper }

procedure Tl3CloseFormHelperFree;
 {* Метод освобождения экземпляра синглетона Tl3CloseFormHelper }
begin
 l3Free(g_Tl3CloseFormHelper);
end;//Tl3CloseFormHelperFree

procedure Tl3CloseFormHelper.pm_SetAlien(const aValue: Il3CloseFormHelper);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//Tl3CloseFormHelper.pm_SetAlien

function Tl3CloseFormHelper.Close(aControl: TWinControl): Boolean;
//#UC START# *A1E64DB467E3_55014D810077_var*
//#UC END# *A1E64DB467E3_55014D810077_var*
begin
//#UC START# *A1E64DB467E3_55014D810077_impl*
 Result := false;
 if (f_Alien <> nil) then
  Result := f_Alien.Close(aControl);
 if not Result then
  if (aControl Is TCustomForm) then
  begin
   TCustomForm(aControl).Close;
   Result := true;
  end;//aControl Is TCustomForm
//#UC END# *A1E64DB467E3_55014D810077_impl*
end;//Tl3CloseFormHelper.Close

class function Tl3CloseFormHelper.Instance: Tl3CloseFormHelper;
 {* Метод получения экземпляра синглетона Tl3CloseFormHelper }
begin
 if (g_Tl3CloseFormHelper = nil) then
 begin
  l3System.AddExitProc(Tl3CloseFormHelperFree);
  g_Tl3CloseFormHelper := Create;
 end;
 Result := g_Tl3CloseFormHelper;
end;//Tl3CloseFormHelper.Instance

class function Tl3CloseFormHelper.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tl3CloseFormHelper <> nil;
end;//Tl3CloseFormHelper.Exists

procedure Tl3CloseFormHelper.ClearFields;
begin
 Alien := nil;
 inherited;
end;//Tl3CloseFormHelper.ClearFields
{$IfEnd} // NOT Defined(NoVCL)

end.
