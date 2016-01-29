{*********************************************************}
{*                   TASSIGN.DPR 1.05                    *}
{*                     Test Program                      *}
{*   Copyright (c) TurboPower Software Co., 1996, 1998   *}
{*                 All rights reserved.                  *}
{*********************************************************}

program TAssign;
  {-Test assign methods for SysTools containers}

{$IFDEF Win32}
  {$APPTYPE CONSOLE}
{$ENDIF}

uses
  SysUtils,
  TstUtil,
  StBase,
  StList,
  StTree,
  StColl,
  StLArr,
  StVArr;

const
  ItemsCount = 10;

type
  PMyRec = ^TMyRec;
  TMyRec = record
    I  : integer;
    St : string[23];
  end;

procedure MyDisposeData(Data : pointer); far;
  begin
    Dispose(PMyRec(Data));
  end;

function MyCompareData(Data1, Data2 : pointer) : integer; far;
  begin
    Result := PMyRec(Data1)^.I - PMyRec(Data2)^.I;
    if (Result = 0) then
      Result := CompareStr(PMyRec(Data1)^.St, PMyRec(Data2)^.St);
  end;

procedure GenMyRec(var MR : TMyRec);
  begin
    MR.I := Random(5);
    MR.St := RandomStr(5);
  end;

function NewMyRec : PMyRec;
  begin
    New(Result);
    GenMyRec(Result^);
  end;

procedure PrintMyRec(const From : string; MR : PMyRec);
  begin
    if ItemsCount < 20 then
      with MR^ do
        WriteLog(Format('%s  %d  %s', [From, I, St]));
  end;

function MyTreePrint(Container : TStContainer;
                     Node : TStNode;
                     OtherData : pointer) : boolean; far;
  begin
    Result := true;
    PrintMyRec('Tree', PMyRec(Node.Data));
  end;

function MyListPrint(Container : TStContainer;
                     Node : TStNode;
                     OtherData : pointer) : boolean; far;
  begin
    Result := true;
    PrintMyRec('List', PMyRec(Node.Data));
  end;

function MyCollPrint(Container : TStContainer;
                     Data, OtherData : pointer) : boolean; far;
  begin
    Result := true;
    PrintMyRec('Coll', PMyRec(Data));
  end;

procedure MyArrayPrint(A : TStLArray);
  var
    i : integer;
    MR : TMyRec;
  begin
    for i := 0 to pred(A.Count) do
      begin
        A.Get(i, MR);
        PrintMyRec('Arry', @MR);
      end;
  end;

procedure MyMatrixPrint(M : TStLMatrix);
  var
    i : integer;
    MR : TMyRec;
  begin
    for i := 0 to pred(M.Rows) do
      begin
        M.Get(i, 0, MR);
        PrintMyRec('Mtrx', @MR);
      end;
  end;

procedure MyVMatrixPrint(M : TStVMatrix);
  var
    i : integer;
    MR : TMyRec;
  begin
    for i := 0 to pred(M.Rows) do
      begin
        M.Get(i, 0, MR);
        PrintMyRec('V-Mx', @MR);
      end;
  end;

var
  MyList : TStList;
  MyColl : TStCollection;
  MyTree : TStTree;
  MyArray : TStLArray;
  MyMatrix : TStLMatrix;
  MyVMatrix : TStVMatrix;

  i : integer;
  MyRec : TMyRec;

