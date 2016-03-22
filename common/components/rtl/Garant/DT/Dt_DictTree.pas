unit Dt_DictTree;

{ $Id: Dt_DictTree.pas,v 1.31 2015/11/24 14:08:24 voba Exp $ }

// $Log: Dt_DictTree.pas,v $
// Revision 1.31  2015/11/24 14:08:24  voba
// -bf убрал конкурентную запись дерева словаря. Теперь дерево переписываем только при апдейте, в спокойной обстановке
//
// Revision 1.30  2014/02/14 15:33:45  lulin
// - избавляемся от ошибок молодости.
//
// Revision 1.29  2013/01/17 10:11:56  voba
// - перенес интерфейсы в отдельный модуль
//
// Revision 1.28  2013/01/16 09:37:32  voba
// no message
//
// Revision 1.27  2010/02/24 18:33:33  lulin
// - избавляемся от ненужного и вредного параметра, доставшегося в наследство от ошибок молодости.
//
// Revision 1.26  2009/10/14 11:08:23  voba
// - избавляемся от библиотеки mg
//
// Revision 1.25  2008/02/20 17:23:03  lulin
// - упрощаем строки.
//
// Revision 1.24  2008/02/12 12:53:17  lulin
// - избавляемся от излишнего метода на базовом классе.
//
// Revision 1.23  2008/02/01 16:41:34  lulin
// - используем кошерные потоки.
//
// Revision 1.22  2008/02/01 14:04:56  narry
// - правильная запись
//
// Revision 1.21  2007/12/26 14:10:35  lulin
// - модуль l3Interfaces полностью переведен на модель.
//
// Revision 1.20  2007/04/25 09:30:57  fireton
// - Рефакторинг DT. Все типы переехали в DT_Types, а константы - в DT_Const
//
// Revision 1.19  2007/01/09 10:36:51  voba
// - ren GetLevelForParent -> GetLevelFor
//
// Revision 1.18  2006/11/07 16:14:48  voba
// - cc
//
// Revision 1.17  2004/08/03 08:52:50  step
// замена dt_def.pas на DtDefine.inc
//
// Revision 1.16  2004/03/03 18:22:21  law
// - rename unit: l3Tree2 -> l3Tree.
//
// Revision 1.15  2003/03/31 13:48:59  demon
// - new: увеличен размер буферов, выделяемых по умолчанию с 64кб до 8Мб
//
// Revision 1.14  2003/02/11 10:04:38  voba
// - rename proc: l3NodeActionL2FA -> l3L2IA.
//
// Revision 1.13  2002/12/24 13:02:00  law
// - change: объединил Int64_Seek c основной веткой.
//
// Revision 1.12.4.1  2002/12/24 11:56:43  law
// - new behavior: используем 64-битный Seek вместо 32-битного.
//
// Revision 1.12  2002/04/02 12:17:22  demon
// - new behavior: add methods for copyTo and copyFrom JournaledDicts
//
// Revision 1.11  2002/03/13 15:42:35  demon
// - new behavior: add LoadEqualClassesToTree procedure
//
// Revision 1.10  2002/03/13 10:32:29  demon
// - new behavior: add IPersistentNode for saving only this type of nodes
//
// Revision 1.9  2002/03/12 17:01:58  demon
// - bug fix
//
// Revision 1.8  2000/12/15 15:36:16  law
// - вставлены директивы Log.
//

{$Include DtDefine.inc}

interface

uses
  SysUtils,
  Dt_Types,
  //MGExFStr,
  //MGBufStr,
  //mgLckStr,
  L3Base,
  l3Stream,
  l3Nodes,
  l3Tree_TLB,
  dt_DictIntf
  ;

const
 cHeaderSize = 9;
 cHeader  : array[1 .. cHeaderSize] of Char = 'Dict Tree';
 cVersion : Char = #01;
