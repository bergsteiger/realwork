unit nsBaseSearchPromptTree;
 {* Дерево подсказок. Синглетон }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\nsBaseSearchPromptTree.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , nsBaseSearchPromptTreeBase
 , l3TreeInterfaces
;

type
 TnsBaseSearchPromptTree = class(TnsBaseSearchPromptTreeBase)
  {* Дерево подсказок. Синглетон }
  public
   class function Make: Il3SimpleTree; reintroduce;
    {* Создаёт дерево подсказок }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: TnsBaseSearchPromptTree;
    {* Метод получения экземпляра синглетона TnsBaseSearchPromptTree }
 end;//TnsBaseSearchPromptTree
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_TnsBaseSearchPromptTree: TnsBaseSearchPromptTree = nil;
 {* Экземпляр синглетона TnsBaseSearchPromptTree }

procedure TnsBaseSearchPromptTreeFree;
 {* Метод освобождения экземпляра синглетона TnsBaseSearchPromptTree }
begin
 l3Free(g_TnsBaseSearchPromptTree);
end;//TnsBaseSearchPromptTreeFree

class function TnsBaseSearchPromptTree.Make: Il3SimpleTree;
 {* Создаёт дерево подсказок }
var
 l_Inst : TnsBaseSearchPromptTree;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnsBaseSearchPromptTree.Make

class function TnsBaseSearchPromptTree.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TnsBaseSearchPromptTree <> nil;
end;//TnsBaseSearchPromptTree.Exists

class function TnsBaseSearchPromptTree.Instance: TnsBaseSearchPromptTree;
 {* Метод получения экземпляра синглетона TnsBaseSearchPromptTree }
begin
 if (g_TnsBaseSearchPromptTree = nil) then
 begin
  l3System.AddExitProc(TnsBaseSearchPromptTreeFree);
  g_TnsBaseSearchPromptTree := Create;
 end;
 Result := g_TnsBaseSearchPromptTree;
end;//TnsBaseSearchPromptTree.Instance
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