begin
  OpenLog('TAssign.Log');
  try
    WriteLog('Creating list, tree, collection containers');
    MyTree := TStTree.Create(TStTreeNode);
    MyTree.Compare := MyCompareData;
    MyList := TStList.Create(TStListNode);
    MyColl := TStCollection.Create(50);

    WriteLog('Clear tree, fill tree, print initial items in tree');
    MyTree.DisposeData := MyDisposeData;
    MyList.DisposeData := nil;
    MyColl.DisposeData := nil;
    MyTree.Clear;
    for i := 1 to ItemsCount do
      MyTree.Insert(NewMyRec);
    MyTree.Iterate(MyTreePrint, true, nil);

    WriteLog('clear list, assign to list, print list');
    MyList.Clear;
    MyList.Assign(MyTree);
    MyList.Iterate(MyListPrint, true, nil);

    WriteLog('clear collection, assign to collection, print collection');
    MyColl.Clear;
    MyColl.Assign(MyTree);
    MyColl.Iterate(MyCollPrint, true, nil);

    WriteLog('Clear list, fill list, print initial items in list');
    MyTree.DisposeData := nil;
    MyList.DisposeData := MyDisposeData;
    MyColl.DisposeData := nil;
    MyList.Clear;
    for i := 1 to ItemsCount do
      MyList.Append(NewMyRec);
    MyList.Iterate(MyListPrint, true, nil);

    WriteLog('clear tree, assign to tree, print tree');
    MyTree.Clear;
    MyTree.Assign(MyList);
    MyTree.Iterate(MyTreePrint, true, nil);

    WriteLog('clear collection, assign to collection, print collection');
    MyColl.Clear;
    MyColl.Assign(MyList);
    MyColl.Iterate(MyCollPrint, true, nil);

    WriteLog('Clear collection, fill coll., print initial items in coll.');
    MyTree.DisposeData := nil;
    MyList.DisposeData := nil;
    MyColl.DisposeData := MyDisposeData;
    MyColl.Clear;
    for i := 1 to ItemsCount do
      MyColl.Insert(NewMyRec);
    MyColl.Iterate(MyCollPrint, true, nil);

    WriteLog('clear list, assign to list, print list');
    MyList.Clear;
    MyList.Assign(MyColl);
    MyList.Iterate(MyListPrint, true, nil);

    WriteLog('clear tree, assign to tree, print tree');
    MyTree.Clear;
    MyTree.Assign(MyColl);
    MyTree.Iterate(MyTreePrint, true, nil);

    MyTree.Free;
    MyList.Free;
    MyColl.Free;

    WriteLog('Creating array, matrix, v-matrix containers');
    MyArray := TStLArray.Create(ItemsCount, sizeof(TMyRec));
    MyMatrix := TStLMatrix.Create(ItemsCount, 1, sizeof(TMyRec));
    MyVMatrix := TStVMatrix.Create(ItemsCount, 1, sizeof(TMyRec),
                                   30, 'VMatrix.Dat', fmOpenReadWrite);

    WriteLog('Clear array, fill array, print initial items in array');
    MyArray.Clear;
    for i := 0 to pred(ItemsCount) do
      begin
        GenMyRec(MyRec);
        MyArray.Put(i, MyRec);
      end;
    MyArrayPrint(MyArray);

    WriteLog('clear matrix, assign to matrix, print matrix');
    MyMatrix.Clear;
    MyMatrix.Assign(MyArray);
    MyMatrixPrint(MyMatrix);

    WriteLog('clear v-matrix, assign to v-matrix, print v-matrix');
    MyVMatrix.Clear;
    MyVMatrix.Assign(MyArray);
    MyVMatrixPrint(MyVMatrix);

    WriteLog('Clear matrix, fill matrix, print initial items in matrix');
    MyMatrix.Clear;
    for i := 0 to pred(ItemsCount) do
      begin
        GenMyRec(MyRec);
        MyMatrix.Put(i, 0, MyRec);
      end;
    MyMatrixPrint(MyMatrix);

    WriteLog('clear array, assign to array, print array');
    MyArray.Clear;
    MyArray.Assign(MyMatrix);
    MyArrayPrint(MyArray);

    WriteLog('clear v-matrix, assign to v-matrix, print v-matrix');
    MyVMatrix.Clear;
    MyVMatrix.Assign(MyMatrix);
    MyVMatrixPrint(MyVMatrix);

    WriteLog('Clear v-matrix, fill v-matrix, print initial items in v-matrix');
    MyVMatrix.Clear;
    for i := 0 to pred(ItemsCount) do
      begin
        GenMyRec(MyRec);
        MyVMatrix.Put(i, 0, MyRec);
      end;
    MyVMatrixPrint(MyVMatrix);

    WriteLog('clear array, assign to array, print array');
    MyArray.Clear;
    MyArray.Assign(MyVMatrix);
    MyArrayPrint(MyArray);

    WriteLog('clear matrix, assign to matrix, print matrix');
    MyMatrix.Clear;
    MyMatrix.Assign(MyVMatrix);
    MyMatrixPrint(MyMatrix);

  finally
    CloseLog;
  end;
end.
