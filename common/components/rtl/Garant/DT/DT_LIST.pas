Unit Dt_List;

{ $Id: DT_LIST.pas,v 1.27 2014/02/14 15:33:45 lulin Exp $ }

// $Log: DT_LIST.pas,v $
// Revision 1.27  2014/02/14 15:33:45  lulin
// - избавляемся от ошибок молодости.
//
// Revision 1.26  2007/11/26 09:37:10  voba
// - use  cUndefItem
//
// Revision 1.25  2007/09/14 15:11:35  voba
// - merge
//
// Revision 1.24  2007/08/14 20:25:14  lulin
// - bug fix: не собиралася Архивариус.
//
// Revision 1.23  2007/08/14 14:30:08  lulin
// - оптимизируем перемещение блоков памяти.
//
// Revision 1.22.4.2  2007/09/04 13:28:35  voba
// - add overload constructor Create
//
// Revision 1.22.4.1  2007/08/20 06:31:30  voba
// no message
//
// Revision 1.22  2007/06/28 11:16:25  voba
// - refact. убрал из function TAbstractList.GetItem второй параметр
//
// Revision 1.21  2007/03/26 09:34:03  fireton
// - изменился формат l3System.FreeLocalMem
//
// Revision 1.20  2007/03/09 07:33:26  voba
// - cc
// - _move function dtMakeRecListBySab to dt_Sab
//
// Revision 1.19  2006/11/17 15:25:03  voba
// - add function dtGetSabFieldSizeArray
// - add function dtMakeRecListBySab
//
// Revision 1.18  2005/01/11 11:07:22  step
// убрана ловушка в TAbstractList.GetItem
//
// Revision 1.17  2004/11/23 10:09:24  step
// изменен текст сообщения об ошибке
//
// Revision 1.16  2004/11/22 17:31:28  step
// поднимаем исключение при пустом fCurItemArr в методе TAbstractList.GetItem
//
// Revision 1.15  2004/11/15 12:14:00  step
// форматирование
//
// Revision 1.14  2004/09/21 12:04:20  lulin
// - Release заменил на Cleanup.
//
// Revision 1.13  2004/08/03 08:52:51  step
// замена dt_def.pas на DtDefine.inc
//
// Revision 1.12  2004/07/23 14:39:57  step
// избавились от парашютиста
//
// Revision 1.11  2004/03/10 15:34:13  voba
// -code clean
//
// Revision 1.10  2003/04/04 12:39:55  demon
// - new behavior: уменьшен буфер для чтения записей из выборок
// HyTech до (65k - 1)
//
// Revision 1.9  2003/03/31 13:48:59  demon
// - new: увеличен размер буферов, выделяемых по умолчанию с 64кб до 8Мб
//
// Revision 1.8  2003/03/12 12:09:41  demon
// - синтаксис fix
//
// Revision 1.7  2001/08/08 09:32:34  voba
// - new behavior: add checking of oppenning SAB
//
// Revision 1.6  2000/12/20 16:17:22  demon
// Remove some warnings (change LongInt to Cardinal type)
//
// Revision 1.5  2000/12/15 15:36:16  law
// - вставлены директивы Log.
//

{$I DtDefine.inc}

Interface
Uses
     l3Base, l3RecList,
     HT_Const, Dt_aTbl, Dt_Types;

Type
 TAbstractList = Class(Tl3Base)
  protected
   fMaxRecCount : LongWord;
   fCurList     : LPSAB;
   fMode        : TOpenMode;

   fCurItem     : Pointer;
   fCurItemArr  : Pointer;
   fFirstItem,
   fLastItem    : Cardinal;

   fItemSize    : Cardinal;

   fForvardOnly : Boolean;

   Procedure RestructBuffer(aItem : Cardinal);

   procedure InitSab;
   procedure DoneSab;
   procedure OpenSab;
   procedure CloseSab;

   procedure SetNewList(aList : LPSAB);
   procedure Cleanup; override;
   function  GetNumOfItems : LongInt;
  public
   constructor Create(aList : LPSAB; aMode : TOpenMode; aReadForvard : Boolean = false); Reintroduce;   overload;
   constructor Create(aList : LPSAB; aMode : TdtOpenMode; aReadForvard : Boolean = false); Reintroduce; overload;

   function    GetItem(aItem : Cardinal) : Pointer;

   function    AddItem(aAbsNum : Cardinal) : Cardinal;
    {* - возвращает номер вставленного элемента }
   function    DelItem(aItem : Cardinal) : Cardinal;
    {* - возвращает Abs номер удаленного элемента }

   property    CurList : LPSab read fCurList write SetNewList;
   property    Count : LongInt read GetNumOfItems;
   property    ReadForvard : Boolean read fForvardOnly write fForvardOnly;
   property    ItemSize : Cardinal read fItemSize;
 end;


