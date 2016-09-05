unit dt_DictModifier;

interface
Uses
 SysUtils;

procedure gApplyDictModifyFile(aDMFileName : TFileName);

(*
�������� ��������� ���� ������������ �������:
(��. http://mdp.garant.ru/pages/viewpage.action?pageId=97354762)

��� ������� ��������� ������� ��������.

��������� ��������� �������

!! ������ ������� ������ ���� ������� ����������� ������� ��� �������� ������ ���� DMFile
Dict=<ID �������>

1) ������� ����� �� �������, ������� ��������� �������� � ���� ����������:

[DEL]
<��������� �����>

2) �������� ����� � �������:

[ADD]
<����� �����>

3) ������� ���� ����� �������, ������� ����� ����� (�����); �������� �� ���� ���������� ������ �������� �� ����� (�����) ��������(�):

[CHANGE]
<������ �����>
<����� �����>

4) ����������� ��� ����� "�������� - ������� �������" (Link) � ���������
[LINKCOPY]
<����� - ��������>
<����� - ��������>

5) ������� ��� ����� "�������� - ������� �������" (Link) � ���������
[LINKDEL]
<�����>
*)


implementation
uses
 daTypes,
 Dt_Types, Dt_Const,
 Dt_Dict, dt_Link,

 l3Types, l3Const, dt_AttrSchema,
 l3Base,
 l3String, l3Interfaces,
 l3Tree_TLB, l3TreeInterfaces, l3Nodes,
 l3Filer, dt_DictConst, dt_DictIntf, dt_LinkServ;

type
 TModifyOperation = (moUnknown, moAdd, moDel, moChange, moLinkCopy, moLinkDel);
const
 TModifyOperationStr : array[TModifyOperation] of AnsiString = ('', '[ADD]', '[DEL]', '[CHANGE]', '[LINKCOPY]', '[LINKDEL]');

 cParserError   = '������ ����� "%S".'#13#10'������ � ������ #%d : %s';
 cStrNotempty   = '������ �� ������';
 cUnknownOper   = '����������� ��������';
 cUnexpectedEOF = '����������� ����� �����';
 cWrongParam    = '�������� �� ����� ���� ������ ��� ���������� � "["';
 cUnExistParam  = '������� ������� �� ����������';
 cDictIDExpect  = '������ ������� ������ ���� ���������� �������';

procedure gApplyDictModifyFile(aDMFileName : TFileName);
 const
  cLevelSlash : AnsiString = '\';
  cDictIDStr : AnsiString = 'Dict=';
  cFamily : TdaFamilyID = 1;

 var
  lLevelSlashLength : integer;

  lDictServ : TDictionaryServer;
  lLinkServ  : TLinkServer;
  lDictID   : TdaDictionaryType;
  lRootNode : TDictRootNode;

  lCurFile  : TevDOSFiler;

  lStrCount : Integer;

 function lReadString : Tl3WString;
 begin
  Result := lCurFile.ReadLn;
  Result := l3Trim(Result);
