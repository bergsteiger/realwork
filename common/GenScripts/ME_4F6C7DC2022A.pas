unit afwSettingsImplSing;

// Модуль: "w:\common\components\gui\Garant\AFW\afwSettingsImplSing.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\gui\Garant\AFW\afwDefine.inc}

interface

uses
 l3IntfUses
 , afwSettingsImplPersistent
;

type
 TafwSettingsImplSing = class(TafwSettingsImplPersistent)
  protected
   procedure InitFields; override;
  public
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: TafwSettingsImplSing;
    {* Метод получения экземпляра синглетона TafwSettingsImplSing }
 end;//TafwSettingsImplSing

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_TafwSettingsImplSing: TafwSettingsImplSing = nil;
 {* Экземпляр синглетона TafwSettingsImplSing }

procedure TafwSettingsImplSingFree;
 {* Метод освобождения экземпляра синглетона TafwSettingsImplSing }
begin
 l3Free(g_TafwSettingsImplSing);
end;//TafwSettingsImplSingFree

class function TafwSettingsImplSing.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TafwSettingsImplSing <> nil;
end;//TafwSettingsImplSing.Exists

class function TafwSettingsImplSing.Instance: TafwSettingsImplSing;
 {* Метод получения экземпляра синглетона TafwSettingsImplSing }
begin
 if (g_TafwSettingsImplSing = nil) then
 begin
  l3System.AddExitProc(TafwSettingsImplSingFree);
  g_TafwSettingsImplSing := Create;
 end;
 Result := g_TafwSettingsImplSing;
end;//TafwSettingsImplSing.Instance

procedure TafwSettingsImplSing.InitFields;
//#UC START# *47A042E100E2_4F6C7DC2022A_var*
//#UC END# *47A042E100E2_4F6C7DC2022A_var*
begin
//#UC START# *47A042E100E2_4F6C7DC2022A_impl*
 inherited;
 Sorted := true;
//#UC END# *47A042E100E2_4F6C7DC2022A_impl*
end;//TafwSettingsImplSing.InitFields

end.
