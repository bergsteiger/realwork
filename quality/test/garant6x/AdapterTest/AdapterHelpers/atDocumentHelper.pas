unit atDocumentHelper;

// Модуль: "w:\quality\test\garant6x\AdapterTest\AdapterHelpers\atDocumentHelper.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TatDocumentHelper" MUID: (4815C75902A2)

interface

uses
 l3IntfUses
 , DocumentUnit
 , DynamicTreeUnit
 , l3_Base
 , BaseTypesUnit
;

type
 PTatLayerContext = ^TatLayerContext;

 TatCurr = record
  ChildrenCount: Integer;
  EP: TEntryPoint;
  ChildLayerID: TDocumentLayerID;
 end;//TatCurr

 TatLayerContext = record
  Curr: TatCurr;
  MaxChild: TChildID;
 end;//TatLayerContext

 TatDTPIterator = class
  private
   f_DTP: IDocumentTextProvider;
   f_LayerStack: array of TatLayerContext;
   f_CurrLayerIdx: Integer;
   f_CurrLayer: PTatLayerContext;
  private
   procedure PushLayer(const aLayer: TatLayerContext); virtual;
   procedure PopLayer; virtual;
   procedure InitLayerStackByNIP(const aNIP: INodeIndexPath); virtual;
  public
   constructor Create(const aDTP: IDocumentTextProvider); reintroduce; virtual;
   function GetNext: TEntryPoint; virtual;
   function HasNext: Boolean; virtual;
   procedure Reset; virtual;
   procedure SetNextToPara(aParaID: TParaId); virtual;
   procedure SetNextToSub(aSubID: TSubId); virtual;
  private
   property CurrLayer: PTatLayerContext
    read f_CurrLayer;
 end;//TatDTPIterator

 TatDTPParaIterator = class(TatDTPIterator)
  private
   f_HasNext: Boolean;
   f_IsParaMustHaveNonZeroID: Boolean;
   f_IsParaMustHaveComments: Boolean;
  public
   constructor Create(const aDTP: IDocumentTextProvider); reintroduce; virtual;
   function HasNext: Boolean; override;
   function GetNext: TEntryPoint; override;
  public
   property IsParaMustHaveNonZeroID: Boolean
    read f_IsParaMustHaveNonZeroID
    write f_IsParaMustHaveNonZeroID;
   property IsParaMustHaveComments: Boolean
    read f_IsParaMustHaveComments
    write f_IsParaMustHaveComments;
 end;//TatDTPParaIterator

 TEntryPointArr = array of TEntryPoint;

 TParaIDArr = array of TParaId;

 TatDocReader = class(TObject)
  private
   f_Document: IDocument;
   f_DTP: IDocumentTextProvider;
   f_ParaIDForJournal: TParaId;
   f_ParaIterator: TatDTPParaIterator;
   f_IsFullLoad: Boolean;
  private
   procedure ReadContent; virtual;
   procedure ReadDocBody; virtual;
  public
   constructor Create(const aDocument: IDocument); reintroduce; virtual;
   procedure Read; virtual;
   procedure ReadFromPara(aParaID: TParaId); virtual;
   procedure ReadFromSub(aSubID: TSubId); virtual;
   destructor Destroy; override;
  public
   property IsFullLoad: Boolean
    read f_IsFullLoad
    write f_IsFullLoad;
 end;//TatDocReader

 _EntityInterface_ = IBookmark;
 {$Include w:\quality\test\garant6x\AdapterTest\AdapterHelpers\atEntityWithName.imp.pas}
 TatBookmark = class(_atEntityWithName_)
  protected
   function pm_GetDocument: IDocument; virtual;
   function pm_GetPara: TParaId; virtual;
   function pm_GetComment: AnsiString; virtual;
  public
   property Document: IDocument
    read pm_GetDocument;
   property Para: TParaId
    read pm_GetPara;
   property Comment: AnsiString
    read pm_GetComment;
 end;//TatBookmark

 TatDocumentHelper = class
  private
   class procedure ReadChildBookmarks(const aDTP: IDocumentTextProvider;
    const aBookmarkList: IBookmarkList);
   class procedure ReadChildComment(const aDTP: IDocumentTextProvider;
    const anEP: TEntryPoint);
  public
   class function GetParaIDArray(const aDTP: IDocumentTextProvider;
    const aMaxParaCount: Integer;
    const isRandomParas: Boolean): TParaIDArr;
   class function IsParaType(aType: Word): Boolean;
   class function GetParaEPArray(const aDTP: IDocumentTextProvider;
    const aMaxParaCount: Integer;
    const isRandomParas: Boolean): TEntryPointArr;
   class procedure ReadPara(const aDTP: IDocumentTextProvider;
    const aParaEP: TEntryPoint);
   class function FindPara(const aDTP: IDocumentTextProvider;
    const aParaID: TParaId;
    out theEP: TEntryPoint): Boolean;
   class function GetEPByNIP(const aDTP: IDocumentTextProvider;
    const aNIP: INodeIndexPath): TEntryPoint;
   class function ReadParaText(const aDTP: IDocumentTextProvider;
    const anEP: TEntryPoint): AnsiString;
 end;//TatDocumentHelper

