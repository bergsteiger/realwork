unit nsContentsNode;

// $Id: nsContentsNode.pas,v 1.17 2014/04/30 13:11:33 lulin Exp $

// $Log: nsContentsNode.pas,v $
// Revision 1.17  2014/04/30 13:11:33  lulin
// - вычищаем ненужные зависимости.
//
// Revision 1.16  2014/04/24 16:54:08  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.15  2014/04/21 16:25:29  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.14  2014/04/08 09:15:16  lulin
// {RequestLink:527682864}.
//
// Revision 1.12  2014/04/07 17:55:59  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.11  2014/04/04 17:53:37  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.10  2014/03/25 11:41:18  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.9  2014/03/13 16:36:45  lulin
// - разделяем реализацию _Tag и Box.
//
// Revision 1.8  2014/03/04 13:11:59  lulin
// - переводим идентификаторы Sub'ов и сегментов на нормальные Enum'ы.
//
// Revision 1.7  2013/10/21 17:30:55  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.6  2013/10/21 15:42:37  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.5  2013/10/21 10:30:30  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.4  2013/07/18 12:25:02  kostitsin
// [$471772806]
//
// Revision 1.3  2013/07/17 14:06:36  kostitsin
// [$454531102]
//
// Revision 1.2  2010/12/24 16:59:43  lulin
// {RequestLink:248195558}.
//
// Revision 1.1  2010/11/23 12:38:51  lulin
// {RequestLink:238945411}.
// - выделяем отдельный и наводим порядок.
//
// Revision 1.9  2010/09/22 12:10:13  lulin
// {RequestLink:235055410}. №2.
//
// Revision 1.8  2010/08/20 13:44:35  lulin
// {RequestLink:232100720}.
// - рисуем базовую ноду.
//
// Revision 1.7  2010/04/01 14:44:16  lulin
// {RequestLink:200085334}.
//
// Revision 1.6  2009/12/15 10:28:25  lulin
// - запрашиваем интерфейс у того объекта, который может его отдать. А не по цепочке родителей.
//
// Revision 1.5  2009/11/30 16:04:37  lulin
// {RequestLink:159352472}.
//
// Revision 1.4  2009/11/20 13:48:40  lulin
// - bug fix: неправильно создавались соседние ноды. В них терялись сильно необходимые данные.
//
// Revision 1.3  2009/11/17 14:49:28  lulin
// {ReqestLink:171967563}. Не учитывали тот факт, что саб мог и не быть в индексе. В результате теряли об этом сабе правильную информацию.
//
// Revision 1.2  2009/10/12 11:27:13  lulin
// - коммитим после падения CVS.
//
// Revision 1.2  2009/10/08 14:31:16  lulin
// - подготавливаемся к фильтрации источников опубликования.
//
// Revision 1.1  2009/09/14 11:28:55  lulin
// - выводим пути и для незавершённых модулей.
//
// Revision 1.4  2009/03/04 13:32:35  lulin
// - <K>: 137470629. Генерируем идентификаторы типов с модели и убираем их из общей помойки.
//
// Revision 1.3  2008/12/12 19:19:02  lulin
// - <K>: 129762414.
//
// Revision 1.2  2008/10/30 15:09:15  lulin
// - <K>: 121159648.
//
// Revision 1.1  2008/10/29 13:50:51  lulin
// - <K>: 121159763.
//
// Revision 1.58  2008/10/22 17:22:47  lulin
// - <K>: 121156794.
//
// Revision 1.57  2008/10/21 10:42:55  lulin
// - <K>: 121156801.
//
// Revision 1.56  2008/09/18 10:23:42  oman
// - fix: Не обновляли оглавление на фоне превью (К-118392311)
//
// Revision 1.55  2008/07/28 09:21:21  mmorozov
// - new: оглавление после обновления не перечитывалось  (K<96484716>);
//
// Revision 1.54  2008/07/08 09:24:41  lulin
// - забыли директиву видимости.
//
// Revision 1.53  2008/06/26 13:25:04  lulin
// - <K>: 95489287.
//
// Revision 1.52  2008/04/03 11:19:09  oman
// - new: Документ-препарат - параметры контекстной фильтрации (cq28562)
//
// Revision 1.51  2008/03/24 13:15:39  oman
// - fix: Не падаем в случае отсутствия значений (cq28695)
//
// Revision 1.50  2008/01/10 07:22:58  oman
// Переход на новый адаптер
//
// Revision 1.48.4.2  2007/12/21 09:45:45  mmorozov
// - MERGE WITH HEAD;
//
// Revision 1.48.4.1  2007/11/21 10:26:26  oman
// Перепиливаем на новый адаптер
//
// Revision 1.49  2007/12/21 07:12:14  mmorozov
// - new: подписка на уведомление об обновлении данных (CQ: OIT5-27823);
//
// Revision 1.48  2007/10/04 13:42:42  oman
// - fix: Некорректно сбрасывали структуру на переключении баз (cq26906)
//
// Revision 1.47  2007/09/28 18:07:09  lulin
// - прикрутил использование места, где должна показываться метка.
//
// Revision 1.46  2007/06/28 06:51:12  lulin
// - cleanup.
//
// Revision 1.45  2007/06/28 06:01:14  lulin
// - избавляемся от дублирования имен.
//
// Revision 1.44  2007/06/27 15:39:46  lulin
// - избавляемся от дублирования имен.
//
// Revision 1.43  2007/06/27 15:02:54  lulin
// - cleanup.
//
// Revision 1.42  2007/05/17 13:59:54  oman
// - fix: Разворачиваем _только_ оглавление (cq25156)
//
// Revision 1.41  2007/03/30 07:13:10  oman
// cleanup (nsDataResetTreeStruct.RegetRootNode)
//
// Revision 1.40  2007/03/23 07:48:34  oman
// - new: Первое приближение новой контекстной фильтрации на
//  структуре документа (cq24456)
//
// Revision 1.39  2007/02/26 13:51:50  oman
// cleanup
//
// Revision 1.38  2007/01/26 10:40:39  oman
// - fix: При контекстной фильтрации делалось не то дерево (cq24111)
//
// Revision 1.37  2007/01/25 13:53:17  oman
// - fix: Делаем "отложенный" DataReset - иначе разваленное
//  оглавление на переключении баз и Back по истории (cq24170)
//
// Revision 1.36  2006/12/08 08:58:50  lulin
// - оптимизация: не парсим стиль ноды, если и так известно значение слоя.
//
// Revision 1.35  2006/11/15 11:51:27  lulin
// - bug fix: не синхронизировали оглавление при первичной загрузке документа (CQ OIT5-23355).
//
// Revision 1.34  2006/11/10 17:15:31  lulin
// - объединил с веткой.
//
// Revision 1.33  2006/11/03 09:45:42  oman
// Merge with B_NEMESIS_6_4_0
//
// Revision 1.32.2.4  2006/11/01 13:25:16  demon
// - fix: GetFirstFit вызываем на рутовой ноде, а не на первом ребенке
// - fix: если подали ID = 0, то возвращаем ноду "Оглавление" (если она есть) без поиска.
//
// Revision 1.32.2.3  2006/11/01 12:34:16  lulin
// - cleanup.
//
// Revision 1.32.2.2  2006/10/31 14:06:59  demon
// - new: Создан метод для нахождения блока в оглавлении по ID (использует механизме на адаптерном дереве)
//
// Revision 1.32.2.1  2006/10/25 10:01:15  mmorozov
// - new behaviour: не кешируем значение HasChild на _TnsINodeWrap, всегда спрашиваем значение у адаптерной ноды;
//
// Revision 1.32  2006/09/12 14:03:42  oman
// - new beh: Поддержка свернуть/развернуть для новых деревьях (cq22540)
//
// Revision 1.31  2006/05/18 08:54:28  lulin
// - bug fix: оглавление создавалось раньше документа - в результате не ставились закладки на элементы оглавления (CQ OIT5-20966).
//
// Revision 1.30  2006/05/06 11:27:36  lulin
// - cleanup.
//
// Revision 1.29  2005/12/16 13:49:29  lulin
// - базовое дерево теперь посылает нотификацию о смене числа детей.
//
// Revision 1.28  2005/12/16 13:36:13  lulin
// - new behavior: теперь нотифицируем о необходимости открытия/закрытия оглавления через подписку к дереву на изменение числа детей.
//
// Revision 1.27  2005/12/08 17:40:21  lulin
// - bug fix: в 3-й раз починил циклические ссылки между объектами.
// - bug fix: висло при Back по истории - т.к. циклически создавался контейнер документа.
//
// Revision 1.26  2005/12/03 21:22:17  lulin
// - контейнер документа распилен на два - потоковый и деревянный.
//
// Revision 1.25  2005/12/03 14:46:53  lulin
// - избавляемся от хитросплетений методов TextSource и контейнера документа.
//
// Revision 1.24  2005/11/30 17:45:44  lulin
// - выделен утилитный модуль.
//
// Revision 1.23  2005/10/24 08:12:27  lulin
// - bug fix: падали с неправильным приведением к интерфейсу, когда у документа не было оглавления.
//
// Revision 1.22  2005/10/24 04:57:37  lulin
// - bug fix: если родительская нода была псевдо-нодой (не из документа), то вместо нее возвращали nil.
//
// Revision 1.21  2005/10/21 09:14:14  lulin
// - bug fix: не до конца было реализовано оглавление - если дергать детей от Root, то они обладали лишь базовым, а не специфическим поведением.
//
// Revision 1.20  2005/10/07 09:21:51  lulin
// - bug fix: при рисовании документа совершенно бесцельно дергался поиск параграфа с Sub'ом.
//
// Revision 1.19  2005/10/05 08:28:49  lulin
// - bug fix: из оглавления от документа в виде дерева, не переходили на встроенные объекты.
//
// Revision 1.18  2005/09/30 05:38:15  lulin
// - сделан переход на закладки и комментарии из оглавления.
//
// Revision 1.17  2005/09/29 15:20:20  lulin
// - задел на правильный переход на закладки и комментарии.
//
// Revision 1.16  2005/09/29 15:02:59  lulin
// - выделен общий код.
//
// Revision 1.15  2005/09/28 17:04:58  lulin
// - new behavior: реализован переход на блоки и Sub'ы в документе в виде дерева - на основе GetFirstFit.
//
// Revision 1.14  2005/09/27 12:55:39  lulin
// - задел на переход на Sub - как только пропадет CORBA Marshal, так сразу можно включить.
//
// Revision 1.13  2005/09/27 10:32:01  lulin
// no message
//
// Revision 1.12  2005/09/21 11:39:11  lulin
// - с моей стороны сделан переход на закладки из оглавления, ждем теперь Захарова (ошибка в CQ есть).
//
// Revision 1.11  2005/09/21 10:44:30  lulin
// - с моей стороны сделан переход на комментарии из оглавления, ждем теперь Захарова (ошибка в CQ есть).
//
// Revision 1.10  2005/09/15 10:07:27  lulin
// - bug fix: оставались неосвобожденные объекты - после перехода из оглавления на начало документа.
//
// Revision 1.9  2005/09/14 13:39:40  lulin
// - заработал переход на блок из оглавления.
//
// Revision 1.8  2005/09/14 09:59:11  lulin
// - практически доделан переход на Sub в документе в виде дерева - заработает, когда _FindNodePath будет возвращать правильные данные.
//
// Revision 1.7  2005/09/14 07:52:05  lulin
// - заготовка для реализации корректного перехода на Sub.
//
// Revision 1.6  2005/09/14 06:27:05  lulin
// - заготовка для реализации корректного перехода на Sub.
//
// Revision 1.5  2005/09/13 15:09:50  lulin
// - по умолчанию получаем документ в виде дерева.
// - попытался прикрутить позиционирование на Sub из оглавления - не получилось - завтра продолжу.
//
// Revision 1.4  2005/09/07 14:20:15  lulin
// - задел на переход на блок, которого еще не было на экране.
//
// Revision 1.3  2005/09/07 12:26:09  lulin
// - bug fix: в оглавлении закладки были с неправильными иконками.
//
// Revision 1.2  2005/09/05 10:04:34  lulin
// - теперь в новом дереве оглавления документа стали отдаваться интерфейсы блока и Sub'а - в результате в оглавлении стали рисоваться правильные иконки.
//
// Revision 1.1  2005/09/05 08:12:25  lulin
// - зачатки специализированного дерева для оглавления документа.
//

