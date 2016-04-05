unit atFoldersHelper;

// Модуль: "w:\quality\test\garant6x\AdapterTest\AdapterHelpers\atFoldersHelper.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TatFoldersHelper" MUID: (480864400141)

interface

uses
 l3IntfUses
 , FoldersUnit
 , BaseTypesUnit
 , BaseTreeSupportUnit
 , l3_Base
 , IOUnit
 , l3RegEx
;

type
 TatFoldersHelper = class;

 IatFoldersNodeMatcher = interface
  ['{0EDEF0CD-6104-4C41-ACD7-A8248088AD75}']
  function IsMatch(const aFoldersNode: IFoldersNode): Boolean;
 end;//IatFoldersNodeMatcher

 TatFolderNodeMatcherBase = {abstract} class(Tl3_Base, IatFoldersNodeMatcher)
  private
   f_FoldersNode: IFoldersNode;
  protected
   function pm_GetFoldersNode: IFoldersNode;
   function CheckIsMatch: Boolean; virtual; abstract;
   function IsMatch(const aFoldersNode: IFoldersNode): Boolean;
   procedure ClearFields; override;
  public
   class function Make: IatFoldersNodeMatcher; reintroduce;
  public
   property FoldersNode: IFoldersNode
    read pm_GetFoldersNode;
 end;//TatFolderNodeMatcherBase

 TatAnyMatcher = {final} class(TatFolderNodeMatcherBase)
  protected
   function CheckIsMatch: Boolean; override;
 end;//TatAnyMatcher

 TatMatchMethod = (
  {* Как выполняем проверку "а эту ли закладку нам нужно удалять" }
  MM_ALL
   {* подходят все }
  , MM_COMPARE
   {* подходят те имена которых совпадают с заданным }
  , MM_REGEXP
   {* подходят те, имена которых удовлетворяют регулярному выражению }
 );//TatMatchMethod

 IatNameMatcher = interface
  ['{37DA6992-43E1-493E-BE86-B98BD0FC9B2B}']
  function Get_MatchMethod: TatMatchMethod;
  procedure Set_MatchMethod(aValue: TatMatchMethod);
  function Get_Name: AnsiString;
  procedure Set_Name(const aValue: AnsiString);
  property MatchMethod: TatMatchMethod
   read Get_MatchMethod
   write Set_MatchMethod;
  property Name: AnsiString
   read Get_Name
   write Set_Name;
 end;//IatNameMatcher

 TatNameMatcher = {abstract} class(TatAnyMatcher, IatNameMatcher)
  private
   f_MatchMethod: TatMatchMethod;
   f_Name: AnsiString;
   f_RegExp: Tl3RegularSearch;
  protected
   function pm_GetObjectCaption: IString; virtual; abstract;
   function Get_MatchMethod: TatMatchMethod;
   procedure Set_MatchMethod(aValue: TatMatchMethod);
   function Get_Name: AnsiString;
   procedure Set_Name(const aValue: AnsiString);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
   function CheckIsMatch: Boolean; override;
  protected
   property ObjectCaption: IString
    read pm_GetObjectCaption;
 end;//TatNameMatcher

 TatFolderMatcher = class(TatNameMatcher)
  protected
   function pm_GetObjectCaption: IString; override;
   function CheckIsMatch: Boolean; override;
 end;//TatFolderMatcher

 TatBookmarkMatcher = class(TatNameMatcher)
  protected
   function pm_GetObjectCaption: IString; override;
   function CheckIsMatch: Boolean; override;
 end;//TatBookmarkMatcher

 TatListMatcher = class(TatNameMatcher)
  protected
   function pm_GetObjectCaption: IString; override;
   function CheckIsMatch: Boolean; override;
 end;//TatListMatcher

 IatFoldersNodeCallback = interface
  ['{7405392E-7DB4-4E52-BE6D-7697BFC0AEA3}']
  procedure OnFoldersNode(const aFoldersNode: IFoldersNode);
 end;//IatFoldersNodeCallback

 TatQueryMatcher = class(TatNameMatcher)
  protected
   function pm_GetObjectCaption: IString; override;
   function CheckIsMatch: Boolean; override;
 end;//TatQueryMatcher

 TatFoldersHelper = class
  public
   class function GetMyDocuments(const folders: IFolders = nil): IFoldersNode;
   class function IterateAllChildFoldersNode(const aRootNode: IFoldersNode;
    const aFoldersNodeCallback: IatFoldersNodeCallback;
    const aMatcher: IatFoldersNodeMatcher = nil;
    isRecursive: Boolean = True): Integer; virtual;
    {* Проходит по элементам в папках. Соответствует ли элемент - определяется путем вызова метода IsMatch на IatFoldersNodeMatcher.
Возвращает количество просмотренных элементов. }
   class procedure AddToMyDocuments(const anEntity: IEntityBase;
    out theAddedNode: INode); virtual;
   class procedure CreateFolder(const aRootNode: IFoldersNode;
    const aName: AnsiString;
    const aComment: AnsiString;
    out theAddedNode: INode); virtual;
    {* Добавляет к указанной ноде дочернюю папку. }
   class procedure AddToFolder(const aFolder: IFoldersNode;
    const anEntity: IEntityBase;
    out theAddedNode: INode); virtual;
 end;//TatFoldersHelper

