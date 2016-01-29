unit IterateableServiceProvider;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "SandBox"
// Модуль: "IterateableServiceProvider.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: SimpleClass::Class Shared Delphi Sand Box::SandBox::Services::TIterateableServiceProvider
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\SandBox\sbDefine.inc}

interface

uses
  l3ProtoObject,
  IterateableService,
  Classes
  ;

type
 TIterateableServiceImpl = {final} class(Tl3ProtoObject, IIterateableService)
 public
 // realized methods
   {iterator} procedure IterateF(anAction: MIterateableService_IterateF_Action;
    anOwner: TComponent);
 public
 // public methods
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 public
 // singleton factory method
   class function Instance: TIterateableServiceImpl;
    {- возвращает экземпляр синглетона. }
 end;//TIterateableServiceImpl

 TIterateableServiceProvider = class
 end;//TIterateableServiceProvider

implementation

uses
  l3Base {a}
  ;


// start class TIterateableServiceImpl

var g_TIterateableServiceImpl : TIterateableServiceImpl = nil;

procedure TIterateableServiceImplFree;
begin
 l3Free(g_TIterateableServiceImpl);
end;

class function TIterateableServiceImpl.Instance: TIterateableServiceImpl;
begin
 if (g_TIterateableServiceImpl = nil) then
 begin
  l3System.AddExitProc(TIterateableServiceImplFree);
  g_TIterateableServiceImpl := Create;
 end;
 Result := g_TIterateableServiceImpl;
end;


class function TIterateableServiceImpl.Exists: Boolean;
 {-}
begin
 Result := g_TIterateableServiceImpl <> nil;
end;//TIterateableServiceImpl.Exists

{iterator} procedure TIterateableServiceImpl.IterateF(anAction: MIterateableService_IterateF_Action;
  anOwner: TComponent);
//#UC START# *A44911B9A95D_551961470035_var*
var
 Hack : Pointer absolute anAction;
 l_Index : Integer;
//#UC END# *A44911B9A95D_551961470035_var*
begin
//#UC START# *A44911B9A95D_551961470035_impl*
 try
  if (anOwner <> nil) then
   for l_Index := 0 to Pred(anOwner.ComponentCount) do
    anAction(anOwner.Components[l_Index]);
 finally
  l3FreeLocalStub(Hack);
 end;//try..finally
//#UC END# *A44911B9A95D_551961470035_impl*
end;//TIterateableServiceImpl.IterateF

initialization
// Регистрация TIterateableServiceImpl
 TIterateableService.Instance.Alien := TIterateableServiceImpl.Instance;

end.