unit evParaFrame;
{* Реализация интерфейсов IedFramePart и IedFrame для различных типов параграфов. }

{ Библиотека "Эверест"    }
{ Автор: Люлин А.В. ©     }
{ Модуль: evParaFrame -   }
{ Начат: 16.06.2000 19:28 }
{ $Id: evParaFrame.pas,v 1.75 2015/10/09 14:48:34 kostitsin Exp $ }

// $Log: evParaFrame.pas,v $
// Revision 1.75  2015/10/09 14:48:34  kostitsin
// {requestlink: 604917289 } - инициализируем неинициализированное
//
// Revision 1.74  2015/01/19 17:26:12  lulin
// {RequestLink:580710025}
//
// Revision 1.73  2014/05/27 10:02:39  dinishev
// {Requestlink:535347343} Более правильное лечение, хотя предыдущая правка была корректной.
//
// Revision 1.72  2014/05/27 09:32:12  dinishev
// {Requestlink:535347343}. Костыль-нога.
//
// Revision 1.71  2014/04/30 11:23:52  lulin
// - выпрямляем зависимости.
//
// Revision 1.70  2014/04/29 13:38:51  lulin
// - вычищаем ненужные зависимости.
//
// Revision 1.69  2014/04/11 15:30:29  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.68  2014/04/10 13:09:44  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.67  2014/04/10 11:50:05  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.66  2014/04/09 13:12:03  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.65  2014/04/08 17:13:19  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.64  2014/04/08 12:35:09  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.63  2014/04/07 17:56:59  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.62  2014/04/03 17:10:25  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.61  2014/03/21 17:15:14  lulin
// - перетряхиваем работу с тегами.
//
// Revision 1.60  2014/03/21 16:24:50  lulin
// - перетряхиваем работу с тегами.
//
// Revision 1.59  2014/03/14 11:05:05  lulin
// - возвращаем объектные свойства.
//
// Revision 1.58  2014/03/13 15:45:59  lulin
// - разделяем реализацию Tag и Box.
//
// Revision 1.57  2013/10/21 15:42:58  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.56  2013/10/21 10:30:41  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.55  2010/07/13 10:45:27  dinishev
// [$226001213]
//
// Revision 1.54  2010/04/12 14:53:46  lulin
// {RequestLink:203129570}.
// - убираем ненужный тип подитеративной функции.
//
// Revision 1.53  2009/07/23 13:42:11  lulin
// - переносим процессор операций туда куда надо.
//
// Revision 1.52  2009/07/23 08:14:39  lulin
// - вычищаем ненужное использование процессора операций.
//
// Revision 1.51  2009/07/14 14:56:26  lulin
// {RequestLink:141264340}. №25.
//
// Revision 1.50  2009/07/11 09:24:41  lulin
// - избавляемся от лишнего дёрганья счётчиков ссылок.
//
// Revision 1.49  2009/05/19 08:40:07  dinishev
// [$147490971]
//
// Revision 1.48  2009/05/18 09:16:23  dinishev
// [$146904388]
//
// Revision 1.47  2009/04/09 14:12:36  lulin
// [$140837386]. №15.
//
// Revision 1.46  2009/04/06 17:51:26  lulin
// [$140837386]. №11.
//
// Revision 1.45  2009/03/04 13:32:46  lulin
// - <K>: 137470629. Генерируем идентификаторы типов с модели и убираем их из общей помойки.
//
// Revision 1.44  2008/06/25 14:47:51  lulin
// - сделана возможность использовать предопределённые значения для рамок.
//
// Revision 1.43  2008/04/14 13:46:35  lulin
// - <K>: 89096854.
//
// Revision 1.42  2008/03/12 14:16:40  dinishev
// Bug fix: не выставлялся флаг измененности при установке границ ко всей таблице.
//
// Revision 1.41  2008/02/14 17:08:54  lulin
// - cleanup.
//
// Revision 1.40  2007/12/13 14:31:30  lulin
// - удалены ненужные типы.
//
// Revision 1.39  2007/12/04 12:47:03  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.34.4.20  2007/09/14 13:26:05  lulin
// - объединил с веткой B_Tag_Clean.
//
// Revision 1.34.4.19.2.3  2007/09/12 17:51:48  lulin
// - cleanup.
//
// Revision 1.34.4.19.2.2  2007/09/12 16:14:07  lulin
// - убран ненужный параметр по-умолчанию.
//
// Revision 1.34.4.19.2.1  2007/09/12 15:23:01  lulin
// - избавляемся от метода, дублирующего функциональность получения атрибута.
//
// Revision 1.34.4.19  2007/09/10 10:19:25  lulin
// - удален ненужный метод.
//
// Revision 1.34.4.18  2007/09/06 09:37:36  lulin
// - переименовано свойство.
//
// Revision 1.34.4.17  2007/06/22 19:18:57  lulin
// - cleanup.
//
// Revision 1.34.4.16  2007/01/05 14:37:19  lulin
// - cleanup.
//
// Revision 1.34.4.15  2006/11/03 11:00:05  lulin
// - объединил с веткой 6.4.
//
// Revision 1.34.4.14.20.1  2006/10/26 11:24:12  lulin
// - избавляемся от лишних преобразований типов.
//
// Revision 1.34.4.14  2005/12/26 13:26:48  lulin
// - bug fix: не всегда отображалось изменение комментариев (CQ OIT5-18865).
//
// Revision 1.34.4.13  2005/11/09 15:28:24  lulin
// - базовые интерфейсы перенесены в правильный модуль.
//
// Revision 1.34.4.12  2005/11/05 09:03:14  lulin
// - выделяем у якоря и у курсора общую функциональность.
//
// Revision 1.34.4.11  2005/07/20 18:36:11  lulin
// - модуль переименован в сответствии с названием интерфейса.
//
// Revision 1.34.4.10  2005/06/16 11:24:12  lulin
// - убрана косвенная типизация параграфов (при помощи _QI и QT).
//
// Revision 1.34.4.9  2005/06/15 13:06:00  lulin
// - убрана инициализация блоков выделения в явном виде.
//
// Revision 1.34.4.8  2005/06/03 12:08:19  lulin
// - cleanup: убраны ненужные зависимости.
//
// Revision 1.34.4.7  2005/06/02 16:19:27  lulin
// - cleanup.
//
// Revision 1.34.4.6  2005/06/02 12:33:08  lulin
// - вчерне заменил прямое создание блока выделения на его получение от фабрики.
//
// Revision 1.34.4.5  2005/06/01 16:22:25  lulin
// - remove unit: evIntf.
//
// Revision 1.34.4.4  2005/05/31 17:46:39  lulin
// - изживаем остатки объектов в качестве курсоров.
//
// Revision 1.34.4.3  2005/05/31 12:06:30  lulin
// - cleanup: при работе с курсорами используем интерфейсы, а не объекты.
//
// Revision 1.34.4.2  2005/05/20 11:27:35  lulin
// - класс TevBlock вынесен в отдельный модуль.
//
// Revision 1.34.4.1  2005/05/18 12:42:47  lulin
// - отвел новую ветку.
//
// Revision 1.30.2.3  2005/05/18 12:32:09  lulin
// - очередной раз объединил ветку с HEAD.
//
// Revision 1.30.2.2  2005/04/28 09:18:29  lulin
// - объединил с веткой B_Tag_Box.
//
// Revision 1.30.2.1  2005/04/15 08:21:35  lulin
// - теперь держим ссылку на тег, а не собственно тег.
//
// Revision 1.33.2.3  2005/04/23 16:23:00  lulin
// - remove prop: _Ik2Tag.AttrWP.
//
// Revision 1.33.2.2  2005/04/23 16:07:25  lulin
// - удален временный интерфейс Ik2TagBox.
//
// Revision 1.33.2.1  2005/04/21 14:46:55  lulin
// - избавляемся от обертки над тегами - теперь объекты посредством шаблонов сами реализуют интерфейс _Ik2Tag.
//
// Revision 1.33  2005/04/20 17:40:50  lulin
// - избавился от промежуточного интерфейса Ik2TagBoxQT.
//
// Revision 1.32  2005/04/20 14:31:57  lulin
// - объединены две ветки инструментов тегов.
//
// Revision 1.31  2005/04/15 08:59:52  lulin
// - теперь держим ссылку на тег, а не собственно тег.
//
// Revision 1.34  2005/04/28 15:03:38  lulin
// - переложил ветку B_Tag_Box в HEAD.
//
// Revision 1.33.2.3  2005/04/23 16:23:00  lulin
// - remove prop: _Ik2Tag.AttrWP.
//
// Revision 1.33.2.2  2005/04/23 16:07:25  lulin
// - удален временный интерфейс Ik2TagBox.
//
// Revision 1.33.2.1  2005/04/21 14:46:55  lulin
// - избавляемся от обертки над тегами - теперь объекты посредством шаблонов сами реализуют интерфейс _Ik2Tag.
//
// Revision 1.33  2005/04/20 17:40:50  lulin
// - избавился от промежуточного интерфейса Ik2TagBoxQT.
//
// Revision 1.32  2005/04/20 14:31:57  lulin
// - объединены две ветки инструментов тегов.
//
// Revision 1.31  2005/04/15 08:59:52  lulin
// - теперь держим ссылку на тег, а не собственно тег.
//
// Revision 1.30  2005/03/29 15:47:37  lulin
// - bug fix: в таблице с первой строкой, состоящей из одной ячейки не появлялась кнопка "Сетка".
//
// Revision 1.29  2005/03/28 11:32:08  lulin
// - интерфейсы переехали в "правильный" модуль.
//
// Revision 1.28  2005/03/25 17:09:01  lulin
// - избавляемся от метода Tk2AtomW.sLong.
//
// Revision 1.27  2005/03/24 18:39:21  lulin
// - remove object: Tk2AtomR.
//
// Revision 1.26  2005/03/24 12:08:12  lulin
// - remove method: Ik2TagBox._Tag.
// - new method: Ik2TagBox._Target.
//
// Revision 1.25  2005/03/23 12:42:23  lulin
// - вместо вызова метода ссылаемся на свойство.
//
// Revision 1.24  2005/03/21 16:28:16  lulin
// - переходим к _Ik2Tag.
//
// Revision 1.23  2005/03/21 06:44:53  lulin
// - убраны ненужные методы.
//
// Revision 1.22  2005/03/19 16:39:51  lulin
// - спрятаны ненужные методы.
//
// Revision 1.21  2005/03/15 11:18:18  lulin
// - cleanup.
//
// Revision 1.20  2005/03/15 10:30:18  lulin
// - от Tk2AtomR переходим к _Ik2Tag.
//
// Revision 1.19  2005/03/14 10:00:33  lulin
// - от Tk2AtomR переходим к _Ik2Tag.
//
// Revision 1.18  2004/11/09 17:06:24  lulin
// - переходим от классов к интерфейсам.
//
// Revision 1.17  2004/11/09 13:37:56  lulin
// - переходим от классов к интерфейсам.
//
// Revision 1.16  2003/10/02 16:33:24  law
// - rename unit: evBseCur -> evBaseCursor.
//
// Revision 1.15  2003/02/06 10:23:48  law
// - cleanup: используем код операции по умолчанию.
//
// Revision 1.14  2003/01/21 12:56:24  law
// - rename proc: TevBlock.GetChildBlockEx -> GetChildBlock.
//
// Revision 1.13  2002/12/26 16:31:28  law
// - new directive: evNeedEditableCursors.
//
// Revision 1.12  2002/12/05 13:47:36  law
// - bug fix: утечка памяти при вызове итератора.
//
// Revision 1.11  2002/11/19 15:32:46  law
// - rename method: Tk2AtomR._rAtom -> _rAtom.
//
// Revision 1.10  2002/07/09 13:57:39  law
// - new unit: evMsgCode.
//
// Revision 1.9  2002/02/07 15:22:30  law
// - rename class: IevBlock -> TevBlock, для того чтобы не путать его с интерфейсом.
//
// Revision 1.8  2002/02/07 15:05:24  law
// - rename class: IevCursor -> _TevCursor, для того чтобы не путать его с интерфейсом.
//
// Revision 1.7  2001/05/03 09:13:45  law
// - comments.
//
// Revision 1.6  2001/03/15 14:52:22  law
// - cleaning & coments.
//
// Revision 1.5  2001/03/05 14:08:28  law
// - поменялся порядок у методов _IterateChildren...
//
// Revision 1.4  2001/01/31 10:37:30  law
// - оптимизировано использование QueryInterface.
//
// Revision 1.3  2000/12/27 14:21:15  law
// - сделано взведение признака модифицирования текста.
//
// Revision 1.2  2000/12/15 15:10:37  law
// - вставлены директивы Log.
//

