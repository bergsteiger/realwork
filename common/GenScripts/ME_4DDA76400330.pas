unit k2SortTagsList;

// Модуль: "w:\common\components\rtl\Garant\K2\k2SortTagsList.pas"
// Стереотип: "SimpleClass"

{$Include k2Define.inc}

interface

uses
 l3IntfUses
 , k2SortTagsListPrim
;

type
 Tk2SortTagsList = class(Tk2SortTagsListPrim)
  public
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: Tk2SortTagsList;
    {* Метод получения экземпляра синглетона Tk2SortTagsList }
 end;//Tk2SortTagsList

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_Tk2SortTagsList: Tk2SortTagsList = nil;
 {* Экземпляр синглетона Tk2SortTagsList }

procedure Tk2SortTagsListFree;
 {* Метод освобождения экземпляра синглетона Tk2SortTagsList }
begin
 l3Free(g_Tk2SortTagsList);
end;//Tk2SortTagsListFree

class function Tk2SortTagsList.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tk2SortTagsList <> nil;
end;//Tk2SortTagsList.Exists

class function Tk2SortTagsList.Instance: Tk2SortTagsList;
 {* Метод получения экземпляра синглетона Tk2SortTagsList }
begin
 if (g_Tk2SortTagsList = nil) then
 begin
  l3System.AddExitProc(Tk2SortTagsListFree);
  g_Tk2SortTagsList := Create;
 end;
 Result := g_Tk2SortTagsList;
end;//Tk2SortTagsList.Instance

end.
