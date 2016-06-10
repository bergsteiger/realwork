unit DocAttrImpl;

{ $Id: DocAttrImpl.pas,v 1.86 2016/04/22 10:59:49 lukyanets Exp $ }

{$I l3Define.inc}
{$R-}
interface

uses
  Windows, Classes, SysUtils, Graphics,
  l3Interfaces,
  l3Types, l3InternalInterfaces, l3Date, l3Base, l3Tree, l3DatLst, l3Except,
  l3IID,
  m3DBInterfaces,
  k2Reader, k2TagGen, k2Types, k2Base,
  evInternalInterfaces,
  evTextSource,
  evEvdRd, evdWriter, evTxtrd, evEditorWindow, evTypes, evIntf,
  //mgCHDSel,
  {GMP_Slct,}
  ddPictConvertor, ddRTFwriter, ddDocumentCopy,
  dt_AttrSchema, DictsSup, DocAttrUtils,
  DT_Const, DT_Types, DT_Lock, DT_Dict, DT_Link, DT_LinkServ, DT_Doc, DT_Hyper,
  Dt_Active, DT_Alarm, DT_Log, DT_Stage,
  DocIntf,
  DocAttrIntf, DocAttrToolsIntf;

(*
TCustomDocAttribute
    +-TListDocAttribute
        |-TDocIDsAttribute
        |-TVerLinkAttribute
        +-TGroupDocAttribute
        |    |-TDateNumDocAttribute
        |    |-TActiveIntervalListDocAttribute
        |    |-TAlarmDocAttribute
        |    |-TPublishedDocAttribute
        |    |-TStagesDocAttribute
        |    +-TCorrectsAttribute
        +-TDictDocAttribute
        |
        |-TPaperWhereDocAttribute
        |-TLogAttribute
        |    |-TJurOperationAttribute
        |    +-TOrdOperationAttribute
        +-TListOfDocAttribute
        |    +-TVersionListAttribute

*)
 type
  TCustomDocAttribute = class(Tl3Base, IDocAttribute)
   private
    fAttrManager : TDocAttributeManager;
    fAttrID  : TdtAttribute;

    fInLoad : Boolean;

    function Get_AttrID : TdtAttribute;

    procedure   LoadPrim; virtual;

    //procedure CheckTypeCompliance(aAttrType : TAttrType);
   public
    constructor Create(aAttrManager : TDocAttributeManager; aAttrID : TdtAttribute); overload; virtual;
    constructor Create(aAttrManager : TDocAttributeManager); overload; virtual;
        {-}
    function    COMQueryInterface(const IID: Tl3GUID; out Obj): Tl3HResult; override;
    function    IsEmpty : Boolean; virtual; abstract;
    procedure   Delete(aIndex : Integer = 0); virtual; abstract;
    procedure   DeleteByHandle(aHandle : Integer); virtual; abstract;
    procedure   DeletePersistent(aHandle : Integer = 0); virtual; abstract;
    procedure   DeleteAll; virtual; abstract;

    function    Get_Modified : Boolean; virtual; abstract;
    procedure   Set_Modified(aValue : Boolean); virtual; abstract;

    procedure   Copy(aSrcAttr : IDocAttribute); virtual;
    procedure   Load;
    function    Save : boolean; virtual; abstract;

    function    GetViewString(aIndex : Integer = 0) : AnsiString; virtual; abstract;

    property AttrID : TdtAttribute read Get_AttrID;
    property Modified : Boolean read Get_Modified write Set_Modified;
  end;

  TListDocAttribute = class(TCustomDocAttribute, IListDocAttribute, Il3ItemNotifyRecipient, Il3ChangeRecipient)
   private
    fList     : Tl3CustomDataList;
    fNameList : Tl3StringDataList;
    fInNotify : Boolean;

    procedure Notify(const aNotifier : Il3ChangeNotifier; aOperation : Integer; aIndex : Integer); virtual;
    procedure Changing;
    procedure Changed;
    function  Add(aValue : Pointer) : Integer;                   virtual;

    function  Get_ViewString(aIndex: Longint) : Tl3PCharLen;     virtual;
    procedure Set_ViewString(aIndex: Longint; aValue : Tl3PCharLen); virtual;

    function  Get_DataSize : Cardinal;                           virtual;
    function  Get_Data(aIndex: Longint) : Pointer;               virtual;
    procedure Set_Data(aIndex: Longint; Value : Pointer);        virtual;

    function  Get_Handle(aIndex : Integer) : Integer;            virtual;

    function  Get_Modified : Boolean;                            override;
    procedure Set_Modified(aValue : Boolean);                    override;

    function  Get_Count : Integer;

    function  Get_List : Tl3CustomDataList;                      virtual;
    function  Get_NameList : Tl3StringDataList;                  virtual;

    function  GetIndexByHandle(aHandle : Integer) : Integer;     virtual;

    function EditData(aHandle : Integer; aValue : Pointer) : Boolean; virtual; abstract;
    function EditItem(aIndex : Integer) : Boolean;            virtual; abstract;
    {* - Вызывает форму редактирования элемента списка. Если aIndex = -1, то добавляется новый элемент}

   protected
    property  List : Tl3CustomDataList read Get_List;
    property  NameList : Tl3StringDataList read Get_NameList;

    procedure Cleanup; override;

   public
        {-}
    function  COMQueryInterface(const IID: Tl3GUID; out Obj): Tl3HResult; override;
    function  IsEmpty : Boolean;                             override;
    procedure Delete(aIndex : Integer = 0);                  override;
    procedure DeleteByHandle(aHandle : Integer);             override;
    procedure DeletePersistent(aHandle : Integer = 0);       override;
    procedure DeleteAll;                                     override;

    function  GetViewString(aIndex : Integer = 0) : AnsiString;  override;
    function  GetViewStringOfData(aData : Pointer) : AnsiString; virtual;
    procedure DataWasChanged(aIndex: Longint);
     {* - вызывается после модификации данных в записи Data[] для коррекции строки отображения и выставления флага модификации}
    procedure RegenerateString(aIndex: Longint);
     {* - вызывается после модификации данных в записи Data[] для коррекции строки отображения}


    property  DataSize : Cardinal read Get_DataSize;

    property  Data[aIndex: Longint] : Pointer
     read Get_Data
     write Set_Data;

    property  Handle[aIndex: Longint] : Integer
     read Get_Handle;

    property  Count : Integer read Get_Count;
  end;

  TGroupDocAttribute = class(TListDocAttribute)
   private
    function  Add(aValue : Pointer) : Integer;               override;
    procedure ClearRecHandle(aValue : Pointer);              virtual; abstract;
  end;

  TDateNumDocAttribute = class(TGroupDocAttribute, IDateNumDocAttributeTool)
   private
    function  Get_List : Tl3CustomDataList;                  override;
    function  Get_Handle(aIndex: Longint) : Integer;         override;
    function  GetViewStringOfData(aData : Pointer) : AnsiString; override;
    procedure ClearRecHandle(aValue : Pointer);              override;
    function EditItem(aIndex : Integer): Boolean;            override;
    procedure LoadPrim;                                      override;
    function GetMinPublishDate: TStDate;
    function GetCasecode: Il3CString;
   public
    constructor Create(aAttrManager : TDocAttributeManager); override;
    function  Save : boolean;                                override;
  end;

  TActiveIntervalListDocAttribute = class(TGroupDocAttribute)
   private
    procedure Set_Data(aIndex: Longint; Value : Pointer);    override;
    function  Get_List: Tl3CustomDataList;                   override;
    function  Get_Handle(aIndex: Longint) : Integer;         override;
    function  GetViewStringOfData(aData : Pointer) : AnsiString; override;

    function InsertDiapason(const aItem : TActiveIntervalRec; aOldIndex: Integer = -1) : Integer;
    {* - вставляет aItem в список диапазонов дат c учетом сортировки}

    function EditItem(aIndex : Integer): Boolean;            override;
    procedure ClearRecHandle(aValue : Pointer);              override;
    procedure LoadPrim;                                      override;
   public
    constructor Create(aAttrManager : TDocAttributeManager); override;
    procedure DeletePersistent(aHandle : Integer = 0);       override;
    function  Save : boolean;                                override;
  end;

  TAlarmDocAttribute = class(TGroupDocAttribute)
   private
    function  Get_List : Tl3CustomDataList;                  override;
    function  Get_Handle(aIndex: Longint) : Integer;         override;
    function  GetViewStringOfData(aData : Pointer) : AnsiString; override;
    procedure ClearRecHandle(aValue : Pointer);              override;

    function EditItem(aIndex : Integer): Boolean;            override;
    procedure LoadPrim;                                      override;
   public
    constructor Create(aAttrManager : TDocAttributeManager); override;
    procedure DeletePersistent(aHandle : Integer = 0);       override;
    function  Save : boolean;                                override;
  end;

  TStagesDocAttribute = class(TGroupDocAttribute,IStageDocAttributeTool)
   private
    function  Add(aValue : Pointer) : Integer;               override;
    function  Get_List : Tl3CustomDataList;                  override;
    function  Get_Handle(aIndex: Longint) : Integer;         override;
    function  GetViewStringOfData(aData : Pointer) : AnsiString; override;
    procedure ClearRecHandle(aValue : Pointer);              override;

    function  EditData(aHandle : Integer;
                       aValue : Pointer) : Boolean;          override;
    function  EditItem(aIndex : Integer): Boolean;           override;
    procedure LoadPrim;                                      override;
   public
    constructor Create(aAttrManager : TDocAttributeManager); override;
   {tools}
    function CheckStageClosed(aStageType : TStageType): Boolean;
    procedure CloseStage(aStageType : TStageType);
    function DateOfStageClosed(aStageType : TStageType): TStDate;

    procedure DeletePersistent(aHandle : Integer = 0);       override;
    function  Save : boolean;                                override;
  end;

  TDocIDsAttribute = class(TListDocAttribute)
   private
    function  Get_List : Tl3CustomDataList;                  override;
    function  Get_Handle(aIndex: Longint) : Integer;         override;
    function  GetViewStringOfData(aData : Pointer) : AnsiString; override;
    procedure LoadPrim;                                      override;

   public
    constructor Create(aAttrManager : TDocAttributeManager); override;
    procedure DeletePersistent(aHandle : Integer = 0);       override;
    function  Save : boolean;                                override;
  end;

  TVerLinkAttribute = class(TListDocAttribute, IIntegerDocAttribute)
   private
    function  Get_List : Tl3CustomDataList;                  override;
    function  Get_NameList : Tl3StringDataList;              override;
    function  Get_Handle(aIndex: Longint) : Integer;         override;
    function  GetViewStringOfData(aData : Pointer) : AnsiString; override;
    function  Add(aValue : Pointer) : Integer;               override;

    procedure Set_Value(aValue : Integer);
    function  Get_Value : Integer;

    procedure LoadPrim;                                      override;
    procedure Set_Modified(aValue : Boolean);                override;
    function  Get_Modified: Boolean;                         override;
   public
    constructor Create(aAttrManager : TDocAttributeManager); override;
    function  EditItem(aIndex : Integer): Boolean;           override;
    procedure DeletePersistent(aHandle : Integer = 0);       override;
    function  Save : boolean;                                override;
  end;

  TLogAttribute = class(TListDocAttribute, ILogDocAttributeTool)
   private
    fLogType : TLogActionFlags;
    function  Get_List : Tl3CustomDataList;                  override;
    function  Get_Handle(aIndex: Longint) : Integer;         override;
    function  GetViewStringOfData(aData : Pointer) : AnsiString; override;

    procedure LoadPrim;                                      override;

    {tools}
    procedure AddAction(aAction : TLogActionType; aDate : TstDate = 0);
    procedure DelAction(aAction : TLogActionType);
    function  HasDocThisLogRec(aAction : TLogActionType; aDate : TStDate = 0 {Any Date}): boolean;
    procedure AddLogRecOnce(aAction : TLogActionType; aCheckDate : TStDate = 0 {Any Date}; aAddDate : TStDate = 0 {Today});
    function Get_Modified: Boolean; override;

   public
    function  EditItem(aIndex : Integer): Boolean;           override;
    procedure DeletePersistent(aHandle : Integer = 0);       override;
    function  Save : boolean;                                override;
  end;

  TJurOperationAttribute = class(TLogAttribute)
  public
   constructor Create(aAttrManager : TDocAttributeManager); override;
  end;

  TOrdOperationAttribute = class(TLogAttribute)
  public
   constructor Create(aAttrManager : TDocAttributeManager); override;
  end;

  TDictDocAttribute = class(TListDocAttribute)
   private
    fSingleValue : boolean; // 0 или 1 элемент в списке
    function  Get_List : Tl3CustomDataList;                  override;
    function  Get_NameList : Tl3StringDataList;              override;
    function  Get_Handle(aIndex: Longint) : Integer;         override;
    function  GetViewString(aIndex : Integer = 0) : AnsiString;  override;
    function  Add(aValue : Pointer) : Integer;               override;

    procedure LoadPrim;                                      override;
   public
    constructor Create(aAttrManager : TDocAttributeManager; aAttrID : TdtAttribute; aSingleValue : boolean = false); overload;
    procedure Copy(aSrcAttr : IDocAttribute);                override;
    procedure DeletePersistent(aHandle : Integer = 0);       override;
    procedure DeleteAll;                                     override;
    function  EditItem(aIndex : Integer): Boolean;           override;
    function  Save : boolean;                                override;
  end;

  TPublishedDocAttribute = class(TGroupDocAttribute)
   private
    procedure ClearRecHandle(aValue : Pointer);              override;
    procedure Set_Data(aIndex: Longint; Value : Pointer);    override;
    function  Get_List: Tl3CustomDataList;                   override;
    function  Get_Handle(aIndex: Longint) : Integer;         override;
    function  GetViewStringOfData(aData : Pointer) : AnsiString; override;

    function EditItem(aIndex : Integer): Boolean;            override;
    procedure LoadPrim;                                      override;
   public
    constructor Create(aAttrManager : TDocAttributeManager); override;
    procedure DeletePersistent(aHandle : Integer = 0);       override;
    function  Save : boolean;                                override;
  end;

  TCorrectsAttribute = class(TGroupDocAttribute)
   private
    fPublishedsNotifier : Il3ChangeNotifier;

    procedure ClearRecHandle(aValue : Pointer);               override;
    procedure Set_Data(aIndex: Longint; Value : Pointer);     override;
    function  Get_List: Tl3CustomDataList;                    override;
    function  Get_Handle(aIndex: Longint) : Integer;          override;
    function  GetViewStringOfData(aData : Pointer) : AnsiString;  override;

    function EditItem(aIndex : Integer): Boolean;             override;
    procedure LoadPrim;                                       override;

    procedure Notify(const aNotifier : Il3ChangeNotifier;
                     aOperation : Integer; aIndex : Integer); override;
   protected
    procedure Cleanup;                                        override;
   public
    constructor Create(aAttrManager : TDocAttributeManager);  override;
    procedure DeletePersistent(aHandle : Integer = 0);        override;
    function  Save : boolean;                                 override;
  end;

 (*
 type
  PPaperWhereRec = ^TPaperWhereRec;
  TPaperWhereRec = record
   rPaperUser       : TDictID;
   rPaperPlace      : AnsiString;
  end;

 const
  cEmptyPaperWhereRec : TPaperWhereRec = (rPaperUser : 0;
                                          rPaperPlace : '');
 type
  TPaperWhereDocAttribute = class(TListDocAttribute)
   private
    fPaperWhere : TPaperWhereRec;
    // эту херь нельзя делать локальной, потому что строка,
    // которая входит в состав записи уничтожается после выхода из процедуры,
    // а запись мы в лист добавляем
    function  Get_List : Tl3CustomDataList;                  override;
    function  Get_NameList : Tl3StringDataList;              override;
    function  Get_Handle(aIndex: Longint) : Integer;         override;
    function  GetViewStringOfData(aData : Pointer) : AnsiString; override;
    function  Add(aValue : Pointer) : Integer;               override;

    //procedure Set_Value(aValue : TPaperWhereRec);
    function  Get_Value : TPaperWhereRec;

    procedure LoadPrim;                                      override;
   public
    constructor Create(aAttrManager : TDocAttributeManager); override;
    function  EditItem(aIndex : Integer): Boolean;           override;
    //function  IsEmpty : Boolean;                             override;

    //procedure DeletePersistent(aHandle : Integer = 0);       override;
    function  Save : boolean;                                override;
  end;
  *)
  TListOfDocAttribute = class(TListDocAttribute)
  private
   function Get_List: Tl3CustomDataList; override;
   function Get_NameList: Tl3StringDataList; override;
  public
   function Save: boolean; override;
  end;

  TVersionListAttribute = class(TListOfDocAttribute)
  private
   function GetViewStringOfData(aData : Pointer): AnsiString; override;
   function Get_Data(aIndex: Longint): Pointer; override;
   procedure LoadPrim; override;
  end;

  TDoc2DocAttribute = class(TListDocAttribute)
  private
   function Get_List: Tl3CustomDataList; override;
   function GetViewStringOfData(aData : Pointer): AnsiString; override;
   procedure LoadPrim; override;
  public
   constructor Create(aAttrManager : TDocAttributeManager); override;
   function EditItem(aIndex : Integer): Boolean; override;
   function Save: Boolean; override;
  end;

