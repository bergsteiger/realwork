unit atUserJournalHelper;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "AdapterTest"
// Модуль: "w:/quality/test/garant6x/AdapterTest/AdapterHelpers/atUserJournalHelper.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x_test::AdapterTest::AdapterHelpers::TatUserJournalHelper
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

interface

uses
  DocumentUnit,
  DynamicTreeUnit,
  SearchUnit,
  Contnrs,
  UserJournalUnit,
  BaseTypesUnit,
  l3_Base
  ;

type
 _EntityInterface_ = IJournalBookmark;
{$Include ..\AdapterHelpers\atEntityWithName.imp.pas}
 TatJournalBookmark = class(_atEntityWithName_)
 protected
 // property methods
   function pm_GetDocument: IDocument; virtual;
   function pm_GetPara: TParaId; virtual;
   function pm_GetFullName: AnsiString; virtual;
 public
 // overridden public methods
   constructor Create(const anEntityBase: IEntityBase); override;
 public
 // public properties
   property Document: IDocument
     read pm_GetDocument;
   property Para: TParaId
     read pm_GetPara;
   property FullName: AnsiString
     read pm_GetFullName;
 end;//TatJournalBookmark

 TatUserJournalHelper = class
 private
 // private methods
   class procedure ReadJournalNode(const aNode: INodeBase);
   class procedure ReadJournalBookmark(const aJournalBookmark: IJournalBookmark);
   class procedure ReadJournalQuery(const aQuery: IQuery);
   class function UserJournal: IUserJournal;
 public
 // public methods
   class procedure AddBookmark(const aBookmark: IJournalBookmark);
   class procedure AddQuery(const aQuery: IQuery);
   class procedure Clear;
   class procedure ReadAll;
   class procedure ReadHistory(aMaxItems: Integer);
   class function GetElements(aDate: Double = 0): TObjectList;
   class function GetQueryHistory(aType: TQueryType;
    aMaxCount: Integer): TObjectList;
 end;//TatUserJournalHelper

implementation

uses
  SysUtils,
  IOUnit,
  atNodeHelper,
  atGblAdapterWorker,
  atLogger,
  atQuery
  ;

{$Include ..\AdapterHelpers\atEntityWithName.imp.pas}

// start class TatJournalBookmark

function TatJournalBookmark.pm_GetDocument: IDocument;
//#UC START# *4FC8EDB701E9_4FC8EC8900FEget_var*
//#UC END# *4FC8EDB701E9_4FC8EC8900FEget_var*
begin
//#UC START# *4FC8EDB701E9_4FC8EC8900FEget_impl*
  f_Entity.GetDocument(Result);
//#UC END# *4FC8EDB701E9_4FC8EC8900FEget_impl*
end;//TatJournalBookmark.pm_GetDocument

function TatJournalBookmark.pm_GetPara: TParaId;
//#UC START# *4FC8EE000329_4FC8EC8900FEget_var*
//#UC END# *4FC8EE000329_4FC8EC8900FEget_var*
begin
//#UC START# *4FC8EE000329_4FC8EC8900FEget_impl*
  Result := f_Entity.GetParaId;
//#UC END# *4FC8EE000329_4FC8EC8900FEget_impl*
end;//TatJournalBookmark.pm_GetPara

function TatJournalBookmark.pm_GetFullName: AnsiString;
//#UC START# *4FC8EE480371_4FC8EC8900FEget_var*
  var
    l_Str : IString;
//#UC END# *4FC8EE480371_4FC8EC8900FEget_var*
begin
//#UC START# *4FC8EE480371_4FC8EC8900FEget_impl*
  f_Entity.GetFullName(l_Str);
  if Assigned(l_Str) then
    Result := l_Str.GetData;
//#UC END# *4FC8EE480371_4FC8EC8900FEget_impl*
end;//TatJournalBookmark.pm_GetFullName

constructor TatJournalBookmark.Create(const anEntityBase: IEntityBase);
//#UC START# *4FC8E5780345_4FC8EC8900FE_var*
//#UC END# *4FC8E5780345_4FC8EC8900FE_var*
begin
//#UC START# *4FC8E5780345_4FC8EC8900FE_impl*
  inherited;
  Name;
  FullName;
//#UC END# *4FC8E5780345_4FC8EC8900FE_impl*
end;//TatJournalBookmark.Create

class procedure TatUserJournalHelper.AddBookmark(const aBookmark: IJournalBookmark);
//#UC START# *4D0A078B002B_4D0A033202D2_var*
//#UC END# *4D0A078B002B_4D0A033202D2_var*
begin
//#UC START# *4D0A078B002B_4D0A033202D2_impl*
 UserJournal.Save(aBookmark, JOT_BOOKMARK);
