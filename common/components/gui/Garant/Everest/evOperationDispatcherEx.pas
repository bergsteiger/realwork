unit evOperationDispatcherEx;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/evOperationDispatcherEx.pas"
// Начат: 19.05.2011 14:55
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Dispatcher::TevOperationDispatcherEx
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  evDisp
  ;

type
 TevOperationDispatcherEx = class(TevOperationDispatcher)
 public
 // public methods
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 public
 // singleton factory method
   class function Instance: TevOperationDispatcherEx;
    {- возвращает экземпляр синглетона. }
 end;//TevOperationDispatcherEx

implementation

uses
  l3Base {a}
  ;


// start class TevOperationDispatcherEx

var g_TevOperationDispatcherEx : TevOperationDispatcherEx = nil;

procedure TevOperationDispatcherExFree;
begin
 l3Free(g_TevOperationDispatcherEx);
end;

class function TevOperationDispatcherEx.Instance: TevOperationDispatcherEx;
begin
 if (g_TevOperationDispatcherEx = nil) then
 begin
  l3System.AddExitProc(TevOperationDispatcherExFree);
  g_TevOperationDispatcherEx := Create;
 end;
 Result := g_TevOperationDispatcherEx;
end;


class function TevOperationDispatcherEx.Exists: Boolean;
 {-}
begin
 Result := g_TevOperationDispatcherEx <> nil;
end;//TevOperationDispatcherEx.Exists

end.