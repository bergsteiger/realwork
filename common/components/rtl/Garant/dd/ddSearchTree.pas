unit ddSearchTree;

{ $Id: ddSearchTree.pas,v 1.4 2014/08/12 11:20:57 fireton Exp $ }

// $Log: ddSearchTree.pas,v $
// Revision 1.4  2014/08/12 11:20:57  fireton
// - выделяем функцию поиска одной строки
//
// Revision 1.3  2012/01/24 10:09:21  fireton
// - поиск префиксов слов с помощью поискового дерева
//
// Revision 1.2  2011/09/08 12:46:48  fireton
// - точка может быть частью слова. а может и не быть
// - искать надо без учёта регистра
//
// Revision 1.1  2011/09/08 08:26:47  fireton
// - посковое дерево, недокоммиченно было
//

interface
uses
 l3ProtoObject,
 l3Interfaces,
 l3SearchNode;

type
 TddFoundPosRec = record
  rStart  : Integer;
  rLength : Integer;
 end;

 TddSearchNodeAction      = procedure (aLeaf: Tl3SearchNode);

 TddProcessPrefixFunc     = function  (const aData: IUnknown): Boolean;
 {* - если возвращает true, то поиск заканчивается - нужный префикс найден}

type
 TddSearchTree = class(Tl3ProtoObject)
 private
  f_Root: Tl3SearchNode;
 protected
  procedure Cleanup; override;
  procedure IterateDataLeaves(anAction: TddSearchNodeAction);
 public
  constructor Create;
  procedure AddString(const aStr: Il3CString; aData: IUnknown);
  procedure IterateDataLeavesF(anAction: TddSearchNodeAction);
  procedure Clear;
  function HasData: Boolean;
  function SearchStr(const aStr: Tl3WString; out theData: IUnknown): Boolean;
  function SearchWords(const aStr: Tl3WString; out thePos: TddFoundPosRec; out theData: IUnknown): Boolean;
  function ScanPrefixes(const aStr: Tl3WString; aProcessPrefixFunc: TddProcessPrefixFunc): Boolean;
  function ScanPrefixesF(const aStr: Tl3WString; aProcessPrefixFunc: TddProcessPrefixFunc): Boolean;
 end;

function  ddL2SNA(Action: Pointer): TddSearchNodeAction;
procedure ddFreeSNA(var Stub: TddSearchNodeAction);

function  ddL2PPF(Action: Pointer): TddProcessPrefixFunc;
procedure ddFreePPF(var Stub: TddProcessPrefixFunc);

implementation
uses
 SysUtils,

 l3Base,
 l3SearchNodePrim,
 l3Types,
 l3String;

const
 cWordAdditionals: TCharSet = ['.']; 

function  ddL2SNA(Action: Pointer): TddSearchNodeAction;
  {-}
  register;
  {-}
asm
          jmp  l3LocalStub
end;{asm}

procedure ddFreeSNA(var Stub: TddSearchNodeAction);
  {-}
  register;
  {-}
asm
          jmp  l3FreeLocalStub
end;{asm}

function  ddL2PPF(Action: Pointer): TddProcessPrefixFunc;
  {-}
  register;
  {-}
asm
          jmp  l3LocalStub
end;{asm}

procedure ddFreePPF(var Stub: TddProcessPrefixFunc);
  {-}
  register;
  {-}
asm
          jmp  l3FreeLocalStub
end;{asm}

// функция сравнивает две строки и возвращает позицию, на которой эти строки начинают различаться
function CompareForSameBeginning(const S1, S2: Tl3WString): Integer;
var
 l_C1, l_C2: Tl3WString;
begin
 Result := 0;
 l_C1 := l3PCharLenPart(S1.S, 0, 1, S1.SCodePage);
 l_C2 := l3PCharLenPart(S2.S, 0, 1, S2.SCodePage);
 while (Result < S1.SLen) and (Result < S2.SLen) do
 begin
  if l3Compare(l_C1, l_C2, l3_siCaseUnsensitive) <> 0 then
   Break;
  Inc(Result);
  l_C1 := l3PCharLenPart(S1.S, Result, Result + 1, S1.SCodePage);
  l_C2 := l3PCharLenPart(S2.S, Result, Result + 1, S2.SCodePage);
 end;
