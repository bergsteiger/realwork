unit afwSettingsChangePublisher;

// Модуль: "w:\common\components\gui\Garant\AFW\afwSettingsChangePublisher.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TafwSettingsChangePublisher" MUID: (5242FE0C02ED)

{$Include w:\common\components\gui\Garant\AFW\afwDefine.inc}

interface

uses
 l3IntfUses
 , afwSettingsChangePublisherPrim
;

type
 TafwSettingsChangePublisher = class(TafwSettingsChangePublisherPrim)
  public
   class function Exists: Boolean;
   class function Instance: TafwSettingsChangePublisher;
    {* Метод получения экземпляра синглетона TafwSettingsChangePublisher }
 end;//TafwSettingsChangePublisher

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_TafwSettingsChangePublisher: TafwSettingsChangePublisher = nil;
 {* Экземпляр синглетона TafwSettingsChangePublisher }

procedure TafwSettingsChangePublisherFree;
 {* Метод освобождения экземпляра синглетона TafwSettingsChangePublisher }
begin
 l3Free(g_TafwSettingsChangePublisher);
end;//TafwSettingsChangePublisherFree

class function TafwSettingsChangePublisher.Exists: Boolean;
//#UC START# *5242FE6200D6_5242FE0C02ED_var*
//#UC END# *5242FE6200D6_5242FE0C02ED_var*
begin
//#UC START# *5242FE6200D6_5242FE0C02ED_impl*
 Result := (g_TafwSettingsChangePublisher <> nil);
//#UC END# *5242FE6200D6_5242FE0C02ED_impl*
end;//TafwSettingsChangePublisher.Exists

class function TafwSettingsChangePublisher.Instance: TafwSettingsChangePublisher;
 {* Метод получения экземпляра синглетона TafwSettingsChangePublisher }
begin
 if (g_TafwSettingsChangePublisher = nil) then
 begin
  l3System.AddExitProc(TafwSettingsChangePublisherFree);
  g_TafwSettingsChangePublisher := Create;
 end;
 Result := g_TafwSettingsChangePublisher;
end;//TafwSettingsChangePublisher.Instance

end.