type
 TTreeOpenFlag = (tofLoad,tofSave,tofChange,tofClear);

 TTreeConstRec = packed record
                  Level : Byte;
                  ID    : LongInt;
                 end;

 PTreeJourRec = ^TTreeJourRec;
 TTreeJourRec = record
                 Operation   : TOperActionType;
                 ID,
                 ParentID,
                 NextID : LongInt;
                end;

 TTreeStrorage = class(Tl3Base)
  protected
   fLockSize     : LongInt;
   fCurOpenFlag  : TTreeOpenFlag;

   fConstName    : TFileName;
   fJourName     : TFileName;
   fDtFl         : Tl3FileStream;
   fJourFl       : Tl3FileStream;

   fChildNodeClass : Tl3NodeClass;

   fCurJourRec   : TTreeJourRec;

   function  IsTreeEmpty : Boolean;

   function  GetTmpJurName : TFileName;
   procedure InitStorage(aOpenFlag : TTreeOpenFlag);
   procedure DoneStorage;

   function  GetJourRec : Boolean;

   procedure PutConstRec(aItem : TTreeConstRec);
   function  GetConstRec(var aItem : TTreeConstRec) : Boolean;

   procedure ClearJour;
   procedure ClearData;

  public
   constructor Create(const aName : string); reintroduce;

   procedure Load(aParent : Il3Node);
   procedure Clear; virtual;
   procedure AddChangeRec(aOperation : TOperActionType;aID,aParentID,aNextID : LongInt);
   procedure CopyTo(aNewName : string);

   procedure Save(aParent : Il3Node; MaySaved : Tl3NodeAction = nil);
   // сохраяем из дерева в памяти в tre, убиваем trc

   property  IsEmpty : Boolean read IsTreeEmpty;
   property  ChildNodeClass : Tl3NodeClass read fChildNodeClass write fChildNodeClass;
 end;

// procedure ConvertFromOldTreeToNew(OldTreeFl,NewTreeFl : string);

 procedure UpdateTreeStuct(const aName : string);
  // Save перекладывает измененные из trc (журнал) в tre (постоянная), вызывается ТОЛЬКО во время ежедневного обновления
implementation

uses
  Classes,

  l3TreeInterfaces,
  l3Tree,
  l3FileUtils,

  DT_Const,
  //Dt_Dict,

  l3Types
  ;
(*
procedure ConvertFromOldTreeToNew(OldTreeFl,NewTreeFl : string);
type
 TOldTreeRec = Record
                Level : Byte;
                ID    : TDictID;
               end;
var
 oldFl,
 newFl   : TmgExFileStream;
 oldBuf,
 newBuf  : TmgBuffStream;

 oldRec  : TOldTreeRec;
 newRec  : TTreeConstRec;
begin
 oldFl:=TmgExFileStream.Create(OldTreeFl,l3_fmRead);
 oldBuf:=TmgBuffStream.Create(oldFl, MaxBuffSize);
 try
  newFl:=TmgExFileStream.Create(NewTreeFl,l3_fmWrite);
  newBuf:=TmgBuffStream.Create(newFl,MaxBuffSize);
  try
   while oldBuf.Read(oldRec,SizeOf(oldRec)) > 0 do
    begin
     newRec.ID:=oldRec.ID;
     newRec.Level:=oldRec.Level;
     newBuf.Write(newRec,SizeOf(newRec));
    end;
  finally
   l3Free(newBuf);
   l3Free(newFl);
  end;
 finally
  l3Free(oldBuf);
  l3Free(oldFl);
 end;
end;
*)
(*************************** TTreeStrorage *******************************)

constructor TTreeStrorage.Create(const aName : string);
begin
 if aName = '' then Abort;

 fLockSize := cHeaderSize + 1;

 fConstName := aName + '.Tre';
 if not FileExists(fConstName) then
 begin
  fDtFl := Tl3FileStream.Create(fConstName, l3_fmWrite);
  l3Free(fDtFl);
 end;

 fJourName := aName + '.Trc';
 if not FileExists(fJourName) then
 begin
  fJourFl := Tl3FileStream.Create(fJourName, l3_fmWrite);
  Try
   fJourFl.WriteBuffer(cVersion, 1);
   fJourFl.WriteBuffer(cHeader, cHeaderSize);
  finally
   l3Free(fJourFl);
  end;
 end;

 inherited Create;
 fChildNodeClass := Tl3UsualNode; //TDictLeafNode;
end;

function TTreeStrorage.IsTreeEmpty : Boolean;
begin
 Result := SizeOfFile(fConstName) = 0;
end;

function  TTreeStrorage.GetTmpJurName : TFileName;
begin
 Result :=fJourName+'$'
end;

