unit ddAppConfigVersions;

// Модуль: "w:\common\components\rtl\Garant\dd\ddAppConfigVersions.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "ddAppConfigVersions" MUID: (52149B3F0208)

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , ddConfigStorages
 , l3Base
 , l3RecList
;

type
 Pdd_acVersionHandler = ^Tdd_acVersionHandler;

 Tdd_acVersionUpgradeProc = procedure(const aStorage: IddConfigStorage);

 Tdd_acVersionHandler = record
  FromVersion: Integer;
  ToVersion: Integer;
  Proc: Tdd_acVersionUpgradeProc;
 end;//Tdd_acVersionHandler

 TddAppConfigVersionManager = class(Tl3Base)
  private
   f_Handlers: Tl3RecList;
  private
   function FindHandler(aFromVersion: Integer;
    out aHandler: Tdd_acVersionHandler): Boolean;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   procedure AddHandler(aFromVersion: Integer;
    aToVersion: Integer;
    aProc: Tdd_acVersionUpgradeProc);
   procedure Upgrade(aFromVersion: Integer;
    aToVersion: Integer;
    const aStorage: IddConfigStorage);
   constructor Create; override;
    {* конструктор объекта. Возвращает объект, со счетчиком ссылок равным 1. }
 end;//TddAppConfigVersionManager

implementation

uses
 l3ImplUses
 , SysUtils
 //#UC START# *52149B3F0208impl_uses*
 //#UC END# *52149B3F0208impl_uses*
;

function TddAppConfigVersionManager.FindHandler(aFromVersion: Integer;
 out aHandler: Tdd_acVersionHandler): Boolean;
//#UC START# *52315563028B_52149B620261_var*
var
 I: Integer;
 l_H: Tdd_acVersionHandler;
//#UC END# *52315563028B_52149B620261_var*
begin
//#UC START# *52315563028B_52149B620261_impl*
 Result  := False;
 for I := 0 to f_Handlers.Hi do
 begin
  l_H := Pdd_acVersionHandler(f_Handlers.ItemSlot(I))^;
  if l_H.FromVersion = aFromVersion then
  begin
   aHandler := l_H;
   Result := True;
   Break;
  end;
 end;
//#UC END# *52315563028B_52149B620261_impl*
end;//TddAppConfigVersionManager.FindHandler

procedure TddAppConfigVersionManager.AddHandler(aFromVersion: Integer;
 aToVersion: Integer;
 aProc: Tdd_acVersionUpgradeProc);
//#UC START# *5231558003C0_52149B620261_var*
var
 l_H: Tdd_acVersionHandler;
//#UC END# *5231558003C0_52149B620261_var*
begin
//#UC START# *5231558003C0_52149B620261_impl*
 if not FindHandler(aFromVersion, l_H) then
 begin
  l_H.FromVersion := aFromVersion;
  l_H.ToVersion := aToVersion;
  l_H.Proc := aProc;
  f_Handlers.Add(l_H);
 end
 else
  raise Exception.CreateFmt('Дублирование обработчика для версии %d', [aFromVersion]);
//#UC END# *5231558003C0_52149B620261_impl*
end;//TddAppConfigVersionManager.AddHandler

procedure TddAppConfigVersionManager.Upgrade(aFromVersion: Integer;
 aToVersion: Integer;
 const aStorage: IddConfigStorage);
//#UC START# *523155A20230_52149B620261_var*
var
 l_Handler: Tdd_acVersionHandler;
 l_CurVersion: Integer;
//#UC END# *523155A20230_52149B620261_var*
begin
//#UC START# *523155A20230_52149B620261_impl*
 l_CurVersion := aFromVersion;
 while l_CurVersion < aToVersion do
  if FindHandler(l_CurVersion, l_Handler) then
  begin
   l_Handler.Proc(aStorage);
   l_CurVersion := l_Handler.ToVersion;
  end
  else
   Break; // Выругаться?
//#UC END# *523155A20230_52149B620261_impl*
end;//TddAppConfigVersionManager.Upgrade

constructor TddAppConfigVersionManager.Create;
 {* конструктор объекта. Возвращает объект, со счетчиком ссылок равным 1. }
//#UC START# *47914F960008_52149B620261_var*
//#UC END# *47914F960008_52149B620261_var*
begin
//#UC START# *47914F960008_52149B620261_impl*
 inherited;
 f_Handlers := Tl3RecList.Create(SizeOf(Tdd_acVersionHandler));
//#UC END# *47914F960008_52149B620261_impl*
end;//TddAppConfigVersionManager.Create

procedure TddAppConfigVersionManager.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_52149B620261_var*
//#UC END# *479731C50290_52149B620261_var*
begin
//#UC START# *479731C50290_52149B620261_impl*
 l3Free(f_Handlers);
 inherited;
//#UC END# *479731C50290_52149B620261_impl*
end;//TddAppConfigVersionManager.Cleanup

end.