{$Include nsDefine.inc }

interface

uses
  l3IID,
  l3Interfaces,
  l3TreeInterfaces,
  l3Tree_TLB,
  l3Variant,

  k2Interfaces,

  afwInterfaces,

  evdTypes,

  evSubImplementation,
  
  nevTools,

  eeSubExport,

  DocTreeUnit,
  DynamicTreeUnit,

  nsINodeWrap,
  nsDataResetTreeStruct,
  nsFilterableTreeStruct
  ;

type
  TnsContentsNode = class(TnsINodeWrap, Il3HandleNode)
    private
    // internal fields
      f_Document : Tl3Tag;
    protected
    // interface methods
      // Il3HandleNode
      function  Get_Handle: Integer;
        virtual;
      procedure Set_Handle(Value: Integer);
        {-}
    protected
    // internal methods
      function  MakeChild(const aNode: INodeBase): Il3SimpleNode;
        override;
        {-}
      function  MakeParent(const aNode: INodeBase): Il3SimpleNode;
        override;
        {-}
      function MakeSibling(const aNode: INodeBase): Il3SimpleNode;
        override;
        {-}
      procedure Cleanup;
        override;
        {-}
    public
    // public methods
      constructor Create(const aNode     : INodeBase;
                         aDocument : Tl3Variant);
        reintroduce;
        {-}
      class function Make(const aNode     : INodeBase;
                          aDocument : Tl3Variant): Il3SimpleNode;
        reintroduce;
        {-}
  end;//TnsContentsNode

  TnsContentsRoot = class(TnsContentsNode, Il3SimpleRootNode)
    protected
    // internal methods
    function CanExpandCollapseAll: Boolean;
      {-}
    procedure ExpandCollapseAll(anExpand: Boolean);
      {-}
  end;//TnsContentsRoot

  TnsContentsTagNode = class(TnsContentsNode)
    private
    // internal fields
      f_Tag : Tl3Tag;
    protected
    // internal methods
      function  COMQueryInterface(const IID: Tl3GUID; out Obj): Tl3HResult;
        override;
        {-}
      procedure Cleanup;
        override;
        {-}
    public
    // public methods
      constructor Create(const aNode     : INodeBase;
                         aDocument : Tl3Variant;
                         aTag      : Tl3Variant);
        reintroduce;
        {-}
      class function Make(const aNode     : INodeBase;
                          aDocument : Tl3Variant;
                          aTag      : Tl3Variant): Il3SimpleNode;
        reintroduce;
        {-}
  end;//TnsContentsTagNode

  TnsHandledHode = class(TnsContentsTagNode)
    protected
    // interface methods
      function  Get_Handle: Integer;
        override;
        {-}
  end;//TnsHandledHode

  TnsContentsLeafParaNode = class(TnsHandledHode)
  end;//TnsContentsLeafParaNode

  TnsContentsSubNode = class(TnsHandledHode)
    protected
    // internal methods
      function  LayerID: Integer;
        virtual;
        {-}
      function  COMQueryInterface(const IID: Tl3GUID; out Obj): Tl3HResult;
        override;
        {-}
  end;//TnsContentsSubNode

  TnsBookmarkNode = class(TnsContentsSubNode)
    protected
    // internal methods
      function  LayerID: Integer;
        override;
        {-}
  end;//TnsBookmarkNode

  TnsContentsBlockNode = class(TnsContentsSubNode)
    protected
    // internal methods
      function  COMQueryInterface(const IID: Tl3GUID; out Obj): Tl3HResult;
        override;
        {-}
  end;//TnsContentsBlockNode

  TnsRealBlockNode = class(TnsContentsBlockNode)
  end;//TnsRealBlockNode

  TnsContentsCommentNode = class(TnsContentsBlockNode)
    protected
    // internal methods
      function  LayerID: Integer;
        override;
        {-}
  end;//TnsContentsCommentNode

  TnsDocumentNode = class(TnsRealBlockNode)
  end;//TnsDocumentNode

  TnsSubPrim = class(TeeSubExport)
    protected
    // internal methods
      function  Tag: Tl3Tag;
        virtual;
        {-}
      function  SubPara: Tl3Variant;
        virtual;
        {-}
      function  CheckExists: Boolean;
        {-}
      function  pm_GetSubPlace: TevSubPlace;
        override;
        {-}
      function  Exists: Boolean;
        override;
        {-}
      function  Select(const Selection: InevSelection): Boolean;
        override;
        {-}
      function GetIsVisibleOnSubPanel: Boolean;
        override;
        {+}
  end;//TnsSubPrim

  TnsSubImplementation = class(TnsSubPrim)
    private
    // internal fields
      f_Node : Il3SimpleNode;
    protected
    // internal methods
      function  AdapterNode: INodeBase;
        {-}
      function  DocumentNode: INodeBase;
        {-}
      function  Tag: Tl3Tag;
        override;
        {-}
      function  SubPara: Tl3Variant;
        override;
        {-}
      procedure Cleanup;
        override;
        {-}
    public
    // public methods
      constructor Create(aDocument  : Tl3Variant;
                         anID             : Integer;
                         aLayerID         : Integer;
                         const aNode      : Il3SimpleNode);
        reintroduce;
        {-}
      class function Make(aDocument  : Tl3Variant;
                          anID             : Integer;
                          aLayerID         : Integer;
                          const aNode      : Il3SimpleNode): IevSub;
        reintroduce;
        {-}
  end;//TnsSubImplementation

  TnsDocumentPartImplementation = class(TevDocumentPartImplementation)
    public
    // public methods
      constructor Create(aDocument  : Tl3Variant;
                         anID             : Integer;
                         aLayerID         : Integer;
                         const aNode      : Il3SimpleNode);
        reintroduce;
        {-}
      class function Make(aDocument  : Tl3Variant;
                          anID             : Integer;
                          aLayerID         : Integer;
                          const aNode      : Il3SimpleNode): IevDocumentPart;
        reintroduce;
        {-}
  end;//TnsDocumentPartImplementation