procedure TTreeStrorage.InitStorage(aOpenFlag : TTreeOpenFlag);
begin
 fCurOpenFlag := aOpenFlag;

 //if fCurOpenFlag = tofSave then
 // fJourFl := Tl3FileStream.Create(GetTmpJurName, l3_fmExclusiveReadWrite)
 //else
  fJourFl := Tl3FileStream.Create(fJourName, l3_fmReadWrite);

 if not fJourFl.Lock(0, fLockSize) then
  raise Exception.Create(Format('Не удается захватить %s', [fJourName]));

 case fCurOpenFlag of
  tofLoad :
   begin
    fDtFl := Tl3FileStream.Create(fConstName, l3_fmRead);
    fJourFl.Seek(fLockSize, soBeginning);
   end;
  tofSave :
   fDtFl := Tl3FileStream.Create(fConstName, l3_fmWrite);

  tofChange :
   fJourFl.Seek(0, soEnd);

  tofClear :
   fDtFl := Tl3FileStream.Create(fConstName, l3_fmWrite);
 end;
end;

procedure TTreeStrorage.DoneStorage;
begin
 //if fCurOpenFlag = tofSave then
 // RenameFileSafe(GetTmpJurName, fJourName);
 fJourFl.Unlock(0, fLockSize);
 l3Free(fDtFl);
 l3Free(fJourFl);
end;

function TTreeStrorage.GetJourRec : Boolean;
var
 ReadSize : LongInt;
begin
 ReadSize := fJourFl.Read(fCurJourRec,SizeOf(fCurJourRec));
 Result := (ReadSize = SizeOf(fCurJourRec));
 if not Result and (ReadSize <> 0) then
  raise Exception.Create('Возможно нарушена структура файла изменений дерева!'#13+
                         'Свяжитесь с разработчиками.');
end;

procedure TTreeStrorage.PutConstRec(aItem : TTreeConstRec);
begin
 fDtFl.WriteBuffer(aItem,SizeOf(aItem));
end;

function TTreeStrorage.GetConstRec(var aItem : TTreeConstRec) : Boolean;
begin
 try
  fDtFl.ReadBuffer(aItem,SizeOf(aItem));
  Result := True;
 except
  Result := False;
 end;
end;

procedure TTreeStrorage.ClearJour;
begin
 fJourFl.Size := fLockSize;
end;

procedure TTreeStrorage.ClearData;
begin
 fDtFl.Size := 0;
end;

procedure TTreeStrorage.Load(aParent : Il3Node);
var
 ConstItem : TTreeConstRec;
 I,
 LastLevel : Integer;

 LastNode,
 NextNode,
 CurParent  : Il3Node;
 CurChild   : Tl3Node;

 TmpIndex   : LongInt;

 tmpTree    : Tl3Tree;
begin
 InitStorage(tofLoad);
 try
  CurParent:=aParent;
  LastNode:=aParent;
  LastLevel:=-1;
  while GetConstRec(ConstItem) do
  begin
   if ConstItem.Level <> LastLevel then
    if ConstItem.Level > LastLevel then
     CurParent:=LastNode
    else
     for I:=1 to (LastLevel-ConstItem.Level) do
     begin
      LastNode:=LastNode.ParentNode;
      CurParent:=LastNode.ParentNode;
     end;
   LastLevel:=ConstItem.Level;

   CurChild:=ChildNodeClass.Create;
   try
    CurChild.StringID := ConstItem.ID;
    LastNode := CurParent.InsertChild(CurChild);
   finally
    l3Free(CurChild);
   end;
  end;

  tmpTree:=Tl3Tree.Create;
  Try
   tmpTree.InsertNode(nil,aParent);
   While GetJourRec do
    Case fCurJourRec.Operation of
     atAdd :
      begin
       CurParent:=tmpTree.FindNodeByParam(aParent,fCurJourRec.ParentID,imParentNeed);
       if CurParent <> nil then
       begin
        CurChild := ChildNodeClass.Create;
        try
         CurChild.StringID := fCurJourRec.ID;
         if fCurJourRec.NextID <> 0 then
         begin
          NextNode := tmpTree.FindNodeByParam(aParent,fCurJourRec.NextID,0);
          if NextNode <> nil then
           CurParent.InsertChildBefore(NextNode, CurChild);
         end
         else
          LastNode := CurParent.InsertChild(CurChild);
        finally
         l3Free(CurChild);
        end;
       end;
      end;
     atDelete :
      begin
       LastNode:=tmpTree.FindNodeByParam(aParent,fCurJourRec.ID,0);
       if LastNode <> nil then
        LastNode.Remove;
       LastNode:=nil;
      end;
     atMove :
      begin
       LastNode:=tmpTree.FindNodeByParam(aParent,fCurJourRec.ID,0);
       if LastNode <> nil then
       begin
        LastNode.Remove;
        CurParent:=tmpTree.FindNodeByParam(aParent,fCurJourRec.ParentID,imParentNeed);
        if CurParent <> nil then
        begin
         if fCurJourRec.NextID <> 0 then
         begin
          NextNode:=tmpTree.FindNodeByParam(CurParent,fCurJourRec.NextID,0);
          if NextNode <> nil then
           CurParent.InsertChildBefore(NextNode,LastNode);
         end
         else
          CurParent.InsertChild(LastNode);
        end;
       end;
      end;
    end; // case
  finally
   l3Free(tmpTree);
  end;
 finally
  DoneStorage;
 end;
