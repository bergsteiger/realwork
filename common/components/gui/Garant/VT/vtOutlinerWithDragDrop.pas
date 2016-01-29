unit vtOutlinerWithDragDrop;

{ $Id: vtOutlinerWithDragDrop.pas,v 1.89 2013/07/23 18:06:42 kostitsin Exp $ }

// $Log: vtOutlinerWithDragDrop.pas,v $
// Revision 1.89  2013/07/23 18:06:42  kostitsin
// [$468654951]
//
// Revision 1.88  2012/03/27 14:42:24  lulin
// - выделяем общую часть.
//
// Revision 1.87  2012/02/17 09:28:19  kostitsin
// Переименовываем NumOfSelect в SelectedCount
//
// Revision 1.86  2011/12/01 12:19:26  gensnet
// http://mdp.garant.ru/pages/viewpage.action?pageId=309167996
//
// Revision 1.85  2011/11/30 12:30:11  lulin
// {RequestLink:232098711}.
// - выравниваем галочки.
//
// Revision 1.84  2010/03/10 19:42:24  lulin
// {RequestLink:196445017}.
//
// Revision 1.83  2010/01/19 12:09:11  lulin
// {RequestLink:178717037}.
//
// Revision 1.82  2009/02/09 13:38:11  lulin
// - bug fix: исправления после Вована.
//
// Revision 1.81  2008/11/06 14:34:40  oman
// - fix: Учитываем приемистость данных деревом на тесте вставки (К-112722830)
//
// Revision 1.80  2008/10/24 15:03:11  lulin
// - bug fix: не собиралась библиотека.
//
// Revision 1.79  2008/10/16 11:17:04  lulin
// - <K>: 121149716.
//
// Revision 1.78  2008/10/16 09:29:28  lulin
// - <K>: 121149716.
//
// Revision 1.77  2008/09/04 12:56:22  lulin
// - вычищен результат, который никем не использовался.
//
// Revision 1.76  2008/09/04 12:26:12  lulin
// - чистка кода.
//
// Revision 1.75  2008/09/04 12:12:36  lulin
// - удалено ненужное событие.
//
// Revision 1.74  2008/09/04 11:56:49  lulin
// - <K>: 88080895.
//
// Revision 1.73  2008/09/04 11:16:17  lulin
// - <K>: 88080895.
//
// Revision 1.72  2008/08/14 16:36:49  mmorozov
// - bugfix: правильно перерисовываем при перетаскивании (<K>: 96484123);
//
// Revision 1.71  2008/05/16 12:37:42  mmorozov
// - new behaviour: при перетаскивании в списке не показываем значок, что можно сбросить (CQ: OIT5-29065);
//
// Revision 1.70  2008/03/19 08:07:16  mmorozov
// - new: ограничиваем размер прямоугольнка с текстом при перетаскивании шириной элемента в дереве + смещаем текст относительно курсора, чтобы не выводился под курсором (в рамках CQ: OIT5-28528);
//
// Revision 1.69  2008/03/19 06:27:17  mmorozov
// - выделен метод для получения текста при перетаскивании для перекрытия в потомках + при перескивании рисуем рамку по размеру выводимого текста (в рамках CQ: OIT5-28528);
//
// Revision 1.68  2008/02/21 14:00:33  mmorozov
// - change: правильно определяем посвеченный при перемещении, кроме того отсутствие подсвеченного не повод не спрашивать у данных дерева можно ли сбросить (в рамках работы над CQ: OIT5-28331);
//
// Revision 1.67  2008/02/21 12:55:44  mmorozov
// - new behaviour: отсутствие текущего или подсвеченного текущего не является основанием чтобы не принимать данные, т.к. это могут делать данные дерева (в рамках работы над CQ: OIT5-28331);
//
// Revision 1.66  2008/02/21 10:31:25  mmorozov
// - new behaviour: при вставке подсвеченного как при перемещении нет, поэтому используем текущий (в рамках CQ: OIT5-28331);
//
// Revision 1.65  2008/02/21 09:35:32  lulin
// - bug fix: не возвращался результат.
//
// Revision 1.64  2008/02/21 08:47:48  mmorozov
// - new: поддержка приёма объектов на уровне данных дерева + поддержка операций копирования\вставки визульным деревом (в рамках CQ: OIT5-28331);
//
// Revision 1.63  2008/02/11 12:19:25  mmorozov
// - библиотека не собиралась + новый поддерживаемый деревом формат (CQ: OIT5-28331);
//
// Revision 1.62  2008/02/11 05:16:05  mmorozov
// - new: узел отвечает на вопрос можно ли его перемещать (CQ: OIT5-28331);
//
// Revision 1.61  2008/02/08 12:19:37  mmorozov
// - new: возможность приёма перетаскиваемых объектов узлами дерева + новый формат в буфере обмена для перемещния нескольких узлов (CQ: OIT5-28331);
//
// Revision 1.60  2007/12/26 13:26:13  lulin
// - подготавливаемся к переезду на модель.
//
// Revision 1.59  2007/06/20 15:13:26  lulin
// - не собиралось из-за Антошиных исправлений.
//
// Revision 1.58  2007/01/30 15:24:18  lulin
// - текст ноды - теперь более простого типа.
//
// Revision 1.57  2007/01/09 09:58:08  lulin
// - bug fix: не собиралась библиотека.
//
// Revision 1.56  2006/12/27 16:54:37  lulin
// - cleanup.
//
// Revision 1.55  2006/12/27 14:39:19  lulin
// - упрощена работа со списками форматов.
//
// Revision 1.54  2006/12/22 15:06:41  lulin
// - текст ноды - теперь структура с длиной и кодовой страницей.
//
// Revision 1.53  2006/12/20 15:52:13  lulin
// - cleanup.
//
// Revision 1.52  2006/12/20 13:33:59  lulin
// - удален ненужный модуль.
//
// Revision 1.51  2006/12/20 09:47:26  lulin
// - bug fix: нельзя было начать DnD в "простых" деревьях.
//
// Revision 1.50  2006/12/19 12:43:59  lulin
// - передаем типизированные данные, а не абстрактные.
//
// Revision 1.49  2006/12/19 12:24:25  lulin
// - избавляемся от запоминания объкта данных на контроле.
//
// Revision 1.48  2006/12/19 11:37:59  lulin
// - cleanup.
//
// Revision 1.47  2006/12/19 11:24:39  lulin
// - объект данных для дерева выделен в отдельный модуль.
//
// Revision 1.46  2006/12/15 10:59:34  lulin
// - для многострочных деревьев иконку от DnD также рисуем многострочной.
//
// Revision 1.45  2006/12/15 10:10:43  lulin
// - скроллируем дерево, если пытаемся опустить данные за его пределами.
//
// Revision 1.44  2006/12/15 09:59:52  lulin
// - разворачиваем принимающую ноду.
//
// Revision 1.43  2006/12/15 09:52:58  lulin
// - поддержка формата _CF_HDrop спущена на базовый объект данных.
//
// Revision 1.42  2006/12/14 15:31:43  lulin
// - создаем список строк в правильном месте.
//
// Revision 1.41  2006/12/14 15:27:35  lulin
// - выделяем общий код.
//
// Revision 1.40  2006/12/14 15:19:02  lulin
// - cleanup.
//
// Revision 1.39  2006/12/14 15:15:15  lulin
// - cleanup.
//
// Revision 1.38  2006/12/14 15:09:53  lulin
// - используем родной список строк.
//
// Revision 1.37  2006/12/14 15:02:53  lulin
// - bug fix: не возвращали корректный результат в случае успешного получения данных.
//
// Revision 1.36  2006/12/14 14:13:33  lulin
// - cleanup.
//
// Revision 1.35  2006/12/14 13:16:03  lulin
// - убран ненужный метод.
//
// Revision 1.34  2006/12/14 13:08:21  lulin
// - по-честному получаем ноду из объекта данных.
//
// Revision 1.33  2006/12/14 11:39:46  lulin
// - подготавливаемся к отдаче ноды по-честному, а не через странный дополнительный метод.
//
// Revision 1.32  2006/12/14 11:06:09  lulin
// - bug fix: не вызывавли унаследованный метод.
//
// Revision 1.31  2006/12/13 17:34:31  lulin
// - теперь базовый контрол поддерживает иконку от перетаскиваемого в него объекта.
//
// Revision 1.30  2006/12/13 16:51:47  lulin
// - cleanup.
//
// Revision 1.29  2006/12/13 16:03:41  lulin
// - cleanup.
//
// Revision 1.28  2006/12/13 15:13:12  lulin
// - cleanup.
//
// Revision 1.27  2006/12/13 14:27:45  lulin
// - cleanup.
//
// Revision 1.26  2006/12/13 13:53:34  lulin
// - убран ненужный параметр.
// - bug fix: не выделялся элемент, который принимает DnD.
//
// Revision 1.25  2006/12/13 13:35:00  lulin
// - cleanup.
//
// Revision 1.24  2006/12/13 13:30:01  lulin
// - используем базовый объект данных, держащий ссылку на неизвестные данные.
// - bug fix: не рисовался элемент который принимает DnD (не доделано).
//
// Revision 1.23  2006/12/13 12:40:31  lulin
// - дерево теперь использует базовый объект данных для DnD.
//
// Revision 1.22  2006/12/13 10:44:01  lulin
// - класс переименован в соответствии с его функционалом.
//
// Revision 1.21  2006/12/13 10:35:35  lulin
// - cleanup.
//
// Revision 1.20  2006/12/13 09:44:00  lulin
// - cleanup.
//
// Revision 1.18  2006/12/13 08:08:16  lulin
// - cleanup.
//
// Revision 1.17  2006/12/13 08:02:44  lulin
// - вычишен ненужный на интерфейсе метод.
//
// Revision 1.16  2005/12/19 12:03:05  lulin
// - new behavior: вставляем ссылки в комментариях из родного формата, а не путем обработки сообщения.
//
// Revision 1.15  2005/12/16 15:25:56  lulin
// - cleanup.
//
// Revision 1.14  2005/12/16 15:12:45  lulin
// - задел на правильный Drag-and-drop ссылок.
//