type
 EAttrWriteError = class(El3NoLoggedException)
 public
  constructor Create(aAttrID : TdtAttribute; const aReasonMsg : AnsiString); overload;
 end;

 EDiapasonIntersect = class(El3NoLoggedException)
 end;



implementation

uses
  ActiveX,
  Forms, Printers, Dialogs, vtDialogs,
  StrShop, IniShop, VConst, Com_Cnst,
  daDataProvider,
  Dt_CFltr, Dt_RecalcHLinkFilter, DT_User,
  //mgBasStr, mgExFStr, mgLnkStr,
  //mgHasPar,
  //m2COMLib,
  m3StorageInterfaces,
  Readers,
  k2Tags,
  ddDocReader, ddNSRC_r,
  l3Bits,
  l3Chars,
  l3Filer,
  l3BaseStream,
  l3Stream,
  l3String,
  l3BitmapContainer,
  l3InterfacesMisc,
  l3Tree_TLB, l3TreeInterfaces,
  l3TreeSupport,
  l3Languages,

  daDataProvider,
  daTypes,

  DT_TblCacheDef,
  DT_TblCache,
  DT_Sab,

  evStatisticsFilter,
  evConst,
  evTextFormatter,
  evDocumentPreview,
  DictMetaForm, TreeDWin, D_AttrActiveInterval, D_IntEdit, d_GetJurOp, D_PublIn,
  D_SrcChk, D_PaperWhere, D_AttrAlarm, D_DateNumberEditor, D_Doc2DocLinkEdit,
  {DocAttrStructs,} StDateSt,
  imageenio,
  m3DB
  , dt_DictTypes, dt_DictConst;

const
 cDoc2DocLinkViewStr: array[dltChanged..dltStaled] of AnsiString =
  ('Документ %d изменен',
   'Документ %d утратил силу');

constructor EAttrWriteError.Create(aAttrID : TdtAttribute; const aReasonMsg : AnsiString);
begin
 CreateFmt('Не удалось записать атрибут "%s"'^M'по причине : %s', [GetAttrName(aAttrID), aReasonMsg]);
end;

{TCustomDocAttribute}

constructor TCustomDocAttribute.Create(aAttrManager : TDocAttributeManager; aAttrID : TdtAttribute);
begin
 Create(aAttrManager);
 fAttrID := aAttrID;
end;

constructor TCustomDocAttribute.Create(aAttrManager : TDocAttributeManager);
begin
 inherited Create;
 fAttrManager := aAttrManager;
end;

function TCustomDocAttribute.COMQueryInterface(const IID: Tl3GUID; out Obj): Tl3HResult;
begin
 if IID.SomeOf([IDocAttributeManager]) then
  Result := Tl3HResult_C(l3QueryInterface(fAttrManager, IID, Obj))
 else
  Result := inherited COMQueryInterface(IID, Obj);
end;

function TCustomDocAttribute.Get_AttrID : TdtAttribute;
begin
 Result := fAttrID;
end;

procedure TCustomDocAttribute.Copy(aSrcAttr : IDocAttribute);
begin
 Assert(False, Format('Copy not Defined AttrID = %d', [Ord(fAttrID)]));
