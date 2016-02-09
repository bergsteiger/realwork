unit l3IterateComponentParents;

// Модуль: "w:\common\components\rtl\Garant\L3\l3IterateComponentParents.pas"
// Стереотип: "Service"

{$Include l3Define.inc}

interface

{$If NOT Defined(NoVCL)}
uses
 l3IntfUses
 , l3ProtoObject
 , Classes
;

type
 Ml3IterateComponentParents_IterateF_Action = function(anItem: TComponent): Boolean;
  {* Тип подитеративной функции для Ml3IterateComponentParents.IterateF }

 (*
 Ml3IterateComponentParents = interface
  {* Контракт сервиса Tl3IterateComponentParents }
  procedure IterateF(anAction: Ml3IterateComponentParents_IterateF_Action;
   aComponent: TComponent);
 end;//Ml3IterateComponentParents
 *)

 Il3IterateComponentParents = interface
  {* Интерфейс сервиса Tl3IterateComponentParents }
  ['{5A7F04AD-BABF-4265-8160-3A5BDA277D22}']
  procedure IterateF(anAction: Ml3IterateComponentParents_IterateF_Action;
   aComponent: TComponent);
 end;//Il3IterateComponentParents

 Tl3IterateComponentParents = {final} class(Tl3ProtoObject)
  private
   f_Alien: Il3IterateComponentParents;
    {* Поле для свойства Alien }
  protected
   procedure pm_SetAlien(const aValue: Il3IterateComponentParents);
   procedure ClearFields; override;
  public
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   procedure IterateF(anAction: Ml3IterateComponentParents_IterateF_Action;
    aComponent: TComponent);
   class function Instance: Tl3IterateComponentParents;
    {* Метод получения экземпляра синглетона Tl3IterateComponentParents }
  public
   property Alien: Il3IterateComponentParents
    write pm_SetAlien;
    {* Внешняя реализация сервиса Il3IterateComponentParents }
 end;//Tl3IterateComponentParents

function L2Ml3IterateComponentParentsIterateFAction(anAction: pointer): Ml3IterateComponentParents_IterateF_Action;
 {* Функция формирования заглушки для ЛОКАЛЬНОЙ подитеративной функции для Ml3IterateComponentParents.IterateF }
{$IfEnd} // NOT Defined(NoVCL)

implementation

{$If NOT Defined(NoVCL)}
uses
 l3ImplUses
 , Controls
 , SysUtils
 , l3Base
;

var g_Tl3IterateComponentParents: Tl3IterateComponentParents = nil;
 {* Экземпляр синглетона Tl3IterateComponentParents }

function L2Ml3IterateComponentParentsIterateFAction(anAction: pointer): Ml3IterateComponentParents_IterateF_Action;
 {* Функция формирования заглушки для ЛОКАЛЬНОЙ подитеративной функции для Ml3IterateComponentParents.IterateF }
asm
 jmp l3LocalStub
end;//L2Ml3IterateComponentParentsIterateFAction

procedure Tl3IterateComponentParentsFree;
 {* Метод освобождения экземпляра синглетона Tl3IterateComponentParents }
begin
 l3Free(g_Tl3IterateComponentParents);
end;//Tl3IterateComponentParentsFree

procedure Tl3IterateComponentParents.pm_SetAlien(const aValue: Il3IterateComponentParents);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//Tl3IterateComponentParents.pm_SetAlien

class function Tl3IterateComponentParents.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tl3IterateComponentParents <> nil;
end;//Tl3IterateComponentParents.Exists

procedure Tl3IterateComponentParents.IterateF(anAction: Ml3IterateComponentParents_IterateF_Action;
 aComponent: TComponent);
//#UC START# *3410F441967F_551AA9BD01EE_var*
var
 Hack : Pointer absolute anAction;
 l_C: TControl;
//#UC END# *3410F441967F_551AA9BD01EE_var*
begin
//#UC START# *3410F441967F_551AA9BD01EE_impl*
 if Assigned(f_Alien) then
  f_Alien.IterateF(anAction, aComponent)
 else
 begin
  try
   anAction(aComponent);
   if aComponent is TControl then
   begin
    l_C := TControl(aComponent);
    while Assigned(l_C.Parent) do
    begin
     l_C := l_C.Parent;
     anAction(l_C);
    end;
   end;
  finally
   l3FreeLocalStub(Hack);
  end;//try..finally
 end;//f_Alien <> nil
//#UC END# *3410F441967F_551AA9BD01EE_impl*
end;//Tl3IterateComponentParents.IterateF

class function Tl3IterateComponentParents.Instance: Tl3IterateComponentParents;
 {* Метод получения экземпляра синглетона Tl3IterateComponentParents }
begin
 if (g_Tl3IterateComponentParents = nil) then
 begin
  l3System.AddExitProc(Tl3IterateComponentParentsFree);
  g_Tl3IterateComponentParents := Create;
 end;
 Result := g_Tl3IterateComponentParents;
end;//Tl3IterateComponentParents.Instance

procedure Tl3IterateComponentParents.ClearFields;
begin
 Alien := nil;
 inherited;
end;//Tl3IterateComponentParents.ClearFields
{$IfEnd} // NOT Defined(NoVCL)

end.