implementation

uses
  SysUtils,

  l3Types,
  l3Base,

  k2Tags,

  evTypes,
  evInternalInterfaces,

  nevInternalInterfaces,

  nsTagNodeTools,
  nsConst, 
  nsTreeStruct,
  nsContentsTree,

  Block_Const,
  CommentPara_Const,
  Sub_Const,

  nsTagNodeToolsNew,
  DocumentUnit
  ;

// start class TnsContentsNode

constructor TnsContentsNode.Create(const aNode     : INodeBase;
                                   aDocument : Tl3Variant);
  //reintroduce;
  {-}
begin
 aDocument.SetRef(f_Document);
 inherited Create(aNode);
end;

class function TnsContentsNode.Make(const aNode     : INodeBase;
                                    aDocument : Tl3Variant): Il3SimpleNode;
  //reintroduce;
  {-}
var
 l_Node : TnsContentsNode;
begin
 if (aNode = nil) then
  Result := nil
 else
 begin
  l_Node := Create(aNode, aDocument);
  try
   Result := l_Node;
  finally
   l3Free(l_Node);
  end;//try..finally
 end;//aNode = nil
end;

procedure TnsContentsNode.Cleanup;
  //override;
  {-}
begin
 inherited;
 FreeAndNil(f_Document);
end;

