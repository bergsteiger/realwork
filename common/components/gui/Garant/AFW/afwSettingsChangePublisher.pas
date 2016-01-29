unit afwSettingsChangePublisher;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "AFW"
// Модуль: "w:/common/components/gui/Garant/AFW/afwSettingsChangePublisher.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::AFW::afwSettings::TafwSettingsChangePublisher
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\AFW\afwDefine.inc}

interface

uses
  afwSettingsChangePublisherPrim
  ;

type
 TafwSettingsChangePublisher = class(TafwSettingsChangePublisherPrim)
 public
 // public methods
   class function Exists: Boolean;
 public
 // singleton factory method
   class function Instance: TafwSettingsChangePublisher;
    {- возвращает экземпляр синглетона. }
 end;//TafwSettingsChangePublisher

implementation

uses
  l3Base {a}
  ;


// start class TafwSettingsChangePublisher

var g_TafwSettingsChangePublisher : TafwSettingsChangePublisher = nil;

procedure TafwSettingsChangePublisherFree;
begin
 l3Free(g_TafwSettingsChangePublisher);
end;

class function TafwSettingsChangePublisher.Instance: TafwSettingsChangePublisher;
begin
 if (g_TafwSettingsChangePublisher = nil) then
 begin
  l3System.AddExitProc(TafwSettingsChangePublisherFree);
  g_TafwSettingsChangePublisher := Create;
 end;
 Result := g_TafwSettingsChangePublisher;
end;


class function TafwSettingsChangePublisher.Exists: Boolean;
//#UC START# *5242FE6200D6_5242FE0C02ED_var*
//#UC END# *5242FE6200D6_5242FE0C02ED_var*
begin
//#UC START# *5242FE6200D6_5242FE0C02ED_impl*
 Result := (g_TafwSettingsChangePublisher <> nil);
//#UC END# *5242FE6200D6_5242FE0C02ED_impl*
end;//TafwSettingsChangePublisher.Exists

end.