end;

constructor TddSearchTree.Create;
begin
 inherited;
 f_Root := Tl3SearchNode.Create(nil, nil);
end;

procedure TddSearchTree.AddString(const aStr: Il3CString; aData: IUnknown);
var
 l_CurNode: Tl3SearchNode;

 procedure SearchOneLevel(const aRoot: Tl3SearchNode; const aStr: Il3CString);
 var
  I: Integer;
  l_NLen: Integer;
  l_Pos: Integer;
  l_SLen: Integer;
  l_Tail: Il3CString;
  l_CurNode: Tl3SearchNode;
  l_Found : Boolean;
  l_NN: Tl3SearchNode;
 begin
  l_Found := False;
  for I := 0 to aRoot.ChildrenCount - 1 do
  begin
   l_CurNode := aRoot.Children[I];
   if l3Same(aStr, l_CurNode.Text, True) then
   begin
    // такая строка уже включена в дерево = просто заменяем данные
    l_CurNode.Data := aData;
    l_Found := True;
    Break;
   end;
   l_Pos := CompareForSameBeginning(aStr.AsWStr, l_CurNode.Text.AsWStr);
   if l_Pos > 0 then // какая-то часть - совпадает!
   begin
    l_NLen := l_CurNode.Text.AsWStr.SLen;
    l_SLen := aStr.AsWStr.SLen;
    if (l_NLen > l_Pos) and (l_SLen > l_Pos) then
    begin
     // совпадает только часть каждой строки = ноду попилить пополам,
     // "хвостик" строки добавить как новую ноду дитём к существующей
     l_CurNode.Split(l_Pos);
     l_Tail := l3Copy(aStr, l_Pos);
     l_NN := Tl3SearchNode.Create(l_Tail, aData);
     try
      l_CurNode.AddChild(l_NN);
     finally
      FreeAndNil(l_NN);
     end;
    end
    else
     if (l_Pos = l_NLen) then
     begin
      // искомый текст длиннее текста ноды = ищем "хвостик" среди детей
      l_Tail := l3Copy(aStr, l_Pos);
      SearchOneLevel(l_CurNode, l_Tail);
     end
     else
     begin
      // текст ноды длиннее искомого текста (l_Pos = l_SLen) = пилим ноду пополам
      // и присваиваем данные текущему "огрызку"
      l_CurNode.Split(l_Pos);
      l_CurNode.Data := aData;
     end;
    l_Found := True;
    Break;
   end;
  end; // for...
  if not l_Found then // среди детей такого нет, добавляем новое дитё в корень
  begin
   l_NN := Tl3SearchNode.Create(aStr, aData);
   try
    aRoot.AddChild(l_NN);
   finally
    FreeAndNil(l_NN);
   end;
  end;
 end;

begin
 Assert(aData <> nil, 'TddSearchTree: нельзя добавлять пустые данные!');
 SearchOneLevel(f_Root, aStr);
end;

procedure TddSearchTree.Cleanup;
begin
 FreeAndNil(f_Root);
 inherited;
end;

procedure TddSearchTree.Clear;
begin
 f_Root.DropChildren;
end;

function TddSearchTree.HasData: Boolean;
begin
 Result := f_Root.ChildrenCount > 0;
end;

procedure TddSearchTree.IterateDataLeaves(anAction: TddSearchNodeAction);
 procedure DoOneLevel(aNode: Tl3SearchNode);
 var
  I: Integer;
 begin
  if (aNode <> f_Root) and (aNode.Data <> nil) then
   anAction(aNode);
  for I := 0 to aNode.ChildrenCount - 1 do
   try
    DoOneLevel(aNode.Children[I]);
   except
    DoOneLevel(aNode.Children[I]);
   end;
 end;
begin
 DoOneLevel(f_Root);
end;

procedure TddSearchTree.IterateDataLeavesF(anAction: TddSearchNodeAction);
begin
 try
  IterateDataLeaves(anAction);
 finally
  ddFreeSNA(anAction);
 end;
end;