implementation

uses
 l3ImplUses
 , atGblAdapterWorker
 , SysUtils
 , atStringHelper
 , DocumentUnit
 , DynamicDocListUnit
 , SearchUnit
;

function TatFolderNodeMatcherBase.pm_GetFoldersNode: IFoldersNode;
//#UC START# *484D51CF004B_4843BEFE0153get_var*
//#UC END# *484D51CF004B_4843BEFE0153get_var*
begin
//#UC START# *484D51CF004B_4843BEFE0153get_impl*
 Result := f_FoldersNode;
//#UC END# *484D51CF004B_4843BEFE0153get_impl*
end;//TatFolderNodeMatcherBase.pm_GetFoldersNode

class function TatFolderNodeMatcherBase.Make: IatFoldersNodeMatcher;
var
 l_Inst : TatFolderNodeMatcherBase;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TatFolderNodeMatcherBase.Make

function TatFolderNodeMatcherBase.IsMatch(const aFoldersNode: IFoldersNode): Boolean;
//#UC START# *4843BEA80357_4843BEFE0153_var*
//#UC END# *4843BEA80357_4843BEFE0153_var*
begin
//#UC START# *4843BEA80357_4843BEFE0153_impl*
  f_FoldersNode := aFoldersNode;
  Result := CheckIsMatch;
//#UC END# *4843BEA80357_4843BEFE0153_impl*
end;//TatFolderNodeMatcherBase.IsMatch

procedure TatFolderNodeMatcherBase.ClearFields;
begin
 f_FoldersNode := nil;
 inherited;
end;//TatFolderNodeMatcherBase.ClearFields

function TatAnyMatcher.CheckIsMatch: Boolean;
//#UC START# *4843BF1B0059_4843C7450355_var*
//#UC END# *4843BF1B0059_4843C7450355_var*
begin
//#UC START# *4843BF1B0059_4843C7450355_impl*
  Result := true;
//#UC END# *4843BF1B0059_4843C7450355_impl*
end;//TatAnyMatcher.CheckIsMatch

function TatNameMatcher.Get_MatchMethod: TatMatchMethod;
//#UC START# *484D48AE03DD_484D485A0275get_var*
//#UC END# *484D48AE03DD_484D485A0275get_var*
begin
//#UC START# *484D48AE03DD_484D485A0275get_impl*
  Result := f_MatchMethod;
//#UC END# *484D48AE03DD_484D485A0275get_impl*
end;//TatNameMatcher.Get_MatchMethod

procedure TatNameMatcher.Set_MatchMethod(aValue: TatMatchMethod);
//#UC START# *484D48AE03DD_484D485A0275set_var*
//#UC END# *484D48AE03DD_484D485A0275set_var*
begin
//#UC START# *484D48AE03DD_484D485A0275set_impl*
  f_MatchMethod := aValue;
  if (f_MatchMethod = MM_REGEXP) AND (NOT Assigned(f_RegExp)) then
  begin
    f_RegExp := Tl3RegularSearch.Create;
    Assert(f_RegExp <> nil, 'f_RegExp <> nil');
    // переустанавливаем имя закладки
    Set_Name(f_Name);
  end;
//#UC END# *484D48AE03DD_484D485A0275set_impl*
end;//TatNameMatcher.Set_MatchMethod

function TatNameMatcher.Get_Name: AnsiString;
//#UC START# *484D490C02C3_484D485A0275get_var*
//#UC END# *484D490C02C3_484D485A0275get_var*
begin
//#UC START# *484D490C02C3_484D485A0275get_impl*
  Result := f_Name;
//#UC END# *484D490C02C3_484D485A0275get_impl*
end;//TatNameMatcher.Get_Name

