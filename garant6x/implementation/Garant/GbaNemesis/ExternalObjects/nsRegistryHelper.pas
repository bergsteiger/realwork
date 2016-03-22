unit nsRegistryHelper;

interface
uses
  Windows;

type
  InsRegistryKeyEnumerator = interface(IUnknown)
  ['{49C05BAC-5C1D-48E5-8A50-578349122F4A}']
    function GetSubkeyCount: Integer;
    function GetName: AnsiString;
    function GetIndex: Integer;
    function MoveNext: Boolean;
    property SubkeyCount: Integer read GetSubkeyCount;
    property Name: AnsiString read GetName;
    property Index: Integer read GetIndex;
  end;

  TnsRegistryHelper = class
  public
    class function KeyEnumerator(ARootKey: HKEY;
      const AFolderKey: AnsiString): InsRegistryKeyEnumerator;
  end;

const
  MAX_KEY_LEN = 255;  

implementation
uses
  Registry, SysUtils, Classes, l3ProtoObject, l3Base;

type
  TnsRegistryKeyEnumerator = class(Tl3ProtoObject, InsRegistryKeyEnumerator)
  private
    f_RootKey: HKEY;
    f_FolderKeyName: AnsiString;
    f_SubkeyCount: Integer;
    f_Index: Integer;
    f_CurrentKeyName: String;
    f_Subkeys: TStrings;
    f_Registry: TRegistry;
    procedure ObtainKeyInfo;
  protected
    function GetSubkeyCount: Integer;
    function GetName: AnsiString;
    function GetIndex: Integer;
    function MoveNext: Boolean;
    procedure Cleanup; override;
  public
    class function Make(ARootKey: HKEY;
      const AFolderKey: AnsiString): InsRegistryKeyEnumerator;
    constructor Create(ARootKey: HKEY;
      const AFolderKey: AnsiString);
  end;

procedure TnsRegistryKeyEnumerator.ObtainKeyInfo;
var
  l_KeyInfo: TRegKeyInfo;
begin
  f_Registry.GetKeyInfo(l_KeyInfo);
  f_SubkeyCount := l_KeyInfo.NumSubKeys;
  f_Registry.GetKeyNames(f_SubKeys);
end;

function TnsRegistryKeyEnumerator.GetSubkeyCount: Integer;
begin
  Result := f_SubkeyCount;
end;

function TnsRegistryKeyEnumerator.GetName: AnsiString;
begin
  Result := f_CurrentKeyName;
end;

function TnsRegistryKeyEnumerator.GetIndex: Integer;
begin
  Result := f_Index;
end;

function TnsRegistryKeyEnumerator.MoveNext: Boolean;
var
  l_RetCode: HRESULT;
begin
  Result := f_Index < Pred(f_SubkeyCount);
  if Result then
  begin
    Inc(f_Index);
    f_CurrentKeyName := f_Subkeys[f_Index];
  end;
end;

procedure TnsRegistryKeyEnumerator.CleanUp;
begin
  f_Registry.CloseKey;
  FreeAndNil(f_Registry);
  FreeAndNil(f_SubKeys);
  inherited;
end;

class function TnsRegistryKeyEnumerator.Make(ARootKey: HKEY;
  const AFolderKey: AnsiString): InsRegistryKeyEnumerator;
var
  l_Inst: TnsRegistryKeyEnumerator;
begin
  l_Inst := Create(ARootKey, AFolderKey);
  try
    Result := l_Inst;
  finally
    FreeAndNil(l_Inst);
  end;
end;

constructor TnsRegistryKeyEnumerator.Create(ARootKey: HKEY;
  const AFolderKey: AnsiString); 
var
  l_RegKeyInfo: TRegKeyInfo;
begin
  inherited Create;

  f_Subkeys := TStringList.Create; 

  f_RootKey := ARootKey;
  f_FolderKeyName := AFolderKey;

  f_SubkeyCount := 0;
  f_Index := -1;

  f_Registry := TRegistry.Create;
  f_Registry.RootKey := f_RootKey;
  if f_Registry.OpenKeyReadonly(AFolderKey) then
    ObtainKeyInfo
  else
    Assert(False, f_FolderKeyName);
end;

{ TnsRegistryHelper }

class function TnsRegistryHelper.KeyEnumerator(ARootKey: HKEY;
  const AFolderKey: AnsiString): InsRegistryKeyEnumerator;
begin
  Result := TnsRegistryKeyEnumerator.Make(ARootKey, AFolderKey);
end;

end.
