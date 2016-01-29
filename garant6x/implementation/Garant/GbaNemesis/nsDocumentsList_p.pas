unit nsDocumentsList_p;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "F1Test"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/nsDocumentsList_p.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestClass::Class>> F1 Базовые определения предметной области::F1Test::Tree::TnsDocumentsList
//
// Обёртка для работы со списком документов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

implementation

{$If not defined(XE)}
uses
  Classes
  {$If defined(Nemesis)}
  ,
  nscTreeView
  {$IfEnd} //Nemesis
  ,
  l3TreeInterfaces,
  TestDocListUtils,
  DynamicDocListUnit,
  DocumentUnit,
  MessageOnDesktop,
  TestStringUtils,
  SysUtils,
  Windows,
  Variants {a},
  ActiveX {a},
  tc5OpenAppClasses {a},
  tc5PublicInfo {a},
  tc6OpenAppClasses {a},
  tc6PublicInfo {a}
  ;
{$IfEnd} //not XE

// start class TnsDocumentsList

{$If not defined(XE)}
function TnsDocumentsList_Get_Position(Self: TnscTreeView): Longword;
//#UC START# *499C2F7C0251_499C264700BDget_var*
var
 l_ListEntry : IListEntryInfo;
//#UC END# *499C2F7C0251_499C264700BDget_var*
begin
 with Self do
 begin
//#UC START# *499C2F7C0251_499C264700BDget_impl*
  Result := High(Result);
  l_ListEntry := GetLEIFromTTV(Self);
  if (l_ListEntry <> nil) then
   Result := l_ListEntry.GetPosition;
//#UC END# *499C2F7C0251_499C264700BDget_impl*
 end;//with Self
end;//TnsDocumentsList_Get_Position
{$IfEnd} //not XE

{$If not defined(XE)}
function TnsDocumentsList_Get_PositionType(Self: TnscTreeView): AnsiString;
//#UC START# *499C32550095_499C264700BDget_var*
var
 l_ListEntry : IListEntryInfo;
//#UC END# *499C32550095_499C264700BDget_var*
begin
 with Self do
 begin
//#UC START# *499C32550095_499C264700BDget_impl*
  Result := '';
  l_ListEntry := GetLEIFromTTV(Self);
  if (l_ListEntry <> nil) then
   case l_ListEntry.GetType of
    PT_SUB      : Result := 'PT_SUB';
    PT_PARA     : Result := 'PT_PARA';
    PT_BOOKMARK : Result := 'PT_BOOKMARK';
   end;//case l_ListEntry.GetType
//#UC END# *499C32550095_499C264700BDget_impl*
 end;//with Self
end;//TnsDocumentsList_Get_PositionType
{$IfEnd} //not XE

{$If not defined(XE)}
function TnsDocumentsList_Get_Relevance(Self: TnscTreeView): SmallInt;
//#UC START# *499C34860092_499C264700BDget_var*
var
 l_ListEntry : IListEntryInfo;
//#UC END# *499C34860092_499C264700BDget_var*
begin
 with Self do
 begin
//#UC START# *499C34860092_499C264700BDget_impl*
  Result := High(Result);
  l_ListEntry := GetLEIFromTTV(Self);
  if (l_ListEntry <> nil) then
   Result := l_ListEntry.GetRelevance;
//#UC END# *499C34860092_499C264700BDget_impl*
 end;//with Self
end;//TnsDocumentsList_Get_Relevance
{$IfEnd} //not XE

{$If not defined(XE)}
function TnsDocumentsList_Get_DocNumber(Self: TnscTreeView): Cardinal;
//#UC START# *499C369D02F6_499C264700BDget_var*
var
 l_ListEntry : IListEntryInfo;
 l_Document : IDocument;
//#UC END# *499C369D02F6_499C264700BDget_var*
begin
 with Self do
 begin
//#UC START# *499C369D02F6_499C264700BDget_impl*
  Result := High(Result);
  l_ListEntry := GetLEIFromTTV(Self);
  if (l_ListEntry <> nil) then
  begin
   l_ListEntry.GetDoc(l_Document);
   Result := l_Document.GetInternalId;
  end;//l_ListEntry <> nil
//#UC END# *499C369D02F6_499C264700BDget_impl*
 end;//with Self