{$Include evDefine.inc }

interface

uses
  Graphics,

  l3Interfaces,
  l3Types,
  l3Variant,
  l3Base,
  l3CacheableBase,

  k2Interfaces,
  k2InternalInterfaces,
  k2ProcessorTagTool,
  k2BaseIntf,

  evEditorInterfaces,

  nevTools
  ;

{$IfDef evNeedEditableCursors}
type
  TevUsialParaFrame = class;

  TevUsialParaFramePart = class(Tl3CacheableBase, IedFramePart)
    private
    // internal fields
      f_UsialParaFrame : TevUsialParaFrame;
      f_FramePartProp  : Integer;
    private
    // property methods
      function  Get_Visible: Bool;
      procedure Set_Visible(Value: Bool);
        {-}
      function  Get_Color: TColor;
      procedure Set_Color(Value: TColor);
        {-}
      function  Get_Width: Long;
      procedure Set_Width(Value: Long);
        {-}
      function  Get_Style: TedLineStyle;
      procedure Set_Style(Value: TedLineStyle);
        {-}
    protected
    // internal methods
      procedure Cleanup;
        override;
        {-}
      function  FramePart(Check: Bool = false): Tl3Variant;
        {-}
      procedure SetLongPropPrim(TagIndex   : Long;
                                Value      : Long;
                                const anOp : InevOp);
        virtual;
        {-}
      procedure SetLongProp(TagIndex: Long; Value: Long);
        {-}
      procedure SetVisible(Value: Bool; const anOp : InevOp);
        virtual;
        {-}
    public
    // public methods
      constructor Create(anUsialParaFrame : TevUsialParaFrame;
                         aFramePartProp   : Integer);
        reintroduce;
        {-}
    public
    // public properties
      property FramePartProp: Integer
        read f_FramePartProp;
        {-}
  end;//TevUsialParaFramePart
  RevUsialParaFramePart = class of TevUsialParaFramePart;                   

  TevUsialParaFrame = class(Tk2ProcessorTagTool, IedFrame)
    protected
    // internal methods
      function  FramePartClass: RevUsialParaFramePart;
        virtual;
        {-}
    private
    // property methods
      function  Get_FramePart(Index: TedFramePartIndex): IedFramePart;
      procedure Set_FramePart(Index: TedFramePartIndex; const Value: IedFramePart);
        {-}
  end;{TevUsialParaFrame}

  TevParagraphPackFrame = class;

  TevParagraphPackFramePart = class(Tl3CacheableBase, IedFramePart)
    private
    {internal fields}
      f_Index              : TedFramePartIndex;
      f_ParagraphPackFrame : TevParagraphPackFrame;
      f_FirstParaFramePart : IedFramePart;
      f_View               : InevView;
    private
    {property methods}
      function  Get_Visible: Bool;
      procedure Set_Visible(Value: Bool);
        {-}
      function  Get_Color: TColor;
      procedure Set_Color(Value: TColor);
        {-}
      function  Get_Width: Long;
      procedure Set_Width(Value: Long);
        {-}
      function  Get_Style: TedLineStyle;
      procedure Set_Style(Value: TedLineStyle);
        {-}
    protected
    {internal methods}
      procedure Cleanup;
        override;
        {-}
      procedure IterateFrameParts(anAction: Tl3FreeAction);
        {-}  
      procedure IterateFramePartsF(anAction: Tl3FreeAction);
        {-}  
    public
    {public methods}
      constructor Create(const aView : InevView;
                         aParagraphPackFrame : TevParagraphPackFrame;
                         anIndex             : TedFramePartIndex);
        reintroduce;
        {-}
  end;{TevParagraphPackFramePart}

  TevParagraphPackFrame = class(Tl3ProcessorTool, IedFrame)
    private
    {internal fields}
      f_Block          : InevRange;
      f_FirstParaFrame : IedFrame;
      f_View           : InevView;
    private
    {property methods}
    private
    {property methods}
      function  Get_FramePart(Index: TedFramePartIndex): IedFramePart;
      procedure Set_FramePart(Index: TedFramePartIndex; const Value: IedFramePart);
        {-}
    protected
    {internal methods}
      procedure Cleanup;
        override;
        {-}
    public
    {public methods}
      constructor Create(const aView : InevView;
                         const aProcessor : InevProcessor;
                         const aBlock     : InevRange);
        reintroduce;
        {-}
  end;{TevParagraphPackFrame}

  TevCellFrameNeighbours = array [TedNeighbourIndex] of IedFrame;

  TevCellFramePart = class(TevUsialParaFramePart)
    protected
    {internal methods}
      function  NeighbourFramePart: IedFramePart;
        {-}
      procedure SetLongPropPrim(TagIndex   : Long;
                                Value      : Long;
                                const anOp : InevOp);
        override;
        {-}
      procedure SetVisible(Value: Bool; const anOp : InevOp);
        override;
        {-}
  end;{TevCellFramePart}

  TevCellFrame = class(TevUsialParaFrame)
    private
    {internal fields}
      f_Neighbours : TevCellFrameNeighbours;
    protected
    {internal methods}
      procedure Cleanup;
        override;
        {-}
      function  FramePartClass: RevUsialParaFramePart;
        override;
        {-}
    public
    {public methods}
      constructor Create(aTagWrap    : Tl3Variant;
                         const aProcessor  : InevProcessor;
                         const aNeighbours : TevCellNeighbours);
        reintroduce;
        {-}
  end;{TevCellFrame}

  TevTableFrame = class;

  TevCellAction = (ev_caRead, ev_caCheck, ev_caDelete);

  TevTableFramePart = class(Tl3CacheableBase, IedFramePart)
    private
    {internal fields}
      f_Index      : TedFramePartIndex;
      f_Visible    : Bool;
      f_Color      : Long;
      f_Width      : Long;
      f_Style      : Long;
      f_TableFrame : TevTableFrame;
    private
    {property methods}
      function  Get_Visible: Bool;
      procedure Set_Visible(Value: Bool);
        {-}
      function  Get_Color: TColor;
      procedure Set_Color(Value: TColor);
        {-}
      function  Get_Width: Long;
      procedure Set_Width(Value: Long);
        {-}
      function  Get_Style: TedLineStyle;
      procedure Set_Style(Value: TedLineStyle);
        {-}
    protected
    {internal methods}
      procedure Cleanup;
        override;
        {-}
      procedure IterateCells(anAction    : Mk2Children_IterateChildrenF_Action;
                             aCellAction : TevCellAction = ev_caRead;
                             const anOp  : InevOp = nil);
        {-}
      procedure IterateCellsF(anAction    : Mk2Children_IterateChildrenF_Action;
                              aCellAction : TevCellAction = ev_caRead;
                              const anOp  : InevOp = nil);
        {-}
      procedure SetLongProp(TagIndex: Long; var OldValue: Long; Value: Long);
        {-}
    public
    {public methods}
      constructor Create(aTableFrame : TevTableFrame;
                         anIndex     : TedFramePartIndex);
        reintroduce;
        {-}
      class function Make(aTableFrame : TevTableFrame;
                          anIndex     : TedFramePartIndex): IedFramePart;
        reintroduce;
        {-}
    public
    {public properties}
      property TableFrame: TevTableFrame
        read f_TableFrame;
        {-}
  end;{TevTableFramePart}

  TevTableFrame = class(Tk2ProcessorTagTool, IedFrame)
    private
    //internal fields
      f_StartRow   : Long;
      f_StartCell  : Long;
      f_FinishRow  : Long;
      f_FinishCell : Long;
    private
    {property methods}
      function  Get_FramePart(Index: TedFramePartIndex): IedFramePart;
      procedure Set_FramePart(Index: TedFramePartIndex; const Value: IedFramePart);
        {-}
    public
    //public methods
      constructor Create(aTagWrap   : Tl3Variant;
                         const aProcessor : InevProcessor;
                         aStartRow        : Long = 0;
                         aFinishRow       : Long = l3MaxIndex;
                         aStartCell       : Long = 0;
                         aFinishCell      : Long = l3MaxIndex);
        reintroduce;
        {-}
    public
    //public properties
      property StartRow: Long
        read f_StartRow;
        {-}
      property StartCell: Long
        read f_StartCell;
        {-}
      property FinishRow: Long
        read f_FinishRow;
        {-}
      property FinishCell: Long
        read f_FinishCell;
        {-}
  end;{TevTableFrame}
{$EndIf evNeedEditableCursors}