implementation

uses
 l3ImplUses
 , IOUnit
 , atNodeHelper
 , k2Facade
 , atLogger
 , LeafPara_Const
 , SysUtils
 , atCommon
 , Math
 , ActiveX
 , BitmapPara_Const
 , ExternalObjectUnit
 , atUserJournalHelper
 , atGblAdapterWorker
 , atStringHelper
 , k2Empty_Const
 //#UC START# *4815C75902A2impl_uses*
 //#UC END# *4815C75902A2impl_uses*
;

procedure TatDTPIterator.PushLayer(const aLayer: TatLayerContext);
//#UC START# *4CFE2AFB01CC_4CFCF9A6024F_var*
//#UC END# *4CFE2AFB01CC_4CFCF9A6024F_var*
begin
//#UC START# *4CFE2AFB01CC_4CFCF9A6024F_impl*
  Inc(f_CurrLayerIdx);
  if f_CurrLayerIdx+1 > Length(f_LayerStack) then
    SetLength(f_LayerStack, f_CurrLayerIdx+1);
  f_LayerStack[f_CurrLayerIdx] := aLayer;
  f_CurrLayer := @(f_LayerStack[f_CurrLayerIdx]);
//#UC END# *4CFE2AFB01CC_4CFCF9A6024F_impl*
end;//TatDTPIterator.PushLayer

procedure TatDTPIterator.PopLayer;
//#UC START# *4CFE2B140080_4CFCF9A6024F_var*
//#UC END# *4CFE2B140080_4CFCF9A6024F_var*
begin
//#UC START# *4CFE2B140080_4CFCF9A6024F_impl*
  Assert(f_CurrLayerIdx > 0, 'f_CurrLayerIdx > 0');
  Dec(f_CurrLayerIdx);
  f_CurrLayer := @(f_LayerStack[f_CurrLayerIdx]);
//#UC END# *4CFE2B140080_4CFCF9A6024F_impl*
end;//TatDTPIterator.PopLayer

constructor TatDTPIterator.Create(const aDTP: IDocumentTextProvider);
//#UC START# *4CFE69960335_4CFCF9A6024F_var*
//#UC END# *4CFE69960335_4CFCF9A6024F_var*
begin
//#UC START# *4CFE69960335_4CFCF9A6024F_impl*
  inherited Create();
  f_DTP := aDTP;
  Reset();
//#UC END# *4CFE69960335_4CFCF9A6024F_impl*
end;//TatDTPIterator.Create

function TatDTPIterator.GetNext: TEntryPoint;
//#UC START# *4CFD01FD00DB_4CFCF9A6024F_var*
  var
    l_NewLayer : TatLayerContext;
//#UC END# *4CFD01FD00DB_4CFCF9A6024F_var*
begin
//#UC START# *4CFD01FD00DB_4CFCF9A6024F_impl*
  // если у текущей есть дети, то делаем первого ребенка текущим
  if CurrLayer.Curr.ChildrenCount > 0 then
  begin
    l_NewLayer.Curr.EP.rLayer := CurrLayer.Curr.ChildLayerID;
    l_NewLayer.Curr.EP.rChild := ROOT_CHILD;
    l_NewLayer.MaxChild := CurrLayer.Curr.ChildrenCount-1;
    PushLayer(l_NewLayer);
  end
  else
  begin
    // если необходимо, поднимаемся вверх до незакончившегося слоя
    while CurrLayer.Curr.EP.rChild = CurrLayer.MaxChild do PopLayer;
    // и переходим к следующему элементу в слое
    Inc(CurrLayer.Curr.EP.rChild);
  end;
  
  Result := CurrLayer.Curr.EP;
