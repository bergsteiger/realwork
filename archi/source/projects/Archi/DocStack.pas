unit DocStack;

{ $Id: DocStack.pas,v 1.13 2014/02/14 15:33:17 lulin Exp $ }

interface

 Uses l3Base, l3ObjectStringList, DT_Const, DT_Types, l3DatLst,
  l3LongintList,
  l3ProtoObject
  ;
  
 type

  TDocStackItem = class(Tl3ProtoObject)
  public
   DocFam    : TFamilyID;
   DocID     : Longint;
   AnchorID  : Longint;
   Positions : Tl3LongintList;
   constructor Create(aDocFam: TFamilyID; aDocID: Longint; aAnchorID: Longint; aPositions: Tl3LongintList);
   procedure Cleanup; override;
  end;

  TOnCurrentChanged = procedure(aNewCurrent : Integer) of object;

  TDocStack = class(Tl3ObjectStringList)
   private
    f_CurrentItem: Integer;
    f_OnCurrentChanged: TOnCurrentChanged;
    function GetDocRecord(Index: Longint) : TDocStackItem;
    procedure pm_SetCurrentItem(const Value: Integer);
   public
    constructor Create; override;
    procedure AddDoc(Const DocName : String; DocFam : TFamilyID;
                     DocID : Longint; aAnchorID : Longint; aPositions: Tl3LongintList; aDoCutTail: Boolean = True);
    procedure ReplaceData(aIndex: Integer; aAnchorID : Longint; aPositions: Tl3LongintList);
    procedure PrepareForPair;
    procedure FillStringList(aList: Tl3StringDataList);
    property CurrentItem: Integer read f_CurrentItem write pm_SetCurrentItem;
    property DocRec[Index: Longint] : TDocStackItem read GetDocRecord;
    property OnCurrentChanged: TOnCurrentChanged read f_OnCurrentChanged write f_OnCurrentChanged;
  end;

implementation

uses
  l3String
  ;

constructor TDocStack.Create;
begin
 inherited Create;
end;

procedure TDocStack.AddDoc(Const DocName : String; DocFam : TFamilyID;
                           DocID : Longint; aAnchorID : Longint;
                           aPositions: Tl3LongintList; aDoCutTail: Boolean = True);
var
 l_Item : TDocStackItem;
begin
 l_Item := TDocStackItem.Create(DocFam, DocID, aAnchorID, aPositions);
 try
  f_CurrentItem := Add(DocName, l_Item);
 finally
  l3Free(l_Item);
 end;
 If Assigned(f_OnCurrentChanged) then f_OnCurrentChanged(f_CurrentItem);
end;

procedure TDocStack.FillStringList(aList: Tl3StringDataList);
var
 I: Integer;
begin
 aList.Clear;
 aList.AddStr(Strings[0]);
 I := 1;
 while I < Count do
 begin
  aList.AddStr(Strings[I]);
  I := I + 2;
 end;
end;

function TDocStack.GetDocRecord(Index: Longint) : TDocStackItem;
begin
 Result := TDocStackItem(Objects[Index]);
end;

procedure TDocStack.pm_SetCurrentItem(const Value: Integer);
begin
 if f_CurrentItem <> Value then
 begin
  f_CurrentItem := Value;
  if Assigned(f_OnCurrentChanged) then
   f_OnCurrentChanged(Value);
 end;
end;

procedure TDocStack.PrepareForPair;
begin
 // лечим рассогласование. Как это происходит до конца не понятно, как-то умудрился не вовремя полузагруженное окно редактора выключить
 if f_CurrentItem > pred(Count) then
  f_CurrentItem := pred(Count);

 // подготовка к принятию в историю следующей пары документов...
 while pred(Count) > f_CurrentItem do
   Delete(f_CurrentItem+1);
 if (Count > 0) and (f_CurrentItem mod 2 = 0) then
  Delete(f_CurrentItem);
end;

procedure TDocStack.ReplaceData(aIndex: Integer; aAnchorID : Longint; aPositions: Tl3LongintList);
var
 l_Temp: TDocStackItem;
begin
 l_Temp := DocRec[aIndex];
 l3Free(l_Temp.Positions);
 l_Temp.AnchorID := aAnchorID;
 l_Temp.Positions := aPositions;
end;

constructor TDocStackItem.Create(aDocFam: TFamilyID; aDocID: Longint; aAnchorID: Longint; aPositions: Tl3LongintList);
begin
 inherited Create;
 DocFam := aDocFam;
 DocID  := aDocID;
 AnchorID := aAnchorID;
 Positions := aPositions;
end;

procedure TDocStackItem.Cleanup;
begin
 if Assigned(Positions) then
  l3Free(Positions);
 inherited;
end;

end.