function TddSearchTree.SearchStr(const aStr: Tl3WString; out theData: IUnknown): Boolean;

 function l_SearchAtOneLevel(const aRoot: Tl3SearchNode; const aStr: Tl3WString): Boolean;
 var
  I: Integer;
  l_CurNode: Tl3SearchNode;
  l_NStr, l_Tail: Tl3WString;
 begin
  Result := False;
  for I := 0 to aRoot.ChildrenCount - 1 do
  begin
   l_CurNode := aRoot.Children[I];
   l_NStr := l_CurNode.Text.AsWStr;
   if l3Starts(l_NStr, aStr, True) then
   begin
    if aStr.SLen = l_NStr.SLen then
    begin
     // полное совпадение = дошли до конца цепочки
     if l_CurNode.Data <> nil then
     begin
      Result := True;
      theData := l_CurNode.Data;
     end
     else
      Result := False;
    end
    else
    begin
     // неполное совпадение = надо поискать "хвостик" среди детей
     l_Tail := l3PCharLenPart(aStr.S, l_NStr.SLen, aStr.SLen, aStr.SCodePage);
     Result := l_SearchAtOneLevel(l_CurNode, l_Tail);
    end;
    Break;
   end;
  end;
 end;

begin
 Result := l_SearchAtOneLevel(f_Root, aStr);
end;

function TddSearchTree.SearchWords(const aStr: Tl3WString; out thePos: TddFoundPosRec; out theData: IUnknown): Boolean;
var
 l_IsFound: Boolean;

 function l_DoWord(const aWord: Tl3PCharLen; IsLast: Bool): Bool;
 var
  l_Word              : Tl3PCharLen;
  l_WithoutAdditionals: Boolean;
 begin
  l_Word := aWord;
  l_WithoutAdditionals := True;
  while True do
  begin
   if SearchStr(l_Word, theData) then
   begin
    Result := False;
    l_IsFound := True;
    thePos.rStart := l_Word.Diff(aStr);
    thePos.rLength := l_Word.SLen;
    Break;
   end
   else
    if l_WithoutAdditionals and
       ((l_Word.S[l_Word.SLen-1] in cWordAdditionals) or (l_Word.S[0] in cWordAdditionals)) then
    begin
     l_Word := l3Trim(l_Word, cWordAdditionals);
     l_WithoutAdditionals := False;
    end
    else
    begin
     Result := True;
     Break;
    end;
  end;
 end;

begin
 l_IsFound := False;
 l3ParseWordsF(aStr, l3L2WA(@l_DoWord), cWordAdditionals);
 Result := l_IsFound;
end;

function TddSearchTree.ScanPrefixes(const aStr: Tl3WString; aProcessPrefixFunc: TddProcessPrefixFunc): Boolean;

 function l_SearchAtOneLevel(const aRoot: Tl3SearchNode; const aStr: Tl3WString): Boolean;
 var
  I: Integer;
  l_CurNode: Tl3SearchNode;
  l_NStr, l_Tail: Tl3WString;
 begin
  Result := False;
  for I := 0 to aRoot.ChildrenCount - 1 do
  begin
   l_CurNode := aRoot.Children[I];
   l_NStr := l_CurNode.Text.AsWStr;
   if l3Starts(l_NStr, aStr, True) then
   begin
    if (aStr.SLen > l_NStr.SLen) and (l_CurNode.ChildrenCount > 0) then
    begin
     // неполное совпадение = надо поискать "хвостик" среди детей, возможно найдётся префикс подлиннее
     l_Tail := l3PCharLenPart(aStr.S, l_NStr.SLen, aStr.SLen, aStr.SCodePage);
     Result := l_SearchAtOneLevel(l_CurNode, l_Tail);
    end;
    if (not Result) and (l_CurNode.Data <> nil) then
     Result := aProcessPrefixFunc(l_CurNode.Data);
    Break;
   end;
  end;
 end;

begin
 Assert(Assigned(aProcessPrefixFunc));
 Result := l_SearchAtOneLevel(f_Root, aStr);
end;

function TddSearchTree.ScanPrefixesF(const aStr: Tl3WString; aProcessPrefixFunc: TddProcessPrefixFunc): Boolean;
begin
 try
  Result := ScanPrefixes(aStr, aProcessPrefixFunc);
 finally
  ddFreePPF(aProcessPrefixFunc);
 end;
end;

end.