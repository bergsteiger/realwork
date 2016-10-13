unit msmDeletedElements;

// Модуль: "w:\common\components\gui\Garant\msm\msmDeletedElements.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmDeletedElements" MUID: (57F7BBC60360)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , msmChangedElementsPrim
;

type
 TmsmDeletedElements = class(TmsmChangedElementsPrim)
  public
   class function Instance: TmsmDeletedElements;
    {* Метод получения экземпляра синглетона TmsmDeletedElements }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TmsmDeletedElements

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , msmChangedElementsPack
 {$IfEnd} // NOT Defined(NoScripts)
 , SysUtils
 , l3Base
 //#UC START# *57F7BBC60360impl_uses*
 //#UC END# *57F7BBC60360impl_uses*
;

var g_TmsmDeletedElements: TmsmDeletedElements = nil;
 {* Экземпляр синглетона TmsmDeletedElements }

procedure TmsmDeletedElementsFree;
 {* Метод освобождения экземпляра синглетона TmsmDeletedElements }
begin
 l3Free(g_TmsmDeletedElements);
end;//TmsmDeletedElementsFree

class function TmsmDeletedElements.Instance: TmsmDeletedElements;
 {* Метод получения экземпляра синглетона TmsmDeletedElements }
begin
 if (g_TmsmDeletedElements = nil) then
 begin
  l3System.AddExitProc(TmsmDeletedElementsFree);
  g_TmsmDeletedElements := Create;
 end;
 Result := g_TmsmDeletedElements;
end;//TmsmDeletedElements.Instance

class function TmsmDeletedElements.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TmsmDeletedElements <> nil;
end;//TmsmDeletedElements.Exists

end.
