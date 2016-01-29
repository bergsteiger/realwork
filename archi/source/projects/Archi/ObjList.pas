unit ObjList;

{ $Id: ObjList.pas,v 1.11 2015/04/17 10:40:08 kostitsin Exp $ }

interface

uses
  WinTypes,
  l3DatLst,
  DragData,

  DocIntf,
  DT_Dict,
  DT_Active;

type
  TDragDataType   = (ddNone, ddDragObj, ddHyperLink, ddBackHyperLink, ddDoc,
                     ddSrchObj, ddSrchID, ddDictItem, ddMailDocLink);

  PSrchObjAddr = ^TSrchObjAddr;
  TSrchObjAddr = Pointer;

  PSrchIDAddr  = ^TSrchIDAddr;
  TSrchIDAddr  = Longint;

  PDictItemAddr = ^TDictItemAddr;
  TDictItemAddr = Record
                   FamID  : Longint;
                   DictID : Longint;
                   ItemID : Longint;
                   ItemTag  : Pointer;
                  end;

  TArchiObjectList = Class(Tl3StringDataList)
   private
    fMonoObjType : TDragDataType;
    procedure DragStopNotify(Sender: TObject);
    procedure RunDrag;
   public
    constructor Create; override;
    procedure AddObjRec(aName : PAnsiChar; aType : TDragDataType; aDataRec : PAnsiChar; aAddDataSize : Cardinal = 0);
  end;

var
 ArchiObjectList : TArchiObjectList;

 function CursorByType(DDType : Integer) : HCursor; export;

implementation

uses
  SysUtils,
  Forms,
  Controls,

  DT_Const,
  DT_Types,

  l3Base,

  ResShop;

function CursorByType(DDType : Integer) : HCursor;
begin
 case TDragDataType(DDType) of
  ddNone          : Result := Screen.Cursors[crDefault];
  ddDragObj       : Result := Screen.Cursors[crDragObj];
  ddHyperLink     : Result := Screen.Cursors[crLink];
  ddBackHyperLink : Result := Screen.Cursors[crSubLink];
  ddMailDocLink   : Result := Screen.Cursors[crLink];
  else              Result := Screen.Cursors[crDragObj];
 end;
end;

{TArchiObjectList}
constructor TArchiObjectList.Create;
begin
 inherited Create;
 SetDataSize(SizeOf(TDictItemAddr) + 1);
 NeedAllocStr   := True;
 NeedDisposeStr := True;
end;

procedure TArchiObjectList.AddObjRec(aName : PAnsiChar; aType : TDragDataType; aDataRec : PAnsiChar; aAddDataSize : Cardinal = 0);
var
 I      : Longint;
 ItData : PAnsiChar;
 lRecSize : Integer;
begin
 if Count = 0 then
 begin
  fMonoObjType := aType;
  RunDrag;
 end
 else
  if fMonoObjType <> aType then
   fMonoObjType := ddDragObj;

 TDragDataSupport.Instance.DragDataType := Ord(fMonoObjType);
 I := Add(aName);
 if aAddDataSize = 0 then
  case aType of
   ddDoc           : lRecSize := SizeOf(TGlobalCoordinateRec);
   ddSrchObj       : lRecSize := SizeOf(TSrchObjAddr);
   ddSrchID        : lRecSize := SizeOf(TSrchIDAddr );
   ddDictItem      : lRecSize := SizeOf(TDictItemAddr);
   ddBackHyperLink : lRecSize := SizeOf(TGlobalCoordinateRec);
   else              lRecSize := SizeOf(TGlobalCoordinateRec);
  end
 else
  lRecSize := SizeOf(TDictItemAddr) + aAddDataSize;

 ItData := Data[I];
 ItData[0] := AnsiChar(aType);
 StrMove(ItData + 1, aDataRec, lRecSize);
end;

procedure TArchiObjectList.RunDrag;
begin
 with TDragDataSupport.Instance do
 begin
  DragData := Self;
  RunDragData(nil);
  OnDragStop := DragStopNotify;
 end;
end;

procedure TArchiObjectList.DragStopNotify(Sender: TObject);
var
 I        : Longint;
 l_ItemTag: Pointer;
begin
 for I := 0 to pred(Count) do
  if (TDragDataType(Data[I][0]) = ddDictItem) then
  begin
   l_ItemTag := PDictItemAddr(Data[I] + 1)^.ItemTag;
   if l_ItemTag <> nil then
    IUnknown(l_ItemTag)._Release;
  end; // if (TDragDataType(Data[I][0]) = ddDictItem) then
 Clear;
 TDragDataSupport.Instance.OnDragStop := nil;
end;

(*************)

procedure FinitArchiObjectList; Far;
begin
 l3Free(ArchiObjectList);
end;

initialization
 AddExitProc(FinitArchiObjectList);
 ArchiObjectList := TArchiObjectList.Create;
 TDragDataSupport.Instance.OnGetCursorByType := CursorByType;
end.