//#UC END# *4D0A078B002B_4D0A033202D2_impl*
end;//TatUserJournalHelper.AddBookmark

class procedure TatUserJournalHelper.AddQuery(const aQuery: IQuery);
//#UC START# *4D0A07A7007E_4D0A033202D2_var*
//#UC END# *4D0A07A7007E_4D0A033202D2_var*
begin
//#UC START# *4D0A07A7007E_4D0A033202D2_impl*
  UserJournal.Save(aQuery, JOT_QUERY);
//#UC END# *4D0A07A7007E_4D0A033202D2_impl*
end;//TatUserJournalHelper.AddQuery

class procedure TatUserJournalHelper.Clear;
//#UC START# *4D0A07C00107_4D0A033202D2_var*
  var
    l_Root : INodeBase;
//#UC END# *4D0A07C00107_4D0A033202D2_var*
begin
//#UC START# *4D0A07C00107_4D0A033202D2_impl*
  with UserJournal do
  begin
    GetUserJornalTree(l_Root);
    Clear;
  end
//#UC END# *4D0A07C00107_4D0A033202D2_impl*
end;//TatUserJournalHelper.Clear

class procedure TatUserJournalHelper.ReadAll;
//#UC START# *4D0A07D1012C_4D0A033202D2_var*
  var
    l_Root : INodeBase;
//#UC END# *4D0A07D1012C_4D0A033202D2_var*
begin
//#UC START# *4D0A07D1012C_4D0A033202D2_impl*
  UserJournal.GetUserJornalTree(l_Root);
  if (l_Root <> nil) then
    TatNodeHelper.LoadNodes(l_Root, High(Word), High(Cardinal), ReadJournalNode);
//#UC END# *4D0A07D1012C_4D0A033202D2_impl*
end;//TatUserJournalHelper.ReadAll

class procedure TatUserJournalHelper.ReadHistory(aMaxItems: Integer);
//#UC START# *4D0A07EB0282_4D0A033202D2_var*
  var
    l_JBL : IJournalBookmarkList;
    l_JB : IJournalBookmark;
    i : Integer;
//#UC END# *4D0A07EB0282_4D0A033202D2_var*
begin
//#UC START# *4D0A07EB0282_4D0A033202D2_impl*
  try
    UserJournal.GetBookmarkHistory(BJT_BOOKMARK, aMaxItems, l_JBL);
  except
    on ECanNotFindData do ;
  end;
    
  if (l_JBL <> nil) then
    for i := 0 to l_JBL.Count-1 do
    begin
      l_JBL.pm_GetItem(i, l_JB);
      ReadJournalBookmark(l_JB);
    end;
//#UC END# *4D0A07EB0282_4D0A033202D2_impl*
end;//TatUserJournalHelper.ReadHistory

class procedure TatUserJournalHelper.ReadJournalNode(const aNode: INodeBase);
//#UC START# *4D0A100E0332_4D0A033202D2_var*
  var
    l_JournalBookmark : IJournalBookmark;
    l_Query : IQuery;
    l_Entity : IEntityBase;
    l_NodeType : TJournalObjectType;
//#UC END# *4D0A100E0332_4D0A033202D2_var*
begin
//#UC START# *4D0A100E0332_4D0A033202D2_impl*
  l_NodeType := TJournalObjectType(aNode.GetType);
  //
  if l_NodeType = JOT_FOLDER then
    TatNodeHelper.GetCaption(aNode)
  else
  begin
    try
      aNode.GetEntity(l_Entity);
    except
      on ENoEntity do ;
    end;
    //
    if (l_Entity <> nil) then
      case l_NodeType of
        JOT_BOOKMARK :
          if Supports(l_Entity, IJournalBookmark, l_JournalBookmark) then
            ReadJournalBookmark(l_JournalBookmark);
        JOT_QUERY :
          if Supports(l_Entity, IQuery, l_Query) then
            ReadJournalQuery(l_Query);
      end;
   end;
//#UC END# *4D0A100E0332_4D0A033202D2_impl*
end;//TatUserJournalHelper.ReadJournalNode

class procedure TatUserJournalHelper.ReadJournalBookmark(const aJournalBookmark: IJournalBookmark);
//#UC START# *4D0A10510060_4D0A033202D2_var*
  var
    l_String : IString;
//#UC END# *4D0A10510060_4D0A033202D2_var*
begin
//#UC START# *4D0A10510060_4D0A033202D2_impl*
  aJournalBookmark.GetName(l_String);
  if l_String <> nil then
    l_String.GetData;
//#UC END# *4D0A10510060_4D0A033202D2_impl*
end;//TatUserJournalHelper.ReadJournalBookmark