procedure TatNameMatcher.Set_Name(const aValue: AnsiString);
//#UC START# *484D490C02C3_484D485A0275set_var*
//#UC END# *484D490C02C3_484D485A0275set_var*
begin
//#UC START# *484D490C02C3_484D485A0275set_impl*
  f_Name := aValue;
  if (f_MatchMethod = MM_REGEXP) then
    f_RegExp.SearchPattern := f_Name;
//#UC END# *484D490C02C3_484D485A0275set_impl*
end;//TatNameMatcher.Set_Name

procedure TatNameMatcher.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_484D485A0275_var*
//#UC END# *479731C50290_484D485A0275_var*
begin
//#UC START# *479731C50290_484D485A0275_impl*
  inherited;
  FreeAndNil(f_RegExp);
//#UC END# *479731C50290_484D485A0275_impl*
end;//TatNameMatcher.Cleanup

procedure TatNameMatcher.InitFields;
//#UC START# *47A042E100E2_484D485A0275_var*
//#UC END# *47A042E100E2_484D485A0275_var*
begin
//#UC START# *47A042E100E2_484D485A0275_impl*
  f_MatchMethod := MM_ALL;
  f_Name := '';
//#UC END# *47A042E100E2_484D485A0275_impl*
end;//TatNameMatcher.InitFields

function TatNameMatcher.CheckIsMatch: Boolean;
//#UC START# *4843BF1B0059_484D485A0275_var*
  var
    l_ObjectCaption : IString;
    l_Pos : Tl3MatchPosition;
//#UC END# *4843BF1B0059_484D485A0275_var*
begin
//#UC START# *4843BF1B0059_484D485A0275_impl*
  Result := false;
  if NOT (inherited CheckIsMatch) then
    Exit;
  // нам подходят любые ноды...
  if (f_MatchMethod = MM_ALL) then
  begin
    Result := true;
    Exit;
  end;
  // получаем имя объекта
  l_ObjectCaption := ObjectCaption;
  // и сравниваем с заданным
  case f_MatchMethod of
    MM_COMPARE  : Result := (l_ObjectCaption.GetData = f_Name);
    MM_REGEXP   : Result := f_RegExp.SearchInString(
      l_ObjectCaption.GetData, 0, l_ObjectCaption.GetLength, l_Pos, l_ObjectCaption.GetCodePage );
  end;
//#UC END# *4843BF1B0059_484D485A0275_impl*
end;//TatNameMatcher.CheckIsMatch

function TatFolderMatcher.pm_GetObjectCaption: IString;
//#UC START# *484D51FE0183_484D2643016Eget_var*
  var
    l_Object : IUnknown;
//#UC END# *484D51FE0183_484D2643016Eget_var*
begin
//#UC START# *484D51FE0183_484D2643016Eget_impl*
  FoldersNode.Open(l_Object);
  if (l_Object <> nil) then
    (l_Object as IFolder).GetName(Result)
  else
    Raise Exception.Create('Не могу получить папку из ноды!');
//#UC END# *484D51FE0183_484D2643016Eget_impl*
end;//TatFolderMatcher.pm_GetObjectCaption

function TatFolderMatcher.CheckIsMatch: Boolean;
//#UC START# *4843BF1B0059_484D2643016E_var*
//#UC END# *4843BF1B0059_484D2643016E_var*
begin
//#UC START# *4843BF1B0059_484D2643016E_impl*
  Result :=
    ( TFoldersItemType( FoldersNode.GetObjectType ) = FIT_FOLDER )
    AND ( inherited CheckIsMatch );
//#UC END# *4843BF1B0059_484D2643016E_impl*
end;//TatFolderMatcher.CheckIsMatch

function TatBookmarkMatcher.pm_GetObjectCaption: IString;
//#UC START# *484D51FE0183_4843C0AE03D4get_var*
  var
    l_Object : IUnknown;
//#UC END# *484D51FE0183_4843C0AE03D4get_var*
begin
//#UC START# *484D51FE0183_4843C0AE03D4get_impl*
  FoldersNode.Open(l_Object);
  if (l_Object <> nil) then
    (l_Object as IBookmark).GetName(Result)
  else
    Raise Exception.Create('Не могу получить закладку из ноды!');
//#UC END# *484D51FE0183_4843C0AE03D4get_impl*
end;//TatBookmarkMatcher.pm_GetObjectCaption