//#UC END# *4CFD01FD00DB_4CFCF9A6024F_impl*
end;//TatDTPIterator.GetNext

function TatDTPIterator.HasNext: Boolean;
//#UC START# *4CFD01EF02C5_4CFCF9A6024F_var*
  var
    i : Integer;
//#UC END# *4CFD01EF02C5_4CFCF9A6024F_var*
begin
//#UC START# *4CFD01EF02C5_4CFCF9A6024F_impl*
  // смотрим, есть ли у текущей дети
  CurrLayer.Curr.ChildLayerID := f_DTP.GetChildLayerId(CurrLayer.Curr.EP);
  CurrLayer.Curr.ChildrenCount := f_DTP.ChildrenCount(CurrLayer.Curr.ChildLayerID);
  Result := CurrLayer.Curr.ChildrenCount > 0;

  // если нет, то проверяем что не дошли до конца
  i := f_CurrLayerIdx;
  while (NOT Result) AND (i >= 0) do
  begin
    Result := f_LayerStack[i].Curr.EP.rChild < f_LayerStack[i].MaxChild;
    Dec(i);
  end;
//#UC END# *4CFD01EF02C5_4CFCF9A6024F_impl*
end;//TatDTPIterator.HasNext

procedure TatDTPIterator.Reset;
//#UC START# *4DD3A0CC019F_4CFCF9A6024F_var*
  var
    l_NewLayer : TatLayerContext;
//#UC END# *4DD3A0CC019F_4CFCF9A6024F_var*
begin
//#UC START# *4DD3A0CC019F_4CFCF9A6024F_impl*
  l_NewLayer.Curr.EP.rLayer := ROOT_LAYER;
  l_NewLayer.Curr.EP.rChild := ROOT_CHILD;
  l_NewLayer.MaxChild := ROOT_CHILD;
  l_NewLayer.Curr.ChildrenCount := 1;
  //
  f_CurrLayerIdx := -1;
  PushLayer(l_NewLayer);
//#UC END# *4DD3A0CC019F_4CFCF9A6024F_impl*
end;//TatDTPIterator.Reset

procedure TatDTPIterator.InitLayerStackByNIP(const aNIP: INodeIndexPath);
//#UC START# *4DD3A0D902D1_4CFCF9A6024F_var*
  var
    i : Integer;
    l_NewLayer : TatLayerContext;
//#UC END# *4DD3A0D902D1_4CFCF9A6024F_var*
begin
//#UC START# *4DD3A0D902D1_4CFCF9A6024F_impl*
  Assert(aNIP <> nil, 'aNIP <> nil');
  //
  Reset();
  CurrLayer.Curr.ChildLayerID := f_DTP.GetChildLayerId(CurrLayer.Curr.EP);
  //
  for i := 0 to aNIP.Count-1 do
  begin
    l_NewLayer.Curr.EP.rChild := aNIP.Items[i];
    if (i = aNIP.Count-1) then
      if l_NewLayer.Curr.EP.rChild = ROOT_CHILD then
        break
      else
        Dec(l_NewLayer.Curr.EP.rChild);
    //
    l_NewLayer.Curr.EP.rLayer := CurrLayer.Curr.ChildLayerID;
    l_NewLayer.Curr.ChildLayerID := f_DTP.GetChildLayerId(l_NewLayer.Curr.EP);
    l_NewLayer.Curr.ChildrenCount := f_DTP.ChildrenCount(l_NewLayer.Curr.ChildLayerID);
    //
    l_NewLayer.MaxChild := CurrLayer.Curr.ChildrenCount-1;
    //
    PushLayer(l_NewLayer);
  end;
//#UC END# *4DD3A0D902D1_4CFCF9A6024F_impl*
end;//TatDTPIterator.InitLayerStackByNIP

procedure TatDTPIterator.SetNextToPara(aParaID: TParaId);
//#UC START# *4DD3A0F10121_4CFCF9A6024F_var*
  var
    l_NIP : INodeIndexPath;
//#UC END# *4DD3A0F10121_4CFCF9A6024F_var*
begin
//#UC START# *4DD3A0F10121_4CFCF9A6024F_impl*
  Reset();
  f_DTP.GetChildLayerId(CurrLayer.Curr.EP); // без этой строки FindPara внизу выкидывает ECanNotFindData там где не должен, почему так, я не знаю
  //
  try
    f_DTP.FindPara(aParaID, l_NIP);
  except
    on ex : ECanNotFindData do
    begin
      Logger.Info('Не можем найти параграф %d', [aParaID]);
      Raise;
    end;
  end;
  InitLayerStackByNIP(l_NIP);