implementation

uses
  l3MinMax,
  l3InterfacesMisc,
  
  evConst,

  k2Tags,
  k2Base,

  evMsgCode,

  nevFacade,

  ParaList_Const
  ;

{$IfDef evNeedEditableCursors}

// start class TevUsialParaFrame 

function TevUsialParaFrame.FramePartClass: RevUsialParaFramePart;
  {virtual;}
  {-}
begin
 Result := TevUsialParaFramePart;
end;

function TevUsialParaFrame.Get_FramePart(Index: TedFramePartIndex): IedFramePart;
  {-}
begin
 with Self.TagInst do
  Case Index of
   ed_fpiUp .. ed_fpiRight :
    Pointer(Result) := Pointer(IedFramePart(FramePartClass.Create(Self, k2_tiFrameUp + Ord(Index))));
   else
    Result := nil;
  end//Case Index
end;
  
procedure TevUsialParaFrame.Set_FramePart(Index: TedFramePartIndex; const Value: IedFramePart);
  {-}
begin
end;

// start class TevUsialParaFramePart 

constructor TevUsialParaFramePart.Create(anUsialParaFrame : TevUsialParaFrame;
                                         aFramePartProp   : Integer);
  {reintroduce;}
  {-}
begin
 inherited Create;
 l3Set(f_UsialParaFrame, anUsialParaFrame);
 f_FramePartProp := aFramePartProp;