function TatBookmarkMatcher.CheckIsMatch: Boolean;
//#UC START# *4843BF1B0059_4843C0AE03D4_var*
//#UC END# *4843BF1B0059_4843C0AE03D4_var*
begin
//#UC START# *4843BF1B0059_4843C0AE03D4_impl*
  Result :=
    ( TFoldersItemType( FoldersNode.GetObjectType ) = FIT_BOOKMARK )
    AND ( inherited CheckIsMatch );
//#UC END# *4843BF1B0059_4843C0AE03D4_impl*
end;//TatBookmarkMatcher.CheckIsMatch

function TatListMatcher.pm_GetObjectCaption: IString;
//#UC START# *484D51FE0183_484FE8AF001Eget_var*
  var
    l_Object : IUnknown;
//#UC END# *484D51FE0183_484FE8AF001Eget_var*
begin
//#UC START# *484D51FE0183_484FE8AF001Eget_impl*
  FoldersNode.Open(l_Object);
  if (l_Object <> nil) then
    (l_Object as IDynList).GetName(Result)
  else
    Raise Exception.Create('Не могу получить список из ноды!');
//#UC END# *484D51FE0183_484FE8AF001Eget_impl*
end;//TatListMatcher.pm_GetObjectCaption

function TatListMatcher.CheckIsMatch: Boolean;
//#UC START# *4843BF1B0059_484FE8AF001E_var*
//#UC END# *4843BF1B0059_484FE8AF001E_var*
begin
//#UC START# *4843BF1B0059_484FE8AF001E_impl*
  Result :=
    ( TFoldersItemType( FoldersNode.GetObjectType ) = FIT_LIST )
    AND ( inherited CheckIsMatch );
//#UC END# *4843BF1B0059_484FE8AF001E_impl*
end;//TatListMatcher.CheckIsMatch

function TatQueryMatcher.pm_GetObjectCaption: IString;
//#UC START# *484D51FE0183_4FD2376601E4get_var*
  var
    l_Object : IUnknown;
//#UC END# *484D51FE0183_4FD2376601E4get_var*
begin
//#UC START# *484D51FE0183_4FD2376601E4get_impl*
  FoldersNode.Open(l_Object);
  if (l_Object <> nil) then
    (l_Object as IDynList).GetName(Result)
  else
    Raise Exception.Create('Не могу получить запрос из ноды!');
//#UC END# *484D51FE0183_4FD2376601E4get_impl*
end;//TatQueryMatcher.pm_GetObjectCaption

function TatQueryMatcher.CheckIsMatch: Boolean;
//#UC START# *4843BF1B0059_4FD2376601E4_var*
//#UC END# *4843BF1B0059_4FD2376601E4_var*
begin
//#UC START# *4843BF1B0059_4FD2376601E4_impl*
  Result :=
    ( TFoldersItemType( FoldersNode.GetObjectType ) = FIT_QUERY )
    AND ( inherited CheckIsMatch );
//#UC END# *4843BF1B0059_4FD2376601E4_impl*
end;//TatQueryMatcher.CheckIsMatch

class function TatFoldersHelper.GetMyDocuments(const folders: IFolders = nil): IFoldersNode;
//#UC START# *4808645502A6_480864400141_var*
  var
    root : INode;
//#UC END# *4808645502A6_480864400141_var*
begin
//#UC START# *4808645502A6_480864400141_impl*
  if (folders = nil) then
    TatGblAdapterWorker.Instance.Folders.GetRoot(root)
  else
    folders.GetRoot(root);
  root.GetChild(0, Result);
  Assert(Result <> nil, 'Result <> nil');
//#UC END# *4808645502A6_480864400141_impl*
end;//TatFoldersHelper.GetMyDocuments

class function TatFoldersHelper.IterateAllChildFoldersNode(const aRootNode: IFoldersNode;
 const aFoldersNodeCallback: IatFoldersNodeCallback;
 const aMatcher: IatFoldersNodeMatcher = nil;
 isRecursive: Boolean = True): Integer;
 {* Проходит по элементам в папках. Соответствует ли элемент - определяется путем вызова метода IsMatch на IatFoldersNodeMatcher.
Возвращает количество просмотренных элементов. }
//#UC START# *4843C7000113_480864400141_var*
  var
    l_CurrNode : IFoldersNode;
    i : Integer;
