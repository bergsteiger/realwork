unit nsPostingsTreeSingle;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\nsPostingsTreeSingle.pas"
// Стереотип: "SimpleClass"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , nsPostingsLine
;

type
 TnsPostingsTreeSingle = {final} class(TnsPostingsTree)
  public
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: TnsPostingsTreeSingle;
    {* Метод получения экземпляра синглетона TnsPostingsTreeSingle }
 end;//TnsPostingsTreeSingle
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_TnsPostingsTreeSingle: TnsPostingsTreeSingle = nil;
 {* Экземпляр синглетона TnsPostingsTreeSingle }

procedure TnsPostingsTreeSingleFree;
 {* Метод освобождения экземпляра синглетона TnsPostingsTreeSingle }
begin
 l3Free(g_TnsPostingsTreeSingle);
end;//TnsPostingsTreeSingleFree

class function TnsPostingsTreeSingle.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TnsPostingsTreeSingle <> nil;
end;//TnsPostingsTreeSingle.Exists

class function TnsPostingsTreeSingle.Instance: TnsPostingsTreeSingle;
 {* Метод получения экземпляра синглетона TnsPostingsTreeSingle }
begin
 if (g_TnsPostingsTreeSingle = nil) then
 begin
  l3System.AddExitProc(TnsPostingsTreeSingleFree);
  g_TnsPostingsTreeSingle := Create;
 end;
 Result := g_TnsPostingsTreeSingle;
end;//TnsPostingsTreeSingle.Instance
{$IfEnd} // NOT Defined(Admin)

end.