end;

procedure TCustomDocAttribute.LoadPrim;
begin
 Assert(False, Format('Load not Defined AttrID = %d', [Ord(fAttrID)]));
end;

procedure TCustomDocAttribute.Load;
begin
 if fInLoad then Exit;
 try
  fInLoad := True;
  LoadPrim;
 finally
  fInLoad := False;
 end;
end;

{TActiveIntervalListDocAttribute}
constructor TActiveIntervalListDocAttribute.Create(aAttrManager : TDocAttributeManager);
begin
 inherited Create(aAttrManager);
 fAttrID := atActiveIntervals;
end;

function  TActiveIntervalListDocAttribute.Get_List : Tl3CustomDataList;
begin
 if fList = nil then
 begin
  fList := Tl3DataList.CreateSize(SizeOf(TActiveIntervalRec));

  if (fAttrManager.Document <> nil) and (fAttrManager.Document.DocID > 0) then
  begin
   fList.LockModified := True;
   try
    LinkServer(fAttrManager.DocFamily).ActiveIntervals.GetDocActiveIntervalsList(fAttrManager.Document.DocID, fList);
   finally
    fList.LockModified := False;
   end;
  end;
 end;
 Result := fList;
end;

procedure TActiveIntervalListDocAttribute.Set_Data(aIndex: Longint; Value : Pointer);
begin
 with NameList do
  Data[aIndex] := Value;
end;

function TActiveIntervalListDocAttribute.EditItem(aIndex : Integer): Boolean;
var
 lActIntRec  : TActiveIntervalRec;
 lIsInserted : Boolean;
 lRecEmpty   : Boolean;
begin
 Result := False;
 lRecEmpty := aIndex < 0;
 with NameList do
  if aIndex >= 0 then
   lActIntRec := PActiveIntervalRec(Data[aIndex])^;
  repeat
   Result := GetAttrActiveInterval(lActIntRec, lRecEmpty);
   if Result then
   begin
    try
     lIsInserted := True;
     aIndex := InsertDiapason(lActIntRec, aIndex);
     Result := aIndex >= 0;
    except
     on E : EDiapasonIntersect do
     begin
      Application.ShowException(E);
      lIsInserted := False;
      lRecEmpty := False;
     end;
    end;
   end;
  until lIsInserted or not Result;
end;

function TActiveIntervalListDocAttribute.InsertDiapason(const aItem : TActiveIntervalRec; aOldIndex: Integer = -1) : Integer;

 function CheckIntersect : Boolean;
 var
  I : Integer;
 begin
  Result := False;
  if aItem.Typ = 1 then Exit;

  with NameList do
   for I := 0 to Pred(Count) do
    if (I <> aOldIndex) and
       (PActiveIntervalRec(Data[I])^.Typ = 0) and
       IsDateBoundsIntersected(MakeDateBounds(aItem.Start,aItem.Finish),
                               MakeDateBounds(PActiveIntervalRec(Data[I])^.Start,
                                              PActiveIntervalRec(Data[I])^.Finish)) then
    begin
     Result := True;
     Break;
    end;
 end;

begin
 Result := 0;
 if CheckIntersect then
  raise EDiapasonIntersect.Create('Пересечение диапазонов дат.');
 with NameList do
  begin
   while Result < Count do
    if (Result = aOldIndex) then Inc(Result)
    else
     if (aItem.Start > PActiveIntervalRec(Data[Result])^.Start) then Inc(Result)
     else
      Break;

   if (aOldIndex >= 0) and (Result > aOldIndex) then Dec(Result);

   if (Result = aOldIndex) then
   begin
    Self.Data[Result] := @aItem;
    //Strings[Result] := PAnsiChar(GenActiveIntervalString(PActiveIntervalRec(Data[Result])^));
   end
   else
   begin
    if (aOldIndex >= 0) then Delete(aOldIndex);
    InsertData(Result, PAnsiChar(GenActiveIntervalString(aItem)), @aItem);
   end;
  end;
end;

procedure TActiveIntervalListDocAttribute.DeletePersistent(aHandle : Integer = 0);
begin
 if fAttrManager.Document <> nil then
  LinkServer(fAttrManager.DocFamily).ActiveIntervals.DelDocActiveInterval(fAttrManager.Document.DocID, Byte(aHandle));
end;

function  TActiveIntervalListDocAttribute.Get_Handle(aIndex: Longint) : Integer;
begin
 Result := PActiveIntervalRec(Data[aIndex])^.RecID;
end;

function  TActiveIntervalListDocAttribute.GetViewStringOfData(aData : Pointer) : AnsiString;
begin
 Result := GenActiveIntervalString(PActiveIntervalRec(aData)^);
end;

procedure TActiveIntervalListDocAttribute.LoadPrim;
begin
end;

function  TActiveIntervalListDocAttribute.Save : Boolean;
var
 lInd       : Integer;
 lFullAIRec : TActiveIntervalRec;
begin
 if fAttrManager.Document = nil then
 begin
  Result := False;
  Exit;
 end;

 Result := Modified;
 if Result then
 begin
  with List do
  begin
   if Count = 0 then
   begin
    lFullAIRec := MakeActiveIntervalRec(minActiveDate, maxActiveDate);
    LinkServer(fAttrManager.DocFamily).ActiveIntervals.AddDocActiveInterval(fAttrManager.Document.DocID, @lFullAIRec);
   end
   else
    for lInd := 0 to Pred(Count) do
     if l3TestMask(Flags[lInd], lfItemModified) then
      LinkServer(fAttrManager.DocFamily).ActiveIntervals.AddDocActiveInterval(fAttrManager.Document.DocID, PActiveIntervalRec(Data[lInd]))
  end;
  Modified := False;
 end;
end;

procedure TActiveIntervalListDocAttribute.ClearRecHandle(aValue : Pointer);
begin
 PActiveIntervalRec(aValue)^.RecID := 0;
end;

{TLogAttribute}
function  TLogAttribute.Get_List : Tl3CustomDataList;
begin
 if fList = nil then
 begin
  fList := Tl3DataList.CreateSize(SizeOf(TDisplayLogRec));
  //fList.Subscribe(Self as Il3ChangeRecipient);
  //fList.Subscribe(Self as Il3ItemNotifyRecipient);

  if (fAttrManager.Document <> nil) and (fAttrManager.Document.DocID <> 0) then
   Load;
 end;
 Result := fList;
end;

procedure TLogAttribute.LoadPrim;
begin
 if (fAttrManager.Document <> nil) and (fAttrManager.Document.DocID > 0) then
 with List do
 begin
  LockModified := True;
  try
   LinkServer(fAttrManager.DocFamily).LogBook.GetLogDataList(fAttrManager.Document.DocID, fLogType, Tl3DataList(fList));
  finally
   LockModified := False;
  end;
 end;
end;

function TLogAttribute.EditItem(aIndex : Integer): Boolean;
var
 lLogRec : TDisplayLogRec;
begin
 Result := False;
 with NameList do
  if aIndex >= 0 then
   lLogRec := PDisplayLogRec(Data[aIndex])^;

 Result := GetJurOperation(lLogRec, aIndex < 0);
 if Result then
  Add(@lLogRec);
end;

procedure TLogAttribute.DeletePersistent(aHandle : Integer = 0);
var
 lRec : PDisplayLogRec;
begin
 // - Когда будет Save открутить
 lRec := PDisplayLogRec(fList.Data[aHandle]);
 LinkServer(fAttrManager.DocFamily).LogBook.DelSingleLogRec(fAttrManager.Document.DocID,
                                                TLogActionType(lRec^.Action), lRec^.Date, lRec^.Time);
 //fList.Delete(aHandle);
end;

function  TLogAttribute.Get_Handle(aIndex: Longint) : Integer;
begin
 Result := aIndex;
end;

function  TLogAttribute.GetViewStringOfData(aData : Pointer) : AnsiString;
begin
 with PDisplayLogRec(aData)^ do
 begin
  Result := GetLogJrnlName(TLogActionType(Action));
  if Date <> BadDate then
   Result := Result + FormatDateTime(' dd.mm.yyyy', StDateToDateTime(DemonToStDate(Date)));
  //StTimeToTimeString('hh:mm' {ShortTimeFormat}, lDNRec^.Time, False)+#9+
  //GetLogJrnlName(lDNRec^.Action) + #9 + lDNRec^.Author;
 end;
end;

function  TLogAttribute.Save : Boolean;
begin
 Result := False;
 //Abort;
end;

function TLogAttribute.Get_Modified: Boolean;
begin
 {- когда будет Save открутить}
 Result := False;
end;

procedure TLogAttribute.AddAction(aAction : TLogActionType; aDate : TstDate = 0);
var
 lRec : TDisplayLogRec;
begin
 with lRec do
 begin
  Action := Ord(aAction);
  Date := aDate;
  if Date = 0 then
   Date := CurrentDate;

  Time := CurrentTime;
  Author := GlobalDataProvider.UserManager.GetUserName(GlobalDataProvider.ImpersonatedUserID);
 end;
 List.Add(@lRec);

 {- когда будет Save открутить}
 if fAttrManager.Document.DocID > 0 then
  LinkServer(fAttrManager.DocFamily).LogBook.PutDateLogRec(fAttrManager.Document.DocID,
                                                 TLogActionType(lRec.Action), lRec.Date, lRec.Time);

end;

procedure TLogAttribute.DelAction(aAction : TLogActionType);
var
 I : Integer;
 lRec : PDisplayLogRec;
begin
 I := Pred(List.Count);
 while I >=0 do
 begin
  lRec := PDisplayLogRec(Data[I]);

  if lRec^.Action = Ord(aAction) then
  begin
   {- когда будет Save открутить}
   if fAttrManager.Document.DocID > 0 then
    LinkServer(fAttrManager.DocFamily).LogBook.DelSingleLogRec(fAttrManager.Document.DocID,
                                                  TLogActionType(lRec^.Action), lRec^.Date, lRec^.Time);
   List.Delete(I);
  end;
  Dec(I);
 end;
end;

function TLogAttribute.HasDocThisLogRec(aAction : TLogActionType; aDate : TStDate = 0 {Any Date}): boolean;
var
 I : Integer;