//#UC END# *4DD3A0F10121_4CFCF9A6024F_impl*
end;//TatDTPIterator.SetNextToPara

procedure TatDTPIterator.SetNextToSub(aSubID: TSubId);
//#UC START# *4DD3A10C0050_4CFCF9A6024F_var*
  var
    l_NIP : INodeIndexPath;
//#UC END# *4DD3A10C0050_4CFCF9A6024F_var*
begin
//#UC START# *4DD3A10C0050_4CFCF9A6024F_impl*
  try
    f_DTP.FindBlockOrSub(aSubID, l_NIP);
  except
    on ex : ECanNotFindData do
    begin
      Logger.Info('Не можем найти саб %d', [aSubId]);
      Raise;
    end;
  end;
  InitLayerStackByNIP(l_NIP);
//#UC END# *4DD3A10C0050_4CFCF9A6024F_impl*
end;//TatDTPIterator.SetNextToSub

constructor TatDTPParaIterator.Create(const aDTP: IDocumentTextProvider);
//#UC START# *4DCD71E3035A_4CFE70A801B2_var*
//#UC END# *4DCD71E3035A_4CFE70A801B2_var*
begin
//#UC START# *4DCD71E3035A_4CFE70A801B2_impl*
  inherited;
  f_HasNext := false;
  f_IsParaMustHaveNonZeroID := false;
  f_IsParaMustHaveComments := false;
//#UC END# *4DCD71E3035A_4CFE70A801B2_impl*
end;//TatDTPParaIterator.Create

function TatDTPParaIterator.HasNext: Boolean;
//#UC START# *4CFD01EF02C5_4CFE70A801B2_var*
  var
    l_EP : TEntryPoint;
    l_Comment : IEVDStream;
//#UC END# *4CFD01EF02C5_4CFE70A801B2_var*
begin
//#UC START# *4CFD01EF02C5_4CFE70A801B2_impl*
  while (NOT f_HasNext) AND (inherited HasNext) do
  begin
    l_EP := inherited GetNext;
    //
    f_HasNext :=
      TatDocumentHelper.IsParaType( Ord(f_DTP.GetChildType(l_EP)) )
      AND ( (NOT f_IsParaMustHaveNonZeroID) OR (f_DTP.GetChildExternalId(l_EP) <> 0) );
    //  
    if f_HasNext AND f_IsParaMustHaveComments then
    begin
      f_DTP.GetChildComment(l_EP, l_Comment);
      f_HasNext := l_Comment <> nil;
    end;
  end;
  Result := f_HasNext;
//#UC END# *4CFD01EF02C5_4CFE70A801B2_impl*
end;//TatDTPParaIterator.HasNext

function TatDTPParaIterator.GetNext: TEntryPoint;
//#UC START# *4CFD01FD00DB_4CFE70A801B2_var*
//#UC END# *4CFD01FD00DB_4CFE70A801B2_var*
begin
//#UC START# *4CFD01FD00DB_4CFE70A801B2_impl*
  if f_HasNext OR HasNext then
    Result := CurrLayer.Curr.EP;
  f_HasNext := false;
//#UC END# *4CFD01FD00DB_4CFE70A801B2_impl*
end;//TatDTPParaIterator.GetNext

constructor TatDocReader.Create(const aDocument: IDocument);
//#UC START# *4DD39F4E00F4_4DD39F320114_var*
//#UC END# *4DD39F4E00F4_4DD39F320114_var*
begin
//#UC START# *4DD39F4E00F4_4DD39F320114_impl*
  inherited Create;
  f_Document := aDocument;
  f_IsFullLoad := false;
  //
  f_Document.GetTextProvider(false, f_DTP);
  Assert(f_DTP <> nil, 'f_DTP <> nil');
  f_ParaIterator := TatDTPParaIterator.Create(f_DTP);
//#UC END# *4DD39F4E00F4_4DD39F320114_impl*
end;//TatDocReader.Create

procedure TatDocReader.Read;
//#UC START# *4DD39FBB038F_4DD39F320114_var*
  var
    l_JournalBookmark : IJournalBookmark;
    l_Flash : IExternalObject;