end;//TnsDocumentsList_Get_DocNumber
{$IfEnd} //not XE

{$If not defined(XE)}
function TnsDocumentsList_GetSubID(Self: TnscTreeView): Integer;
//#UC START# *499C444C01B8_499C264700BD_var*
var
 l_ListEntry : IListEntryInfo;
 l_Document : IDocument;
//#UC END# *499C444C01B8_499C264700BD_var*
begin
 with Self do
 begin
//#UC START# *499C444C01B8_499C264700BD_impl*
  Result := -1;
  l_ListEntry := GetLEIFromTTV(Self);
  if (l_ListEntry <> nil) then
  begin
   l_ListEntry.GetDoc(l_Document);
   if (l_Document <> nil) then
   begin
    // получаем номер саба
    if (l_ListEntry.GetType = PT_PARA) then
     Result := GetSubIDByParaID( l_Document, l_ListEntry.GetPosition )
    else
    if (l_ListEntry.GetType = PT_SUB) then
     Result := l_ListEntry.GetPosition;
   end; // if
  end; // if
//#UC END# *499C444C01B8_499C264700BD_impl*
 end;//with Self
end;//TnsDocumentsList_GetSubID
{$IfEnd} //not XE

{$If not defined(XE)}
function TnsDocumentsList_NodeIndexByDocNumber(Self: TnscTreeView; const DocNumbers: AnsiString;
  MaxDocsToCheck: Integer;
  IsDrawDbgInfo: Boolean): AnsiString;
//#UC START# *499C49B50383_499C264700BD_var*
var
  l_CurrNode : Il3SimpleNode;
  l_ListEntry : IListEntryInfo;
  l_Document : IDocument;

  currDocNumber, nodesProcessed : Cardinal;
  msgOnDesktop : TMessageOnDesktop;
  startTime: Cardinal;
  inStrList : TStringList;
  l_docNumbers : array of Cardinal;
  i, j, lowDocNumbers, highDocNumbers : Integer;
  isLastNode : Boolean;
//#UC END# *499C49B50383_499C264700BD_var*
begin
 with Self do
 begin
//#UC START# *499C49B50383_499C264700BD_impl*
  try
    Result := '';
    if (DocNumbers = '') then Exit;
    // разбиваем в список строк
    inStrList := TStringList.Create;
    Split(';', DocNumbers, inStrList);
    // конвертируем массив строк в массив номеров документов
    j := 0;
    for i := 0 to inStrList.Count-1 do
      if (inStrList[i] <> '') then // а то мало ли какая фигня попадется...
      begin
        SetLength(l_docNumbers, j+1);
        l_docNumbers[j] := StrToInt64(inStrList[i]);
        Inc(j);
      end;
    FreeAndNil(inStrList);
    // готовимся к переборке списка
    nodesProcessed := 0;
    startTime := GetTickCount;
    msgOnDesktop := TMessageOnDesktop.Create;
    lowDocNumbers := Low(l_docNumbers);
    highDocNumbers := High(l_docNumbers);
    //
    l_CurrNode := GetNode(0);
    // перебираем, если есть что
    if (l_CurrNode <> nil) then
      while (true) do
      begin
        // получаем IListEntryInfo
        l_ListEntry := GetLEIFromNode(l_CurrNode);
        if NOT (l_ListEntry <> nil) then
          break; // ошибка
        // получаем номер документа
        l_ListEntry.GetDoc(l_Document);
        currDocNumber := l_Document.GetInternalId;

        // проверяем, а не является ли номер документа нужным нам
        for i := lowDocNumbers to highDocNumbers do
          if (currDocNumber = l_docNumbers[i]) then
          begin // является
            // добавляем в ответ в формате номер_документа:индекс_ноды
            Result := Result + IntToStr(currDocNumber) + ':' + IntToStr(l_CurrNode.IndexInParent) + ';';
            // урезаем массив, чтобы быстрее искалось
            for j := i to highDocNumbers-1 do
              l_docNumbers[j] := l_docNumbers[j+1];
            SetLength(l_docNumbers, Length(l_docNumbers)-1);
            //
            lowDocNumbers := Low(l_docNumbers);
            highDocNumbers := High(l_docNumbers);
            break;
          end;
        if (highDocNumbers = -1) then
          break; // массив с номерами документов кончился, искать больше нечего

        isLastNode := l_CurrNode.IsLast;

        // рисуем информацию о ходе поиска
        Inc(nodesProcessed);
        if (isDrawDbgInfo AND ( ( (nodesProcessed mod 64) = 0) OR isLastNode)) then
          msgOnDesktop.DrawMessage('Обработано нод: ' + IntToStr(nodesProcessed) + '; скорость: ' + IntToStr(1000*nodesProcessed div (GetTickCount - startTime + 1)) + ' нод/сек.');

        if (NOT isLastNode) AND (nodesProcessed < maxDocsToCheck) then
          l_CurrNode := l_CurrNode.Next
        else
          break; // список документов закончился
      end;
  finally
    FreeAndNil(msgOnDesktop);
    FreeAndNil(inStrList);
  end;