{$Include vtDefine.inc }

interface

uses
  Classes,

  Controls,
  Forms,
  ImgList,
  Graphics,
  SysUtils,
  ShlObj,

  l3Types,
  l3Interfaces,
  l3IID,
  l3TreeInterfaces,
  l3InternalInterfaces,
  l3Tree_TLB,
  l3Units,
  l3Tree,
  l3Base,
  l3InterfacesMisc,
  l3BitmapContainer,

  afwControl,

  vtLister,
  vtOutliner,
  vtOutlinerWithQuickSearch
  {$IfNDef DesignTimeLibrary}
  ,
  evNodeData
  {$EndIf  DesignTimeLibrary}
  ;

type
  Tl3CanBeginDrag = procedure (const aNode   : Il3SimpleNode;
                               var aOkEffect : Longint) of object;
    {-}
  Tl3CanAcceptData = function (const aData: IDataObject): Boolean of object;
    {-}
  Tl3DoDrop = function (const aData  : Il3SimpleNode;
                        aWantMenu    : Boolean;
                        var dwEffect : Longint): Boolean of object;
    {-}

  {$IfNDef DesignTimeLibrary}
  RvtNodeDataObject = class of TevNodeData;
  {$EndIf  DesignTimeLibrary}  
  TvtOutlinerWithDragDrop = class(TvtOutlinerWithQuickSearch)
    private
    // internal methods
      f_DnDSupported    : Boolean;
      f_OnCanBeginDrag  : Tl3CanBeginDrag;
      f_OnCanAcceptData : Tl3CanAcceptData;
      f_OnDoDrop        : Tl3DoDrop;
      f_HighLighted     : Integer;
    protected
    // internal methods
      function MakeDraggingText(const aNode: Il3SimpleNode): Il3CString;
        {-}
      procedure DoOnGetItemStyle(aItemIndex         : Integer;
                                 const aFont        : Il3Font;
                                 var aTextBackColor : TColor;
                                 var aItemBackColor : TColor;
                                 var aVJustify      : TvtVJustify;
                                 var aFocused       : Boolean;
                                 var theImageVertOffset : Integer);
        override;
        {-}
      procedure SetHighLighted(aIndex : Integer);
        {-}
      function  GetDragAndDropSupported: Boolean;
        override;
        {-}
      procedure TryDragAndDrop(aNodeIndex: Integer; aKey: Integer);
        override;
        {-}
  //Il3FileSource
      function  CanAcceptDataAt(const aData  : IDataObject;
                                const aPoint : TPoint): Boolean;
        {-}
      function  CanAcceptData(const aData: IDataObject): Boolean; virtual;
        {-}
      function DoGetAcceptableFormats: Tl3ClipboardFormats;
        override;
        {-}
      function DoDoDrop(aFormat       : Tl3ClipboardFormat;
                      const aMedium : Tl3StoragePlace;
                      var dwEffect  : Longint): Boolean;
        override;
        {-}
      function  DoDoDragOver(const aData  : IDataObject;
                             const aPoint : TPoint): Boolean;
        override;
        {-}
      procedure DoDoDragLeave;
        override;
        {-}
      {$IfNDef DesignTimeLibrary}
      function  DataObjectClass: RvtNodeDataObject;
        virtual;
        {-}
      {$EndIf  DesignTimeLibrary}  
      procedure Cleanup;
        override;
        {-}
    public
    // public methods
      constructor Create(anOwner: TComponent);
        override;
        {-}
    public
    // public properties
      property DragAndDropSupported: Boolean
        read f_DnDSupported
        write f_DnDSupported
        default false;
        {-}
      property OnCanBeginDrag: Tl3CanBeginDrag
        read f_OnCanBeginDrag
        write f_OnCanBeginDrag;
        {-}
      property OnCanAcceptData: Tl3CanAcceptData
        read f_OnCanAcceptData
        write f_OnCanAcceptData;
        {-}
      property OnDoDrop: Tl3DoDrop
        read f_OnDoDrop
        write f_OnDoDrop;
        {-}
      property HighLighted: Integer
        read f_HighLighted
        write SetHighLighted;
        {-}
      property VJustify;
        {-}
  end;//TvtOutlinerWithDragDrop

