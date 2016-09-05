unit csTaskChangeHelper;

// Модуль: "w:\common\components\rtl\Garant\cs\csTaskChangeHelper.pas"
// Стереотип: "Service"
// Элемент модели: "TcsTaskChangeHelper" MUID: (5583BE960064)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , l3ProtoObject
;

 (*
 McsTaskChangeHelper = interface
  {* Контракт сервиса TcsTaskChangeHelper }
  procedure TaskGotErrorStatus;
 end;//McsTaskChangeHelper
 *)

type
 IcsTaskChangeHelper = interface
  {* Интерфейс сервиса TcsTaskChangeHelper }
  procedure TaskGotErrorStatus;
 end;//IcsTaskChangeHelper

 TcsTaskChangeHelper = {final} class(Tl3ProtoObject)
  private
   f_Alien: IcsTaskChangeHelper;
    {* Внешняя реализация сервиса IcsTaskChangeHelper }
  protected
   procedure pm_SetAlien(const aValue: IcsTaskChangeHelper);
   procedure ClearFields; override;
  public
   procedure TaskGotErrorStatus;
   class function Instance: TcsTaskChangeHelper;
    {* Метод получения экземпляра синглетона TcsTaskChangeHelper }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
  public
   property Alien: IcsTaskChangeHelper
    write pm_SetAlien;
    {* Внешняя реализация сервиса IcsTaskChangeHelper }
 end;//TcsTaskChangeHelper
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
 //#UC START# *5583BE960064impl_uses*
 //#UC END# *5583BE960064impl_uses*
;

var g_TcsTaskChangeHelper: TcsTaskChangeHelper = nil;
 {* Экземпляр синглетона TcsTaskChangeHelper }

procedure TcsTaskChangeHelperFree;
 {* Метод освобождения экземпляра синглетона TcsTaskChangeHelper }
begin
 l3Free(g_TcsTaskChangeHelper);
end;//TcsTaskChangeHelperFree

procedure TcsTaskChangeHelper.pm_SetAlien(const aValue: IcsTaskChangeHelper);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//TcsTaskChangeHelper.pm_SetAlien

procedure TcsTaskChangeHelper.TaskGotErrorStatus;
//#UC START# *F75B4443B80B_5583BE960064_var*
//#UC END# *F75B4443B80B_5583BE960064_var*
begin
//#UC START# *F75B4443B80B_5583BE960064_impl*
 if Assigned(f_Alien) then
  f_Alien.TaskGotErrorStatus;
//#UC END# *F75B4443B80B_5583BE960064_impl*
end;//TcsTaskChangeHelper.TaskGotErrorStatus

class function TcsTaskChangeHelper.Instance: TcsTaskChangeHelper;
 {* Метод получения экземпляра синглетона TcsTaskChangeHelper }
begin
 if (g_TcsTaskChangeHelper = nil) then
 begin
  l3System.AddExitProc(TcsTaskChangeHelperFree);
  g_TcsTaskChangeHelper := Create;
 end;
 Result := g_TcsTaskChangeHelper;
end;//TcsTaskChangeHelper.Instance

class function TcsTaskChangeHelper.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TcsTaskChangeHelper <> nil;
end;//TcsTaskChangeHelper.Exists

procedure TcsTaskChangeHelper.ClearFields;
begin
 Alien := nil;
 inherited;
end;//TcsTaskChangeHelper.ClearFields
{$IfEnd} // NOT Defined(Nemesis)

end.
