unit evParaIDEliminator;
{* Фильтр, выкидивающий идентификаторы параграфов . }

{ Библиотека "Эверест"    }
{ Начал: Люлин А.В.       }
{ Модуль: evParaIDEliminator - }
{ Начат: 01.02.2005 16:39 }
{ $Id: evParaIDEliminator.pas,v 1.6 2014/04/08 12:35:09 lulin Exp $ }

// $Log: evParaIDEliminator.pas,v $
// Revision 1.6  2014/04/08 12:35:09  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.5  2007/12/04 12:47:03  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.3.8.3  2007/09/14 13:26:05  lulin
// - объединил с веткой B_Tag_Clean.
//
// Revision 1.3.8.2.2.1  2007/09/12 19:56:47  lulin
// - bug fix: не собиралась библиотека.
//
// Revision 1.3.8.2  2007/09/06 09:37:36  lulin
// - переименовано свойство.
//
// Revision 1.3.8.1  2005/06/23 13:52:45  lulin
// - фильтр листьевых параграфов переехал в папку EVD.
//
// Revision 1.3  2005/03/28 11:32:08  lulin
// - интерфейсы переехали в "правильный" модуль.
//
// Revision 1.2  2005/03/25 11:04:26  lulin
// - используем _AttrW вместо SetNull.
//
// Revision 1.1  2005/02/01 14:12:03  lulin
// - bug fix: при вставке комментарие теперь отрезаем ID параграфов - т.к. иначе на комментарии ставились закладки, ни и прочая...
//

{$I evDefine.inc }

interface

uses
  k2Interfaces,
  
  evdLeafParaFilter
  ;

type
  TevParaIDEliminator = class(TevdLeafParaFilter)
   {* Фильтр, выкидивающий идентификаторы параграфов . }
    protected
    // internal methods
      procedure DoWritePara(aLeaf: Tl3Variant);
        override;
        {-}
  end;//TevParaIDEliminator

implementation

uses
  k2Tags
  ;

// start class TevParaIDEliminator

procedure TevParaIDEliminator.DoWritePara(aLeaf: Tl3Variant);
  //override;
  {-}
begin
 if (aLeaf <> nil) then
 begin
  if aLeaf.Attr[k2_tiHandle].IsValid then
   aLeaf.Attr[k2_tiHandle] := nil;
 end;//aLeaf <> nil
 inherited;
end;

end.