end;

procedure TevUsialParaFramePart.Cleanup;
  {override;}
  {-}
begin
 l3Free(f_UsialParaFrame);
 inherited;
end;

function TevUsialParaFramePart.FramePart(Check: Bool = false): Tl3Variant;
  {-}
var
 l_Op : InevOp;
begin
 Result := nil;
 with f_UsialParaFrame do
 begin
  if Check then
  begin
   if (Processor = nil) then
    Result := TagInst.cAtom(k2_tiFrame).cAtom(FramePartProp)
   else
   begin
    l_Op := Processor.StartOp;
    try
     Result := TagInst.cAtom(k2_tiFrame, l_Op).cAtom(FramePartProp, l_Op);
    finally
     l_Op := nil;
    end;{try..finally}
   end;
  end//Check
  else
   with TagInst.Attr[k2_tiFrame] do
    if IsValid then
     Result := Attr[FramePartProp]
    else
     Result := k2NullTag;
 end;{with f_UsialParaFrame}
end;

procedure TevUsialParaFramePart.SetLongPropPrim(TagIndex   : Long;
                                                Value      : Long;
                                                const anOp : InevOp);
  {virtual;}
  {-}
var
 l_Frame : Tl3Variant;
begin
 with f_UsialParaFrame do
 begin
  l_Frame := TagInst.Attr[k2_tiFrame];
  if (l_Frame <> nil) AND l_Frame.Attr[k2_tiHandle].IsValid then
  // это чтобы не поломать предопределённую рамку
  begin
   l_Frame := l_Frame.CloneTag.AsObject;
   TagInst.AttrW[k2_tiFrame, anOp] := l_Frame;
  end;//l_Frame <> nil
  with TagInst.Attr[k2_tiFrame].Attr[FramePartProp] do
  begin
   if IsValid then
   begin
    IntW[TagIndex, anOp] := Value;
    if (anOp <> nil) then
     anOp.MarkModified(TagInst);
   end;//IsValid
  end;//with Attr[k2_tiFrame].Attr[FramePartProp]
 end;//with f_UsialParaFrame
end;

procedure TevUsialParaFramePart.SetLongProp(TagIndex: Long; Value: Long);
  {-}
var
 l_Op : InevOp;
begin
 with f_UsialParaFrame do
 begin
  if (Processor <> nil)
   then l_Op := Processor.StartOp;
  try
   SetLongPropPrim(TagIndex, Value, l_Op);
  finally
   l_Op := nil;
  end;{try..finally}
 end;{with f_UsialParaFrame}
end;

function TevUsialParaFramePart.Get_Visible: Bool;
  {-}
begin
 Result := FramePart.IsValid;
end;

procedure TevUsialParaFramePart.SetVisible(Value: Bool; const anOp : InevOp);
  {virtual;}
  {-}
var
 l_Frame : Tl3Variant;
begin
 with f_UsialParaFrame do
 begin
  l_Frame := TagInst.Attr[k2_tiFrame];
  if (l_Frame <> nil) AND l_Frame.Attr[k2_tiHandle].IsValid then
  // это чтобы не поломать предопределённую рамку
  begin
   l_Frame := l_Frame.CloneTag.AsObject;
   TagInst.AttrW[k2_tiFrame, anOp] := l_Frame;
  end;//l_Frame <> nil
  if Value then
   TagInst.cAtom(k2_tiFrame, anOp).cAtom(FramePartProp, anOp)
  else
   with TagInst.Attr[k2_tiFrame] do
    if IsValid then
    begin
     AttrW[FramePartProp, anOp] := nil;
     if (anOp <> nil) then
      anOp.MarkModified(TagInst);
    end;//IsValid
 end;//f_UsialParaFrame
end;

procedure TevUsialParaFramePart.Set_Visible(Value: Bool);
  {-}
var
 l_Op : InevOp;
begin
 with f_UsialParaFrame do
 begin
  if (Processor <> nil) then
   l_Op := Processor.StartOp;
  try
   SetVisible(Value, l_Op);
  finally
   l_Op := nil;
  end;{try..finally}
 end;{with f_UsialParaFrame}
end;

function TevUsialParaFramePart.Get_Color: TColor;
  {-}
begin
 with FramePart do
  if IsValid then
   Result := rLong(k2_tiForeColor, -1)
  else
   Result := -1;  
end;

procedure TevUsialParaFramePart.Set_Color(Value: TColor);
  {-}
begin
 SetLongProp(k2_tiForeColor, Long(Value));
end;

function TevUsialParaFramePart.Get_Width: Long;
  {-}
begin
 with FramePart do
  if IsValid then
   Result := IntA[k2_tiWidth]
  else
   Result := 0;
end;

procedure TevUsialParaFramePart.Set_Width(Value: Long);
  {-}
begin
 SetLongProp(k2_tiWidth, Value);
end;

function TevUsialParaFramePart.Get_Style: TedLineStyle;
  {-}
begin
 with FramePart do
  if IsValid then
   Result := TedLineStyle(rLong(k2_tiLineType, Ord(ed_lsUndefined)))
  else
   Result := ed_lsUndefined;