function TnsContentsNode.Get_Handle: Integer;
  //virtual;
  {-}
begin
 Result := 0;
end;

procedure TnsContentsNode.Set_Handle(Value: Integer);
  {-}
  {-}
begin
 Assert(False);
end;

function TnsContentsNode.MakeChild(const aNode: INodeBase): Il3SimpleNode;
  //override;
  {-}
begin
 Result := TnsContentsTree.MakeTagNode(f_Document, aNode);
 if (Result = nil) then
  Result := TnsContentsNode.Make(aNode, f_Document);
end;

function TnsContentsNode.MakeParent(const aNode: INodeBase): Il3SimpleNode;
  //override;
  {-}
begin
 Result := TnsContentsTree.MakeTagNode(f_Document, aNode);
 if (Result = nil) then
  Result := TnsContentsNode.Make(aNode, f_Document);
end;

function TnsContentsNode.MakeSibling(const aNode: INodeBase): Il3SimpleNode;
  //override;
  {-}
begin
 Result := TnsContentsTree.MakeTagNode(f_Document, aNode);
 if (Result = nil) then
  Result := TnsContentsNode.Make(aNode, f_Document);
end;

// start class TnsHandledNode

function TnsHandledHode.Get_Handle: Integer;
  {-}
begin
 Result := f_Tag.IntA[k2_tiHandle];
