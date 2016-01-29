unit evDictEntry;

{ Библиотека "Эверест"    }
{ Автор: Люлин А.В. ©     }
{ Модуль: evDictEntry -   }
{ Начат: 19.04.2004 13:38 }
{ $Id: evDictEntry.pas,v 1.24 2015/01/19 17:26:12 lulin Exp $ }

// $Log: evDictEntry.pas,v $
// Revision 1.24  2015/01/19 17:26:12  lulin
// {RequestLink:580710025}
//
// Revision 1.23  2014/04/08 12:35:09  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.22  2014/04/07 17:56:59  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.21  2014/03/21 16:24:50  lulin
// - перетряхиваем работу с тегами.
//
// Revision 1.20  2014/03/06 17:23:19  lulin
// - избавляемся от теговых обёрток.
//
// Revision 1.19  2009/07/23 13:42:10  lulin
// - переносим процессор операций туда куда надо.
//
// Revision 1.18  2009/07/10 16:15:41  lulin
// - избавляемся от лишнего дёрганья счётчиков ссылок.
//
// Revision 1.17  2009/06/01 16:07:31  lulin
// [$148574348].
//
// Revision 1.16  2009/04/06 17:51:26  lulin
// [$140837386]. №11.
//
// Revision 1.15  2007/12/04 12:47:00  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.11.4.7  2007/09/14 13:26:04  lulin
// - объединил с веткой B_Tag_Clean.
//
// Revision 1.11.4.6.2.1  2007/09/13 12:35:57  lulin
// - переименовано свойство.
//
// Revision 1.11.4.6  2007/09/11 18:49:58  lulin
// - удален ненужный параметр.
//
// Revision 1.11.4.5  2007/08/10 20:02:56  lulin
// - cleanup.
//
// Revision 1.11.4.4  2007/07/23 05:20:46  oman
// warning fix
//
// Revision 1.11.4.3  2005/12/26 13:26:48  lulin
// - bug fix: не всегда отображалось изменение комментариев (CQ OIT5-18865).
//
// Revision 1.11.4.2  2005/11/09 15:28:23  lulin
// - базовые интерфейсы перенесены в правильный модуль.
//
// Revision 1.11.4.1  2005/05/18 12:42:46  lulin
// - отвел новую ветку.
//
// Revision 1.8.2.2  2005/05/18 12:32:08  lulin
// - очередной раз объединил ветку с HEAD.
//
// Revision 1.8.2.1  2005/04/28 09:18:28  lulin
// - объединил с веткой B_Tag_Box.
//
// Revision 1.10.2.1  2005/04/23 16:07:24  lulin
// - удален временный интерфейс Ik2TagBox.
//
// Revision 1.10  2005/04/20 17:40:50  lulin
// - избавился от промежуточного интерфейса Ik2TagBoxQT.
//
// Revision 1.9  2005/04/20 14:51:42  lulin
// - объединены две ветки инструментов тегов.
//
// Revision 1.11  2005/04/28 15:03:37  lulin
// - переложил ветку B_Tag_Box в HEAD.
//
// Revision 1.10.2.1  2005/04/23 16:07:24  lulin
// - удален временный интерфейс Ik2TagBox.
//
// Revision 1.10  2005/04/20 17:40:50  lulin
// - избавился от промежуточного интерфейса Ik2TagBoxQT.
//
// Revision 1.9  2005/04/20 14:51:42  lulin
// - объединены две ветки инструментов тегов.
//
// Revision 1.8  2005/03/28 11:32:07  lulin
// - интерфейсы переехали в "правильный" модуль.
//
// Revision 1.7  2005/03/28 06:37:08  lulin
// - remove object: Tk2AtomW.
//
// Revision 1.6  2005/03/21 16:28:16  lulin
// - переходим к _Ik2Tag.
//
// Revision 1.5  2005/03/19 16:39:51  lulin
// - спрятаны ненужные методы.
//
// Revision 1.4  2004/04/19 12:06:32  law
// - bug fix: как всегда забыл про _MarkModified.
//
// Revision 1.3  2004/04/19 11:53:50  law
// - new: свойству IevNodeDict сделана возможность записи.
//
// Revision 1.2  2004/04/19 10:52:23  law
// - new property: IevDictEntry.ShortName.
//
// Revision 1.1  2004/04/19 09:53:13  law
// - new unit: evDictEntry.
// - new class: TevDictEntry.
//

{$Include evDefine.inc }

interface

uses
  l3Interfaces,
  l3Types,
  l3Base,

  k2Interfaces,
  k2InternalInterfaces,
  k2ProcessorTagTool,

  evdDOM,

  nevBase,
  evInternalInterfaces
  ;

type
  TevDictEntry = class(Tk2ProcessorTagTool, IevdDictEntry)
    protected
    // interface methods
      // IevdDictEntry
      function  pm_GetShortName(aLang: TevdLanguage): Tl3PCharLen;
      procedure pm_SetShortName(aLang: TevdLanguage; const aValue: Tl3PCharLen);
        {-}
    public
    // public methods
      class function Make(aTagWrap   : Tl3Variant;
                          const aProcessor : InevProcessor): IevdDictEntry;
       reintroduce;
        {-}                  
  end;//TevDictEntry

implementation

uses
  l3String,

  k2Const,
  k2Tags
  ;

// start class TevDictEntry

class function TevDictEntry.Make(aTagWrap   : Tl3Variant;
                                 const aProcessor : InevProcessor): IevdDictEntry;
  {-}
var
 l_DictEntry : TevDictEntry;  
begin
 l_DictEntry := Create(aTagWrap, aProcessor);
 try
  Result := l_DictEntry;
 finally
  l3Free(l_DictEntry);
 end;//try..finally
end;

function TevDictEntry.pm_GetShortName(aLang: TevdLanguage): Tl3PCharLen;
  {-}
begin
 l3AssignNil(Result);
 with Self.GetRedirect.rAtomEx([k2_tiShortName, k2_tiChildren, k2_tiByIndex, Ord(aLang)]) do
  if IsValid then
   Tl3WString(Result) := AsWStr;
end;

procedure TevDictEntry.pm_SetShortName(aLang: TevdLanguage; const aValue: Tl3PCharLen);
var
 l_Op : InevOp;
begin
 l_Op := StartOp;
 try
  Self.GetRedirect.cAtomEx([k2_tiShortName, k2_tiChildren, k2_tiByIndex, Ord(aLang)], l_Op).
   PCharLenW[k2_tiValue, l_Op] := aValue;
  if Assigned(l_Op) then
   l_Op.MarkModified(Self.GetRedirect);
 finally
  l_Op := nil;
 end;//try..finally
end;

end.