end;

procedure TevUsialParaFramePart.Set_Style(Value: TedLineStyle);
  {-}
begin
 SetLongProp(k2_tiLineType, Long(Value));
end;

// start class TevTableFramePart 

constructor TevTableFramePart.Create(aTableFrame : TevTableFrame;
                                     anIndex     : TedFramePartIndex);
  {reintroduce;}
  {-}

 function CalcVisible(FramePart: Tl3Variant; Index: Long): Bool; far;
 begin
  with FramePart do
   if IsValid then begin
    Result := false;
    f_Visible := true;
   end else
    Result := true;
 end;

 function CalcParam(FramePart: Tl3Variant; Index: Long): Bool; far;
 begin
  with FramePart do
   if IsValid then begin
    if (f_Width <> 0) then
     with Attr[k2_tiWidth] do
      if IsValid then begin
       if (f_Width = -1) then
        f_Width := AsLong
       else if (f_Width <> AsLong) then
        f_Width := 0;
      end;
    if (f_Color <> -1) then
     with Attr[k2_tiForeColor] do
      if IsValid then begin
       if (f_Color = -2) then
        f_Color := AsLong
       else if (f_Color <> AsLong) then
        f_Color := -1;
      end;
    if (f_Style <> Ord(ed_lsUndefined)) then
     with Attr[k2_tiLineType] do
      if IsValid then begin
       if (f_Style = -1) then
        f_Style := AsLong
       else if (f_Style <> AsLong) then
        f_Style := Ord(ed_lsUndefined);
      end;
    Result := (f_Width <> 0) OR (f_Color <> -1) OR (f_Style <> Ord(ed_lsUndefined));
   end else
    Result := true;
 end;

begin
 inherited Create;
 l3Set(f_TableFrame, aTableFrame);
 f_Index := anIndex;
 f_Visible := false;
 f_Width := -1;
 f_Color := -2;
 f_Style := -1;
 IterateCellsF(L2Mk2ChildrenIterateChildrenFAction(@CalcVisible));
 if f_Visible then
  IterateCellsF(L2Mk2ChildrenIterateChildrenFAction(@CalcParam));
 if (f_Width = -1) then f_Width := 0;
 if (f_Color = -2) then f_Color := -1;
 if (f_Style = -1) then f_Style := Ord(ed_lsUndefined);
end;

class function TevTableFramePart.Make(aTableFrame : TevTableFrame;
                    anIndex     : TedFramePartIndex): IedFramePart;
  //reintroduce;
  {-}
var
 l_Part : TevTableFramePart;
begin
 l_Part := Create(aTableFrame, anIndex);
 try               
  Result := l_Part;
 finally
  l3Free(l_Part);
 end;//try..finally
end;

procedure TevTableFramePart.Cleanup;
  {override;}
  {-}
begin
 l3Free(f_TableFrame);
 inherited;
end;

procedure TevTableFramePart.IterateCells(anAction    : Mk2Children_IterateChildrenF_Action;
                                         aCellAction : TevCellAction = ev_caRead;
                                         const anOp  : InevOp = nil);
  {-}

 function SetParam(Cell: Tl3Variant; FramePartIndex: Long): Bool; far;
 var
  l_FramePart : Tl3Variant;
 var
  l_Frame : Tl3Variant;
 begin//SetParam
  l_FramePart := k2NullTag;
  case aCellAction of
   ev_caRead :
    with Cell.Attr[k2_tiFrame] do
     if IsValid then
      l_FramePart := Attr[FramePartIndex];
   ev_caCheck :
   begin
    l_Frame := Cell.Attr[k2_tiFrame];
    if (l_Frame <> nil) AND l_Frame.Attr[k2_tiHandle].IsValid then
    // это чтобы не поломать предопределённую рамку
    begin
     l_Frame := l_Frame.CloneTag.AsObject;
     Cell.AttrW[k2_tiFrame, anOp] := l_Frame;
    end;//l_Frame <> nil
    l_FramePart := Cell.cAtom(k2_tiFrame, anOp).cAtom(FramePartIndex, anOp);
    if (anOp <> nil) then
     anOp.MarkModified(f_TableFrame.TagInst);
   end;//ev_caCheck
   ev_caDelete :
   begin
    l_Frame := Cell.Attr[k2_tiFrame];
    if (l_Frame <> nil) AND l_Frame.Attr[k2_tiHandle].IsValid then
    // это чтобы не поломать предопределённую рамку
    begin
     l_Frame := l_Frame.CloneTag.AsObject;
     Cell.AttrW[k2_tiFrame, anOp] := l_Frame;
    end;//l_Frame <> nil
    with l_Frame do
     if IsValid then begin
      AttrW[FramePartIndex, anOp] := nil;
      if (anOp <> nil) then
       anOp.MarkModified(f_TableFrame.TagInst);
     end;//IsValid
     Result := true;
     Exit;
   end;//ev_caDelete
  end;//case aCellAction
  if Assigned(anAction) then
   Result := anAction(l_FramePart, 0)
  else
   Result := true;
 end;//SetParam

 function SetUpParam(Cell: Tl3Variant; Index: Long): Bool; far;
 begin
  Result := SetParam(Cell, k2_tiFrameUp);
 end;

 function SetDownParam(Cell: Tl3Variant; Index: Long): Bool; far;
 begin
  Result := SetParam(Cell, k2_tiFrameDown);
 end;

 function SetLeftParam(Row: Tl3Variant; Index: Long): Bool; far;
 var
  l_CellIndex : Long;
 begin//SetLeftParam
  l_CellIndex := Max(TableFrame.StartCell, 0);
  if (l_CellIndex = 0) then
   Result := SetParam(Row.Child[0], k2_tiFrameLeft)
  else begin
   with Row do
    if (l_CellIndex < ChildrenCount) then begin
     Result := SetParam(Child[l_CellIndex], k2_tiFrameLeft);
     if Result then
      Result := SetParam(Child[Pred(l_CellIndex)], k2_tiFrameRight);
    end else
     Result := true;
  end;//l_CellIndex = 0
 end;//SetLeftParam

 function SetRightParam(Row: Tl3Variant; Index: Long): Bool; far;
 var
  l_CellCount : Long;
  l_CellIndex : Long;
 begin//SetRightParam
  with Row do begin
   l_CellCount := ChildrenCount;
   l_CellIndex := Min(TableFrame.FinishCell, Pred(l_CellCount));
   if (l_CellIndex = Pred(l_CellCount)) then
    Result := SetParam(Child[l_CellIndex], k2_tiFrameRight)
   else begin
    Result := SetParam(Child[l_CellIndex], k2_tiFrameRight);
    if Result then
     Result := SetParam(Child[Succ(l_CellIndex)], k2_tiFrameLeft);
   end;//l_CellIndex = Pred(l_CellCount)
  end;//with Row
 end;//SetRightParam

 function SetVertParam(Row: Tl3Variant; Index: Long): Bool;   
 var
  l_StartCell  : Long;
  l_FinishCell : Long;

  function SetCellParam(Cell: Tl3Variant; Index: Long): Bool;
  begin//SetCellParam
   if (Index = l_StartCell) then
    Result := SetParam(Cell, k2_tiFrameRight)
   else if (Index = l_FinishCell) then
    Result := SetParam(Cell, k2_tiFrameLeft)
   else begin
    Result := SetParam(Cell, k2_tiFrameLeft);
    if Result then
     Result := SetParam(Cell, k2_tiFrameRight);
   end;//Index = l_StartCell
   if not Result then SetVertParam := false;
  end;//SetCellParam

 var
  l_CellCount : Long;
 begin//SetVertParam
  Result := true;
  with Row do begin
   l_CellCount := ChildrenCount;
   with TableFrame do begin
    l_StartCell := Max(StartCell, 0);
    l_FinishCell := Min(FinishCell, Pred(l_CellCount));
   end;//with TableFrame
   if (l_CellCount > 1) AND ((l_FinishCell - l_StartCell) > 0) then
    IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@SetCellParam), l_StartCell, l_FinishCell);
  end;{with Row}
 end;//SetVertParam