end;

// start class TnsContentsSubNode

function TnsContentsSubNode.LayerID: Integer;
  //virtual;
  {-}
begin
 Result := Ord(ev_sbtSub);
end;

function TnsContentsSubNode.COMQueryInterface(const IID: Tl3GUID; out Obj): Tl3HResult;
  //override;
  {-}
begin
 Result.SetOk;
 if IID.EQ(IevSub) then
 begin
  {$IfOpt D-}
  if (f_Document <> nil) AND (f_Tag <> nil) then
  {$EndIf}
   IevSub(Obj) := TnsSubImplementation.Make(f_Document,
                                            f_Tag.IntA[k2_tiHandle], LayerID,
                                            Self)
  {$IfOpt D-}
  else
   Result.SetNoInterface
  {$EndIf};
 end//IID.EQ(IevSub)
 else
  Result := inherited COMQueryInterface(IID, Obj);
end;

// start class TnsContentsTagNode

constructor TnsContentsTagNode.Create(const aNode     : INodeBase;
                                      aDocument : Tl3Variant;
                                      aTag      : Tl3Variant);
  //reintroduce;
  {-}
begin
 inherited Create(aNode, aDocument);
 aTag.SetRef(f_Tag);
end;

class function TnsContentsTagNode.Make(const aNode     : INodeBase;
                                       aDocument : Tl3Variant;
                                       aTag      : Tl3Variant): Il3SimpleNode;
  //reintroduce;
  {-}
