unit evDocumentAnchorIndex;
{* Реализация индекса точек входа. }

{ Библиотека "Эверест"  }
{ Автор: Люлин А.В. ©   }
{ Модуль: ev - }
{ Начат: 30.06.99 18:39 }
{ $Id: evDocumentAnchorIndex.pas,v 1.2 2015/01/19 16:50:47 lulin Exp $ }

// $Log: evDocumentAnchorIndex.pas,v $
// Revision 1.2  2015/01/19 16:50:47  lulin
// {RequestLink:580710025}
//
// Revision 1.1  2014/07/25 15:27:52  lulin
// - готовимся к рисованию фабрик.
//
// Revision 1.34  2014/04/07 17:56:59  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.33  2014/04/04 17:53:34  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.32  2009/07/23 13:42:10  lulin
// - переносим процессор операций туда куда надо.
//
// Revision 1.31  2009/07/10 16:15:41  lulin
// - избавляемся от лишнего дёрганья счётчиков ссылок.
//
// Revision 1.30  2009/04/07 15:11:47  lulin
// [$140837386]. №13. Чистка кода.
//
// Revision 1.29  2008/02/07 19:12:55  lulin
// - избавляемся от излишне универсальных методов базовых списков.
//
// Revision 1.28  2007/12/25 12:55:52  lulin
// - удален ненужный модуль.
//
// Revision 1.27  2007/12/04 12:46:58  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.24.8.6  2007/09/11 18:49:58  lulin
// - удален ненужный параметр.
//
// Revision 1.24.8.5  2007/08/10 19:01:28  lulin
// - cleanup.
//
// Revision 1.24.8.4  2007/01/05 14:37:18  lulin
// - cleanup.
//
// Revision 1.24.8.3  2005/11/25 15:59:28  lulin
// - bug fix: падали в отсутствии процессора.
//
// Revision 1.24.8.2  2005/11/25 10:47:27  lulin
// - bug fix: оказывается недочинил удаление блока из индекса.
//
// Revision 1.24.8.1  2005/11/09 15:28:22  lulin
// - базовые интерфейсы перенесены в правильный модуль.
//
// Revision 1.24  2005/03/31 10:30:46  lulin
// - remove unit: evBase_TLB.
//
// Revision 1.23  2005/03/28 11:32:06  lulin
// - интерфейсы переехали в "правильный" модуль.
//
// Revision 1.22  2005/03/24 13:30:50  lulin
// - удалена функция преобразования Tk2AtomR к Ik2TagBox.
//
// Revision 1.21  2005/03/24 12:08:12  lulin
// - remove method: Ik2TagBox._Tag.
// - new method: Ik2TagBox._Target.
//
// Revision 1.20  2005/03/16 09:20:37  lulin
// - переходим к _Ik2Tag.
//
// Revision 1.19  2005/03/09 18:40:19  lulin
// - remove method: Tk2AtomR.DeleteChild.
// - new method: _Ik2Tag.DeleteChild.
//
// Revision 1.18  2004/11/10 12:13:25  lulin
// - cleanup: перевел параграфы с реализации интерфейсов на реализацию инструментов.
//
// Revision 1.17  2004/06/29 14:26:40  law
// - избавляемся от метода Tk2AtomR._Set.
//
// Revision 1.16  2004/06/04 15:14:51  law
// - убрал прямое обращение к _Tl3PVList (т.к. для оптимизации предполагается, что в теле документа не всегда он может хранится).
//
// Revision 1.15  2004/06/02 16:42:26  law
// - удален класс Tl3VList.
//
// Revision 1.14  2002/07/09 13:57:38  law
// - new unit: evMsgCode.
//
// Revision 1.13  2001/09/04 16:47:26  law
// - comments: xHelpGen.
//
// Revision 1.12  2001/06/18 14:32:48  law
// - cleanup.
//
// Revision 1.11  2000/12/15 15:10:33  law
// - вставлены директивы Log.
//

{$I evDefine.inc }

interface

uses
  l3Base,
  l3Types,

  k2Interfaces,
  k2ProcTagTool,

  nevBase
  ;

type
  TevDocumentAnchorIndex = class(Tk2ProcTagTool, IevAnchorIndex)
   {* Реализация индекса точек входа. }
    protected
    // interface methods
      // IevAnchorIndex
      procedure Delete(Layer: Integer; Handle: Integer);
        {* - удалить точку входа. }
    public
    // public methods
      class function Make(aTarget    : Tl3Variant;
                          const aProcessor : Ik2Processor): IevAnchorIndex;
        reintroduce;
        {* - создать интерфейс IevAnchorIndex. }
  end;{TevDocumentAnchorIndex}

implementation

uses
  l3Interfaces, {-for Il3Processor}

  k2Tags,

  evMsgCode   {-for ev_msgDeleteSub}
  ;

// start class TevDocumentAnchorIndex

class function TevDocumentAnchorIndex.Make(aTarget    : Tl3Variant;
                                           const aProcessor : Ik2Processor): IevAnchorIndex;
  //reintroduce;
  {* - создать интерфейс IevAnchorIndex. }
var
 l_Index : TevDocumentAnchorIndex;
begin
 l_Index := Create(aTarget, aProcessor);
 try
  Result := l_Index;
 finally
  l3Free(l_Index);
 end;//try..finally
end;

procedure TevDocumentAnchorIndex.Delete(Layer: Integer; Handle: Integer);
  {-}
var
 l_Pack : InevOp;             {-пачка операций     }
 l_Sub  : Tl3Variant;
 i      : Long;
begin
 if (Processor = nil) then
  l_Pack := nil
 else
  l_Pack := Processor.StartOp(ev_msgDeleteSub);
 {-открываем пачку операций}
 try
  with GetRedirect.rAtomEx([k2_tiSubs, k2_tiChildren, k2_tiHandle, Layer]) do
   if IsValid then
   begin
    l_Sub := rAtomEx([k2_tiChildren, k2_tiHandle, Handle], @i);
    if l_Sub.IsValid then
     DeleteChild(i, l_Pack);
   end;//IsValid
 finally
  l_Pack := nil; {-закрываем пачку операций}
 end;//try..finally
end;
  
end.

