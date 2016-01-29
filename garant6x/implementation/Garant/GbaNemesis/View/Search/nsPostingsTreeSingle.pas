unit nsPostingsTreeSingle;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View$Strange"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Search/nsPostingsTreeSingle.pas"
// Начат: 31.10.2011 17:46
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Common For Shell And Monitoring::Search::View$Strange::Search::TnsPostingsTreeSingle
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin)}
uses
  nsPostingsLine
  ;
{$IfEnd} //not Admin

{$If not defined(Admin)}
type
 TnsPostingsTreeSingle = {final} class(TnsPostingsTree)
 public
 // public methods
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 public
 // singleton factory method
   class function Instance: TnsPostingsTreeSingle;
    {- возвращает экземпляр синглетона. }
 end;//TnsPostingsTreeSingle
{$IfEnd} //not Admin

implementation

{$If not defined(Admin)}
uses
  l3Base {a}
  ;
{$IfEnd} //not Admin

{$If not defined(Admin)}


// start class TnsPostingsTreeSingle

var g_TnsPostingsTreeSingle : TnsPostingsTreeSingle = nil;

procedure TnsPostingsTreeSingleFree;
begin
 l3Free(g_TnsPostingsTreeSingle);
end;

class function TnsPostingsTreeSingle.Instance: TnsPostingsTreeSingle;
begin
 if (g_TnsPostingsTreeSingle = nil) then
 begin
  l3System.AddExitProc(TnsPostingsTreeSingleFree);
  g_TnsPostingsTreeSingle := Create;
 end;
 Result := g_TnsPostingsTreeSingle;
end;


class function TnsPostingsTreeSingle.Exists: Boolean;
 {-}
begin
 Result := g_TnsPostingsTreeSingle <> nil;
end;//TnsPostingsTreeSingle.Exists

{$IfEnd} //not Admin

end.