begin
 Result := False;
 I := Pred(List.Count);
 while I >= 0 do
 begin
  with PDisplayLogRec(Data[I])^ do
   Result := (Action = Ord(aAction)) and ((aDate = 0) or (Date = aDate));
  if Result then Exit;
  Dec(I);
 end;
end;

procedure TLogAttribute.AddLogRecOnce(aAction : TLogActionType; aCheckDate : TStDate = 0 {Any Date}; aAddDate : TStDate = 0 {Today});
{* Если aCheckDate = 0, то проверяется наличие команды с любой датой,
   Если aAddDate = 0, то добавляется с текущей датой}
begin
 if not HasDocThisLogRec(aAction, aCheckDate) then
  AddAction(aAction, aAddDate);
end;

{TJurOperationAttribute}

constructor TJurOperationAttribute.Create(aAttrManager : TDocAttributeManager);
begin
 inherited Create(aAttrManager);
 fAttrID := atJurLogRecords;
 fLogType := acfJuror;
end;

{TOrdOperationAttribute}

constructor TOrdOperationAttribute.Create(aAttrManager : TDocAttributeManager);
begin
 inherited Create(aAttrManager);
 fAttrID := atOrdLogRecords;
 fLogType := acfOrdinal;
end;

{TAlarmDocAttribute}
constructor TAlarmDocAttribute.Create(aAttrManager : TDocAttributeManager);
begin
 inherited Create(aAttrManager);
 fAttrID := atAlarms;
end;

function  TAlarmDocAttribute.Get_List : Tl3CustomDataList;
begin
 if fList = nil then
 begin
  fList := Tl3DataList.CreateSize(SizeOf(TAlarmRec));

  if (fAttrManager.Document <> nil) and (fAttrManager.Document.DocID > 0) then
  begin
   fList.LockModified := True;
   try
    LinkServer(fAttrManager.DocFamily).Alarms.GetDocAlarmsList(fAttrManager.Document.DocID, fList);
    //fAttrManager.Document.DocData.GetDocAlarmsList(fList);
   finally
    fList.LockModified := False;
   end;
  end;
 end;
 Result := fList;
end;

procedure TAlarmDocAttribute.DeletePersistent(aHandle : Integer = 0);
begin
 if fAttrManager.Document <> nil then
 begin
  //fAttrManager.Document.DocServer.AlarmTbl.DocID := fAttrManager.Document.DocID;
  //fAttrManager.Document.DocServer.AlarmTbl.DelDocAlarm(Byte(aHandle));
  LinkServer(fAttrManager.DocFamily).Alarms.DelDocAlarm(fAttrManager.Document.DocID, Byte(aHandle));
 end;
end;

function  TAlarmDocAttribute.Get_Handle(aIndex: Longint) : Integer;
begin
 Result := PAlarmRec(Data[aIndex])^.RecID;
end;

function  TAlarmDocAttribute.GetViewStringOfData(aData : Pointer) : AnsiString;
begin
 Result := GenAlarmString(PAlarmRec(aData)^);
end;

procedure TAlarmDocAttribute.LoadPrim;
begin
end;

function  TAlarmDocAttribute.Save : Boolean;
var
 lInd : Integer;
begin
 if fAttrManager.Document = nil then
 begin
  Result := False;
  Exit;
 end;
 Result := Modified;
 if Result then
 begin
  //fAttrManager.Document.DocServer.AlarmTbl.DocID := fAttrManager.Document.DocID;
  with List do
   for lInd := 0 to Pred(Count) do
    if l3TestMask(Flags[lInd], lfItemModified) then
     LinkServer(fAttrManager.DocFamily).Alarms.AddDocAlarm(fAttrManager.Document.DocID, PAlarmRec(Data[lInd]));
  Modified := False;
 end;
end;

procedure TAlarmDocAttribute.ClearRecHandle(aValue : Pointer);
begin
 PAlarmRec(aValue)^.RecID := cUndefDictIDByte;
end;

function TAlarmDocAttribute.EditItem(aIndex : Integer): Boolean;
var
 lRec : TAlarmRec;
begin
 Result := False;
 if aIndex = -1 then // root
 begin
  lRec.RecID := cUndefDictIDByte;
  Result := GetAttrAlarm(lRec, True);
  if Result then Add(@lRec);
 end
 else
 begin
  Result := GetAttrAlarm(PAlarmRec(Data[aIndex])^, False);
  if Result then
   DataWasChanged(aIndex);
 end;
end;

{TListDocAttribute}

procedure TListDocAttribute.Cleanup;
begin
 Inherited;
 if fNameList <> nil then
 begin
  Il3ChangeNotifier(fNameList).Unsubscribe(Self as Il3ChangeRecipient);
  Il3ChangeNotifier(fNameList).Unsubscribe(Self as Il3ItemNotifyRecipient);
 end;
 l3Free(fNameList);
 l3Free(fList);
end;

function  TListDocAttribute.Get_List : Tl3CustomDataList;
begin
 Result := nil;
end;

function TListDocAttribute.Get_NameList : Tl3StringDataList;
var
 I : Integer;
begin
 if fNameList = nil then
 begin
  fNameList := Tl3StringDataList.Create;  
  with fNameList do
  begin
   DataSize := 0;
   NeedAllocStr := True;
   HostDataList := List;
   for I := 0 to Pred(Count) do
    Strings[I] := PAnsiChar(GetViewString(I));
   Modified := False;
   Il3ChangeNotifier(fNameList).Subscribe(Self as Il3ChangeRecipient);
   Il3ChangeNotifier(fNameList).Subscribe(Self as Il3ItemNotifyRecipient);
  end;
 end;
 Result := fNameList;
end;

procedure TListDocAttribute.Notify(const aNotifier : Il3ChangeNotifier; aOperation : Integer; aIndex : Integer);
begin
 if fInNotify then Exit;
 fInNotify := True;
 try
  if (fNameList <> nil) and
     ((aOperation = ntInsert) and (Length(NameList.Strings[aIndex]) = 0))
     or (aOperation = ntChangeItemData) then
   NameList.PasStr[aIndex] := GetViewString(aIndex);
 finally
  fInNotify := False;
 end;
end;

procedure TListDocAttribute.Changing;
begin
end;

procedure TListDocAttribute.Changed;
begin
 if Assigned(fAttrManager) and not fInLoad then
  fAttrManager.evntChangeDocAttribute(Self as IDocAttribute);
end;

function  TListDocAttribute.Get_ViewString(aIndex: Longint) : Tl3PCharLen;
begin
 Result := l3PCharLen(NameList.Strings[aIndex], -1, GlobalDataProvider.BaseLanguage[fAttrManager.DocFamily].AnsiCodePage);
// Result := fAttrManager.Document.TextSource.Document.Attr[]  l3PCharLen(NameList.Strings[aIndex], -1, GlobalDataProvider.BaseLanguage[fAttrManager.DocFamily].AnsiCodePage);
end;

procedure TListDocAttribute.Set_ViewString(aIndex: Longint; aValue : Tl3PCharLen);
begin
 // не реализовано
 raise Exception.Create('Set_ViewString не реализован');
end;

function  TListDocAttribute.Get_DataSize : Cardinal;
begin
 Result := List.DataSize;
end;

function  TListDocAttribute.Get_Data(aIndex: Longint) : Pointer;
begin
 Result := List.Data[aIndex];
end;

procedure TListDocAttribute.Set_Data(aIndex: Longint; Value : Pointer);
begin
 List.Data[aIndex] := Value;
end;

function TListDocAttribute.Add(aValue : Pointer) : Integer;
begin
 NameList.Changing;
 try
  if AttrID in GlSingleItemLinkAttrSet then
   NameList.Clear;
  Result := NameList.Add(PAnsiChar(GetViewStringOfData(aValue)), aValue);
 finally
  NameList.Changed;
 end;
end;

function TListDocAttribute.COMQueryInterface(const IID: Tl3GUID; out Obj): Tl3HResult;
begin
 if IID.SomeOf([Il3ChangeNotifier{, Il3ChangeRecipient, Il3ItemNotifyRecipient}]) then
  Result := Tl3HResult_C(l3QueryInterface(List, IID, Obj))
 else
  Result := inherited COMQueryInterface(IID, Obj);
end;

function  TListDocAttribute.Get_Handle(aIndex: Longint) : Integer;
begin
 Result := List.DataInt[aIndex];

 {If fAttrID in [atActiveIntervals,atAlarms] then
  Result := PByte(@Result)^;}
end;

function  TListDocAttribute.IsEmpty : Boolean;
begin
 Result := List.Count = 0;
end;

function  TListDocAttribute.GetViewString(aIndex : Integer = 0) : AnsiString;
begin
 if (aIndex < List.Count) then
  Result := GetViewStringOfData(Get_Data(aIndex))
 else
  Result := '';
end;

function  TListDocAttribute.GetViewStringOfData(aData : Pointer) : AnsiString;
begin
 Result := '';
end;

procedure TListDocAttribute.DataWasChanged(aIndex: Longint);
begin
 List.Flags[aIndex] := List.Flags[aIndex] or lfItemModified;
 RegenerateString(aIndex);
end;

procedure TListDocAttribute.RegenerateString(aIndex: Longint);
begin
 NameList.Strings[aIndex] := PAnsiChar(GetViewString(aIndex));
end;

function TListDocAttribute.Get_Modified : Boolean;
begin
 Result := List.Modified;
end;

procedure TListDocAttribute.Set_Modified(aValue : Boolean);
begin
 List.Modified := aValue;
end;

function  TListDocAttribute.Get_Count : Integer;
begin
 if List <> nil then
  Result := List.Count
 else
  Result := 0;
end;

function  TListDocAttribute.GetIndexByHandle(aHandle : Integer) : Integer;  
var
 I : Integer;
begin
 Result := -1;
 for I := 0 to Pred(List.Count) do
 if Handle[I] = aHandle then
 begin
  Result := I;
  Break;
 end;
end;

procedure TListDocAttribute.DeleteByHandle(aHandle : Integer);
var
 lIndex : Integer;
begin
 lIndex := GetIndexByHandle(aHandle);
 if lIndex >= 0 then
  Delete(lIndex);
end;

procedure TListDocAttribute.Delete(aIndex : Integer = 0);
begin
 DeletePersistent(Handle[aIndex]);
 List.Delete(aIndex);
 Modified := True;
