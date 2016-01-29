unit evdHiddenParaEliminator;

{ Библиотека "EVD"        }
{ Начал: Люлин А.В.       }
{ Модуль: evdHiddenParaEliminator - }
{ Начат: 14.06.2007 11:55 }
{ $Id: evdHiddenParaEliminator.pas,v 1.2 2014/04/08 14:17:04 lulin Exp $ }

// $Log: evdHiddenParaEliminator.pas,v $
// Revision 1.2  2014/04/08 14:17:04  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.1  2007/06/14 07:58:39  lulin
// - добавлен фильтр, выкидывающий параграфы, покрашенные "серым".
//

{$Include evdDefine.inc }

interface

uses
  k2Interfaces,
  
  evdLeafParaFilter
  ;

type
  TevdHiddenParaEliminator = class(TevdLeafParaFilter)
    protected
    // internal methods
      function  NeedWritePara(aLeaf: Tl3Variant): Boolean;
        override;
        {-}
  end;//TevdHiddenParaEliminator

implementation

uses
  k2Tags
  ;

// start class TevdHiddenParaEliminator

function TevdHiddenParaEliminator.NeedWritePara(aLeaf: Tl3Variant): Boolean;
  //override;
  {-}
begin
 Result := aLeaf.BoolA[k2_tiVisible];  
end;

end.