var
 l_Node : TnsContentsTagNode;
begin
 if (aNode = nil) then
  Result := nil
 else
 begin
  l_Node := Create(aNode, aDocument, aTag);
  try
   Result := l_Node;
  finally
   l3Free(l_Node);
  end;//try..finally
 end;//aNode = nil
end;

procedure TnsContentsTagNode.Cleanup;
  //override;
  {-}
begin
 inherited;
 FreeAndNil(f_Tag);
end;

function TnsContentsTagNode.COMQueryInterface(const IID: Tl3GUID; out Obj): Tl3HResult;
  //override;
  {-}
begin
 Result.SetOk;
 if IID.EQ(Il3TagRef) then
  Il3TagRef(Obj) := f_Tag.AsRef
 else
  Result := inherited COMQueryInterface(IID, Obj);
end;

// start class TnsContentsCommentNode

function TnsContentsCommentNode.LayerID: Integer;
  //override;
  {-}
begin
 Result := f_Tag.IntA[k2_tiLayerID];
end;

// start class TnsContentsBlockNode

function TnsContentsBlockNode.COMQueryInterface(const IID: Tl3GUID; out Obj): Tl3HResult;
  //override;
  {-}
begin
 Result.SetOk;
 if IID.EQ(IevDocumentPart) then
  IevDocumentPart(Obj) := TnsDocumentPartImplementation.Make(f_Document,
                                                             f_Tag.IntA[k2_tiHandle],
                                                             LayerID,
                                                             Self)
 else
  Result := inherited COMQueryInterface(IID, Obj);