(*  if Result.Len > 0 then
   Result.CodePage := CP_ANSI;*)
  Inc(lStrCount);
 end;

 function lGetOper(const aStr : Tl3WString) : TModifyOperation;
 var
  I : TModifyOperation;
 begin
  Result := moUnknown;
  //aStr.TrimAll;
  for I := moAdd to High(TModifyOperation) do
   if l3Same(aStr, l3PCharLen(TModifyOperationStr[I]), true) then
   begin
    Result := I;
    Exit;
   end;//l3Same(aStr.. 
  if Result = moUnknown then
   raise Exception.CreateFmt(cParserError, [aDMFileName, lStrCount, cUnknownOper]);
 end;

 procedure lReadEmpty;
 var
  lStr : Tl3WString;
 begin
  if not lCurFile.EOF then
  begin
   lStr := lReadString;

   if lStr.SLen > 0 then
    raise Exception.CreateFmt(cParserError, [aDMFileName, lStrCount, cStrNotempty]);
  end;
 end;

 function lReadParam : Il3CString;
 begin
  if lCurFile.EOF then
   raise Exception.CreateFmt(cParserError, [aDMFileName, lStrCount, cUnexpectedEOF]);

  Result := l3CStr(lReadString);
   Assert(false);

  if (l3IsNil(Result)) or l3IsChar(Result, 0, '[') then
   raise Exception.CreateFmt(cParserError, [aDMFileName, lStrCount, cWrongParam]);
 end;

 function lGetNodeID(const aNodeFullName : Il3CString) : Il3Node;
 begin
  Result := l3SearchByPath(lRootNode, aNodeFullName.AsWStr, cLevelSlash);
  if Result = nil then
   raise Exception.CreateFmt(cParserError, [aDMFileName, lStrCount, cUnExistParam]);
 end;

 function lAddtoDict(const aFullName : Il3CString) : Il3Node;
 var
  l_Node    : Il3Node;
  l_EndPos  : Integer;
  l_Name    : Tl3WString;
  l_Part    : Tl3WString;
 begin
  l_Name := aFullName.AsWStr;
  Result := l3GetPartPath(lRootNode, l_Name, cLevelSlash);
  if not l3IsNil(l_Name) then
  repeat
   l_EndPos := l3Pos(l_Name, l3PCharLen(cLevelSlash));
   if l_EndPos <> l3NotFound then
    l_Part := l3Copy(l_Name, 0, l_EndPos)
   else
    l_Part := l_Name;

   if not l3IsNil(l_Part) then
   begin
    Result := lDictServ.Dict[lDictID].AddDictNode(cUndefDictID, l_Part, l3PCharLen(cEmptyEngName), l3PCharLen, Result as Il3Node);
    if l_EndPos <> l3NotFound then
     l_Name := l3Copy(l_Name, l_EndPos + Length(cLevelSlash));
   end;
  until l_EndPos = l3NotFound;
 end;

 procedure lDelFromDict(const aDelStr : Il3CString; aNewID : TDictID = cUndefDictID);
 var
  lNode    : Il3Node;
  //lDelNode : Il3Node;
 begin
  lNode := lGetNodeID(aDelStr);

  (lNode as IPersistentNode).DeleteEx(aNewID);

  // ������� ��� ����� ���� ��� ��� ��������� ������� � �����
  (*
  begin
   lDelNode := lNode;
   lNode := lNode.ParentNode;
   (lDelNode as IPersistentNode).DeleteEx(aNewID);
   while lNode.ChildNode = nil do
   begin
    lDelNode := lNode;
    lNode := lNode.ParentNode;
    lDelNode.Delete;
   end;
  end;
  *)
 end;

 procedure lChangeDictItem(const aOldName, aNewName : Il3CString);
 var
  lNode    : Il3Node;
  lNewNode : Il3Node;
  lPos     : Integer;
  lOldPath : AnsiString;
  lOldName : AnsiString;
  lNewPath : AnsiString;
  lNewName : AnsiString;

  procedure SplitPathName(const aName : Tl3WString; var lPath : AnsiString; var lName : AnsiString);
  var
   lPos : Integer;
  begin
   lPos := l3StringRPos(PAnsiChar(cLevelSlash), aName.S, aName.SLen);
   if lPos = -1 then
   begin
    lPath := '';
    lName := l3GetStrPas(aName.S);
   end
   else
   begin
    lPath := l3GetStrPas(aName.S, lPos);
    lName := l3GetStrPas(aName.S + lPos + lLevelSlashLength, aName.SLen - lPos - lLevelSlashLength);
   end;
  end;

 begin
  lNode := lGetNodeID(aOldName);

  lNewNode := l3SearchByPath(lRootNode, aNewName.AsWStr, cLevelSlash);
  //���� aNewName ����������, �� ������� aOldName � ��������� ������ �� aNewName
  if lNewNode <> nil then
   (lNode as IPersistentNode).DeleteEx((lNewNode as IDictItem).Handle)
  else
  begin
   SplitPathName(aOldName.AsWStr, lOldPath, lOldName);
   SplitPathName(aNewName.AsWStr, lNewPath, lNewName);

   //���� � ����� �����
   if lNewPath = lNewPath then
    //������ �����������
    if lOldName <> lNewName then
     lDictServ.Dict[lDictID].EditDictItem((lNode as IDictItem).Handle, l3PCharLen(lNewName), l3PCharLen, l3PCharLen)
   else
   begin
    //������� �����
    lNewNode := lAddtoDict(aNewName);
    //� ������ ������ � ��������� ���������
    (lNode as IPersistentNode).DeleteEx((lNewNode as IDictItem).Handle);
   end;
  end;
 end;

 procedure lLinkCopy(const aSrcName, aDestName : Il3CString);
 var
  lSrcNode  : Il3Node;
  lDestNode : Il3Node;
 begin
  lSrcNode := lGetNodeID(aSrcName);
  lDestNode := lGetNodeID(aDestName);
 
  lLinkServ.CopyLinks(DLType2AttrID(lDictID), lnkDictIDFld, (lSrcNode as IDictItem).Handle, (lDestNode as IDictItem).Handle);
 end;

 procedure lLinkDel(const aNodeName : Il3CString);
 var
  lNode : Il3Node;
 begin
  lNode := lGetNodeID(aNodeName);
  lLinkServ.Links[lDictID].DelAllRecsByDictID((lNode as IDictItem).Handle);
 end;

 var
 lOper      : TModifyOperation;
 lParam1    : Il3CString;
 lParam2    : Il3CString;
 lStr      : Tl3WString;
 l_S       : Tl3String;

 begin
  lLevelSlashLength := Length(cLevelSlash);

  lCurFile:=TevDOSFiler.Make(aDMFileName);

  try
   lCurFile.Mode:=l3_fmRead;
   lCurFile.Open;
   lStrCount := 0;

   l_S := Tl3String.Make(lReadString);
   try
    l_S.CodePage := CP_ANSI;
    l_S.DeleteAllChars(' ');
    if l3AnsiStrLICompExt(l_S.St, PAnsiChar(cDictIDStr), Length(cDictIDStr)) = 0 then
     lDictID := TdaDictionaryType(StrToInt(l3GetStrPas(l_S.St + Length(cDictIDStr))))
    else
     raise Exception.CreateFmt(cParserError, [aDMFileName, lStrCount, cDictIDExpect]);
   finally
    FreeAndNil(l_S);
   end;//try..finally

   lDictServ := DictServer(cFamily); {TDictionaryServer.Create;}
   lRootNode := lDictServ.DictRootNode[lDictID];

   lLinkServ := LinkServer(cFamily);
   lLinkServ.Links[lDictID].table.StartCaching;
   try

    //Cnt:=0;
    while not lCurFile.EOF do
    begin
     lStr := lReadString;
     if lStr.SLen = 0 then Continue
     else
     begin
      lOper := lGetOper(lStr); // ������ ��������
      case lOper of
       moAdd :
        begin
         lParam1 := lReadParam;
         lAddtoDict(lParam1);
         lReadEmpty;
        end;
       moDel :
        begin
         lParam1 := lReadParam;
         lDelFromDict(lParam1);
         lReadEmpty;
        end;
       moChange :
        begin
         lParam1 := lReadParam;
         lParam2 := lReadParam;
         lChangeDictItem(lParam1, lParam2);
         lReadEmpty;
        end;
       moLinkCopy :
        begin
         lParam1 := lReadParam;
         lParam2 := lReadParam;
         lLinkCopy(lParam1, lParam2);
         lReadEmpty;
        end;
       moLinkDel :
        begin
         lParam1 := lReadParam;
         lLinkDel(lParam1);
         lReadEmpty;
        end;
      end;
     end; //case lOper of
    end; //while not lCurFile.EOF do
    //lRootNode.Save;
   finally
    lLinkServ.Links[lDictID].table.StopCaching;
   end;
  finally
   l3Free(lCurFile);
  end;
 end;
end.
