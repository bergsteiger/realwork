{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dccompchanges;

interface
{$I dc.inc}
uses
  windows, classes, dcdreamlib, typinfo, sysutils, controls, menus, dccommon, dcsystem,
  forms;

type
  TStorePropertyProc = procedure (Sender : TObject; Instance : TObject; const PropName : string; var Store : boolean) of object;
  TNeedTrackComponentProc = procedure (Sender : TObject; Instance : TComponent; var NeedTrack : boolean) of object;

  TCompStateItem = class(TCollectionItem)
  private
    fInstance : TComponent;
    fLinkedComp : TDCLinkedComponent;

    procedure SetInstance(val : TComponent);
    procedure Notification(AComponent : TComponent; Operation : TOperation);
  public
    CompName : string;
    State : TMemoryStream;
    Deleted : boolean;

    constructor Create(Collection: TCollection); override;
    destructor  Destroy; override;

    property Instance : TComponent read fInstance write SetInstance;
  end;

  TCompStateCollection = class(TCollection)
  private
    function GetItem(index : integer) : TCompStateItem;
  public
    function CompExists(Instance : TComponent) : boolean;

    property Items[index : integer] : TCompStateItem read GetItem; default;
  end;

  TDCCompChanges = class
  private
    fStartList    : TCompStateCollection;
    fDeletedList  : TStringList;
    fDeletedCompList : TList;
    fNewList      : TList;
    fComponent    : TComponent;
    fParentList   : TStringList;
    fModifiedList : TList;
    fDockedList   : TStringList;
    fUnDockedList : TStringList;
    fOnError      : TReaderError;
    fOnFindMethod : TFindMethodEvent;
    fOnStoreProp  : TStorePropertyProc;
    fOnNeedTrackComponent : TNeedTrackComponentProc;
    fChangesVersion : integer;

    fStarted      : boolean;

    fsaveisstored  : array[1..5] of byte;
{$IFDEF D5}
    fsaveWriteProp : array[1..5] of byte;
{$ENDIF}
    procedure FindDeleted;
    procedure ApplyDelete;

    procedure FindNew;
    procedure FindModified;

    procedure ComponentRead(c : TComponent);
    function  GetParent(c : TComponent) : TComponent;

    {$IFDEF D4}
    procedure FindDocked;
    procedure ApplyUndock(Component : TComponent);
    procedure ApplyDock(Component : TComponent);
    {$ENDIF}

    procedure ReaderError(Reader: TReader; const Message: string; var Handled: Boolean);
    procedure AddToStartList(AComponent : TComponent);
    procedure ReadNew(Reader : TReader);
    procedure ReadModified(Component : TComponent; Reader : TReader);
    procedure ReaderSetName(Reader: TReader; Component: TComponent;
                            var Name: string);

    procedure HookIsStored;
    procedure UnHookIsStored;


    procedure NeedStoreProp(Instance : TObject; PropInfo : PPropInfo; var Store : boolean);
    procedure _WriteComponent(w : TWriter; Instance : TComponent);
    function  NeedTrackComponent(Instance : TComponent) : boolean; virtual;
{$IFDEF D5}
    procedure HookWriteProperty;
    procedure UnHookWriteProperty;
    procedure _WriteProperty(Instance: TPersistent; PropInfo: Pointer);
{$ENDIF}
  public
    constructor Create;
    destructor  Destroy; override;

    procedure Start(Component : TComponent);
    procedure Finish;

    procedure SaveToStream(Stream : TStream);
    procedure ApplyFromStream(Component : TComponent; Stream : TStream);

    procedure SaveToFile(const FileName : TFileName);
    procedure SaveToRegistry(const Key : string);
    procedure LoadFromRegistry(Component : TComponent; const Key : string);
    procedure ApplyFromFile(Component : TComponent; const FileName : TFileName);

    property  StartList : TCompStateCollection read fStartList;
    property  OnStoreProp : TStorePropertyProc read fOnStoreProp write fOnStoreProp;
    property  OnNeedTrackComponent : TNeedTrackComponentProc read fOnNeedTrackComponent write fOnNeedTrackComponent;
    property  OnError : TReaderError read fOnError write fOnError;
    property  OnFindMethod : TFindMethodEvent read fOnFindMethod write fOnFindMethod;
  end;

  TCustomDataModuleNotifier = class(TControl)
  end;

var
  IsStoredPropAddr : pointer;
  WritePropertyAddr : pointer;

const
  CVersion = 3;

procedure CompChangesStreamToStrings(ChangesStream : TStream; OutStrings : TStrings);
procedure CompChangesStreamToTextStream(ChangesStream, OutStream : TStream);

implementation

type
  PWord = ^word;

function GetRealAddr(p : PWord) : pointer;
begin
  if p^ = $25FF then //package thunk
    integer(result) := PInt(PInt(integer(p) + 2)^)^
  else
    result := p;
end;

type
  TMWinControl = class(TWinControl);
  TMWriter = class(TWriter);

{------------------------------------------------------------------}

{$IFNDEF D3}
type
  T_Filer = class(TObject)
  private
    FStream: TStream;
    FBuffer: Pointer;
    FBufSize: Integer;
    FBufPos: Integer;
    FBufEnd: Integer;
  end;

function GetD2ReaderPosition(R : TReader) : integer;
begin
  with T_Filer(R) do
    result := FStream.Position - (FBufEnd - FBufPos);
end;
{$ENDIF}

{------------------------------------------------------------------}

function GetReaderCompName(Reader : TReader) : string;
var
  SavePos   : integer;
  ChildPos  : integer;
  Flags     : TFilerFlags;
  CompClass : string;
begin
  with Reader do
    begin
      {$IFNDEF D3}
      SavePos := GetD2ReaderPosition(Reader);
      {$ELSE}
      SavePos := Reader.Position;
      {$ENDIF}
      ReadPrefix(Flags, ChildPos);
      CompClass := ReadStr;
      result := ReadStr;
      Position := SavePos;
    end;
end;

{------------------------------------------------------------------}

procedure RestoreMenuItemIndex(mcomp : TComponent; Reader : TReader; ChangesVersion : integer);
begin
  if ChangesVersion >= 2 then
    begin
      if mcomp is TMenuItem then
        TMenuItem(mcomp).MenuIndex := Reader.ReadInteger;
    end;
end;

{******************************************************************}

constructor TCompStateItem.Create(Collection: TCollection);
begin
  inherited ;
  State := TMemoryStream.Create;
  fLinkedComp := TDCLinkedComponent.Create(nil);
  fLinkedComp.NotifyProc := Notification;
end;

{------------------------------------------------------------------}

procedure TCompStateItem.Notification(AComponent : TComponent; Operation : TOperation);
begin
  if (AComponent = Instance) and (Operation = opRemove) then
    Deleted := true;
end;

{------------------------------------------------------------------}

procedure TCompStateItem.SetInstance(val : TComponent);
begin
  fInstance := val;
  fLinkedComp.Link := val;
end;

{------------------------------------------------------------------}

destructor  TCompStateItem.Destroy;
begin
  State.Free;
  fLinkedComp.Free;
  inherited;
end;

{******************************************************************}

function TCompStateCollection.GetItem(index : integer) : TCompStateItem;
begin
  result := TCompStateItem(inherited GetItem(index));
end;

{------------------------------------------------------------------}

function TCompStateCollection.CompExists(Instance : TComponent) : boolean;
var
  i : integer;
begin
  for i := 0 to Count - 1 do
    if Items[i].Instance = Instance then
      begin
        result := true;
        exit;
      end;

  result := false;
end;

{******************************************************************}

threadvar
  _changes : TDCCompChanges;

function _IsStoredProp(Instance: TObject; PropInfo: PPropInfo) : Boolean;
begin
  _changes.UnHookIsStored;
  try
    result := IsStoredProp(Instance, PropInfo);
  finally
    _changes.HookIsStored;
  end;

  _changes.NeedStoreProp(Instance, PropInfo, result);
end;

{------------------------------------------------------------------}

function  TDCCompChanges.NeedTrackComponent(Instance : TComponent) : boolean;
begin
  result := true;
  if Assigned(OnNeedTrackComponent) then
    OnNeedTrackComponent(self, Instance, result);
end;

{------------------------------------------------------------------}

procedure TDCCompChanges.NeedStoreProp(Instance : TObject; PropInfo : PPropInfo; var Store : boolean);
begin
  if Assigned(OnStoreProp) then
    OnStoreProp(self, Instance, PropInfo.Name, Store);
end;

{------------------------------------------------------------------}

procedure TDCCompChanges.HookIsStored;
var
  p : pchar;
  newcode : array[0..4] of byte;
  i : DWORD;
begin
  p := IsStoredPropAddr;
  move(p^, fsaveisstored, 5);
  newcode[0] := $E9;
  PInteger(@newcode[1])^ := integer(@_IsStoredProp) - integer(IsStoredPropAddr) - 5;
  WriteProcessMemory(GetCurrentProcess, IsStoredPropAddr, @(newcode[0]), 5, i);
end;

{------------------------------------------------------------------}

procedure TDCCompChanges.UnHookIsStored;
var
  i : DWORD;
begin
  WriteProcessMemory(GetCurrentProcess, IsStoredPropAddr, @(fsaveisstored[1]), 5, i);
end;

{------------------------------------------------------------------}
{$IFDEF D5}
procedure TDCCompChanges._WriteProperty(Instance: TPersistent; PropInfo: Pointer);
var
  PropType: PTypeInfo;
begin
  if (PPropInfo(PropInfo)^.SetProc <> nil) and
     (PPropInfo(PropInfo)^.GetProc <> nil) then
    begin
      PropType := PPropInfo(PropInfo)^.PropType^;
      if PropType.Kind = tkEnumeration then
        begin
          TMWriter(self).WritePropName(PPropInfo(PropInfo)^.Name);
          TMWriter(self).WriteIdent(GetEnumName(PropType, GetOrdProp(Instance, PropInfo)));
        end
      else
        begin
          _changes.UnHookWriteProperty;
          try
            TMWriter(self).WriteProperty(Instance, PropInfo);
          finally
            _changes.HookWriteProperty;
          end;
        end;
    end;
end;

{------------------------------------------------------------------}

procedure TDCCompChanges.HookWriteProperty;
var
  p : pchar;
  newcode : array[0..4] of byte;
  i : DWORD;
begin
  p := WritePropertyAddr;
  move(p^, fsaveWriteProp, 5);
  newcode[0] := $E9;
  PInteger(@newcode[1])^ := integer(Addr(TDCCompChanges._WriteProperty)) - integer(p) - 5;
  WriteProcessMemory(GetCurrentProcess, p, @(newcode[0]), 5, i);
end;

{------------------------------------------------------------------}

procedure TDCCompChanges.UnhookWriteProperty;
var
  i : DWORD;
begin
  WriteProcessMemory(GetCurrentProcess, WritePropertyAddr, @(fsaveWriteProp[1]), 5, i);
end;
{$ENDIF}
{------------------------------------------------------------------}

procedure TDCCompChanges._WriteComponent(w : TWriter; Instance : TComponent);
begin
  try
    HookIsStored;
{$IFDEF D5}
    HookWriteProperty;
{$ENDIF}
    _changes := self;
    w.WriteSignature;
    w.WriteComponent(Instance);
  finally
{$IFDEF D5}
    UnhookWriteProperty;
{$ENDIF}
    UnHookIsStored;
  end;
end;

{------------------------------------------------------------------}

constructor TDCCompChanges.Create;
begin
  inherited;
  fStartList := TCompStateCollection.Create(TCompStateItem);
  fDeletedList := TStringList.Create;
  fNewList := TList.Create;
  fParentList := TStringList.Create;
  fModifiedList := TList.Create;
  fDockedList := TStringList.Create;
  fUnDockedList := TStringList.Create;
  fDeletedCompList := TList.Create;
end;

{------------------------------------------------------------------}

destructor  TDCCompChanges.Destroy;
begin
  fStartList.Free;
  fDeletedList.Free;
  fParentList.Free;
  fModifiedList.Free;
  fDockedList.Free;
  fUnDockedList.Free;
  fNewList.Free;
  fDeletedCompList.Free;
  inherited;
end;

{------------------------------------------------------------------}

procedure TDCCompChanges.AddToStartList(AComponent : TComponent);
begin
  with TCompStateItem(fStartList.Add) do
    begin
      Instance := AComponent;
      CompName := Instance.Name;
      with TWriter.Create(State, 4096) do
        try
          Root := fComponent;
          IgnoreChildren := true;
          {State.}WriteComponent(Instance);
        finally
          Free;
        end;
    end;
end;

{------------------------------------------------------------------}

procedure TDCCompChanges.Start(Component : TComponent);

  procedure _add (c : TComponent);
  var
    i : integer;
  begin
    if NeedTrackComponent(c) then
      AddToStartList(C);
    with C do
      for i := 0 to ComponentCount - 1 do
        _add(Components[i]);
  end;
  
begin
  fComponent := Component;
  fStartList.Clear;
  _add(Component);
{  AddToStartList(Component);
  with Component do
    for i := 0 to ComponentCount - 1 do
      AddToStartList(Components[i]);}
//          AddObject(Components[i].Name, Components[i]);
  fStarted := true;
end;

{------------------------------------------------------------------}

procedure TDCCompChanges.FindDeleted;
var
  i : integer;
  csitem : TCompStateItem;
begin
  fDeletedList.Clear;
  fDeletedCompList.Clear;
  with fStartList do
    for i := 0 to Count - 1 do
      begin
        csitem := Items[i];
        if csItem.Deleted then
          begin
            fDeletedList.Add(csItem.CompName);
            fDeletedCompList.Add(csItem.Instance);
          end;
      end;
end;

{------------------------------------------------------------------}

procedure TDCCompChanges.FindNew;
var
  i : integer;
  comp : TComponent;

  function IsNew(comp : TComponent) : boolean;
  begin
    result := NeedTrackComponent(comp) and not ((comp = nil) or fStartList.CompExists(comp) and not (fDeletedCompList.IndexOf(comp) >= 0));
  end;

  function IsParentNew(comp : TComponent) : boolean;
  begin
    result := comp.HasParent and IsNew(comp.GetParentComponent);
  end;

begin
  fNewList.Clear;
  with fComponent do
    for i := 0 to ComponentCount - 1 do
      begin
        comp := Components[i];
        if not (comp is TCustomDataModuleNotifier) and IsNew(comp) and not IsParentNew(comp) then
          fNewList.Add(comp);
      end;
end;

{------------------------------------------------------------------}

procedure TDCCompChanges.FindModified;
var
  s : TMemoryStream;
  i : integer;
  w : TWriter;
begin
  fModifiedList.Clear;
  s := TMemoryStream.Create;
  try
    for i := 0 to fStartList.Count - 1 do
      with fStartList[i] do
        begin
          if Deleted then
            continue;

          s.Clear;
          w := TWriter.Create(s, 4096);
          try
            w.Root := fComponent;
            //w.IgnoreChildren := true;
            w.WriteComponent(Instance);
          finally
            w.Free;
          end;

          if (s.Size = State.Size) and CompareMem(s.Memory, State.Memory, s.Size) then
            continue;

          fModifiedList.Add(Instance);
        end;
  finally
    s.Free;
  end;
end;

{------------------------------------------------------------------}
{$IFDEF D4}
function BoundsToString(Control : TWinControl) : string;
begin
  with Control do
    result := IntToStr(Left) + ',' + IntToStr(Top) + ',' +
              IntToStr(Width) + ',' + IntToStr(Height) + ',' +
              IntToStr(byte(Control.Visible));
end;

{------------------------------------------------------------------}

function StringToBounds(const SBounds : string; Control : TWinControl) : boolean;
var
  slist : TStringList;

  function _val(i : integer) : integer;
  begin
    result := StrToIntDef(slist[i], 0);
  end;
  
var
  _l : integer;
begin
  slist := TStringList.Create;
  with Control, slist do
    try
      CommaText := SBounds;
      result := boolean(_val(4));
      _l := _val(0);

      if not result then
        inc(_l, 20000);

      SetBounds(_l, _val(1), _val(2), _val(3));
    finally
      Free;
    end;
end;

{------------------------------------------------------------------}

procedure TDCCompChanges.FindDocked;
var
  i : integer;
begin
  with fComponent do
    for i := 0 to ComponentCount - 1 do
      if (Components[i] is TWinControl) and NeedTrackComponent(Components[i]) then
        with TWinControl(Components[i]) do
          if HostDockSite <> nil then
            if TComponent(GetParentForm(HostDockSite)) = fComponent then
              fDockedList.Add(Name + '=' + HostDockSite.Name)
            else
              fUnDockedList.Add(Name + '=' + BoundsToString(HostDockSite));
end;
{$ENDIF}
{------------------------------------------------------------------}

procedure TDCCompChanges.Finish;
begin
  if fStarted then
    begin
      FindDeleted;
      FindNew;
      FindModified;
      {$IFDEF D4}
      FindDocked;
      {$ENDIF}
    end;
end;

{------------------------------------------------------------------}

procedure TDCCompChanges.ApplyDelete;
var
  i : integer;
  c : TComponent;
begin
  with fDeletedList do
    for i := 0 to Count - 1 do
      begin
        c := fComponent.FindComponent(Strings[i]);
        if c <> nil then
          c.Free;
      end;
end;

{------------------------------------------------------------------}

const
  NPDelimiter = ',';

function Control2NamePath(TopOwner, AControl: TComponent): string;
var
  _WCtrl: TComponent;
  _Ctrl: TComponent;
  idx: integer;
begin
  result := AControl.Name;
  _Ctrl := AControl;
  _WCtrl := _Ctrl.Owner;
  if (result = '') or (_WCtrl <> TopOwner) then
    begin
      Result := '';
      while Assigned(_WCtrl) do
      begin
        idx := _Ctrl.ComponentIndex;
        Result := IntToStr(idx) + NPDelimiter + Result;
        if _WCtrl.Name <> '' then
        begin
          Result := _WCtrl.Name + NPDelimiter + Result;
          break;
        end;
        _Ctrl := _WCtrl;
        _WCtrl := _WCtrl.Owner;
        if _WCtrl = TopOwner then
          break;
      end;
      if Result[Length(Result)] = NPDelimiter then
        SetLength(Result, Length(Result) - 1);
    end;
end;

{------------------------------------------------------------------}

function NamePath2Control(AOwner: TComponent; const ANamePath: string): TComponent;
var
  _Comma: integer;
  _Path, _Idx: string;
  cindex : integer;
begin
  _Comma := Pos(NPDelimiter, ANamePath);
  if _Comma = 0 then
    Result := TControl(AOwner.FindComponent(ANamePath))
  else
  begin
    _Path := ANamePath;
    Result := TControl(AOwner.FindComponent(Copy(_Path, 1, _Comma - 1)));
    Delete(_Path, 1, _Comma); //idx,idx...,idx
    while _Path <> '' do
    begin
      _Comma := Pos(NPDelimiter, _Path);
      if _Comma = 0 then
      begin
        _Idx := _Path;
        _Path := '';
      end
      else
      begin
        _Idx := Copy(_Path, 1, _Comma - 1);
        Delete(_Path, 1, _Comma); //idx,idx...,idx
      end;
      cindex := StrToInt(_Idx);
      with TWinControl(Result) do
        if ComponentCount < cindex then
          result := nil
        else
          result := Components[cindex];
    end;
  end;
end;

{------------------------------------------------------------------}

const
  SMainComponentName = '0';

procedure TDCCompChanges.SaveToStream(Stream : TStream);
var
  i : integer;
  w : TWriter;

  {---------------------------------------------}

  procedure WriteComp(clist : TList; cindex : integer);
  var
    parent : TComponent;
    comp   : TComponent;
  begin
    if cindex < 0 then
      exit;

    comp := clist[cindex];

    if Comp = nil then
      exit;

    parent := Comp.GetParentComponent;
    with clist do
      begin
        if (parent <> nil) then
          WriteComp(clist, clist.IndexOf(parent));

        _WriteComponent(w, comp);
        if comp is TMenuItem then
          w.writeinteger(TMenuItem(comp).MenuIndex);
//        w.WriteComponent(comp);
        Items[cindex] := nil;
      end;
  end;

  {---------------------------------------------}

  procedure FillParents(clist : TList);
  var
    i : integer;
    parent : TComponent;
    pname  : string;
  begin
    fParentList.Clear;
    with clist do
      for i := 0 to Count - 1 do
        with TComponent(Items[i]) do
          begin
            parent := GetParentComponent;

            if parent <> nil then
              begin
                if parent = fComponent then
                  pname := SMainComponentName
                else
                  pname := Control2NamePath(fComponent, TControl(parent));

                fParentList.Add(Name + '=' + pname) {parent.name};
              end;
          end;
  end;

  {---------------------------------------------}
var
  comp : TComponent;
  cname : string;
begin
  w := TWriter.Create(Stream, 4096);
  with w do
    try
      Root := fComponent;

      WriteInteger(CVersion); // changes version  2 - index of menu item is stored

      WriteString(fDeletedList.Text);
      WriteString(fDockedList.Text);
      WriteString(fUnDockedList.Text);

      with fNewList do
        begin
          WriteInteger(Count);
          if Count > 0 then
            begin
              FillParents(fNewList);
              WriteString(fParentList.Text);

              w.IgnoreChildren := false;
              for i := 0 to Count - 1 do
                WriteComp(fNewList, i);

              WriteListEnd;
            end;
        end;

       with fModifiedList do
         begin
           WriteInteger(Count);
           if Count > 0 then
             begin
               FillParents(fModifiedList);

               WriteInteger(0); // new version
               WriteString(fParentList.Text);

               for i := 0 to Count - 1 do
                 begin
                   comp := TComponent(Items[i]);

                   if comp = fComponent then
                     cname := SMainComponentName
                   else
                     cname := Control2NamePath(fComponent, comp);

                   WriteString(cname);

                   if cname = '' then
                     continue;

                   w.IgnoreChildren := not (comp.ClassNameIs('TNoteBook') or comp.ClassNameIs('TPage') or
                                            comp.ClassNameIs('TQRChart') or comp.ClassNameIs('TQRDBChart'));
                   _WriteComponent(w, comp);
                   if comp is TMenuItem then
                     w.writeinteger(TMenuItem(comp).MenuIndex);
                 end;
             end;
         end;

    finally
      Free;
    end;
end;

{------------------------------------------------------------------}
type
  TMComponent = class(TComponent);
  TMReader = class(TReader);

function TDCCompChanges.GetParent(c : TComponent) : TComponent;
var
  i : integer;
begin
  result := nil;
  if c <> nil then
    begin
      i := fParentList.IndexOfName(c.Name);
      if i < 0 then
        exit;

//      result := fComponent.FindComponent(fParentList.Values[c.Name])
      result := NamePath2Control(fComponent, fParentList.Values[c.Name]);
    end;
end;

{------------------------------------------------------------------}

procedure TDCCompChanges.ComponentRead(c : TComponent);
var
  pcomp : TComponent;
begin
  pcomp := GetParent(c);
  if pcomp <> nil then
    TMComponent(c).SetParentComponent(pcomp);
end;

procedure TDCCompChanges.ReadNew(Reader : TReader);
var
  newcount : integer;
  cname    : string;
  pname    : string;
  pcomp    : TComponent;
  newcomp  : TComponent;
begin
  with Reader do
    begin
      newcount := ReadInteger;
      if newcount > 0 then
        begin
          fParentList.Text := ReadString;

          BeginReferences;
          try
            while not EndOfList do
              begin
                ReadSignature;
                cname := GetReaderCompName(Reader);
                pname := fParentList.Values[cname];

                if (pname = SMainComponentName) or (CompareText(GetOriginalComponentName(fComponent.Name), GetOriginalComponentName(pname)) = 0) then
                  pcomp := fComponent
                else
                  pcomp := NamePath2Control(fComponent, pname);
                  //pcomp := fComponent.FindComponent(pname);

                Parent := pcomp;
                newcomp := ReadComponent(nil);

                RestoreMenuItemIndex(newcomp, Reader, fChangesVersion);

                if newcomp is TCustomDCOleControl then
                  TMWinControl(newcomp).RecreateWnd;

              end;
            ReadListEnd;
            FixupReferences;
          finally
            EndReferences;
          end;
        end;
    end;
end;

{------------------------------------------------------------------}

procedure TDCCompChanges.ReaderSetName(Reader: TReader; Component: TComponent;
            var Name: string);
begin
  if (Component.Name <> Name) and (Component.Owner <> nil) and (Component.Owner.FindComponent(Name) <> nil) then
    Name := UniqueName(Component.Owner, copy(Component.ClassName, 2, MaxInt));
end;

{------------------------------------------------------------------}

type
  TMControl = class(TControl);

procedure TDCCompChanges.ReadModified(Component : TComponent; Reader : TReader);
var
  i : integer;
  j : integer;
  modcount : integer;
  _cname   : string;
  mcomp    : TComponent;
  mparent  : TWinControl;
begin
  with TMReader(Reader) do
    begin
      modcount := ReadInteger;
      if modcount > 0 then
        try
          if NextValue in [vaInt8, vaInt16, vaInt32] then
            begin           // new version
              ReadInteger;
              fParentList.Text := ReadString;
            end;

          BeginReferences;
          for i := 0 to modcount - 1 do
            begin
              _cname := ReadString;

              if _cname = '' then
                continue;

              if (_cname = SMainComponentName) or (_cname = Component.Name) then
                mcomp := Component
              else
                mcomp := NamePath2Control(Component, _cname);

              if mcomp <> nil then
                begin
                  {$IFNDEF D4}
                  if InheritsFromClassName(mcomp, 'TField') then                        //don't resource
                    SetPropValue(mcomp, 'FieldName', 'f__' + IntToStr(integer(mcomp))); //don't resource
                  {$ENDIF}

                  Parent := GetParent(mcomp);

                  mparent := nil;

                  if mcomp is TControl then
                    begin
                      mparent := TControl(mcomp).parent;

                      if mparent <> nil then
                        mparent.DisableAlign;

                      if mcomp is TWinControl then
                        TWinControl(mcomp).DisableAlign;
                    end;

                  try
                    if fChangesVersion > 2 then
                      ReadSignature;

                    ReadComponent(mcomp);
                    ComponentRead(mcomp);
                    RestoreMenuItemIndex(mcomp, Reader, fChangesVersion);

                  finally
                    if mcomp is TWinControl then
                      with TWinControl(mcomp) do
                        begin
                          for j := 0 to ControlCount - 1 do
                            with TMControl(Controls[j]) do
                              UpdateBoundsRect(Rect(Left, Top, Left + Width, Top + Height));

                          TWinControl(mcomp).EnableAlign;
                        end;

                    if mparent <> nil then
                      mparent.EnableAlign;
                  end;
                end
              else
                break;
            end;
          FixupReferences;
        finally
          EndReferences;
        end;
    end;
end;

{------------------------------------------------------------------}

{$IFDEF D4}
procedure TDCCompChanges.ApplyUndock(Component : TComponent);
var
  i : integer;
  _visible : boolean;
  mcomp    : TComponent;
  docksite : TWinControl;
begin
  with fUnDockedList do
    for i := 0 to Count - 1 do
      begin
        mcomp := Component.FindComponent(Names[i]);
        if (mcomp is TControl) then
          with TControl(mcomp) do
            begin
              docksite := FloatingDockSiteClass.Create(Application);
              _visible := StringToBounds(Values[Names[i]], docksite);
              TControl(mcomp).ManualDock(docksite);
              TControl(mcomp).Visible := _visible;
              if not _visible then
                with docksite do
                  left := left - 20000;
            end;
      end;
end;

{------------------------------}

procedure TDCCompChanges.ApplyDock;
var
  i : integer;
  dcontrol : TControl;
  dtarget  : TWinControl;
begin
  with fDockedList do
    for i := 0 to Count - 1 do
      begin
        dcontrol := TControl(Component.FindComponent(Names[i]));
        dtarget := TWinControl(Component.FindComponent(Values[Names[i]]));
        if (dcontrol <> nil) and (dtarget <> nil) then
          dcontrol.ManualDock(dtarget);
      end;
end;
{$ENDIF}
{------------------------------}

procedure FixupTabs(comp : TComponent);
begin
  if Comp is TWinControl then
    TMWinControl(Comp).FixupTabList;
end;

{------------------------------}

procedure TDCCompChanges.ApplyFromStream(Component : TComponent; Stream : TStream);
var
  Reader : TReader;
  i      : integer;
{$IFDEF D5}
  wasinline : boolean;
{$ENDIF}  
begin
  Reader := TReader.Create(Stream, 4096);
  with TMReader(Reader) do
    try
      OnError      := fOnError;
      OnFindMethod := fOnFindMethod;
      OnSetName    := ReaderSetName;

      Root := Component;
      Owner := Root;
      OnError := ReaderError;
      fComponent := Component;

      if NextValue in [vaInt8, vaInt16, vaInt32] then // Changes version
        fChangesVersion := ReadInteger
      else
        fChangesVersion := 1;

      fDeletedList.Text := ReadString;
      ApplyDelete;

      fDockedList.Text := ReadString;
      fUnDockedList.Text := ReadString;

{$IFDEF D5}
      wasinline := csInline in Component.ComponentState;
{$ENDIF}      
      ReadNew(Reader);
      ReadModified(Component, Reader);
{$IFDEF D5}
      TMComponent(Component).SetInline(wasinline);
{$ENDIF}
      with Component do
        for i := 0 to ComponentCount - 1 do
          FixupTabs(Components[i]);

      FixupTabs(Component);

      {$IFDEF D4}
      ApplyUnDock(Component);
      ApplyDock(Component);

      fUndockedList.Clear;
      fDockedList.Clear;
      {$ENDIF}
    finally
      Free;
    end;
end;

{------------------------------------------------------------------}

procedure TDCCompChanges.ReaderError(Reader: TReader; const Message: string; var Handled: Boolean);
begin
  Handled := true;
end;

{------------------------------------------------------------------}

procedure TDCCompChanges.ApplyFromFile(Component : TComponent; const FileName : TFileName);
var
  FileStream : TFileStream;
begin
  FileStream := TFileStream.Create(FileName, DefaultOpenMode);
  try
    ApplyFromStream(Component, FileStream);
  finally
    FileStream.Free;
  end;
end;

{------------------------------------------------------------------}

procedure TDCCompChanges.SaveToFile(const FileName : TFileName);
var
  FileStream : TFileStream;
begin
  FileStream := TFileStream.Create(FileName, fmCreate);
  try
    SaveToStream(FileStream);
  finally
    FileStream.Free;
  end;
end;

{------------------------------------------------------------------}

procedure TDCCompChanges.LoadFromRegistry(Component : TComponent; const Key : string);
var
  s : TRegistryStream;
begin
  s := TRegistryStream.Create(Key, DefaultOpenMode);
  try
    if s.size > 0 then
      ApplyFromStream(Component, s);
  finally
    s.Free;
  end;
end;

{------------------------------------------------------------------}

procedure TDCCompChanges.SaveToRegistry(const Key : string);
var
  s : TRegistryStream;
begin
  s := TRegistryStream.Create(Key, fmCreate);
  try
    SaveToStream(s);
  finally
    s.Free;
  end;
end;

procedure _test;
begin
  IsStoredProp(nil, PPropInfo(nil));
end;

procedure GetIsStoredPropAddr;
var
  p : PChar;
begin
  p := pchar(Addr(_test)) + 4;
  if p^ = #$E8 then  //don't resource
    begin
      inc(p);
      IsStoredPropAddr := pointer(PInt(p)^ + integer(p) + 4);
      IsStoredPropAddr := GetRealAddr(IsStoredPropAddr);
    end;

  if false then
    _test;
end;

{******************************************************************}

procedure CompChangesStreamToTextStream(ChangesStream, OutStream : TStream);
var
  OutStrings : TStrings;

  function _EndOfList : boolean;
  begin
    with TReader.Create(ChangesStream, 32) do
      try
        result := EndOfList;
      finally
        Free;
      end;
  end;

  procedure _ReadListEnd;
  begin
    with TReader.Create(ChangesStream, 32) do
      try
        ReadListEnd;
      finally
        Free;
      end;
  end;

  function _ReadString : string;
  begin
    with TReader.Create(ChangesStream, 32) do
      try
        result := ReadString;
      finally
        Free;
      end;
  end;

  procedure _WriteString(const s : string);
  begin
    if s <> '' then
      OutStream.Write(s[1], length(s));
  end;

  procedure _OutStrings(const Name, Value : string);
  var
    s : TStrings;
  begin
    OutStrings.Add('[' + Name + ']');
    s := TStringList.Create;
    try
      s.Text := Value;
      OutStrings.Add(IntToStr(s.Count));
      OutStrings.AddStrings(s);
    finally
      s.Free;
    end;
  end;

var
  newcount : integer;
  modcount : integer;
  i : integer;
begin
  OutStrings := TStringList.Create;
  try
    with TReader.Create(ChangesStream, 1024) do
      try
        if NextValue in [vaInt8, vaInt16, vaInt32] then // Skip changes version
          ReadInteger;

        _OutStrings('Deleted', ReadString);
        _OutStrings('Docked', ReadString);
        _OutStrings('Undocked', ReadString);

        newcount := ReadInteger;
        OutStrings.Add('NewCount = ' + IntToStr(newcount));
        if newcount > 0 then
          _OutStrings('NewParents', ReadString);
      finally
        Free;
      end;

    OutStrings.SaveToStream(OutStream);
    OutStrings.Clear;

    if newcount > 0 then
      begin
        while not _EndOfList do
          ObjectBinaryToText(ChangesStream, OutStream);

        _ReadListEnd;
      end;

    with TReader.Create(ChangesStream, 1024) do
      try
        modcount := ReadInteger;
        if NextValue in [vaInt8, vaInt16, vaInt32] then // version
          begin
            ReadInteger;
            _OutStrings('ModifiedParents', ReadString);
          end;

      finally
        Free;
      end;

    OutStrings.Add('ModCount = ' + IntToStr(modcount));
    OutStrings.SaveToStream(OutStream);
    OutStrings.Clear;

    for i := 0 to modcount - 1 do
      begin
        _WriteString(_ReadString + #13#10);
        ObjectBinaryToText(ChangesStream, OutStream);
      end;

  finally
    OutStrings.Free;
  end;
end;

{------------------------------------------------------------------}

procedure CompChangesStreamToStrings(ChangesStream : TStream; OutStrings : TStrings);
var
  s : TStream;
begin
  s := TMemoryStream.Create;
  try
    CompChangesStreamToTextStream(ChangesStream, s);
    s.Seek(0, soFromBeginning);
    OutStrings.LoadFromStream(s);
  finally
    s.Free;
  end;
end;


initialization
  GetIsStoredPropAddr;
{$IFDEF D4}
  WritePropertyAddr := GetRealAddr(Addr(TMWriter.WriteProperty));
{$ENDIF}  
end.