end;

// start class TnsBookmarkNode

function TnsBookmarkNode.LayerID: Integer;
  //override;
  {-}
begin
 Result := Ord(ev_sbtBookmark);
end;

// start class TnsSubImplementation

constructor TnsSubImplementation.Create(aDocument  : Tl3Variant;
                                        anID             : Integer;
                                        aLayerID         : Integer;
                                        const aNode      : Il3SimpleNode);
  //reintroduce;
  {-}
var
 l_Proc : Ik2Processor;
begin
 if not aDocument.Box.Owner.QI(Ik2Processor, l_Proc) then
 begin
  if aDocument.Box.Owner.IsValid then
   Assert(false);
 end;//not aDocument.Box.Owner.QI(Ik2Processor, l_Proc)
 inherited Create(aDocument, l_Proc, anID, aLayerID);
 f_Node := aNode;
end;

class function TnsSubImplementation.Make(aDocument  : Tl3Variant;
                                         anID             : Integer;
                                         aLayerID         : Integer;
                                         const aNode      : Il3SimpleNode): IevSub;
  //reintroduce;
  {-}
var
 l_Node : TnsSubImplementation;
begin
 l_Node := Create(aDocument, anID, aLayerID, aNode);
 try
  Result := l_Node;
 finally
  l3Free(l_Node);
 end;//try..finally
end;

procedure TnsSubImplementation.Cleanup;
  //override;
  {-}
begin
 inherited;
 f_Node := nil;
end;

function TnsSubImplementation.AdapterNode: INodeBase;
  {-}
begin
 Supports(f_Node, INodeBase, Result);
end;

function TnsSubImplementation.DocumentNode: INodeBase;
  {-}
begin
 Supports(Document, INodeBase, Result);
end;

function TnsSubImplementation.Tag: Tl3Tag;
  {-}
var
 l_T : Il3TagRef;
begin
 if Supports(f_Node, Il3TagRef, l_T) then
  Result := l_T.AsObject
 else
  Result := nil;
end;

function TnsSubImplementation.SubPara: Tl3Variant;
  {-}

 procedure DoFind(const aNode: INodeBase);
 var
  l_Node : INodeBase;
  l_Para : INodeBase;
 begin//DoFind
  l_Node := DocumentNode;
  if (l_Node <> nil) then
  begin
   l_Node.FindNode(aNode, l_Para);
   if (l_Para <> nil) then
    Result := nsFindTagByNode(l_Node, l_Para, Document);
  end;//l_Node <> nil
 end;//DoFind

begin
 Result := nil;
 if Tag.IsKindOf(k2_typBlock) then
  DoFind(AdapterNode)
 else
 if Tag.IsKindOf(k2_typCommentPara) then
  Result := nsFindTagByID(Document, k2_typCommentPara, ID)
 else
 if Tag.IsKindOf(k2_typSub) then
  Result := nsFindTagByID(Document, k2_typSub, ID);