class procedure TatUserJournalHelper.ReadJournalQuery(const aQuery: IQuery);
//#UC START# *4D0A107B033E_4D0A033202D2_var*
  var
    l_String : IString;
    l_Date : TDate;
//#UC END# *4D0A107B033E_4D0A033202D2_var*
begin
//#UC START# *4D0A107B033E_4D0A033202D2_impl*
  aQuery.GetName(l_String);
  if l_String <> nil then
    l_String.GetData;
//#UC END# *4D0A107B033E_4D0A033202D2_impl*
end;//TatUserJournalHelper.ReadJournalQuery

class function TatUserJournalHelper.UserJournal: IUserJournal;
//#UC START# *4D0A18D900B0_4D0A033202D2_var*
//#UC END# *4D0A18D900B0_4D0A033202D2_var*
begin
//#UC START# *4D0A18D900B0_4D0A033202D2_impl*
  Result := TatGblAdapterWorker.Instance.GblAdapterDll.MakeUserJournal;
//#UC END# *4D0A18D900B0_4D0A033202D2_impl*
end;//TatUserJournalHelper.UserJournal

class function TatUserJournalHelper.GetElements(aDate: Double = 0): TObjectList;
//#UC START# *4FC8C0CF0161_4D0A033202D2_var*
  var
    l_Entity : IEntityBase;
    l_Root, l_Node, l_TempNode : INodeBase;
    l_Query : IQuery;
//#UC END# *4FC8C0CF0161_4D0A033202D2_var*
begin
//#UC START# *4FC8C0CF0161_4D0A033202D2_impl*
  Result := TObjectList.Create(true);
  //
  UserJournal.GetUserJornalTree(l_Root);

  l_Node := l_Root;
  while true do
  begin
    // переходим на следующую ноду
    if l_Node.HasChildren then
    begin
      l_TempNode := l_Node;
      l_TempNode.GetFirstChild(l_Node);
      l_TempNode := nil;
    end
    else
    begin
      while l_Node.IsLast do
      begin
        l_TempNode := l_Node;
        l_TempNode.GetParent(l_Node);
        l_TempNode := nil;
        if l_Node = nil then Exit;
      end;
      //
      l_TempNode := l_Node;
      l_TempNode.GetNext(l_Node);
      l_TempNode := nil;
    end;

    // пропускаем папки, дата которых раньше чем заданная
    while (aDate <> 0) AND (l_Node.GetLevel = 1) AND (TJournalObjectType(l_Node.GetType) = JOT_FOLDER) AND (StrToDate(TatNodeHelper.GetCaption(l_Node)) < aDate) do
      if NOT l_Node.IsLast then
      begin
        l_TempNode := l_Node;
        l_TempNode.GetNext(l_Node);
        l_TempNode := nil;
      end
      else
        Exit;

    // пропускаем папки
    if TJournalObjectType(l_Node.GetType) = JOT_FOLDER then continue;

    try
      l_Node.GetEntity(l_Entity);
    except
      on ENoEntity do ;
    end;

    if l_Entity <> nil then
      if TatJournalBookmark.IsItMe(l_Entity) then
        Result.Add(TatJournalBookmark.Create(l_Entity))
      else if TatQuery.IsItMe(l_Entity) then
      begin
        (l_Entity as IQuery).Clone(l_Query);
        Result.Add(TatQuery.Create(l_Query));
      end
      else
        Raise Exception.Create('Неизвестная Entity!');
  end;

//#UC END# *4FC8C0CF0161_4D0A033202D2_impl*
end;//TatUserJournalHelper.GetElements

class function TatUserJournalHelper.GetQueryHistory(aType: TQueryType;
  aMaxCount: Integer): TObjectList;
//#UC START# *500D90A4007E_4D0A033202D2_var*
  var
    l_QL : IQueryList;
    l_Query : IQuery;
    i : Integer;
//#UC END# *500D90A4007E_4D0A033202D2_var*
begin
//#UC START# *500D90A4007E_4D0A033202D2_impl*
  Result := nil;
  try
    UserJournal.GetQueryHistory(aType, aMaxCount, l_QL);
  except
    on ECanNotFindData do Exit;
  end;

  if Assigned(l_QL) AND (l_QL.Count > 0) then
  begin
    Result := TObjectList.Create;
    Result.OwnsObjects := true;
    for i := 0 to l_QL.Count-1 do
    begin
      l_QL.pm_GetItem(i, l_Query);
      Result.Add( TatQuery.Create(l_Query) );
    end;
  end;
//#UC END# *500D90A4007E_4D0A033202D2_impl*
end;//TatUserJournalHelper.GetQueryHistory

end.