end;

procedure TListDocAttribute.DeletePersistent(aHandle : Integer = 0);
begin
end;

procedure TListDocAttribute.DeleteAll;
begin
end;

{TGroupDocAttribute}
function TGroupDocAttribute.Add(aValue : Pointer) : Integer;
begin
 ClearRecHandle(aValue);
 Result := inherited Add(aValue);
end;

{TDateNumDocAttribute}

constructor TDateNumDocAttribute.Create(aAttrManager : TDocAttributeManager);
begin
 Inherited Create(aAttrManager);
 fAttrID := atDateNums;
end;

function  TDateNumDocAttribute.Get_List : Tl3CustomDataList;
begin
 if fList = nil then
 begin
  fList := Tl3DataList.CreateSize(SizeOf(TDNDictRec));

  if (fAttrManager.Document <> nil) and (fAttrManager.Document.DocID > 0) then
   Load;
 end;
 Result := fList;
end;

procedure TDateNumDocAttribute.LoadPrim;
var
 lSortOrder  : TSortRec;
begin
 if (fAttrManager.Document = nil) or (fAttrManager.Document.DocID <= 0) then Exit;
 lSortOrder.Fld[1]:=dnTypFld;
 lSortOrder.Fld[2]:=dnDateFld;
 lSortOrder.FldCount:=2;

 LinkServer(fAttrManager.DocFamily).GetDataList(da_dlDateNums, fAttrManager.Document.DocID, fList, lSortOrder);
 Modified := False;
end;

function  TDateNumDocAttribute.Get_Handle(aIndex: Longint) : Integer;
begin
 {!!}
 Result := PDNDictRec(Data[aIndex])^.ID;
end;

function  TDateNumDocAttribute.GetViewStringOfData(aData : Pointer) : AnsiString;
begin
 Result := GenDateNumString(PDNDictRec(aData)^);
end;

function TDateNumDocAttribute.GetMinPublishDate: TStDate;
var
 I : Integer;
begin
 Result := 0;
 for I := 0 to Pred(Count) do
  with PDNDictRec(Data[I])^ do
   if ((Result = 0) or (Result > Date)) and (Date > 0) and (Typ = dnPublish) then
    Result := Date;
end;

function  TDateNumDocAttribute.Save : Boolean;
var
 lInd : Integer;
begin
 if fAttrManager.Document = nil then
 begin
  Result := False;
  Exit;
 end;

 Result := Modified;
 if Result then
 begin
  fAttrManager.Document.DocData.SetAttrList(AttrID, List);
  Modified := false;
 end;
end;

procedure TDateNumDocAttribute.ClearRecHandle(aValue : Pointer);
begin
 PDNDictRec(aValue)^.ID := cUndefDictID;
end;

function TDateNumDocAttribute.EditItem(aIndex : Integer): Boolean;
var
 lRec : TDNDictRec; 
begin
 Result := False;

 if aIndex = -1 then // root
 begin
  lRec.ID := 0;
  Result := GetAttrDateNum(lRec, True);
  if Result then Add(@lRec);
 end
 else
 begin
  lRec := PDNDictRec(Data[aIndex])^;
  Result := GetAttrDateNum(lRec, False);
  if Result then
   Data[aIndex] := @lRec;
  //DataWasChanged(aIndex);
 end;
end;

function TDateNumDocAttribute.GetCasecode: Il3CString;
var
 I : Integer;
begin
 for I := 0 to Pred(Count) do
  with PDNDictRec(Data[I])^ do
   if (Typ = dnLawCaseNum) then
   begin
    Result := l3ArrayToCString(Num, cDNNumberLen);
    Break;
   end;
end;

{TDictDocAttribute}

constructor TDictDocAttribute.Create(aAttrManager : TDocAttributeManager; aAttrID : TdtAttribute; aSingleValue : boolean = false);
begin
 Inherited Create(aAttrManager, aAttrID);
 fSingleValue := aSingleValue;
end;

function TDictDocAttribute.Add(aValue : Pointer) : Integer;
begin
 NameList.Changing;
 try
  if NameList.IndexOfData(aValue, SizeOf(TDictID)) = -1 then
  begin
   if fSingleValue then
    NameList.Clear;
   Result := NameList.Add(PAnsiChar(DictServer(CurrentFamily).Dict[AttrID2DLType(fAttrID)].GetFullDictItemName(TDictID(aValue))), @aValue, SizeOf(TDictID));
  end;
 finally
  NameList.Changed;
 end;
end;

procedure TDictDocAttribute.Copy(aSrcAttr : IDocAttribute);
var
 I : integer;
 lHandle : Integer;
begin
 if aSrcAttr.AttrID <> fAttrID then Exit;

 for I := 0 to Pred((aSrcAttr as IListDocAttribute).Count) do
 begin
  lHandle := (aSrcAttr as IListDocAttribute).Handle[I];
  Add(Pointer(lHandle));
 end;
end;

procedure TDictDocAttribute.DeletePersistent(aHandle : Integer = 0);
begin
 Modified := True;
 //синхронизация с таблицами в момент сохранения
 //исключение Sub = cAllSubs (удаляем со всех сабов)
 if (fAttrManager.Document <> nil) and
    (fAttrManager.SubID = cAllSubs)  then
 begin
  LinkServer(fAttrManager.DocFamily).DelSubNode(fAttrID, fAttrManager.Document.DocID, fAttrManager.SubID, aHandle);
  fAttrManager.Document.SynchronizeDeleteFromAttrManagers(fAttrManager, AttrID, aHandle);
  Modified := False;
 end;
end;

procedure TDictDocAttribute.DeleteAll;
var
 lLinkTbl : TLinkTbl;
begin
 //синхронизация с таблицами в момент сохранения
 //исключение Sub = cAllSubs не работает

 if (fAttrManager.Document = nil) or
    (fAttrManager.SubID = cAllSubs) then
  Exit;

 if List.Count > 0 then
 begin
  List.Clear;
  Modified := True;
 end;

 (*
 //синхронизация с таблицами в момент сохранения
 //исключение Sub = cAllSubs (удаляем со всех сабов)
 if (fAttrManager.DocData <> nil) and
    (fAttrManager.SubID = cAllSubs)  then
 begin
  LinkServer.Family := fAttrManager.DocData.Family;
  lLinkTbl := LinkServer.Links[TdaDictionaryType(fAttrID)];

  if lLinkTbl is TSubLinkTbl then
   TSubLinkTbl(lLinkTbl).DelAllSubNodes(fAttrManager.DocData.DocID, fAttrManager.SubID)
  else
   lLinkTbl.DelAllNodesOnID(fAttrManager.DocData.DocID);
  fAttrManager.DocData.SynchronizeDeleteFromAttrManagers(fAttrManager, AttrID, aHandle);
  fList.Modified := False;
 end;
 *)

end;

function TDictDocAttribute.EditItem(aIndex : Integer): Boolean;
var
 lTreeCur      : Il3Tree;