implementation

uses
  Types,

  Windows,

  l3Defaults,
  l3TreeConst,
  l3String,
  l3SysUtils,

  vtOutlinerWithDragDropRes
  ;

// start class TvtOutlinerWithDragDrop

constructor TvtOutlinerWithDragDrop.Create(anOwner: TComponent);
begin
 inherited;
 f_DnDSupported := false;
 f_OnCanBeginDrag := nil;
 f_OnCanAcceptData := nil;
 f_OnDoDrop := nil;
 f_HighLighted := -1;
end;

procedure TvtOutlinerWithDragDrop.Cleanup;
begin
 f_OnCanAcceptData := nil;
 f_OnDoDrop := nil;
 inherited;
end;

{$IfNDef DesignTimeLibrary}
function TvtOutlinerWithDragDrop.DataObjectClass: RvtNodeDataObject;
  //virtual;
  {-}
begin
 Result := TevNodeData;
end;
{$EndIf DesignTimeLibrary}

function TvtOutlinerWithDragDrop.CanAcceptDataAt(const aData  : IDataObject;
                                                 const aPoint : TPoint): Boolean;
var
 l_Index : Integer;
 l_Part  : Byte;
begin
 HitTest(aPoint, l_Index, l_Part, true);
 if (l_Index <> HighLighted) then
  HighLighted := l_Index;
 Result := CanAcceptData(aData);