implementation

uses
 HT_Dll, Dt_Const, Dt_err, SysUtils, l3MinMax;

const
 cUndefItem = High(Cardinal);
(**************************** TAbstractList ***************************************)

Constructor TAbstractList.Create(aList : LPSAB;aMode : TOpenMode; aReadForvard : Boolean = false);
begin
 Inherited Create;
 With fMode do
 Begin
  openMode:=aMode.openMode;
  Count:=aMode.Count;
  If Count<>0 then
  Begin
   l3System.GetLocalMem(FldArr,Count*SizeOf(SmallInt));
   l3Move(aMode.FldArr^,FldArr^,Count*SizeOf(SmallInt));
  end
  else
   FldArr:=Nil;
 end;
 fCurList:=aList;
 InitSab;
 fForvardOnly := aReadForvard;
end;

constructor TAbstractList.Create(aList : LPSAB; aMode : TdtOpenMode; aReadForvard : Boolean = false);
begin
 Inherited Create;
 With fMode do
 Begin
  openMode := aMode.rOpenMode;
  Count := Length(aMode.rFieldsArr);
  If Count<>0 then
  Begin
   l3System.GetLocalMem(FldArr, Count*SizeOf(SmallInt));
   l3Move(aMode.rFieldsArr[0], FldArr^, Count*SizeOf(SmallInt));
  end
  else
   FldArr:=Nil;
 end;
 fCurList:=aList;
 InitSab;
 fForvardOnly := aReadForvard;
end;

Procedure TAbstractList.Cleanup;
Begin
 DoneSab;
 l3System.FreeLocalMem(fMode.FldArr);
 Inherited;
end;

Procedure TAbstractList.InitSab;
Begin
 If (fCurList<>Nil) and
    (htResultsType(fCurList^)<>Res_NProc)
  then
   Begin
    if not htIsResultOpen(fCurList^) then
     Ht(htOpenResults(fCurList^,fMode.openMode,fMode.FldArr,fMode.Count));
    Ht(htResultsItemLen(fCurList^,fItemSize));
    fMaxRecCount:=l3MinMax.Max((MaxBuffSize div 128 - 1) div fItemSize,1);
    l3System.GetLocalMem(fCurItemArr,fItemSize*fMaxRecCount);
    l3System.GetLocalMem(fCurItem,fItemSize);
    l3FillChar(fCurItemArr^,fItemSize*fMaxRecCount);
    //fForvardOnly:=False;
    fFirstItem := cUndefItem;
   end;
end;

Procedure TAbstractList.DoneSab;
Begin
 If Assigned(fCurItemArr) then
  l3System.FreeLocalMem(fCurItemArr);
 If Assigned(fCurItem) then
  l3System.FreeLocalMem(fCurItem);
 If (fCurList<>Nil) and
    htIsResultOpen(fCurList^)
  then
   htCloseResults(fCurList^);
end;

Procedure TAbstractList.OpenSab;
Begin
 If (fCurList<>Nil) and
    (htResultsType(fCurList^)<>Res_NProc)
  then
   Begin
    Ht(htOpenResults(fCurList^,fMode.openMode,fMode.FldArr,fMode.Count));
    l3FillChar(fCurItemArr^,fItemSize*fMaxRecCount);
    //fForvardOnly:=False;
    fFirstItem := cUndefItem;
   end;
end;

Procedure TAbstractList.CloseSab;
Begin
 If (fCurList<>Nil) and
    htIsResultOpen(fCurList^)
  then
   htCloseResults(fCurList^);
end;

Procedure TAbstractList.SetNewList(aList : LPSAB);
Begin
 If aList = fCurList then
  Exit;

 If aList = Nil then
  DoneSab
 else
  CloseSab;

 If fCurList = Nil then
 begin
  fCurList := aList;
  InitSab;
 end
 else
 begin
  fCurList := aList;
  OpenSab;
 end;
end;

function TAbstractList.GetNumOfItems : LongInt;
begin
 if (fCurList=Nil) or (htResultsType(fCurList^)=Res_NProc) then
  Result := 0
 else
  Result := fCurList^.gFoundCnt;
end;

procedure TAbstractList.RestructBuffer(aItem : Cardinal);
var
 NewFirst,
 NewLast   : Cardinal;

 MoveSour,
 MoveDest,
 ReadPoint : Pointer;
 MoveSize,
 ReadSize  : Word;
 SeekItem,
 HtRead    : Cardinal;