//#UC END# *499C49B50383_499C264700BD_impl*
 end;//with Self
end;//TnsDocumentsList_NodeIndexByDocNumber
{$IfEnd} //not XE

{$If not defined(XE)}
procedure TnsDocumentsList_GoToNodeByIndex(Self: TnscTreeView; NodeIndex: Integer);
//#UC START# *499C5013009E_499C264700BD_var*
//#UC END# *499C5013009E_499C264700BD_var*
begin
 with Self do
 begin
//#UC START# *499C5013009E_499C264700BD_impl*
  GotoOnNode(GetNode(NodeIndex));
//#UC END# *499C5013009E_499C264700BD_impl*
 end;//with Self
end;//TnsDocumentsList_GoToNodeByIndex
{$IfEnd} //not XE

procedure TnsDocumentsList_Get_Position_Pub5(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TnscTreeView);
 try
  Value := (TnsDocumentsList_Get_Position(TnscTreeView(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TnsDocumentsList_Get_Position_Pub6(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TnscTreeView);
 try
  Value := (TnsDocumentsList_Get_Position(TnscTreeView(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TnsDocumentsList_Get_PositionType_Pub5(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TnscTreeView);
 try
  Value := (TnsDocumentsList_Get_PositionType(TnscTreeView(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TnsDocumentsList_Get_PositionType_Pub6(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TnscTreeView);
 try
  Value := (TnsDocumentsList_Get_PositionType(TnscTreeView(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TnsDocumentsList_Get_Relevance_Pub5(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TnscTreeView);
 try
  Value := (TnsDocumentsList_Get_Relevance(TnscTreeView(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TnsDocumentsList_Get_Relevance_Pub6(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TnscTreeView);
 try
  Value := (TnsDocumentsList_Get_Relevance(TnscTreeView(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TnsDocumentsList_Get_DocNumber_Pub5(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TnscTreeView);
 try
  Value := (TnsDocumentsList_Get_DocNumber(TnscTreeView(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TnsDocumentsList_Get_DocNumber_Pub6(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TnscTreeView);
 try
  Value := (TnsDocumentsList_Get_DocNumber(TnscTreeView(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TnsDocumentsList_GetSubID_Pub5(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TnscTreeView);
 try
  Value := (TnsDocumentsList_GetSubID(TnscTreeView(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TnsDocumentsList_GetSubID_Pub6(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TnscTreeView);
 try
  Value := (TnsDocumentsList_GetSubID(TnscTreeView(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TnsDocumentsList_NodeIndexByDocNumber_Pub5(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TnscTreeView);
 try
  Value := (TnsDocumentsList_NodeIndexByDocNumber(TnscTreeView(Instance), __coerce_String(Args^[2]), OleVariant(Args^[1]), OleVariant(Args^[0])));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TnsDocumentsList_NodeIndexByDocNumber_Pub6(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TnscTreeView);
 try
  Value := (TnsDocumentsList_NodeIndexByDocNumber(TnscTreeView(Instance), __coerce_String(Args^[2]), OleVariant(Args^[1]), OleVariant(Args^[0])));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TnsDocumentsList_GoToNodeByIndex_Pub5(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TnscTreeView);
 try
  (TnsDocumentsList_GoToNodeByIndex(TnscTreeView(Instance), OleVariant(Args^[0])));
 except
  // - гасим исключения
 end;//try..except
end;

procedure TnsDocumentsList_GoToNodeByIndex_Pub6(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TnscTreeView);
 try
  (TnsDocumentsList_GoToNodeByIndex(TnscTreeView(Instance), OleVariant(Args^[0])));
 except
  // - гасим исключения
 end;//try..except
end;

procedure _RegisterPublicInformation5;
begin
 tc5PublicInfo._RegisterMethod(TnscTreeView, tc5OpenAppClasses.mtGet, 'Position', TypeInfo(Longword), [], [], TnsDocumentsList_Get_Position_Pub5);
 tc5PublicInfo._RegisterMethod(TnscTreeView, tc5OpenAppClasses.mtGet, 'PositionType', TypeInfo(AnsiString), [], [], TnsDocumentsList_Get_PositionType_Pub5);
 tc5PublicInfo._RegisterMethod(TnscTreeView, tc5OpenAppClasses.mtGet, 'Relevance', TypeInfo(SmallInt), [], [], TnsDocumentsList_Get_Relevance_Pub5);
 tc5PublicInfo._RegisterMethod(TnscTreeView, tc5OpenAppClasses.mtGet, 'DocNumber', TypeInfo(Cardinal), [], [], TnsDocumentsList_Get_DocNumber_Pub5);
 tc5PublicInfo._RegisterMethod(TnscTreeView, tc5OpenAppClasses.mtInvoke, 'GetSubID', TypeInfo(Integer), [], [], TnsDocumentsList_GetSubID_Pub5);
 tc5PublicInfo._RegisterMethod(TnscTreeView, tc5OpenAppClasses.mtInvoke, 'NodeIndexByDocNumber', TypeInfo(AnsiString), [TypeInfo(AnsiString), TypeInfo(Integer), TypeInfo(Boolean)], ['DocNumbers', 'MaxDocsToCheck', 'IsDrawDbgInfo'], TnsDocumentsList_NodeIndexByDocNumber_Pub5);
 tc5PublicInfo._RegisterMethod(TnscTreeView, tc5OpenAppClasses.mtInvoke, 'GoToNodeByIndex', nil, [TypeInfo(Integer)], ['NodeIndex'], TnsDocumentsList_GoToNodeByIndex_Pub5);
end;

procedure _RegisterPublicInformation6;
begin
 tc6PublicInfo._RegisterMethod(TnscTreeView, tc6OpenAppClasses.mtGet, 'Position', TypeInfo(Longword), [], [], TnsDocumentsList_Get_Position_Pub6);
 tc6PublicInfo._RegisterMethod(TnscTreeView, tc6OpenAppClasses.mtGet, 'PositionType', TypeInfo(AnsiString), [], [], TnsDocumentsList_Get_PositionType_Pub6);
 tc6PublicInfo._RegisterMethod(TnscTreeView, tc6OpenAppClasses.mtGet, 'Relevance', TypeInfo(SmallInt), [], [], TnsDocumentsList_Get_Relevance_Pub6);
 tc6PublicInfo._RegisterMethod(TnscTreeView, tc6OpenAppClasses.mtGet, 'DocNumber', TypeInfo(Cardinal), [], [], TnsDocumentsList_Get_DocNumber_Pub6);
 tc6PublicInfo._RegisterMethod(TnscTreeView, tc6OpenAppClasses.mtInvoke, 'GetSubID', TypeInfo(Integer), [], [], TnsDocumentsList_GetSubID_Pub6);
 tc6PublicInfo._RegisterMethod(TnscTreeView, tc6OpenAppClasses.mtInvoke, 'NodeIndexByDocNumber', TypeInfo(AnsiString), [TypeInfo(AnsiString), TypeInfo(Integer), TypeInfo(Boolean)], ['DocNumbers', 'MaxDocsToCheck', 'IsDrawDbgInfo'], TnsDocumentsList_NodeIndexByDocNumber_Pub6);
 tc6PublicInfo._RegisterMethod(TnscTreeView, tc6OpenAppClasses.mtInvoke, 'GoToNodeByIndex', nil, [TypeInfo(Integer)], ['NodeIndex'], TnsDocumentsList_GoToNodeByIndex_Pub6);
end;

initialization
  _RegisterPublicInformation5;
  _RegisterPublicInformation6;

end.