end;

function TvtOutlinerWithDragDrop.CanAcceptData(const aData: IDataObject): Boolean;
  {-}

  function lp_CanAcceptNode: Boolean;
  var
   l_Medium            : Tl3StoragePlace;
   l_Node              : Il3SimpleNode;
   l_NodeHighLighted   : Il3SimpleNode;
   l_Format            : Cardinal;

   function lp_GetData: Boolean;
   var
    l_FormatEtc: TFormatEtc;
   begin
    with l_FormatEtc do
    begin
     ptd := nil;
     dwAspect := DVASPECT_CONTENT; // - нужно содержимое
     lIndex := -1;
     tymed := TYMED_HGLOBAL or TYMED_ISTREAM or TYMED_GDI;
     cfFormat := l_Format;
    end;//with l_FormatEtc
    Result := aData.GetData(l_FormatEtc, l_Medium) = S_Ok;
   end;//lp_InitFormatEtc

   function lp_AskNode: Boolean;
   var
    l_Data: Pl3TreeData;
   begin
    if ((l_Format = CF_TreeNode) or (l_Format = CF_TreeNodes)) AND
     (l_Medium.tymed = TYMED_HGLOBAL) then
    begin
     l_Data := GlobalLock(l_Medium.hGlobal);
     try
      l_NodeHighLighted := GetNode(HighLighted);
      if (l_Data.rNode <> nil) and
          l_Data.rNode.IsSame(GetCurrentNode) and
          ((l_NodeHighLighted = nil) or (not l_NodeHighLighted.CanAcceptData(l_Data^))) then
       // - в список, из которого перетаскивают узлы их добавить нельзя;
       Result := False
      else
       Result := TreeStruct.CanAcceptData(l_Node, l_Data^);
     finally
      GlobalUnlock(l_Medium.hGlobal);
     end;//try..finally
    end//if l_Format in [CF_TreeNode, CF_TreeNodes])...
    else
     Result := false;
   end;//lp_AskNode

  var
   l_AcceptableFormats : Tl3ClipboardFormats;
   l_FormatIndex       : Integer;
  begin
   Result := false;
   if HighLighted = -1 then
    l_Node := GetCurrentNode
   else
    l_Node := GetNode(HighLighted);
   try
    l_AcceptableFormats := GetAcceptableFormats;
    for l_FormatIndex := Low(l_AcceptableFormats) to High(l_AcceptableFormats) do
    begin
     l_Format := l_AcceptableFormats[l_FormatIndex];
     // Получили приемлимый доступный формат:
     if lp_GetData then
     try
      Result := lp_AskNode;
     finally
      if (l_Medium.unkForRelease = nil) then
       l3ReleaseStgMedium(l_Medium);
     end;//try..finally
     // Данные приняты, выходим:
     if Result then
      Exit;
    end;//for l_Format := Low(GetAcceptableFormats)...
   finally
    l_Node := nil;
   end;//try..finally
  end;//lp_CanAcceptNode