Begin
 ReadSize:=0;
 If fForvardOnly then
  NewFirst:=l3MinMax.CardinalDec(aItem,1)
 else
  NewFirst:=l3MinMax.CardinalDec(aItem,(fMaxRecCount div 2));

 NewLast:=NewFirst+fMaxRecCount-1;
 if NewLast >= Cardinal(fCurList^.gFoundCnt) then
 begin
  NewLast:=l3MinMax.CardinalDec(fCurList^.gFoundCnt,1);
  if NewFirst<>0 then
   NewFirst:=l3MinMax.CardinalDec(NewLast,fMaxRecCount-1);
 end;

  If (fFirstItem = cUndefItem) or
     (NewFirst >= fLastItem) or
     (NewLast <= fFirstItem)
   then
    Begin
     fFirstItem:=NewFirst;
     Ht(htSeekResults(fCurList^,fFirstItem,RSEEK_SET));
     HtRead:=Ht(htReadResults(fCurList^,fCurItemArr,fItemSize*fMaxRecCount));
     fLastItem:=fFirstItem+(HtRead div fItemSize)-1;
    end
   else
    Begin
     MoveSize:=0;
     MoveSour:=Nil;
     MoveDest:=Nil;
     ReadPoint:=Nil;
     SeekItem:=cUndefItem;
     If (NewFirst >= fFirstItem)
      then
       Begin
        MoveSour:=Pointer(Cardinal(fCurItemArr)+(NewFirst-fFirstItem)*fItemSize);
        MoveDest:=fCurItemArr;
        MoveSize:=(fLastItem-NewFirst+1)*fItemSize;
        ReadPoint:=Pointer(Cardinal(fCurItemArr)+(fLastItem-NewFirst+1)*fItemSize);
        ReadSize:=(NewLast-fLastItem)*fItemSize;
        SeekItem:=fLastItem+1;
       end;

     If (NewLast <= fLastItem)
      then
       Begin
        MoveSour:=fCurItemArr;
        MoveDest:=Pointer(Cardinal(fCurItemArr)+(fFirstItem-NewFirst)*fItemSize);
        MoveSize:=(NewLast-fFirstItem+1)*fItemSize;
        ReadPoint:=fCurItemArr;
        ReadSize:=(fFirstItem-NewFirst)*fItemSize;
        SeekItem:=NewFirst;
       end;

     If (MoveSize<>0) and (MoveSour<>Nil) and (MoveDest<>Nil)
      then
       l3Move(MoveSour^,MoveDest^,MoveSize);

     HtRead:=0;
     If (ReadSize<>0) and (ReadPoint<>Nil) and (SeekItem<>cUndefItem)
      then
       Begin
        Ht(htSeekResults(fCurList^,SeekItem,RSEEK_SET));
        HtRead:=Ht(htReadResults(fCurList^,ReadPoint,ReadSize));
       end;
     fFirstItem:=NewFirst;
     fLastItem:=fFirstItem+(MoveSize+HtRead) div fItemSize - 1;
    end;
end;

function TAbstractList.GetItem(aItem : Cardinal) : Pointer;
begin
 If (fCurList=Nil) or (htResultsType(fCurList^)=Res_NProc) then
  raise EHtErrors.CreateInt(ecSrchEmpty);

 If (aItem >= Cardinal(fCurList^.gFoundCnt)) then
 begin
  Result:=Nil;
  Exit;
 end;

 if (fFirstItem = cUndefItem) or
    Not ((aItem >= fFirstItem) and (aItem <= fLastItem)) then
  RestructBuffer(aItem);

 Result := Pointer(Cardinal(fCurItemArr)+(aItem-fFirstItem)*fItemSize);
end;

function TAbstractList.AddItem(aAbsNum : Cardinal) : Cardinal;
begin
 if (fCurList=nil) or (htResultsType(fCurList^)=Res_NProc) then
  raise EHtErrors.CreateInt(ecSrchEmpty);

 Ht(htIncludeResultsItem(fCurList^,aAbsNum,nil));
 Result:=htRecordOrdinalNumber(fCurList^,aAbsNum);
 fFirstItem:=cUndefItem;
end;

function TAbstractList.DelItem(aItem : Cardinal) : Cardinal;
begin
 if (fCurList=nil) or (htResultsType(fCurList^)=Res_NProc) then
  raise EHtErrors.CreateInt(ecSrchEmpty);
 Result:=0;
 if aItem>=Cardinal(fCurList^.gFoundCnt) then
  exit;
 Result:=Ht(htSeekResults(fCurList^,aItem,RSEEK_SET));
 Ht(htExcludeResultsItem(fCurList^,Result));
 fFirstItem:=cUndefItem;
end;

end.