end;

procedure TTreeStrorage.Save(aParent : Il3Node; MaySaved : Tl3NodeAction);
Var
 lCurItem        : TTreeConstRec;
 lPersistentNode : IPersistentNode;

 function IterHandler(CurNode : Il3Node) : Boolean; far;
 begin
  if l3IOk(CurNode.QueryInterface(IPersistentNode, lPersistentNode)) and
     lPersistentNode.MaySaved and
     (not Assigned(MaySaved) or MaySaved(CurNode)) then
  begin
   with lCurItem do
   begin
    Level := CurNode.GetLevelFor(aParent);
    ID := (CurNode as Il3HandleNode).Handle;
   end;

   PutConstRec(lCurItem);
   lPersistentNode := nil;
  end;

  Result := False;
 end;

begin
 InitStorage(tofSave);
 try
  l3IterateSubTreeF(aParent,l3L2NA(@IterHandler),0);
  ClearJour;
 finally
  DoneStorage;
 end;
end;

procedure TTreeStrorage.Clear;
begin
 inherited;
 InitStorage(tofClear);
 try
  ClearJour;
  ClearData;
 finally
  DoneStorage;
 end;
end;

procedure TTreeStrorage.AddChangeRec(aOperation : TOperActionType;
                                     aID,aParentID,aNextID : LongInt);
begin
 InitStorage(tofChange);
 try
  with fCurJourRec do
   begin
    Operation := aOperation;
    ID := aID;
    ParentID := aParentID;
    NextID := aNextID;
   end;
  fJourFl.WriteBuffer(fCurJourRec, SizeOf(fCurJourRec));
 finally
  DoneStorage;
 end;
end;

procedure TTreeStrorage.CopyTo(aNewName : string);
begin
 CopyFile(fConstName,aNewName+'.Tre',cmNoBakCopy);
 CopyFile(fJourName,aNewName+'.Trc',cmNoBakCopy);
end;

(*************************************************************************)

Type
 TUpdPersistentNode = Class(Tl3UsualNode, IPersistentNode)
  // локально используется в UpdateTreeStuct
  function pn_CheckSaveStatus : boolean;
  procedure DeleteEx(aHeirID : TDictID = cUndefDictID; aDateDeleted: TDateTime = 0);
 end;

function TUpdPersistentNode.pn_CheckSaveStatus : boolean;
begin
 Result := True;
end;

procedure TUpdPersistentNode.DeleteEx(aHeirID : TDictID = cUndefDictID; aDateDeleted: TDateTime = 0);
begin
 // do nothing
end;

procedure UpdateTreeStuct(const aName : string);
var
 lTreeStg : TTreeStrorage;
 lRootNode : Tl3UsualNode;
 lJourName : TFileName;
begin
 lJourName := aName + '.Trc';
 if FileExists(lJourName) and (SizeOfFile(lJourName) > (cHeaderSize+1)) then
 begin
  lRootNode := TUpdPersistentNode.Create;
  try
   lTreeStg := TTreeStrorage.Create(aName);
   try
    lTreeStg.ChildNodeClass := TUpdPersistentNode;
    lTreeStg.Load(lRootNode);
    lTreeStg.Save(lRootNode);
   finally
    l3Free(lTreeStg);
   end;
  finally
   l3Free(lRootNode);
  end;
 end;

 // злобный хак
 SysUtils.DeleteFile(aName + '.del');
end;

end.