begin
 if Assigned(f_OnCanAcceptData) then
  Result := f_OnCanAcceptData(aData)
 else
  Result := lp_CanAcceptNode;
end;

function TvtOutlinerWithDragDrop.DoGetAcceptableFormats: Tl3ClipboardFormats;
  //override;
  {-}
begin
 Result := l3CatFormatArray(inherited DoGetAcceptableFormats,
  [CF_TreeNodes, CF_TreeNode]);
end;
  
function TvtOutlinerWithDragDrop.DoDoDrop(aFormat       : Tl3ClipboardFormat;
                                        const aMedium : Tl3StoragePlace;
                                        var dwEffect  : Longint): Boolean;
  //override;
  {-}
var
 l_Data : Pl3TreeData;
 l_Node : Il3SimpleNode;
begin
 if aMedium.tymed = TYMED_HGLOBAL then
 begin
  l_Data := GlobalLock(aMedium.hGlobal);
  try
   // Обработчик на форме:
   if Assigned(f_OnDoDrop) then
   begin
    if (aFormat = CF_TreeNode) and
      Supports(l_Data.rNode, Il3SimpleNode, l_Node) then
     Result := f_OnDoDrop(l_Node, false, dwEffect)
    else
     Result := false; 
   end//Assigned(f_OnDoDrop)
   // Данные будет принимать узел:
   else
    if (aFormat = CF_TreeNode) or (aFormat = CF_TreeNodes) then
    begin
     // При вставке из буфера текущего подсвеченного нет:
     if HighLighted = -1 then
      l_Node := CurrentCNode
     else
      l_Node := GetNode(HighLighted);
     try
      Result := TreeStruct.DropData(l_Node, l_Data^);
     finally
      l_Node := nil;
     end;//try..finally
    end//if Assigned(f_OnDoDrop) then
    else
     Result := False;
  finally
   GlobalUnlock(aMedium.hGlobal);
  end;//try..finally
 end//aFormat = CF_TreeNode
 else
  Result := inherited DoDoDrop(aFormat, aMedium, dwEffect);