//#UC END# *4843C7000113_480864400141_var*
begin
//#UC START# *4843C7000113_480864400141_impl*
  Result := 0;
  Assert(aRootNode <> nil, 'aRootNode <> nil');
  //
  for i := aRootNode.GetChildCount-1 downto 0 do
  begin
    aRootNode.GetChild(i, l_CurrNode);
    Assert(l_CurrNode <> nil, 'l_CurrNode <> nil');
    if (aMatcher = nil) OR aMatcher.IsMatch(l_CurrNode) then
    begin
      aFoldersNodeCallback.OnFoldersNode(l_CurrNode);
      Inc(Result);
    end
    else if isRecursive AND (TFoldersItemType(l_CurrNode.GetObjectType) = FIT_FOLDER) then
      Result := Result + IterateAllChildFoldersNode(l_CurrNode, aFoldersNodeCallback, aMatcher, isRecursive)
  end; // for
//#UC END# *4843C7000113_480864400141_impl*
end;//TatFoldersHelper.IterateAllChildFoldersNode

class procedure TatFoldersHelper.AddToMyDocuments(const anEntity: IEntityBase;
 out theAddedNode: INode);
//#UC START# *4843E40A01DE_480864400141_var*
  var
    l_MyDocs : IFoldersNode;
//#UC END# *4843E40A01DE_480864400141_var*
begin
//#UC START# *4843E40A01DE_480864400141_impl*
  Assert(anEntity <> nil, 'anEntity <> nil');
  l_MyDocs := GetMyDocuments;
  AddToFolder(l_MyDocs, anEntity, theAddedNode);
  Assert(theAddedNode <> nil, 'theAddedNode <> nil');
//#UC END# *4843E40A01DE_480864400141_impl*
end;//TatFoldersHelper.AddToMyDocuments

class procedure TatFoldersHelper.CreateFolder(const aRootNode: IFoldersNode;
 const aName: AnsiString;
 const aComment: AnsiString;
 out theAddedNode: INode);
 {* Добавляет к указанной ноде дочернюю папку. }
//#UC START# *48468B1302AF_480864400141_var*
  var
    l_Folder : IFolder;
    l_ItemType : TFoldersItemType;

  function FIT2Str(aItemType : TFoldersItemType) : String;
  begin
    case aItemType of
      FIT_BOOKMARK        : Result := 'FIT_BOOKMARK';
      FIT_LIST            : Result := 'FIT_LIST';
      FIT_QUERY           : Result := 'FIT_QUERY';
      FIT_FOLDER          : Result := 'FIT_FOLDER';
      FIT_CONSULTATION    : Result := 'FIT_CONSULTATION';
      FIT_PHARM_LIST      : Result := 'FIT_PHARM_LIST';
      FIT_PHARM_BOOKMARK  : Result := 'FIT_PHARM_BOOKMARK';
    else
      Raise Exception.CreateFmt('Неизвестное значение aItemType (%d)!', [Ord(aItemType)]);
    end;
  end;
//#UC END# *48468B1302AF_480864400141_var*
begin
//#UC START# *48468B1302AF_480864400141_impl*
  Assert(aRootNode <> nil, 'aRootNode <> nil');
  Assert(aName <> '', 'aName <> ''''');
  // проверяем, что родительская нода является папкой
  l_ItemType := TFoldersItemType(aRootNode.GetObjectType);
  if (l_ItemType <> FIT_FOLDER) then
    Raise Exception.CreateFmt('Только папка может содержать дочерние папки! А нам передали объект типа %s.', [FIT2Str(l_ItemType)]);
  // создаем папку
  TatGblAdapterWorker.Instance.Folders.CreateFolder(l_Folder);
  Assert(l_Folder <> nil, 'l_Folder <> nil');
  // устанавливаем ее свойства
  l_Folder.SetName( TatStringHelper.DStr2AStr(aName) );
  l_Folder.SetComment( TatStringHelper.DStr2AStr(aComment) );
  // создаем ноду с папкой
  aRootNode.AddChildNode(l_Folder, theAddedNode);
  Assert(theAddedNode <> nil, 'theAddedNode <> nil');
//#UC END# *48468B1302AF_480864400141_impl*
end;//TatFoldersHelper.CreateFolder

class procedure TatFoldersHelper.AddToFolder(const aFolder: IFoldersNode;
 const anEntity: IEntityBase;
 out theAddedNode: INode);
//#UC START# *48562215003C_480864400141_var*
//#UC END# *48562215003C_480864400141_var*
begin
//#UC START# *48562215003C_480864400141_impl*
  Assert(aFolder <> nil, 'aFolder <> nil');
  Assert(anEntity <> nil, 'anEntity <> nil');
  //
  aFolder.AddChildNode(anEntity, theAddedNode);
  Assert(theAddedNode <> nil, 'theAddedNode <> nil');
//#UC END# *48562215003C_480864400141_impl*
end;//TatFoldersHelper.AddToFolder

end.
