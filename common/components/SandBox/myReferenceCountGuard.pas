unit myReferenceCountGuard;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "SandBox"
// Модуль: "myReferenceCountGuard.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: SimpleClass::Class Shared Delphi Sand Box::SandBox::Basic Interfaces::TmyReferenceCountGuard
//
// Класс исключительно для примеров
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\SandBox\sbDefine.inc}

interface

uses
  myInterfacedObject
  ;

type
 ImyReferenceCountGuard = interface(IUnknown)
  {* Интерфейс исключительно для примеров }
   ['{84AAAF31-F3AC-4BBC-A1B7-4E338748921F}']
   function GetRefCount: Integer;
 end;//ImyReferenceCountGuard

 TmyReferenceCountGuard = class(TmyInterfacedObject, ImyReferenceCountGuard)
  {* Класс исключительно для примеров }
 protected
 // realized methods
   function GetRefCount: Integer;
 public
 // public methods
   class function Make: ImyReferenceCountGuard; reintroduce;
     {* Сигнатура фабрики TmyReferenceCountGuard.Make }
 end;//TmyReferenceCountGuard

implementation

// start class TmyReferenceCountGuard

class function TmyReferenceCountGuard.Make: ImyReferenceCountGuard;
var
 l_Inst : TmyReferenceCountGuard;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TmyReferenceCountGuard.GetRefCount: Integer;
//#UC START# *516D57C50277_516D572B0131_var*
//#UC END# *516D57C50277_516D572B0131_var*
begin
//#UC START# *516D57C50277_516D572B0131_impl*
 Result := RefCount;
//#UC END# *516D57C50277_516D572B0131_impl*
end;//TmyReferenceCountGuard.GetRefCount

end.