end;//DoDoDrop

function TvtOutlinerWithDragDrop.DoDoDragOver(const aData  : IDataObject;
                                              const aPoint : TPoint): Boolean;
var
 l_Pt : TPoint;
begin
 inherited DoDoDragOver(aData, aPoint);
 l_Pt := ScreenToClient(aPoint);
 if (l_Pt.Y <= 15) then
  vlbVScrollPrim(-1)
 else
 if (l_Pt.Y >= Height - 15) then
  vlbVScrollPrim(+1);
 Result := CanAcceptDataAt(aData, aPoint);
end;

procedure TvtOutlinerWithDragDrop.DoDoDragLeave;
  {-}
begin
 HighLighted := -1;
 inherited;
end;

procedure TvtOutlinerWithDragDrop.DoOnGetItemStyle(aItemIndex         : Integer;
                                                   const aFont        : Il3Font;
                                                   var aTextBackColor : TColor;
                                                   var aItemBackColor : TColor;
                                                   var aVJustify      : TvtVJustify;
                                                   var aFocused       : Boolean;
                                                   var theImageVertOffset : Integer);
  //override;
  {-}
const
 cActiveColor = c_MainMenuColor{clRed};
begin
 inherited;
 if (aItemIndex = HighLighted) and (aItemIndex <> -1) then
 begin
  if MultiStrokeItem OR (fsBold in aFont.Style) then
  begin
   if (aFont.ForeColor <> cActiveColor) then
    aFont.ForeColor := cActiveColor
   else
    aFont.ForeColor := clBlack;
  end//MultiStrokeItem
  else
   aFont.Style := aFont.Style + [fsBold];
 end;//aItemIndex = HighLighted..
end;

procedure TvtOutlinerWithDragDrop.SetHighLighted(aIndex : Integer);
begin
 if (aIndex < -1) or (aIndex >= Total) then
  aIndex := -1;
 if (aIndex <> f_HighLighted) then
 begin
  if (DragImageList <> nil) then
   DragImageList.HideDragImage;
  try
   f_HighLighted := aIndex;
   if (f_HighLighted >= 0) then
    TryExpandNode(TreeStruct.Nodes[f_HighLighted], true);
   Repaint;
  finally
   if (DragImageList <> nil) then
    DragImageList.ShowDragImage;
  end;//try..finally
 end;//aIndex <> f_HighLighted
end;//SetHighLighted

function TvtOutlinerWithDragDrop.GetDragAndDropSupported: Boolean;
begin
 Result := DragAndDropSupported;
end;

function TvtOutlinerWithDragDrop.MakeDraggingText(const aNode: Il3SimpleNode): Il3CString;
begin
 if (SelectedCount > 1) then
  Result := l3Fmt(str_nsc_MultiSelectDraggingText.AsCStr, [SelectedCount])
 else
  Result := l3CStr(aNode.Text);
end;

procedure TvtOutlinerWithDragDrop.TryDragAndDrop(aNodeIndex: Integer; aKey: Integer);

var
 l_Bitmap     : Tl3BitmapContainer;
 l_Node       : Il3SimpleNode;

  {$IfNDef DesignTimeLibrary}
  function lp_MakeDataObject: IDataObject;
  begin
   Result := TreeStruct.MakeDataObject(l_Node, l_Bitmap);
   if Result = nil then
    Result := DataObjectClass.Make(l_Node, l_Bitmap);
  end;//lp_MakeDataObject
  {$EndIf  DesignTimeLibrary}