//#UC END# *4DD39FBB038F_4DD39F320114_var*
begin
//#UC START# *4DD39FBB038F_4DD39F320114_impl*
  if f_Document.GetDocType = DT_FLASH then
  begin
    f_Document.GetFlash(l_Flash);
    if l_Flash <> nil then
    begin
      l_Flash.GetDataPointer;
      Logger.Info('У документа есть флэш размером %d байт', [l_Flash.GetDataSize]);
    end
    else
      Logger.Warning('Документ флэшовый, а данных нету');
  end;

  Logger.Info('Имитируем прогрузку оглавления документа через DTP');
  ReadContent();
  Logger.Info('Закончили имитировать прогрузку оглавления документа через DTP');

  Logger.Info('Имитируем прогрузку тела документа через DTP');
  ReadDocBody();
  //
  if f_ParaIDForJournal <> 0 then
  begin
    f_Document.CreateJournalBookmark(f_ParaIDForJournal, l_JournalBookmark);
    Assert(l_JournalBookmark <> nil, 'l_JournalBookmark <> nil');
    TatUserJournalHelper.AddBookmark(l_JournalBookmark);
  end;
  Logger.Info('Закончили имитировать прогрузку тела документа через DTP');
//#UC END# *4DD39FBB038F_4DD39F320114_impl*
end;//TatDocReader.Read

procedure TatDocReader.ReadFromPara(aParaID: TParaId);
//#UC START# *4DD3A06B0131_4DD39F320114_var*
//#UC END# *4DD3A06B0131_4DD39F320114_var*
begin
//#UC START# *4DD3A06B0131_4DD39F320114_impl*
  if aParaID = 0 then
    f_ParaIterator.Reset()
  else
    try
      f_ParaIterator.SetNextToPara(aParaId);
    except
      on ex : ECanNotFindData do
      begin
        Logger.Info('Пытались прочитать документ с параграфа %d но не нашли его, поэтому читаем с начала', [aParaID]);
        f_ParaIterator.Reset();
      end;
    end;
  //
  Read();
//#UC END# *4DD3A06B0131_4DD39F320114_impl*
end;//TatDocReader.ReadFromPara

procedure TatDocReader.ReadFromSub(aSubID: TSubId);
//#UC START# *4DD3A07E0288_4DD39F320114_var*
//#UC END# *4DD3A07E0288_4DD39F320114_var*
begin
//#UC START# *4DD3A07E0288_4DD39F320114_impl*
  if aSubID = 0 then
    f_ParaIterator.Reset()
  else
    try
      f_ParaIterator.SetNextToSub(aSubId);
    except
      on ex : ECanNotFindData do
      begin
        Logger.Info('Пытались прочитать документ с саба %d но не нашли его, поэтому читаем с начала', [aSubID]);
        f_ParaIterator.Reset();
      end;
    end;
  //  
  Read();
//#UC END# *4DD3A07E0288_4DD39F320114_impl*
end;//TatDocReader.ReadFromSub

procedure TatDocReader.ReadContent;
//#UC START# *4DD3A09701DE_4DD39F320114_var*
  var
    l_ContentsRoot : INodeBase;
    l_Bookmarks : IBookmarkList;
    l_CPL : ICommentsParaList;
    l_EODL : IExternalObjectDataList;
    l_EOD : TExternalObjectData;
    i : Integer;
    l_EP : TEntryPoint;
//#UC END# *4DD3A09701DE_4DD39F320114_var*
begin
//#UC START# *4DD3A09701DE_4DD39F320114_impl*
  l_ContentsRoot := nil;
  try
    f_Document.GetContentsRoot(l_ContentsRoot);
  except
    on ECanNotFindData do
      Logger.Info('У документа нет оглавления');
  end;
  //
  if (l_ContentsRoot <> nil) then
  begin
    if f_IsFullLoad then
      i := High(Word)
    else
      i := 2;
    TatNodeHelper.LoadNodes(l_ContentsRoot, i, High(Longword), TatNodeCallbacks.CallNodeCaption);
  end;


  // читаем закладки
  try
    f_Document.GetBookmarkList(l_Bookmarks);
  except
    // http://mdp.garant.ru/pages/viewpage.action?pageId=264897751&focusedCommentId=264900398#comment-264900398
    Logger.Warning('Странное исключение при GetBookmarkList');
  end;
  TatDocumentHelper.ReadChildBookmarks(f_DTP, l_Bookmarks);

  // читаем комментарии
  try
    f_Document.GetCommentsParaList(l_CPL);
  except
    // http://mdp.garant.ru/pages/viewpage.action?pageId=264897751&focusedCommentId=264900398#comment-264900398
    Logger.Warning('Странное исключение при GetCommentsParaList');
    l_CPL := nil;
  end;
  if (l_CPL <> nil) then
    for i := 0 to l_CPL.Count-1 do
      if TatDocumentHelper.FindPara(f_DTP, l_CPL.Items[i], l_EP) then
        TatDocumentHelper.ReadChildComment(f_DTP, l_EP);

  // читаем имена вложенных объектов
  try
    f_Document.GetExternalObjectDataList(l_EODL);
  except
    // http://mdp.garant.ru/pages/viewpage.action?pageId=264897751&focusedCommentId=264900398#comment-264900398
    Logger.Warning('Странное исключение при GetExternalObjectDataList');
    l_EODL := nil;
  end;
  if (l_EODL <> nil) then
    for i := 0 to l_EODL.Count-1 do
    begin
      l_EODL.pm_GetItem(i, l_EOD);
      l_EOD.rName.GetData();
    end;
