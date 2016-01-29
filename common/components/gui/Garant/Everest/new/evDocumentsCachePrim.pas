unit evDocumentsCachePrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/new/evDocumentsCachePrim.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::DocumentContainers::TevDocumentsCachePrim
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
  l3ProtoObject,
  l3DocumentsCacheService
  ;

type
 TevDocumentsCacheService = {final} class(Tl3ProtoObject, Il3DocumentsCacheService)
 public
 // realized methods
   procedure Clear;
 public
 // public methods
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 public
 // singleton factory method
   class function Instance: TevDocumentsCacheService;
    {- возвращает экземпляр синглетона. }
 end;//TevDocumentsCacheService

 TevDocumentsCachePrim = class
 end;//TevDocumentsCachePrim

implementation

uses
  l3Base {a},
  evDocumentsCache
  ;


// start class TevDocumentsCacheService

var g_TevDocumentsCacheService : TevDocumentsCacheService = nil;

procedure TevDocumentsCacheServiceFree;
begin
 l3Free(g_TevDocumentsCacheService);
end;

class function TevDocumentsCacheService.Instance: TevDocumentsCacheService;
begin
 if (g_TevDocumentsCacheService = nil) then
 begin
  l3System.AddExitProc(TevDocumentsCacheServiceFree);
  g_TevDocumentsCacheService := Create;
 end;
 Result := g_TevDocumentsCacheService;
end;


class function TevDocumentsCacheService.Exists: Boolean;
 {-}
begin
 Result := g_TevDocumentsCacheService <> nil;
end;//TevDocumentsCacheService.Exists

procedure TevDocumentsCacheService.Clear;
//#UC START# *0AC8DEBDD602_5506FF1A0056_var*
//#UC END# *0AC8DEBDD602_5506FF1A0056_var*
begin
//#UC START# *0AC8DEBDD602_5506FF1A0056_impl*
 TevDocumentsCache.Clear;
//#UC END# *0AC8DEBDD602_5506FF1A0056_impl*
end;//TevDocumentsCacheService.Clear

initialization
// Регистрация TevDocumentsCacheService
 Tl3DocumentsCacheService.Instance.Alien := TevDocumentsCacheService.Instance;

end.