begin
 with TTreeDesignerForm.Create(nil, fAttrManager.DocFamily, AttrID2DLType(AttrID), dmShow) do
 try
  Result := Execute(NameList, fAttrManager.AttrOperateMode = aomSearch {AllowSelNonLeaf},
            (fAttrManager.AttrOperateMode = aomSearch) or not(AttrID in GlSingleItemLinkAttrSet){MultiSelect});

  if Result then
  begin
   lTreeCur := DictOutliner.CTree;
   lTreeCur.SetLevelSlash(#13);

   GetListFromTree(lTreeCur, NameList, GetMasterDict(AttrID2DLType(AttrID)) <> da_dlNone);
  end;
 finally
  Free;
 end;
end;

function TDictDocAttribute.GetViewString(aIndex : Integer = 0): AnsiString;
begin
 Result := '?'; //GenDateNumString(PDNDictRec(Get_Data(aIndex))^);
end;

function TDictDocAttribute.Get_Handle(aIndex: Longint): Integer;
begin
 Result := PDictID(Data[aIndex])^;
end;

function TDictDocAttribute.Get_List: Tl3CustomDataList;
begin
 if fList = nil then
 begin
  fList := Tl3StringDataList.CreateSize(GetAttrStructSize(fAttrID));
  Il3ChangeNotifier(fList).Subscribe(Self as Il3ChangeRecipient);
  Il3ChangeNotifier(fList).Subscribe(Self as Il3ItemNotifyRecipient);
  l3Set(fNameList, List);
  fNameList.NeedAllocStr := True;
  Load;
 end;
 Result := fList;
end;

function TDictDocAttribute.Get_NameList : Tl3StringDataList;
begin
 if fNameList = nil then Get_List;
 Result := fNameList;
end;

procedure TDictDocAttribute.LoadPrim;
begin
 if Modified and (fAttrManager.SubID <> cAllSubs) then
  l3System.Stack2Log('Перезагрузка измененного списка');

 if (fAttrManager.Document <> nil) and (fAttrManager.Document.DocID > 0) then
 begin
  LinkServer(fAttrManager.DocFamily).GetTreeList(fAttrID, fAttrManager.Document.DocID, fAttrManager.SubID, NameList);
  Modified := False;
 end;
end;

function  TDictDocAttribute.Save : boolean;
var
 lInd : Integer;
begin
 if fAttrManager.Document <> nil then
 begin
  Result := Modified;
  if Result then
  begin
   LinkServer(fAttrManager.DocFamily).ReplaceLinks(fAttrID, List, fAttrManager.Document.DocID, fAttrManager.SubID);
   Modified := False;
  end;
 end
 else
  Result := False;
end;

{TVerLinkAttribute}
constructor TVerLinkAttribute.Create(aAttrManager : TDocAttributeManager);
begin
 Inherited Create(aAttrManager);
 fAttrID := atVerLink;
end;

procedure TVerLinkAttribute.DeletePersistent(aHandle : Integer = 0);
begin
 fAttrManager.Document.DocData.VerLinkExternalNum := 0;
end;

function TVerLinkAttribute.GetViewStringOfData(aData : Pointer): AnsiString;
begin
 Result := Format('№ %d', [PDocID(aData)^]);
end;

function TVerLinkAttribute.Get_Handle(aIndex: Longint): Integer;
begin
 Result := 0;
end;

function TVerLinkAttribute.Get_List: Tl3CustomDataList;
begin
 Result := NameList;
end;

function TVerLinkAttribute.Get_NameList : Tl3StringDataList;
var
 lLinkID : TDocID;
begin
 if fNameList = nil then
 begin
  fNameList := Tl3StringDataList.Create;

  with fNameList do
  begin
   DataSize := SizeOf(TDocID);
   NeedAllocStr := True;
   //HostDataList := List;
   lLinkID := fAttrManager.Document.DocData.VerLinkExternalNum;
   if lLinkID > 0 then
    inherited Add(@lLinkID);

   Modified := False;
   Il3ChangeNotifier(fNameList).Subscribe(Self as Il3ChangeRecipient);
   Il3ChangeNotifier(fNameList).Subscribe(Self as Il3ItemNotifyRecipient);
  end;
 end;
 Result := fNameList;
end;

function TVerLinkAttribute.EditItem(aIndex : Integer): Boolean;
var
 lLinkID : TDocID;
begin
 lLinkID := Get_Value;
 Result := RequestIntegerValue(lLinkID, nil, GetAttrName(fAttrID), 'Номер документа');
 if Result then
  Set_Value(lLinkID);
end;

procedure TVerLinkAttribute.LoadPrim;
begin
end;

function TVerLinkAttribute.Save: boolean;
begin
 Result := Modified;
 if Result then
 try
  fAttrManager.Document.DocData.VerLinkExternalNum := Get_Value;
 except
  on E : Exception do
   raise EAttrWriteError.Create(AttrID, E.Message);
 end;
end;

function TVerLinkAttribute.Add(aValue : Pointer) : Integer;
begin
 if PDictID(aValue)^ > 0 then
  Result := inherited Add(aValue)
 else
 begin
  NameList.Clear;
  Result := -1;
 end; 
end;

procedure TVerLinkAttribute.Set_Value(aValue : Integer);
begin
 Add(@aValue);
end;

function TVerLinkAttribute.Get_Value : Integer;
begin
 if (fNameList <> nil) and
    (fNameList.Count > 0) then
  Result := fNameList.DataInt[0]
 else
  Result := 0;
end;

function TVerLinkAttribute.Get_Modified: Boolean;
begin
 Result := fAttrManager.Document.DocData.VerLinkExternalNum <> Get_Value;
end;

procedure TVerLinkAttribute.Set_Modified(aValue : Boolean);
begin
end;

{TDocIDsAttribute}

constructor TDocIDsAttribute.Create(aAttrManager : TDocAttributeManager);
begin
 Inherited Create(aAttrManager);
 fAttrID := atRenum;
end;

procedure TDocIDsAttribute.DeletePersistent(aHandle : Integer = 0);
begin
end;

function TDocIDsAttribute.GetViewStringOfData(aData : Pointer): AnsiString;
begin
 Result := GenDocIDsString(PDocIDsRec(aData)^);
end;

function TDocIDsAttribute.Get_Handle(aIndex: Longint): Integer;
begin
 Result := PDocIDsRec(Data[aIndex])^.rID;
end;

function TDocIDsAttribute.Get_List: Tl3CustomDataList;
var
 lIDRec : TDocIDsRec;
begin
 if fList = nil then
 begin
  fList := Tl3DataList.CreateSize(SizeOf(TDocIDsRec));
  if fAttrManager.Document <> nil then
  begin
   fList.LockModified := True;
   try
    lIDRec.rIDKind := idkDocExternal;
    with fAttrManager.Document do
     lIDRec.rID := LinkServer(fAttrManager.DocFamily).Renum.GetExtDocID(DocID);
    fList.Add(@lIDRec);

    lIDRec.rIDKind := idkDocInternal;
    lIDRec.rID := fAttrManager.Document.DocID;
    fList.Add(@lIDRec);

    {lIDRec.rIDKind := idkSprExternal;
    fList.Add(lIDRec);

    lIDRec.rIDKind := idkSprInternal;
    fList.Add(lIDRec);
    }

   finally
    fList.LockModified := False;
   end;
  end;
 end;
 Result := fList;
end;

procedure TDocIDsAttribute.LoadPrim;
begin
end;

function TDocIDsAttribute.Save: boolean;
begin
 Result := False;
end;

{TPublishedDocAttribute}
constructor TPublishedDocAttribute.Create(aAttrManager : TDocAttributeManager);
begin
 Inherited Create(aAttrManager);
 fAttrID := atPublisheds;
end;

procedure TPublishedDocAttribute.ClearRecHandle(aValue : Pointer);
begin
 //ничего не надо, в отличие от DateNum'ов записи не уникальные
end;

procedure TPublishedDocAttribute.DeletePersistent(aHandle : Integer = 0);
begin
end;

function TPublishedDocAttribute.EditItem(aIndex : Integer): Boolean;
var
 lTreeCur : Il3Tree;
 lAddIndex : TListIndex;

 procedure lGetListFromTree(const aTree : Il3Tree; aList : Tl3StringDataList; var aAddIndex : TListIndex);
  var
  lCurNode  : Il3Node;
  lCurID    : Longint;
  lIndex    : TListIndex;

  function lFindItem(aID : Integer) : Integer;
  var
   I : Integer;
  begin
   Result := -1;
   for I := 0 to Pred(aList.Count) do
    if aList.DataInt[I] = aID then
    begin
     Result := I;
     Exit;
    end;
  end;

 const
  lfItemNeedDelete = $8000;
 var
  lExtNode : Il3ExtItemNode;
 begin
  aAddIndex := -1;
  //алгоритм добавляет из дерева в список селектированые, убивает расселектированые
  //если элемент уже был в списке, его не трогают, т к там еще могут быть дополнительные данные из LNK#B
  aList.Changing;
  try
   If aTree = nil then Exit;
   lCurNode := Nil;

   //взводим флажок "Удалять" (lfItemNeedDeleted)
   for lIndex := 0 to Pred(aList.Count) do
    aList.Flags[lIndex] := aList.Flags[lIndex] or lfItemNeedDelete;

   Repeat
    lCurNode := aTree.GetNextSelect(lCurNode);
    If lCurNode = Nil then break;

    lIndex := lFindItem((lCurNode as Il3HandleNode).Handle);
    if lIndex = -1 then
    begin // add
     if Supports(lCurNode, Il3ExtItemNode, lExtNode) then
     begin
      lIndex := aList.Add(nil, lExtNode.Data, lExtNode.DataSize);

      if (fAttrManager.Document <> nil) and (fAttrManager.Document.DocID > 0) then
       PPublishDataRec(Data[lIndex])^.DocID := fAttrManager.Document.DocID;

      with PPublishDataRec(Data[lIndex])^ do
       IsNonperiodic := DictServer(CurrentFamily).Dict[da_dlCorSources].DictTbl.GetIsNonperiodic(SourID);

      if aAddIndex = -1 then
       aAddIndex := lIndex
      else
       aAddIndex := -2; // если добавили 2 и больше, то индекс не возвращаем

      //aList.PasStr[lIndex] := GetViewString(lIndex);
     end;
    end
    else
     aList.Flags[lIndex] := aList.Flags[lIndex] and not lfItemNeedDelete;
   until false;

   // убиваем те у которых флажок lfItemNeedDeleted
    for lIndex := Pred(aList.Count) downto 0 do
     if l3TestMask(aList.Flags[lIndex], lfItemNeedDelete) then
     begin
      aList.Delete(lIndex);
      if aAddIndex > lIndex then Dec(aAddIndex); // корректируем на удаленные;
     end;
  finally
   aList.Changed;
  end;
 end;

 procedure lEditOneItem(aIndex : TListIndex);
 var
  lRec : PPublishDataRec;
 begin
  lRec := PPublishDataRec(Data[aIndex]);
  Result := RunPublishedInEditDlg(nil, NameList.PasStr[aIndex], lRec);
  if Result then
   Data[aIndex] := lRec;
 end;
   
begin
 Result := False;

 if (fAttrManager.AttrOperateMode = aomSearch) or (aIndex = -1) then //поисковый запрос или ветка целиком
 begin
  with TTreeDesignerForm.Create(nil, fAttrManager.DocFamily, da_dlCorSources {TdaDictionaryType(AttrID)}, dmShow) do
  try
   Result := Execute(List, false, //fAttrManager.AttrOperateMode = aomSearch {AllowSelNonLeaf},
             True); // (fAttrManager.AttrOperateMode = aomSearch) or not(AttrID in GlSingleItemLinkAttrSet){MultiSelect});

   if Result then
   begin
    lTreeCur := DictOutliner.CTree;
    lTreeCur.SetLevelSlash(#13);

    //List.Clear;
    lGetListFromTree(lTreeCur, NameList, lAddIndex);
    if lAddIndex >= 0 then
     lEditOneItem(lAddIndex)
   end;
  finally
   Free;
  end;
 end
 else //редактирование одного
  lEditOneItem(aIndex);
end;

function TPublishedDocAttribute.GetViewStringOfData(aData : Pointer): AnsiString;
begin
 Result := GenPublInString(PPublishFullRec(aData));
end;

function TPublishedDocAttribute.Get_Handle(aIndex: Longint): Integer;
begin
 Result := PPublishFullRec(Data[aIndex])^.ID;
end;

function TPublishedDocAttribute.Get_List: Tl3CustomDataList;
begin
 if fList = nil then
 begin
  fList := Tl3DataList.CreateSize(SizeOf(TPublishDataRec));
  if (fAttrManager.Document <> nil) and (fAttrManager.Document.DocID > 0) then
  begin
   fList.LockModified := True;
   try
    fAttrManager.Document.DocData.GetPublishedList(fList);
   finally
    fList.LockModified := False;
   end;
  end;
 end;
 Result := fList;
end;

procedure TPublishedDocAttribute.LoadPrim;
begin
end;

function TPublishedDocAttribute.Save: boolean;
begin
 if fAttrManager.Document = nil then
 begin
  Result := False;
  Exit;
 end;

 Result := Modified;
 if Result then
 begin
  fAttrManager.Document.DocData.SetAttrList(AttrID, List); //fAttrManager.Document.DocData.SetPublishedList(List);
  //lNeedCorrect := True;
  //LogRec[acPublInWork] := True;
  Modified := false;
 end;
end;

procedure TPublishedDocAttribute.Set_Data(aIndex: Longint; Value : Pointer);
begin
 with NameList do
 begin
  Data[aIndex] := Value;
  //Strings[aIndex] := PAnsiChar(GetViewStringOfData(Value));
 end;
end;

{TCorrectsAttribute}
constructor TCorrectsAttribute.Create(aAttrManager : TDocAttributeManager);
begin
 Inherited Create(aAttrManager);
 fAttrID := atCorrects;
 fPublishedsNotifier := (fAttrManager.GetDocAttribute(atPublisheds) as Il3ChangeNotifier);
 if fPublishedsNotifier <> nil then
  fPublishedsNotifier.Subscribe(Self as Il3ItemNotifyRecipient);
end;

procedure TCorrectsAttribute.Cleanup;
begin
 if fPublishedsNotifier <> nil then
  fPublishedsNotifier.Unsubscribe(Self as Il3ItemNotifyRecipient);
 Inherited;
end;

procedure TCorrectsAttribute.ClearRecHandle(aValue : Pointer);
begin
 PCorrectDictRec(aValue)^.ID := cUndefDictID;
end;

procedure TCorrectsAttribute.DeletePersistent(aHandle : Integer = 0);
begin
end;

function TCorrectsAttribute.EditItem(aIndex : Integer): Boolean;
var
 lRec : TCorrectDictRec;

 function SrcCheckRecEdit(var aRec: TCorrectDictRec; WasEmpty: Boolean): Boolean;
 begin
  with TSrcCheckDlg.Create(nil) do
  try
   (fAttrManager.GetDocAttribute(atPublisheds) as IListDocAttribute).NameList.AssignTo(cbSource.Items);
   Result := Execute(fAttrManager.DocFamily, aRec, WasEmpty);
  finally
   Free;
  end;
 end;

begin
 Result := False;
 if aIndex = -1 then // root
 begin
  lRec.ID := 0;
  Result := SrcCheckRecEdit(lRec, True);
  if Result then Add(@lRec);
 end
 else
 begin
  Result := SrcCheckRecEdit(PCorrectDictRec(Data[aIndex])^, False);
  if Result then
   DataWasChanged(aIndex);
 end;
end;

function TCorrectsAttribute.GetViewStringOfData(aData : Pointer): AnsiString;
var
 lPubInStr   : AnsiString;
 lPubInIndex : Integer;
begin
 lPubInStr := '';
 if PCorrectDictRec(aData)^.Sour <> 0 then
 begin
  with fAttrManager.GetDocAttribute(atPublisheds) as IListDocAttribute do
  begin
   lPubInIndex := List.IndexOfData(PCorrectDictRec(aData)^.Sour, SizeOf(PCorrectDictRec(aData)^.Sour), 0);
   if lPubInIndex >= 0 then
    lPubInStr := ViewString[lPubInIndex].S;
  end;
 end;

 Result := GenCorrectString(PCorrectDictRec(aData)^, lPubInStr);
end;

function TCorrectsAttribute.Get_Handle(aIndex: Longint): Integer;
begin
 {!!}
 Result := PCorrectDictRec(Data[aIndex])^.ID;
end;

function TCorrectsAttribute.Get_List: Tl3CustomDataList;
begin
 if fList = nil then
 begin
  fList := Tl3DataList.CreateSize(SizeOf(TCorrectDictRec));

  if (fAttrManager.Document <> nil) and (fAttrManager.Document.DocID > 0) then
  begin
   fList.LockModified := True;
   try
    fAttrManager.Document.DocData.GetCorrectList(fList);
   finally
    fList.LockModified := False;
   end;
  end;
 end;
 Result := fList;
end;

procedure TCorrectsAttribute.LoadPrim;
begin
end;

function TCorrectsAttribute.Save: boolean;
//var
// lInd        : Integer;
// lFullAIRec  : TActiveIntervalRec;
begin
 if fAttrManager.Document = nil then
 begin
  Result := False;
  Exit;
 end;

 Result := Modified;
 if Result then
 begin
  fAttrManager.Document.DocData.SetAttrList(AttrID, List);  //fAttrManager.Document.DocData.SetCorrectList(List);
  Modified := false;
 end;
end;

procedure TCorrectsAttribute.Set_Data(aIndex: Longint; Value : Pointer);
begin
 with NameList do
 begin
  Data[aIndex] := Value;
  Strings[aIndex] := PAnsiChar(GetViewStringOfData(Value));
 end;
end;

procedure TCorrectsAttribute.Notify(const aNotifier : Il3ChangeNotifier; aOperation : Integer; aIndex : Integer);
var
 lRec : PCorrectDictRec;
 lPubInID : TDictID;
 I : Integer;
 lInChange : Boolean;

 function IsPublishedPresent(aPubID : TDictID) : boolean;
 var
  I : Integer;
 begin
  Result := False;
  with (fAttrManager.GetDocAttribute(atPublisheds) as IListDocAttribute) do
   for I := 0 to Pred(List.Count) do
    if APubID = Handle[I] then
    begin
     Result := True;
     Break;
    end;
 end;

 procedure DoChange;
 begin
  if not lInChange then
  begin
   List.Changing;
   lInChange := True;
  end;
 end;

begin
 lInChange := False;

 if l3IEQ(aNotifier, fPublishedsNotifier) then
 begin
  if (aOperation = ntDelete) or (aOperation = ntChangeItemData) then
  begin
   lPubInID := (fAttrManager.GetDocAttribute(atPublisheds) as IListDocAttribute).Handle[aIndex];
   try
    for I := 0 to Pred(List.Count) do
    begin
     lRec := PCorrectDictRec(Data[I]);
     if lRec^.Sour = lPubInID then
     begin
      Case aOperation of
       ntDelete :
        begin
         DoChange;
         lRec^.Sour := 0;
         DataWasChanged(I);
        end;
       ntChangeItemData :
        RegenerateString(I);
      end; //Case aOperation of
     end
     else
      if (aOperation = ntChangeItemData) and
         ((lRec^.Sour <> 0) and not IsPublishedPresent(lRec^.Sour)) then
       begin
        DoChange;
        lRec^.Sour := 0;
        DataWasChanged(I);
       end;
    end;
   finally
    if lInChange then List.Changed;
   end;
  end;
 end
 else
  inherited;
end;


(*
{TPaperWhereDocAttribute}
constructor TPaperWhereDocAttribute.Create(aAttrManager : TDocAttributeManager);
begin
 Inherited Create(aAttrManager);
 fAttrID := atPaperWhere;
end;

//function TPaperWhereDocAttribute.IsEmpty : Boolean;
//begin
//end;

function TPaperWhereDocAttribute.Add(aValue : Pointer) : Integer;
begin
 List.Changing;
 try
  List.Clear;
  if (PPaperWhereRec(aValue)^.rPaperUser <> 0) or
     (PPaperWhereRec(aValue)^.rPaperPlace <> '') then
   Result := inherited Add(aValue);
 finally
  List.Changed;
 end;
end;

//procedure TPaperWhereDocAttribute.DeletePersistent(aHandle : Integer = 0);
//begin
//end;

function TPaperWhereDocAttribute.Get_Value: TPaperWhereRec;
begin
 if IsEmpty then
  Result := cEmptyPaperWhereRec
 else
  Result := PPaperWhereRec(Data[0])^;
end;

function TPaperWhereDocAttribute.EditItem(aIndex : Integer): Boolean;
begin
 fPaperWhere := Get_Value;
 with TPaperWhereDlg.Create(nil) do
 try
  Result := Execute(fPaperWhere.rPaperUser, fPaperWhere.rPaperPlace);
  if Result then
   Add(@fPaperWhere);
 finally
  Free;
 end;
end;

function TPaperWhereDocAttribute.GetViewStringOfData(aData : Pointer): AnsiString;
begin
 with PPaperWhereRec(aData)^ do
  Result := GenPaperWhereString(rPaperUser, rPaperPlace);
end;

function TPaperWhereDocAttribute.Get_Handle(aIndex: Longint): Integer;
begin
 Result := 0;
end;

function TPaperWhereDocAttribute.Get_List: Tl3CustomDataList;
begin
 if fNameList = nil then
 begin
  fNameList := Tl3StringDataList.CreateSize(SizeOf(TPaperWhereRec));
  l3Set(fList,fNameList);

  fNameList.NeedAllocStr := True;
  Il3ChangeNotifier(fNameList).Subscribe(Self as Il3ChangeRecipient);
  Il3ChangeNotifier(fNameList).Subscribe(Self as Il3ItemNotifyRecipient);

  Load;
 end;
 Result := fList;
end;

function TPaperWhereDocAttribute.Get_NameList: Tl3StringDataList;
begin
 Result := List as Tl3StringDataList;
end;

procedure TPaperWhereDocAttribute.LoadPrim;
begin
 with fAttrManager.Document.DocData.Card^, fPaperWhere do
 begin
  rPaperUser := PaperUser;
  rPaperPlace := PaperPlace;
 end;

 List.LockModified := True;
 try
  Add(@fPaperWhere);
 finally
  List.LockModified := False;
 end;

 Modified := False;
end;

function TPaperWhereDocAttribute.Save: boolean;

 function IsCange(const aPaperWhere : TPaperWhereRec) : Boolean;
 begin
  with fAttrManager.Document.DocData.Card^, aPaperWhere do
   Result := (PaperUser <> rPaperUser) or (PaperPlace <> rPaperPlace);
 end;

begin
 fPaperWhere := Get_Value;
 Result := IsCange(fPaperWhere);

 if Result then
 begin
  with fAttrManager.Document.DocData.Card^, fPaperWhere do
  begin
   PaperUser := rPaperUser;
   PaperPlace := rPaperPlace;
  end;
  Modified := False;
 end;
end;
*)

{TListOfDocAttribute}

function TListOfDocAttribute.Get_List: Tl3CustomDataList;
begin
 Result := NameList;
end;

function TListOfDocAttribute.Get_NameList: Tl3StringDataList;
begin
 if fNameList = nil then
 begin
  fNameList := Tl3StringDataList.Create;
  Load;
 end;
 Result := fNameList;
end;

function TListOfDocAttribute.Save: boolean;
begin
 Result := False;
end;

{TVersionListAttribute}

function TVersionListAttribute.GetViewStringOfData(aData : Pointer): AnsiString;
var
 I : Integer;
 lIntervalStr : AnsiString;
 lChDateStr   : AnsiString;
 lDocument : TarDocument;
 lDocID       : TDocID;

begin
 lDocID := TDocID(aData);
 lDocument := TarDocument.CreateParam(fAttrManager.DocFamily, lDocID);
 try
  with lDocument do
  begin
   with AttrManager.GetDocAttribute(atActiveIntervals) as IListDocAttribute do
    for I := 0 to Pred(Count) do
     with PActiveIntervalRec(Data[I])^ do
      if Typ = 0 then
      begin
       if I > 0 then lIntervalStr := lIntervalStr +',';
       lIntervalStr := lIntervalStr + GenDateDiapasonString(MakeDateBounds(Start,Finish));
      end;

   with AttrManager.GetDocAttribute(atDateNums) as IListDocAttribute do
    for I := 0 to Pred(Count) do
     with PDNDictRec(Data[I])^ do
      if Typ = dnChangerDate then
       lChDateStr := lChDateStr + ' ' + GenStDateString(Date);

  end;
 finally
  l3Free(lDocument);
 end;

 if lIntervalStr = '' then
  lIntervalStr := ' действует';

 Result := Format('[%d] Интервал действия:%s',
           [LinkServer(fAttrManager.DocFamily).Renum.GetExtDocID(lDocID), lIntervalStr]);

 if lChDateStr <> '' then
  Result := Result + Format('   Дата изменяющего документа:%s', [lChDateStr]);

end;

function TVersionListAttribute.Get_Data(aIndex: Longint): Pointer;
begin
 Result := Pointer(fAttrManager.Document.DocData.VersionsList.GetDoc(aIndex).ID);
end;

procedure TVersionListAttribute.LoadPrim;
var
 lIndex : Integer;
 lID : TDocID;

begin
 with NameList do
 begin
  Clear;
  DataSize := SizeOf(TDocID);
  NeedAllocStr := True;
  LockModified := True;
  try
   for lIndex := 0 to Pred(fAttrManager.Document.DocData.VersionsList.Count) do
   begin
    lID := fAttrManager.Document.DocData.VersionsList.GetDoc(lIndex).ID;
    AddStr(GetViewStringOfData(Pointer(lID)), @lID);
   end;
  finally
   LockModified := False;
  end;
 end;
end;

{TStagesDocAttribute}
constructor TStagesDocAttribute.Create(aAttrManager : TDocAttributeManager);
begin
 Inherited Create(aAttrManager);
 fAttrID := atStages;
end;

procedure TStagesDocAttribute.ClearRecHandle(aValue : Pointer);
begin
 // ничего не надо
end;

procedure TStagesDocAttribute.DeletePersistent(aHandle : Integer = 0);
begin
(*
 if fAttrManager.Document.DocData <> nil then
 begin
  fAttrManager.Document.DocServer.AlarmTbl.DocID := fAttrManager.DocData.DocID;
  fAttrManager.Document.DocServer.AlarmTbl.DelDocAlarm(Byte(aHandle));
 end;
*)
end;

function TStagesDocAttribute.EditItem(aIndex : Integer): Boolean;
//var
// lRec : TAlarmRec;
begin

(* Result := False;
 if aIndex = -1 then // root
 begin
  lRec.RecID := 0;
  Result := GetAttrAlarm(lRec, True);
  if Result then Add(@lRec);
 end
 else
 begin
  Result := GetAttrAlarm(PAlarmRec(Data[aIndex])^, False);
  if Result then
   DataWasChanged(aIndex);
 end;
*)
end;

function TStagesDocAttribute.GetViewStringOfData(aData : Pointer): AnsiString;
begin
 Result := StageNameByID(TStageType(PStageFullRec(aData)^.StType));
end;

function TStagesDocAttribute.Get_Handle(aIndex: Longint): Integer;
begin
 Result := PStageFullRec(Data[aIndex])^.StType;
end;

function TStagesDocAttribute.EditData(aHandle : Integer; aValue : Pointer) : Boolean;
var
 lIndex : Integer;
begin
 lIndex := GetIndexByHandle(aHandle);
 if lIndex < 0 then
 begin
  PStageFullRec(aValue)^.StType := aHandle;
  lIndex := Add(aValue);
  //Handle[lIndex] := aHandle;
 end
 else
  Data[lIndex] := aValue;
  //DataWasChanged(lIndex);
end;

function TStagesDocAttribute.Add(aValue : Pointer) : Integer;
begin
 List.Changing;
 try
  Result := List.Add(aValue);
 finally
  List.Changed;
 end;
end;

function TStagesDocAttribute.CheckStageClosed(aStageType : TStageType): Boolean;
begin
 Result := DateOfStageClosed(aStageType) > 0;
end;

procedure TStagesDocAttribute.CloseStage(aStageType : TStageType);
var
 lIndex : Integer;
 lStageRec : TStageFullRec;
begin
 lIndex := GetIndexByHandle(Byte(aStageType));
 if lIndex >= 0 then
  lStageRec := PStageFullRec(Data[lIndex])^
 else
 begin
  l3FillChar(lStageRec, SizeOf(lStageRec));
  lStageRec.StType := Ord(aStageType);
 end;

 if lStageRec.BDate = 0 then lStageRec.BDate := 1;
 if lStageRec.EDate = 0 then lStageRec.EDate := 1;

 EditData(Ord(aStageType), @lStageRec);
end;

function TStagesDocAttribute.DateOfStageClosed(aStageType : TStageType): TStDate;
var
 lIndex : Integer;
begin
 lIndex := GetIndexByHandle(Byte(aStageType));
 if lIndex >= 0 then
  Result := PStageFullRec(Data[lIndex]).EDate
 else
  Result := 0;
end;

function TStagesDocAttribute.Get_List: Tl3CustomDataList;
begin
 If fList = nil then
 begin
  fList := Tl3DataList.CreateSize(SizeOf(TStageFullRec));
  if (fAttrManager.Document <> nil) and (fAttrManager.Document.DocID > 0) then
  begin
   fList.LockModified := True;
   try
    if fAttrManager.Document.DocID > 0 then
     LinkServer(fAttrManager.DocFamily).Stages.GetDocStagesRecList(fAttrManager.Document.DocID, fList);
   finally
    fList.LockModified := False;
   end;
   //fList.Subscribe(Self as Il3ChangeRecipient);
   //fList.Subscribe(Self as Il3ItemNotifyRecipient);
  end;
 end;
 Result := fList;
end;

procedure TStagesDocAttribute.LoadPrim;
begin
end;

function TStagesDocAttribute.Save: boolean;
var
 lInd : Integer;
begin
 if fAttrManager.Document = nil then
 begin
  Result := False;
  Exit;
 end;

 Result := Modified;
 if Result then
 begin
  LinkServer(fAttrManager.DocFamily).Stages.SetDocStagesRecList(fAttrManager.Document.DocID, fList);
  Modified := false;
 end;
end;

{TDocIDsAttribute}

constructor TDoc2DocAttribute.Create(aAttrManager : TDocAttributeManager);
begin
 Inherited Create(aAttrManager);
 fAttrID := atDoc2DocLink;
end;

function TDoc2DocAttribute.EditItem(aIndex : Integer): Boolean;
var
 l_Rec : TDoc2DocRec;
begin
 if aIndex > -1 then
 begin
  l_Rec := PDoc2DocRec(Data[aIndex])^;
  if Doc2DocLinkEdit(l_Rec, False) then
   Data[aIndex] := @l_Rec;
 end
 else
  if Doc2DocLinkEdit(l_Rec, True) then
  begin
   l_Rec.rDocID := 
   Add(@l_Rec);
  end;
end;

function TDoc2DocAttribute.GetViewStringOfData(aData : Pointer): AnsiString;
var
 l_Rec: PDoc2DocRec;
 l_DocID: TDocID;
begin
 l_Rec := PDoc2DocRec(aData);
 l_DocID := l_Rec^.rLinkedDocID;
 l_DocID := LinkServer(fAttrManager.DocFamily).Renum.GetExtDocID(l_DocID);
 Result := Format(cDoc2DocLinkViewStr[l_Rec^.rLinkType], [l_DocID]);
end;

function TDoc2DocAttribute.Get_List: Tl3CustomDataList;
begin
 if fList = nil then
 begin
  fList := Tl3DataList.CreateSize(GetAttrStructSize(atDoc2DocLink));
  if (fAttrManager.Document <> nil) and (fAttrManager.Document.DocID > 0) then
   Load;
 end;
 Result := fList;
end;

procedure TDoc2DocAttribute.LoadPrim;
var
 l_Sab: ISab;
 l_DocID: TDocID;
 lRAProcStub : TdtRecAccessProc;

 function l_AddRec(aRec: PDoc2DocRec) : Boolean;
 begin
  Result := True;
  List.Add(aRec);
 end;

begin
 if (fAttrManager.Document = nil) or (fAttrManager.Document.DocID <= 0) then
  Exit;

 l_Sab := MakeSab(LinkServer(fAttrManager.DocFamily)[atDoc2DocLink]);
 try
  l_DocID := fAttrManager.Document.DocID;
  l_Sab.Select(lnkDocIDFld, l_DocID);
  lRAProcStub := L2RecAccessProc(@l_AddRec);
  try
   l_Sab.IterateRecords(lRAProcStub, [lnkDocIDFld, lddLinkTypeFld, lddLinkedDocFld]);
  finally
   FreeRecAccessProc(lRAProcStub);
  end;
 finally
  l_Sab := nil;
 end;
 Modified := False;
end;

function TDoc2DocAttribute.Save: Boolean;
var
 l_Cache: TCacheDiffAttrData;
 I: Integer;
 l_DocID: TDocID;
begin
 l_Cache := TCacheDiffAttrData.Create(CurrentFamily, ctDoc2DocLink);
 l_DocID := fAttrManager.Document.DocID;
 try
  for I := 0 to List.Count-1 do
   with PDoc2DocRec(Data[I])^ do
    l_Cache.AddRecord([l_DocID, rLinkType, rLinkedDocID]);
  l_Cache.CloseDoc(l_DocID);
  Modified := False;
 finally
  l3Free(l_Cache);
 end;
end;

end.