//#UC END# *4DD3A09701DE_4DD39F320114_impl*
end;//TatDocReader.ReadContent

procedure TatDocReader.ReadDocBody;
//#UC START# *4DD3A5890061_4DD39F320114_var*
  var
    l_ParasCount : Integer;
    l_EP : TEntryPoint;
    l_LastParaID : TParaId;
//#UC END# *4DD3A5890061_4DD39F320114_var*
begin
//#UC START# *4DD3A5890061_4DD39F320114_impl*
  if f_IsFullLoad then
    l_ParasCount := High(l_ParasCount)
  else
    l_ParasCount := 30;
  //
  f_ParaIDForJournal := 0;
  f_ParaIterator.IsParaMustHaveNonZeroID := false;
  while f_ParaIterator.HasNext() AND (l_ParasCount > 0) do
  begin
    l_EP := f_ParaIterator.GetNext();
    TatDocumentHelper.ReadPara(f_DTP, l_EP);
    l_LastParaID := f_DTP.GetChildExternalId(l_EP);
    if l_LastParaID <> 0 then f_ParaIDForJournal := l_LastParaID;
    Dec(l_ParasCount);
  end;
//#UC END# *4DD3A5890061_4DD39F320114_impl*
end;//TatDocReader.ReadDocBody

destructor TatDocReader.Destroy;
//#UC START# *48077504027E_4DD39F320114_var*
//#UC END# *48077504027E_4DD39F320114_var*
begin
//#UC START# *48077504027E_4DD39F320114_impl*
  FreeAndNil(f_ParaIterator);
  inherited;
//#UC END# *48077504027E_4DD39F320114_impl*
end;//TatDocReader.Destroy

{$Include w:\quality\test\garant6x\AdapterTest\AdapterHelpers\atEntityWithName.imp.pas}

function TatBookmark.pm_GetDocument: IDocument;
//#UC START# *4FD0E49203B9_4FD0E3FA03BEget_var*
//#UC END# *4FD0E49203B9_4FD0E3FA03BEget_var*
begin
//#UC START# *4FD0E49203B9_4FD0E3FA03BEget_impl*
  f_Entity.GetDocument(Result);
//#UC END# *4FD0E49203B9_4FD0E3FA03BEget_impl*
end;//TatBookmark.pm_GetDocument

function TatBookmark.pm_GetPara: TParaId;
//#UC START# *4FD0E4FE026D_4FD0E3FA03BEget_var*
//#UC END# *4FD0E4FE026D_4FD0E3FA03BEget_var*
begin
//#UC START# *4FD0E4FE026D_4FD0E3FA03BEget_impl*
  Result := f_Entity.GetParagraph;
//#UC END# *4FD0E4FE026D_4FD0E3FA03BEget_impl*
end;//TatBookmark.pm_GetPara

function TatBookmark.pm_GetComment: AnsiString;
//#UC START# *4FD0E5450255_4FD0E3FA03BEget_var*
  var
    l_Str : IString;
//#UC END# *4FD0E5450255_4FD0E3FA03BEget_var*
begin
//#UC START# *4FD0E5450255_4FD0E3FA03BEget_impl*
  f_Entity.GetComment(l_Str);
  if l_Str <> nil then
    Result := l_Str.GetData;
//#UC END# *4FD0E5450255_4FD0E3FA03BEget_impl*
end;//TatBookmark.pm_GetComment

class function TatDocumentHelper.GetParaIDArray(const aDTP: IDocumentTextProvider;
 const aMaxParaCount: Integer;
 const isRandomParas: Boolean): TParaIDArr;