var
 l_Rect       : TRect;
 l_DnDCaption : Il3CString;

  function lp_CalcRect(const aCanvas: Il3Canvas): TRect;
  begin
   Result := l_Rect;
    // - размер рамки у элемента дерева;
   with aCanvas do
    if MultiStrokeItem then
     DrawText(l_DnDCaption.AsWStr, Result, DT_WORDBREAK or DT_CALCRECT)
    else
    begin
     DrawText(l_DnDCaption.AsWStr, Result, DT_SINGLELINE or DT_CALCRECT);
     // Если прямоугольник получился длинее чем элемент дерева, то корректируем
     // его:
     if Result.Right > l_Rect.Right then
      Result.Right := l_Rect.Right;
    end;//if MultiStrokeItem then
  end;//lp_CalcRect

const
 cTextIndent = 15;
  // - отступ при выводе текста.
var
 l_dwOkEffect : Longint;
 l_dwEffect   : Longint;
 l_R          : Tl3SRect;
 l_DO         : IDataObject;
begin
 l_Node := GetNode(aNodeIndex);
 if (l_Node <> nil) then
 try
  if Assigned(f_OnCanBeginDrag) then
  begin
   l_dwOkEffect := DROPEFFECT_COPY or DROPEFFECT_MOVE;
   f_OnCanBeginDrag(l_Node, l_dwOkEffect);
   if (l_dwOkEffect = DROPEFFECT_NONE) then
    Exit;
  end//Assigned(f_OnCanBeginDrag)
  else
   if l_Node.CanMove then
    l_dwOkEffect := DROPEFFECT_COPY or DROPEFFECT_MOVE
   else
    l_dwOkEffect := DROPEFFECT_COPY;
  inherited TryDragAndDrop(aNodeIndex, aKey);
  {$IfNDef DesignTimeLibrary}
  l_DnDCaption := MakeDraggingText(l_Node);
  l_Bitmap := Tl3BitmapContainer.Create; // Создаем растр
  try
   with l_Bitmap do
   begin
    Bitmap.PixelFormat := pf24bit;
    l_Rect := GetDrawTextRect(Current);//GetDrawTextRect
    with Canvas do
    begin
     BeginPaint;
     try
      with Font do
      begin
       ForeColor := clRed;
       BackColor := clWindow;
      end;//with Font do
      DrawEnabled := true;
      // Определим размер выводимой подписи:
      l_Rect := lp_CalcRect(l_Bitmap.Canvas);
      // Добавим пространства для рамки:
      InflateRect(l_Rect, 1, 1);
      // Установим размер изображения:
      Width := l_Rect.Right - l_Rect.Left + 1 + cTextIndent;
      Height := l_Rect.Bottom - l_Rect.Top + 1;
      // Рамка:
      l_R := l3SRect(cTextIndent, 0, l_Bitmap.Width, l_Bitmap.Height);
       // - смещение рамки с текстом относительно курсора;
      DrawFocusRect(l_R);
      Brush.Style := bsClear;
      // Текст:
      l_R.Inflate1(-1);
      ClipRect := DR2LR(l_R);
      if MultiStrokeItem then
       DrawText(l_DnDCaption.AsWStr, TRect(l_R), DT_WORDBREAK)
      else
       DrawText(l_DnDCaption.AsWStr, TRect(l_R), DT_SINGLELINE);
     finally
      EndPaint;
     end;//try..finally
    end;//with Canvas
   end;//with l_Bitmap
   l_DO := lp_MakeDataObject;
   try
    DoDragDrop(l_DO, l_dwOkEffect, l_dwEffect);
   finally
    l_DO := nil;
   end;//try..finally
  finally
   l3Free(l_Bitmap);
  end;//try..finally
  {$EndIf  DesignTimeLibrary}
 finally
  l_Node := nil;
 end;//try..finally
end;

end.