var
 l_StartRow  : Long;
 l_FinishRow : Long;
 l_StartCell : Long;
 l_FinishCell: Long;

 function SetHorzParam(Row: Tl3Variant; Index: Long): Bool; far;

  function SetFirstRowCellParam(Cell: Tl3Variant; Index: Long): Bool; far;
  begin//SetFirstRowCellParam
   Result := SetParam(Cell, k2_tiFrameDown);
   if not Result then SetHorzParam := false;
  end;//SetFirstRowCellParam

  function SetLastRowCellParam(Cell: Tl3Variant; Index: Long): Bool; far;
  begin//SetLastRowCellParam
   Result := SetParam(Cell, k2_tiFrameUp);
   if not Result then SetHorzParam := false;
  end;//SetLastRowCellParam

  function SetInnerRowCellParam(Cell: Tl3Variant; Index: Long): Bool; far;
  begin//SetInnerRowCellParam
   Result := SetParam(Cell, k2_tiFrameUp);
   if Result then
    Result := SetParam(Cell, k2_tiFrameDown);
   if not Result then SetHorzParam := false;
  end;//SetInnerRowCellParam

 begin//SetHorzParam
  Result := true;
  with TableFrame do
   if (Index = l_StartRow) then
    Row.IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@SetFirstRowCellParam),
                         Max(StartCell, l3MinIndex),
                         l_FinishCell)
   else if (Index = l_FinishRow) then
    Row.IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@SetLastRowCellParam),
                         l_StartCell,
                         Min(FinishCell, l3MaxIndex))
   else
    if Child[l_StartRow].ChildrenCount = Row.ChildrenCount then
     Row.IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@SetInnerRowCellParam),
                          Max(StartCell, l3MinIndex),
                          l_FinishCell)
    else
     Row.IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@SetInnerRowCellParam),
                          l_StartCell,
                          Min(FinishCell, l3MaxIndex));
 end;//SetHorzParam

var
 l_RowCount : Long;
 l_ParaS    : InevPara;
 l_ParaF    : InevPara; 
 l_OffsetS  : Integer;
 l_OffsetF  : Integer;
begin//IterateCells
 with TableFrame do
 begin
  l_RowCount := TagInst.ChildrenCount;
  l_StartRow := Max(StartRow, l3MinIndex);
  l_FinishRow := Min(FinishRow, Pred(l_RowCount));
  l_StartCell := Max(StartCell, l3MinIndex);
  l_FinishCell := Min(FinishCell, l3MaxIndex);
  if l_StartCell > l_FinishCell then
  begin
   Child[l_StartRow].Child[l_StartCell].QT(InevPara, l_ParaS);
   l_OffsetS := l_ParaS.OffsetX;
   Child[l_FinishRow].Child[l_FinishCell].QT(InevPara, l_ParaF);
   if Child[l_FinishRow].ChildrenCount > l_ParaF.PID + 1 then
   begin
    l_OffsetF := l_ParaF.OffsetX + l_ParaF.AsObject.IntA[k2_tiWidth] - 1;
    l_FinishCell := (l_ParaS.OwnerPara as InevTableRow).FindCell(l_OffsetF, 0);
   end
   else
    l_FinishCell := l_StartCell;
   l_StartCell := (l_ParaF.OwnerPara as InevTableRow).FindCell(l_OffsetS, 0);
  end; // if l_StartCell > l_FinishCell then 
  case f_Index of
   ed_fpiUp : begin
    Child[l_StartRow].
     IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@SetUpParam),
                      Max(StartCell, l3MinIndex),
                      l_FinishCell);
    if (l_StartRow > 0) then
     Child[Pred(l_StartRow)].
      IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@SetDownParam),
                      Max(StartCell, l3MinIndex),
                      l_FinishCell);
   end;//ed_fpiUp
   ed_fpiDown : begin
    Child[l_FinishRow].
     IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@SetDownParam),
                      l_StartCell,
                      Min(FinishCell, l3MaxIndex));
    if (l_FinishRow < Pred(l_RowCount)) then
     Child[Succ(l_FinishRow)].
      IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@SetUpParam),
                      l_StartCell,
                      Min(FinishCell, l3MaxIndex));
   end;//ed_fpiDown
   ed_fpiLeft :
    IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@SetLeftParam), l_StartRow, l_FinishRow);
   ed_fpiRight :
    IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@SetRightParam), l_StartRow, l_FinishRow);
   ed_fpiVert :
    IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@SetVertParam), l_StartRow, l_FinishRow);
   ed_fpiHorz : begin
    if (l_RowCount > 1) AND ((l_FinishRow - l_StartRow) > 0) then
     IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@SetHorzParam), l_StartRow, l_FinishRow);
   end;{ed_fpiHorz}
  end;{case f_Index}
 end;//with TableFrame
end;//IterateCells

procedure TevTableFramePart.IterateCellsF(anAction    : Mk2Children_IterateChildrenF_Action;
                                          aCellAction : TevCellAction = ev_caRead;
                                          const anOp  : InevOp = nil);
  {-}
begin//IterateCellsF
 try
  IterateCells(anAction, aCellAction, anOp);
 finally
  k2FreeTIA(anAction);
 end;{try..finally}
end;//IterateCellsF

procedure TevTableFramePart.SetLongProp(TagIndex: Long; var OldValue: Long; Value: Long);
  {-}

var
 l_Op : InevOp;

 function SetParam(FramePart: Tl3Variant; Index: Long): Bool; far;
 begin//SetParam
  Result := true;
  FramePart.IntW[TagIndex, l_Op] := Value;
  if (l_Op <> nil) then
   l_Op.MarkModified(f_TableFrame.TagInst);
 end;//SetParam