//#UC START# *4815C85E0300_4815C75902A2_var*
  var
    l_EPArr : TEntryPointArr;
    i : Integer;
//#UC END# *4815C85E0300_4815C75902A2_var*
begin
//#UC START# *4815C85E0300_4815C75902A2_impl*
  l_EPArr := GetParaEPArray(aDTP, aMaxParaCount, isRandomParas);
  if (l_EPArr <> nil) then
  begin
    SetLength(Result, Length(l_EPArr));
    for i := 0 to High(Result) do
      Result[i] := aDTP.GetChildExternalId(l_EPArr[i]);
  end    
  else
    Result := nil;
//#UC END# *4815C85E0300_4815C75902A2_impl*
end;//TatDocumentHelper.GetParaIDArray

class function TatDocumentHelper.IsParaType(aType: Word): Boolean;
//#UC START# *4CB869C3010F_4815C75902A2_var*
//#UC END# *4CB869C3010F_4815C75902A2_var*
begin
//#UC START# *4CB869C3010F_4815C75902A2_impl*
  Result := (aType <> k2_idEmpty) AND k2.TypeTable.TypeByHandle[aType].IsKindOf(k2_typLeafPara);
//#UC END# *4CB869C3010F_4815C75902A2_impl*
end;//TatDocumentHelper.IsParaType

class function TatDocumentHelper.GetParaEPArray(const aDTP: IDocumentTextProvider;
 const aMaxParaCount: Integer;
 const isRandomParas: Boolean): TEntryPointArr;
//#UC START# *4CFF5AE60132_4815C75902A2_var*
  var
    l_DTPIter : TatDTPParaIterator;
    i, l_NewPos : Integer;
    l_Tmp : TEntryPoint;
//#UC END# *4CFF5AE60132_4815C75902A2_var*
begin
//#UC START# *4CFF5AE60132_4815C75902A2_impl*
  l_DTPIter := TatDTPParaIterator.Create(aDTP);
  l_DTPIter.IsParaMustHaveNonZeroID := true;
  try
    i := 0;
    // заполняем массив точками входа для параграфов
    // если нужны случайные параграфы, то вычитываем все, чтобы потом выбрать случайные
    while l_DTPIter.HasNext do
    begin
      if (i > High(Result)) then
        SetLength(Result, Length(Result) + 500);

      Result[i] := l_DTPIter.GetNext;
      Inc(i);

      if (NOT isRandomParas) AND (i = aMaxParaCount) then
        break;
    end;
    //
    SetLength(Result, i);
  finally
    FreeAndNil(l_DTPIter);
  end;

  // если нужны случайные и получено больше чем надо, то выбираем случайные
  if (Result <> nil) AND isRandomParas AND (Length(Result) > aMaxParaCount) then
  begin
    for i := 0 to aMaxParaCount-1 do
    begin
      l_NewPos := RandomRange(i, High(Result));
      l_Tmp := Result[i];
      Result[i] := Result[l_NewPos];
      Result[l_NewPos] := l_Tmp;
    end;
    SetLength(Result, aMaxParaCount);
  end;
//#UC END# *4CFF5AE60132_4815C75902A2_impl*
end;//TatDocumentHelper.GetParaEPArray

class procedure TatDocumentHelper.ReadPara(const aDTP: IDocumentTextProvider;
 const aParaEP: TEntryPoint);
//#UC START# *4D07884A01F1_4815C75902A2_var*
  var
    l_Stream : IStream;
    l_Bookmarks : IBookmarkList;
    i : Integer;
    l_EO : IExternalObject;
    l_Ptr : PChar;
    l_Char : Char;
//#UC END# *4D07884A01F1_4815C75902A2_var*
begin
//#UC START# *4D07884A01F1_4815C75902A2_impl*
  ReadParaText(aDTP, aParaEP);

  // читаем комментарий
  ReadChildComment(aDTP, aParaEP);

  // читаем закладки
  try
    aDTP.GetChildBookmarks(aParaEP, l_Bookmarks);
  except
    on EEmptyResult do ;
  end;
  ReadChildBookmarks(aDTP, l_Bookmarks);

  // читаем картинку
  if k2.TypeTable.TypeByHandle[Ord(aDTP.GetChildType(aParaEP))].IsKindOf(k2_typBitmapPara) then
  begin
    TatGblAdapterWorker.Instance.Common.GetPicture(aDTP.GetChildExternalId(aParaEP), l_EO);
    // проверяем что действительно читается
    l_Ptr := PChar(l_EO.GetDataPointer);
    for i := 0 to l_EO.GetDataSize()-1 do
    begin
      l_Char := l_Ptr^;
      Inc(l_Ptr);
    end;
  end;