end;

// start class TnsDocumentPartImplementation

constructor TnsDocumentPartImplementation.Create(aDocument  : Tl3Variant;
                                                 anID             : Integer;
                                                 aLayerID         : Integer;
                                                 const aNode      : Il3SimpleNode);
  //reintroduce;
  {-}
var
 l_Sub : TnsSubImplementation;
begin
 l_Sub := TnsSubImplementation.Create(aDocument, anID, aLayerID, aNode);
 try
  inherited Create(l_Sub);
 finally
  l3Free(l_Sub);
 end;//try..finally
end;

class function TnsDocumentPartImplementation.Make(aDocument  : Tl3Variant;
                                                  anID             : Integer;
                                                  aLayerID         : Integer;
                                                  const aNode      : Il3SimpleNode): IevDocumentPart;
  //reintroduce;
  {-}
var
 l_Block : TnsDocumentPartImplementation;
begin
 l_Block := Create(aDocument, anID, aLayerID, aNode);
 try
  Result := l_Block;
 finally
  l3Free(l_Block);
 end;//try..finally
end;

// start class TnsSubPrim

function TnsSubPrim.SubPara: Tl3Variant;
  //virtual;
  {-}
begin
 Result := nil;
end;

function TnsSubPrim.CheckExists: Boolean;
  {-}
var
 l_Container : InevDocumentContainer;
 l_Para      : Tl3Variant;
 l_Doc       : InevPara;
begin
 if IsInIndex then
  Result := true
 else
 begin
  Result := False;
  if (Document <> nil) AND (ID >= 0) then
  begin
   l_Para := SubPara;
   if (l_Para <> nil) AND l_Para.IsValid AND
      Document.QT(InevPara, l_Doc, Processor) then
    try
     l_Container := l_Doc.DocumentContainer;
     if (l_Container <> nil) then
     begin
      Result := l_Container.RealizeSub(LayerID, Tag, l_Para).IsValid;
      if Result then
      begin
       if (LayerID = Ord(ev_sbtSub)) AND (ID = 0) then
        Redirect := Document
       else
        Redirect := Document.rAtomEx([k2_tiSubs,
                                    k2_tiChildren, k2_tiHandle, LayerID,
                                    k2_tiChildren, k2_tiHandle, ID,
                                    k2_tiObject]);
      end;//Result
     end;//l_Container <> nil
    finally
     l_Doc := nil;
    end;//try..finally
  end;//ID > 0
 end;//IsInIndex
end;

function TnsSubPrim.pm_GetSubPlace: TevSubPlace;
  //override;
  {-}
begin
 if CheckExists then
  Result := inherited pm_GetSubPlace
 else
  Result := ev_spNoWhere; 
end;

function TnsSubPrim.Exists: Boolean;
  //override;
  {-}
begin
 Result := inherited Exists;
 if not Result then
  Result := CheckExists;
end;

function TnsSubPrim.Select(const Selection: InevSelection): Boolean;
  //override;
  {-}
begin
 if CheckExists then
  Result := inherited Select(Selection)
 else
  Result := False;
end;

function TnsSubPrim.GetIsVisibleOnSubPanel: Boolean;
var
 l_Provider: IDocumentTextProvider;
begin
 Result := True;
 if (Self.pm_GetLayerID = Ord(ev_sbtSub)) then
  if Self.pm_GetPara.Box.QI(IDocumentTextProvider, l_Provider) then
   Result := l_Provider.ShowSubPanelIcon(ID);
end;

function TnsSubPrim.Tag: Tl3Tag;
  //virtual;
  {-}
begin
 Result := nil;
end;

{ TnsContentsRoot }

function TnsContentsRoot.CanExpandCollapseAll: Boolean;
begin
 Result := True;
end;

procedure TnsContentsRoot.ExpandCollapseAll(anExpand: Boolean);
begin
 DoExpandCollapseAll(anExpand);
end;

end.