begin//SetLongProp
 if f_Visible AND (OldValue <> Value) then begin
  OldValue := Value;
  with TableFrame do begin
   if (Processor <> nil) then l_Op := Processor.StartOp;
   try
    IterateCellsF(@L2Mk2ChildrenIterateChildrenFAction(@SetParam), ev_caCheck, l_Op);
   finally
    l_Op := nil;
   end;{try..finally}
  end;{with TableFrame}
 end;{f_Visible}
end;//SetLongProp

function TevTableFramePart.Get_Visible: Bool;
  {-}
begin
 Result := f_Visible;
end;
  
procedure TevTableFramePart.Set_Visible(Value: Bool);
  {-}
var
 l_Op : InevOp;
begin
 f_Visible := Value;
 with TableFrame do
 begin
  if (Processor <> nil) then
   l_Op := Processor.StartOp;
  try
   if Value then
    IterateCells(nil, ev_caCheck, l_Op)
   else
    IterateCells(nil, ev_caDelete, l_Op); 
  finally
   l_Op := nil;
  end;//try..finally
 end;//with TableFrame
end;
  
function  TevTableFramePart.Get_Color: TColor;
  {-}
begin
 Result := f_Color;
end;

procedure TevTableFramePart.Set_Color(Value: TColor);
  {-}
begin
 SetLongProp(k2_tiForeColor, f_Color, Value);
end;

function TevTableFramePart.Get_Width: Long;
  {-}
begin
 Result := f_Width;
end;

procedure TevTableFramePart.Set_Width(Value: Long);
  {-}
begin
 SetLongProp(k2_tiWidth, f_Width, Value);
end;

function TevTableFramePart.Get_Style: TedLineStyle;
  {-}
begin
 Result := TedLineStyle(f_Style);
end;

procedure TevTableFramePart.Set_Style(Value: TedLineStyle);
  {-}
begin
 SetLongProp(k2_tiLineType, f_Style, Ord(Value));
end;

{ start class TevTableFrame }

constructor TevTableFrame.Create(aTagWrap   : Tl3Variant;
                                 const aProcessor : InevProcessor;
                                 aStartRow        : Long = 0;
                                 aFinishRow       : Long = l3MaxIndex;
                                 aStartCell       : Long = 0;
                                 aFinishCell      : Long = l3MaxIndex);
  //reintroduce;
  {-}
begin
 inherited Create(aTagWrap, aProcessor);
 f_StartRow := aStartRow;
 f_FinishRow := aFinishRow;
 f_StartCell := aStartCell;
 f_FinishCell := aFinishCell;
end;

function TevTableFrame.Get_FramePart(Index: TedFramePartIndex): IedFramePart;
  {-}

 function DoRow(aRow: Tl3Variant; anIndex: Integer): Boolean;
 begin//DoRow
  if (aRow.ChildrenCount > 1) then
  begin
   Get_FramePart := TevTableFramePart.Make(Self, Index);
   Result := false;
  end
  else
   Result := true;
 end;//DoRow

begin
 Case Index of
  ed_fpiUp .. ed_fpiRight :
   Result := TevTableFramePart.Make(Self, Index);
  ed_fpiVert : begin
   if (FinishCell - StartCell > 0) then
   begin
    Result := nil;
    Self.TagInst.IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@DoRow), StartRow, FinishRow);
   end//FinishCell - StartCell > 0
   else
    Result := nil;
  end;{ed_fpiVert}
  ed_fpiHorz : begin
   if (Min(FinishRow, Pred(TagInst.ChildrenCount)) -
       Max(StartRow, 0) > 0) then
    Result := TevTableFramePart.Make(Self, Index)
   else
    Result := nil;
  end;{ed_fpiHorz}
  else
   Result := nil;
 end;{Case Index}
end;

procedure TevTableFrame.Set_FramePart(Index: TedFramePartIndex; const Value: IedFramePart);
  {-}
begin
end;

{ start class TevCellFrame }

constructor TevCellFrame.Create(aTagWrap    : Tl3Variant;
                                const aProcessor  : InevProcessor;
                                const aNeighbours : TevCellNeighbours);
  {reintroduce;}
  {-}
var                                                         
 i : TedFramePartIndex;
begin
 inherited Create(aTagWrap, aProcessor);
 for i := Low(f_Neighbours) to High(f_Neighbours) do begin
  if (aNeighbours[i] = nil) or not aNeighbours[i].AsObject.IsValid then
   f_Neighbours[i] := nil
  else
   Pointer(f_Neighbours[i]) := Pointer(IedFrame(TevUsialParaFrame.Create(aNeighbours[i].AsObject, aProcessor)));
 end;{for i}
end;

procedure TevCellFrame.Cleanup;
  {override;}
  {-}
var
 i : TedFramePartIndex;
begin
 for i := Low(f_Neighbours) to High(f_Neighbours) do
  f_Neighbours[i] := nil;
 inherited;
end;

function TevCellFrame.FramePartClass: RevUsialParaFramePart;
  {override;}
  {-}
begin
 Result := TevCellFramePart;
end;

{ start class TevCellFramePart }

function TevCellFramePart.NeighbourFramePart: IedFramePart;
  {-}
begin
 Result := nil;
 with TevCellFrame(f_UsialParaFrame) do
 begin
  Case FramePartProp of
   k2_tiFrameUp :
    if (f_Neighbours[ed_fpiUp] <> nil) then
     Result := f_Neighbours[ed_fpiUp].FramePart[ed_fpiDown];
   k2_tiFrameDown :
    if (f_Neighbours[ed_fpiDown] <> nil) then
     Result := f_Neighbours[ed_fpiDown].FramePart[ed_fpiUp];
   k2_tiFrameLeft :
    if (f_Neighbours[ed_fpiLeft] <> nil) then
     Result := f_Neighbours[ed_fpiLeft].FramePart[ed_fpiRight];
   k2_tiFrameRight :
    if (f_Neighbours[ed_fpiRight] <> nil) then
     Result := f_Neighbours[ed_fpiRight].FramePart[ed_fpiLeft];
  end;//Case Self.f_Index
 end;//with TevCellFrame(f_UsialParaFrame)
end;
  
procedure TevCellFramePart.SetLongPropPrim(TagIndex   : Long;
                                           Value      : Long;
                                           const anOp : InevOp);
  {override;}
  {-}
var
 l_FramePart : IedFramePart;
begin
 inherited;
 l_FramePart := NeighbourFramePart;
 if (l_FramePart <> nil) then begin
  Case TagIndex of
   k2_tiForeColor : l_FramePart.Color := TColor(Value);
   k2_tiWidth     : l_FramePart.Width := Value;
   k2_tiLineType  : l_FramePart.Style := TedLineStyle(Value);
  end;{Case TagIndex}
  l_FramePart := nil;
 end;{l_FramePart <> nil}
end;

procedure TevCellFramePart.SetVisible(Value: Bool; const anOp : InevOp);
  {override;}
  {-}