//#UC END# *4D07884A01F1_4815C75902A2_impl*
end;//TatDocumentHelper.ReadPara

class function TatDocumentHelper.FindPara(const aDTP: IDocumentTextProvider;
 const aParaID: TParaId;
 out theEP: TEntryPoint): Boolean;
//#UC START# *4D07A129017B_4815C75902A2_var*
  var
    l_NIP : INodeIndexPath;
    i : Integer;
//#UC END# *4D07A129017B_4815C75902A2_var*
begin
//#UC START# *4D07A129017B_4815C75902A2_impl*
  Result := false;
  //
  try
    aDTP.FindPara(aParaID, l_NIP);
  except
    on ECanNotFindData do ;
  end;
  //
  if l_NIP <> nil then
  begin
    theEP := GetEPByNIP(aDTP, l_NIP);
    Result := true;
  end;
//#UC END# *4D07A129017B_4815C75902A2_impl*
end;//TatDocumentHelper.FindPara

class procedure TatDocumentHelper.ReadChildBookmarks(const aDTP: IDocumentTextProvider;
 const aBookmarkList: IBookmarkList);
//#UC START# *4D6E71B102CA_4815C75902A2_var*
  var
    l_Bookmark : TBookmark2;
    i : Integer;
//#UC END# *4D6E71B102CA_4815C75902A2_var*
begin
//#UC START# *4D6E71B102CA_4815C75902A2_impl*
  if (aBookmarkList <> nil) then
    for i := 0 to aBookmarkList.Count-1 do
    begin
      aBookmarkList.pm_GetItem(i, l_Bookmark);
      l_Bookmark.rName.GetData();
    end;
//#UC END# *4D6E71B102CA_4815C75902A2_impl*
end;//TatDocumentHelper.ReadChildBookmarks

class procedure TatDocumentHelper.ReadChildComment(const aDTP: IDocumentTextProvider;
 const anEP: TEntryPoint);
//#UC START# *4D6E741503AA_4815C75902A2_var*
  var
    l_EVDStream : IEVDStream;
//#UC END# *4D6E741503AA_4815C75902A2_var*
begin
//#UC START# *4D6E741503AA_4815C75902A2_impl*
  aDTP.GetChildComment(anEP, l_EVDStream);
  if (l_EVDStream <> nil) then
    ReadStream(l_EVDStream);
//#UC END# *4D6E741503AA_4815C75902A2_impl*
end;//TatDocumentHelper.ReadChildComment

class function TatDocumentHelper.GetEPByNIP(const aDTP: IDocumentTextProvider;
 const aNIP: INodeIndexPath): TEntryPoint;
//#UC START# *5046225B0281_4815C75902A2_var*
  var
    i : Integer;
//#UC END# *5046225B0281_4815C75902A2_var*
begin
//#UC START# *5046225B0281_4815C75902A2_impl*
  Result.rLayer := ROOT_LAYER;
  Result.rChild := ROOT_CHILD;
  //
  for i := 0 to aNIP.Count-1 do
  begin
    Result.rLayer := aDTP.GetChildLayerId(Result);
    Result.rChild := aNIP.Items[i];
  end;
//#UC END# *5046225B0281_4815C75902A2_impl*
end;//TatDocumentHelper.GetEPByNIP

class function TatDocumentHelper.ReadParaText(const aDTP: IDocumentTextProvider;
 const anEP: TEntryPoint): AnsiString;
//#UC START# *50462535009C_4815C75902A2_var*
  var
    l_ChildText : IString;
    l_EVDStream : IEVDStream;
//#UC END# *50462535009C_4815C75902A2_var*
begin
//#UC START# *50462535009C_4815C75902A2_impl*
  Result := '';
  //
  aDTP.GetChildText(anEP, l_ChildText);
  if (l_ChildText <> nil) then
    Result := TatStringHelper.AStr2DStr(l_ChildText);
  //
  aDTP.GetChildEvdStyle(anEP, l_EVDStream);
  if (l_EVDStream <> nil) then
    ReadStream(l_EVDStream);
//#UC END# *50462535009C_4815C75902A2_impl*
end;//TatDocumentHelper.ReadParaText

end.
