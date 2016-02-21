unit k2NilOp;

// Модуль: "w:\common\components\rtl\Garant\K2\k2NilOp.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\K2\k2Define.inc}

interface

uses
 l3IntfUses
 , k2Op
;

type
 Tk2NilOp = class(Tk2Op)
  public
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: Tk2NilOp;
    {* Метод получения экземпляра синглетона Tk2NilOp }
 end;//Tk2NilOp

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_Tk2NilOp: Tk2NilOp = nil;
 {* Экземпляр синглетона Tk2NilOp }

procedure Tk2NilOpFree;
 {* Метод освобождения экземпляра синглетона Tk2NilOp }
begin
 l3Free(g_Tk2NilOp);
end;//Tk2NilOpFree

class function Tk2NilOp.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tk2NilOp <> nil;
end;//Tk2NilOp.Exists

class function Tk2NilOp.Instance: Tk2NilOp;
 {* Метод получения экземпляра синглетона Tk2NilOp }
begin
 if (g_Tk2NilOp = nil) then
 begin
  l3System.AddExitProc(Tk2NilOpFree);
  g_Tk2NilOp := Create;
 end;
 Result := g_Tk2NilOp;
end;//Tk2NilOp.Instance

end.