var
 l_FramePart : IedFramePart;
begin
 inherited;
 l_FramePart := NeighbourFramePart;
 if (l_FramePart <> nil) then begin
  l_FramePart.Visible := Value;
  l_FramePart := nil;
 end;{l_FramePart <> nil}
end;

// start class TevParagraphPackFrame 

constructor TevParagraphPackFrame.Create(const aView : InevView;
                                         const aProcessor : InevProcessor;
                                         const aBlock     : InevRange);
  {reintroduce;}
  {-}
var
 l_Start, l_Finish : InevBasePoint;
begin
 inherited Create(aProcessor);
 f_View := aView;
 f_Block := aBlock;
 aBlock.GetBorderPoints(l_Start, l_Finish);
 if (l_Start <> nil) then
  with l_Start.MostInner.Obj^.AsObject do
   if IsValid AND not IsKindOf(k2_typParaList) then
    Pointer(f_FirstParaFrame) := Pointer(IedFrame(TevUsialParaFrame.Create(Box, aProcessor)));
end;

procedure TevParagraphPackFrame.Cleanup;
  {override;}
  {-}
begin
 f_View := nil;
 f_FirstParaFrame := nil;
 f_Block := nil;
 inherited;
end;

function TevParagraphPackFrame.Get_FramePart(Index: TedFramePartIndex): IedFramePart;
  {-}
begin
 Case Index of
  ed_fpiUp .. ed_fpiRight :
   Pointer(Result) := Pointer(IedFramePart(TevParagraphPackFramePart.Create(f_View, Self, Index)));
  else
   Result := nil;
 end;{Case Index}
end;

procedure TevParagraphPackFrame.Set_FramePart(Index: TedFramePartIndex; const Value: IedFramePart);
  {-}
begin
end;

{ start class TevParagraphPackFramePart }

constructor TevParagraphPackFramePart.Create(const aView : InevView;
                                             aParagraphPackFrame : TevParagraphPackFrame;
                                             anIndex             : TedFramePartIndex);
  {reintroduce;}
  {-}
var
 l_Frame : IedFrame;  
begin
 inherited Create;
 f_View := aView;
 l3Set(f_ParagraphPackFrame, aParagraphPackFrame);
 f_Index := anIndex;
 l_Frame := aParagraphPackFrame.f_FirstParaFrame;
 if (l_Frame = nil) then
  f_FirstParaFramePart := nil
 else
  f_FirstParaFramePart := l_Frame[anIndex]; 
end;

procedure TevParagraphPackFramePart.Cleanup;
  {override;}
  {-}
begin
 f_View := nil;
 f_FirstParaFramePart := nil;
 l3Free(f_ParagraphPackFrame);
 inherited;
end;

function TevParagraphPackFramePart.Get_Visible: Bool;
  {-}
begin
 if (f_FirstParaFramePart = nil) then
  Result := false
 else
  Result := f_FirstParaFramePart.Visible;
end;

procedure TevParagraphPackFramePart.Set_Visible(Value: Bool);
  {-}

 function SetVisible(FramePart: PIedFramePart): Bool; far;
 begin
  Result := true;
  FramePart^.Visible := Value;
 end;

begin
 IterateFramePartsF(l3L2FA(@SetVisible));
end;

function TevParagraphPackFramePart.Get_Color: TColor;
  {-}
begin
 if (f_FirstParaFramePart = nil) then
  Result := -1
 else
  Result := f_FirstParaFramePart.Color;
end;

procedure TevParagraphPackFramePart.Set_Color(Value: TColor);
  {-}

 function SetColor(FramePart: PIedFramePart): Bool; far;
 begin
  Result := true;
  FramePart^.Color := Value;
 end;

begin
 IterateFramePartsF(l3L2FA(@SetColor));
end;


function TevParagraphPackFramePart.Get_Width: Long;
  {-}
begin
 if (f_FirstParaFramePart = nil) then
  Result := 0
 else
  Result := f_FirstParaFramePart.Width;
end;

procedure TevParagraphPackFramePart.Set_Width(Value: Long);
  {-}
  
 function SetWidth(FramePart: PIedFramePart): Bool; far;
 begin
  Result := true;
  FramePart^.Width := Value;
 end;

begin
 IterateFramePartsF(l3L2FA(@SetWidth));
end;

function TevParagraphPackFramePart.Get_Style: TedLineStyle;
  {-}
begin
 if (f_FirstParaFramePart = nil) then
  Result := ed_lsUndefined
 else
  Result := f_FirstParaFramePart.Style;
end;

procedure TevParagraphPackFramePart.Set_Style(Value: TedLineStyle);
  {-}

 function SetStyle(FramePart: PIedFramePart): Bool; far;
 begin
  Result := true;
  FramePart^.Style := Value;
 end;

begin
 IterateFramePartsF(l3L2FA(@SetStyle));
end;

procedure TevParagraphPackFramePart.IterateFrameParts(anAction: Tl3FreeAction);
  {-}

var
 l_Processor : InevProcessor;

 function IterateBlock(const aBlock: InevRange): Bool;

  function GetBlockFramePart(const aChild: InevRange; Index: Long): Bool; far;
  var
   l_Frame     : IedFrame;
   l_FramePart : IedFramePart;
  begin{GetBlockFramePart}
   Result := true;
   if aChild.AsObject.IsKindOf(k2_typParaList) then
   begin
    Result := IterateBlock(aBlock.GetChildSel(f_View, Index, False));
    IterateBlock := Result;
   end//aChild.IsKindOf(k2_typParaList)
   else
   begin
    Pointer(l_Frame) := Pointer(IedFrame(TevUsialParaFrame.Create(aChild.AsObject, l_Processor)));
    try
     l_FramePart := l_Frame[f_Index];
     if (l_FramePart <> nil) then begin
      Result := anAction(@l_FramePart);
      l_FramePart := nil;
     end;{l_FramePart <> nil}
    finally
     l_Frame := nil;
    end;{try..finally}
   end;//aChild.IsKindOf(k2_typParaList)
  end;{GetBlockFramePart}

 begin{IterateBlock}
  Result := true;
  aBlock.IterateF(evL2TSA(@GetBlockFramePart));
 end;{IterateBlock}

var
 l_Op : InevOp;
begin
 if Assigned(anAction) then
  with f_ParagraphPackFrame do
  begin
   l_Processor := Processor;
   if (l_Processor <> nil) then
    l_Op := l_Processor.StartOp;
   try
    IterateBlock(f_ParagraphPackFrame.f_Block);
   finally
    l_Op := nil;
   end;//try..finally
  end;//with f_ParagraphPackFrame
end;

procedure TevParagraphPackFramePart.IterateFramePartsF(anAction: Tl3FreeAction);
  {-}
begin
 try
  IterateFrameParts(anAction);
 finally
  l3FreeFA(anAction);
 end;//try..finally
end;
{$EndIf evNeedEditableCursors}

end.

