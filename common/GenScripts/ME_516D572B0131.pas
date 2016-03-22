unit myReferenceCountGuard;
 {* Класс исключительно для примеров }

// Модуль: "w:\common\components\SandBox\myReferenceCountGuard.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmyReferenceCountGuard" MUID: (516D572B0131)

{$Include w:\common\components\SandBox\sbDefine.inc}

interface

uses
 l3IntfUses
 , myInterfacedObject
;

type
 ImyReferenceCountGuard = interface
  {* Интерфейс исключительно для примеров }
  ['{84AAAF31-F3AC-4BBC-A1B7-4E338748921F}']
  function GetRefCount: Integer;
 end;//ImyReferenceCountGuard

 TmyReferenceCountGuard = class(TmyInterfacedObject, ImyReferenceCountGuard)
  {* Класс исключительно для примеров }
  protected
   function GetRefCount: Integer;
  public
   class function Make: ImyReferenceCountGuard; reintroduce;
 end;//TmyReferenceCountGuard

implementation

uses
 l3ImplUses
;

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
end;//TmyReferenceCountGuard.Make

function TmyReferenceCountGuard.GetRefCount: Integer;
//#UC START# *516D57C50277_516D572B0131_var*
//#UC END# *516D57C50277_516D572B0131_var*
begin
//#UC START# *516D57C50277_516D572B0131_impl*
 Result := RefCount;
//#UC END# *516D57C50277_516D572B0131_impl*
end;//TmyReferenceCountGuard.GetRefCount

end.
