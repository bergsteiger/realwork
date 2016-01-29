{*********************************************************************}
{                                                                     }
{             Add-In Express Component Library                        }
{                  Add-in Express for VCL                             }
{                                                                     }
{             Copyright (C) Add-in Express Ltd.                       }
{             ALL RIGHTS RESERVED                                     }
{                                                                     }
{    The entire contents of this file is protected by U.S. and        }
{    International Copyright Laws. Unauthorized reproduction,         }
{    reverse-engineering, and distribution of all or any portion of   } 
{    the code contained in this file is strictly prohibited and may   }
{    result in severe civil and criminal penalties and will be        }
{    prosecuted to the maximum extent possible under the law.         }
{                                                                     }
{    RESTRICTIONS                                                     }
{                                                                     }
{    THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES ARE        }
{    CONFIDENTIAL AND PROPRIETARY TRADE SECRETS OF ADD-IN EXPRESS     }
{    LTD.                                                             }
{    THE REGISTERED DEVELOPER IS LICENSED TO DISTRIBUTE THE Add-in    }
{    Express VCL AND ALL ACCOMPANYING VCL COMPONENTS AS PART          }
{    OF AN EXECUTABLE PROGRAM ONLY.                                   }
{                                                                     }
{    THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED       }
{    FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE         }
{    COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE        }
{    AVAILABLE TO OTHER INDIVIDUALS WITHOUT WRITTEN CONSENT           }
{    AND PERMISSION FROM ADD-IN EXPRESS LTD.                          }
{                                                                     }
{    CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON        }
{    ADDITIONAL RESTRICTIONS.                                         }
{                                                                     }
{*********************************************************************}

unit adxSmartTag;

{$I adxDefs.inc}

interface

uses Windows, SysUtils, Classes, Dialogs, Forms,
  {$IFNDEF ADX_VCL5}
  MaskUtils,
  {$ENDIF}
  {$IFDEF ADX_VCL5}
  Mask,
  {$ENDIF}
  {$IFDEF UNICODE}
  StrUtils,
  {$ENDIF}
  Menus, ComObj, ActiveX, adxSmartTagTLB;

type
  TadxSmartTagModule = class;
  TadxSmartTagModuleClass = class of TadxSmartTagModule;

  TadxRecognizerFactory = class(TAutoObjectFactory)
  private
    FFilePath: string;
    FDataModuleClass: TadxSmartTagModuleClass;
    function GetRegistryKey: string; virtual;
  protected
  public
    constructor Create(ComServer: TComServerObject; AutoClass: TAutoClass;
      const ClassID: TGUID; ModuleClass: TadxSmartTagModuleClass);
    procedure UpdateRegistry(Register: Boolean); override;
    property FilePath: string read FFilePath;
  end;

  TadxActionFactory = class(TadxRecognizerFactory)
  private
    function GetRegistryKey: string; override;
  protected
  public
  end;

  TadxRecognizerObject = class(TAutoObject, ISmartTagRecognizer, ISmartTagRecognizer2)
  private
    { ISmartTagRecognizer }
    function Get_ProgId: WideString; safecall;
    function Get_Name(LocaleID: SYSINT): WideString; safecall;
    function Get_Desc(LocaleID: SYSINT): WideString; safecall;
    function Get_SmartTagCount: SYSINT; safecall;
    function Get_SmartTagName(SmartTagID: SYSINT): WideString; safecall;
    function Get_SmartTagDownloadURL(SmartTagID: SYSINT): WideString; safecall;
    procedure Recognize(const Text: WideString; DataType: IF_TYPE; LocaleID: SYSINT;
      const RecognizerSite: ISmartTagRecognizerSite); safecall;
    { ISmartTagRecognizer2 }
    procedure Recognize2(const Text: WideString; DataType: IF_TYPE; LocaleID: SYSINT;
      const RecognizerSite2: ISmartTagRecognizerSite2;
      const ApplicationName: WideString; const TokenList: ISmartTagTokenList); safecall;
    function Get_PropertyPage(SmartTagID: SYSINT; LocaleID: SYSINT): WordBool; safecall;
    procedure DisplayPropertyPage(SmartTagID: SYSINT; LocaleID: SYSINT); safecall;
    procedure SmartTagInitialize(const ApplicationName: WideString); safecall;

    function GetFactory: TadxRecognizerFactory;
  protected
    { IDispatch }
    function Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
      Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult; override; stdcall;
  public
    procedure Initialize; override;
    procedure BeforeDestruction; override;
    property Factory: TadxRecognizerFactory read GetFactory;
  end;

  TadxActionObject = class(TAutoObject, ISmartTagAction, ISmartTagAction2)
  private
    { ISmartTagAction }
    function Get_ProgId: WideString; safecall;
    function Get_Name(LocaleID: SYSINT): WideString; safecall;
    function Get_Desc(LocaleID: SYSINT): WideString; safecall;
    function Get_SmartTagCount: SYSINT; safecall;
    function Get_SmartTagName(SmartTagID: SYSINT): WideString; safecall;
    function Get_SmartTagCaption(SmartTagID: SYSINT; LocaleID: SYSINT): WideString; safecall;
    function Get_VerbCount(const SmartTagName: WideString): SYSINT; safecall;
    function Get_VerbID(const SmartTagName: WideString; VerbIndex: SYSINT): SYSINT; safecall;
    function Get_VerbCaptionFromID(VerbID: SYSINT;
      const ApplicationName: WideString; LocaleID: SYSINT): WideString; safecall;
    function Get_VerbNameFromID(VerbID: SYSINT): WideString; safecall;
    procedure InvokeVerb(VerbID: SYSINT; const ApplicationName: WideString;
      const Target: IDispatch; const Properties: ISmartTagProperties;
      const Text: WideString; const Xml: WideString); safecall;
    { ISmartTagAction2 }
    function Get_VerbCaptionFromID2(VerbID: SYSINT; const ApplicationName: WideString;
      LocaleID: SYSINT; const Properties: ISmartTagProperties;
      const Text: WideString; const Xml: WideString;
      const Target: IDispatch): WideString; safecall;
    procedure InvokeVerb2(VerbID: SYSINT; const ApplicationName: WideString;
      const Target: IDispatch; const Properties: ISmartTagProperties;
      const Text: WideString; const Xml: WideString; LocaleID: SYSINT); safecall;
    function Get_IsCaptionDynamic(VerbID: SYSINT; const ApplicationName: WideString;
      LocaleID: SYSINT): WordBool; safecall;
    function Get_ShowSmartTagIndicator(VerbID: SYSINT; const ApplicationName: WideString;
      LocaleID: SYSINT): WordBool; safecall;
    procedure SmartTagInitialize(const ApplicationName: WideString); safecall;

    function GetFactory: TadxActionFactory;
  protected
    { IDispatch }
    function Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
      Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult; override; stdcall;
  public
    procedure Initialize; override;
    procedure BeforeDestruction; override;
    property Factory: TadxActionFactory read GetFactory;
  end;

  TadxActionEvent = procedure(Sender: TObject; const AppName: WideString;
    const Target: IDispatch; const Text, Xml: WideString; LocaleID: SYSINT) of object;
  TadxActionEventEx = procedure(Sender: TObject; const AppName: WideString;
    const Target: IDispatch; const Text, Xml: WideString; LocaleID: SYSINT;
    const Properties: ISmartTagProperties) of object;

  TadxSmartTagAction = class(TCollectionItem)
  private
    FTag: Integer;
    FVerbID: Integer;
    FName: WideString;
    FCaptions: TStringList;
    FOnClick: TadxActionEvent;
    FOnClickEx: TadxActionEventEx;
    function GetCaption: WideString;
    procedure SetCaption(const Value: WideString);
    function GetCaptions(LocaleID: Integer): WideString;
    procedure SetCaptions(LocaleID: Integer; const Value: WideString);
    procedure ReadCaptions(Reader: TReader);
    procedure WriteCaptions(Writer: TWriter);
    procedure SetName(const Value: WideString);
  protected
    procedure DefineProperties(Filer: TFiler); override;
    function GetDisplayName: string; override;
    procedure SetDisplayName(const Value: string); override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    property Captions[LocaleID: Integer]: WideString read GetCaptions write SetCaptions;
  published
    property Caption: WideString read GetCaption write SetCaption stored False;
    property Name: WideString read FName write SetName;
    property Tag: Integer read FTag write FTag default 0;
    property OnClick: TadxActionEvent read FOnClick write FOnClick;
    property OnClickEx: TadxActionEventEx read FOnClickEx write FOnClickEx;
  end;

  TadxSmartTagActions = class(TOwnedCollection)
  private
    function GetItem(Index: Integer): TadxSmartTagAction;
    procedure SetItem(Index: Integer; Value: TadxSmartTagAction);
  protected
    function GetAttrCount: Integer; override;
    function GetAttr(Index: Integer): string; override;
    function GetItemAttr(Index, ItemIndex: Integer): string; override;
    procedure SetItemName(Item: TCollectionItem); override;
  public
    function Add: TadxSmartTagAction;
    function FindItemID(ID: Integer): TadxSmartTagAction;
    function Insert(Index: Integer): TadxSmartTagAction;
    property Items[Index: Integer]: TadxSmartTagAction read GetItem write SetItem; default;
  end;

  TadxKindType = (ktList, ktMask, ktCustom);
  TadxCommitSmartTagProc = procedure (const Index, Len: Integer);

  TadxRecognizeEvent = procedure (Sender: TObject; const Text: WideString;
    DataType: IF_TYPE; LocaleID: Integer; const CommitSmartTagProc: TadxCommitSmartTagProc;
    AppName: string; const TokenList: ISmartTagTokenList) of object;
  TadxRecognizedEvent = procedure (Sender: TObject; PropertyBag: ISmartTagProperties) of object;
  TadxPropertyPageEvent = procedure (Sender: TObject; LocaleID: Integer) of object;

  {$IFDEF ADX_VCL5}
  TEditMask = type string;
  {$ENDIF}

  TadxSmartTag = class(TComponent)
  private
    FOwner: TadxSmartTagModule;
    FActions: TadxSmartTagActions;
    FCaptions: TStringList;
    FDownloadURL: WideString;
    FKind: TadxKindType;
    FRecognizedMask: TEditMask;
    FRecognizedWords: TStrings;
    FOnActionNeeded: TNotifyEvent;
    FOnRecognize: TadxRecognizeEvent;
    FOnRecognized: TadxRecognizedEvent;
    FOnPropertyPage: TadxPropertyPageEvent;
    procedure SetRecognizedWords(const Value: TStrings);
    function GetCaption: WideString;
    procedure SetCaption(const Value: WideString);
    function GetCaptions(LocaleID: Integer): WideString;
    procedure SetCaptions(LocaleID: Integer; const Value: WideString);
    procedure ReadCaptions(Reader: TReader);
    procedure WriteCaptions(Writer: TWriter);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Captions[LocaleID: Integer]: WideString read GetCaptions write SetCaptions;
  published
    property Actions: TadxSmartTagActions read FActions write FActions;
    property Caption: WideString read GetCaption write SetCaption stored False;
    property DownloadURL: WideString read FDownloadURL write FDownloadURL;
    property Kind: TadxKindType read FKind write FKind default ktList;
    property RecognizedMask: TEditMask read FRecognizedMask write FRecognizedMask;
    property RecognizedWords: TStrings read FRecognizedWords write SetRecognizedWords;
    property OnActionNeeded: TNotifyEvent read FOnActionNeeded write FOnActionNeeded;
    property OnPropertyPage: TadxPropertyPageEvent read FOnPropertyPage write FOnPropertyPage;
    property OnRecognize: TadxRecognizeEvent read FOnRecognize write FOnRecognize;
    property OnRecognized: TadxRecognizedEvent read FOnRecognized write FOnRecognized;
  end;

  TInitializeEvent = procedure (Sender: TObject;
    ApplicationName: WideString) of object;
  TOnErrorEvent = procedure (const E: SysUtils.Exception;
    var Handled: boolean) of object;

  TadxSmartTagModule = class(TDataModule)
  private
    FNamespaceURI: string;
    FSmartTags: TList;
    FSmartTagNames: TStringList;
    FSmartTagDescs: TStringList;
    FOnActionInitialize: TInitializeEvent;
    FOnActionFinalize: TNotifyEvent;
    FOnInitialize: TInitializeEvent;
    FOnFinalize: TNotifyEvent;
    FOnError: TOnErrorEvent;
    function GetSmartTagName: WideString;
    procedure SetSmartTagName(const Value: WideString);
    function GetSmartTagDesc: WideString;
    procedure SetSmartTagDesc(const Value: WideString);
    function GetSmartTagNames(LocaleID: Integer): WideString;
    procedure SetSmartTagNames(LocaleID: Integer; const Value: WideString);
    function GetSmartTagDescs(LocaleID: Integer): WideString;
    procedure SetSmartTagDescs(LocaleID: Integer; const Value: WideString);
    procedure ReadNames(Reader: TReader);
    procedure WriteNames(Writer: TWriter);
    procedure ReadDescs(Reader: TReader);
    procedure WriteDescs(Writer: TWriter);
    procedure DoError(const E: Exception);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property SmartTagDescs[LocaleID: Integer]: WideString read GetSmartTagDescs write SetSmartTagDescs;
    property SmartTagNames[LocaleID: Integer]: WideString read GetSmartTagNames write SetSmartTagNames;
  published
    property NamespaceURI: string read FNamespaceURI write FNamespaceURI;
    property SmartTagDesc: WideString read GetSmartTagDesc write SetSmartTagDesc stored False;
    property SmartTagName: WideString read GetSmartTagName write SetSmartTagName stored False;
    property OnActionInitialize: TInitializeEvent read FOnActionInitialize write FOnActionInitialize;
    property OnActionFinalize: TNotifyEvent read FOnActionFinalize write FOnActionFinalize;
    property OnInitialize: TInitializeEvent read FOnInitialize write FOnInitialize;
    property OnFinalize: TNotifyEvent read FOnFinalize write FOnFinalize;
    property OnError: TOnErrorEvent read FOnError write FOnError;
  end;

function GetStrings(Source: TPersistent; const PropName: string): TStringList;

implementation

uses Registry, adxAddIn;

{$IFDEF ADX_TRIAL}
{$I Trial_st_1.inc}
{$ENDIF}

const
  adxSmartRegKey = '\Software\Microsoft\Office\Common\Smart Tag\%s\';

  { Error messages }
  adxST_ECode = 32100;
  adxST_ECodeCantBeEmpty = adxST_ECode + 1;
  adxST_ErrorCantBeEmpty = 'The %s property cannot be empty.';
  adxST_ECodeCantDelete = adxST_ECode + 2;
  adxST_ErrorCantDelete = 'Cannot delete the registry key.';
  adxST_ECodeNameUnique = adxST_ECode + 3;
  adxST_ErrorNameUnique = 'The Name property must be unique.';

var
  FModule: TadxSmartTagModule = nil;

function GetStrings(Source: TPersistent; const PropName: string): TStringList;
begin
  Result := nil; 
  if Source is TadxSmartTagModule then begin
    if PropName = 'SmartTagName' then
      Result := (Source as TadxSmartTagModule).FSmartTagNames
    else
      Result := (Source as TadxSmartTagModule).FSmartTagDescs;
  end
  else
  if Source is TadxSmartTag then
    Result := (Source as TadxSmartTag).FCaptions
  else
  if Source is TadxSmartTagAction then
    Result := (Source as TadxSmartTagAction).FCaptions;
end;

{ TadxRecognizerFactory }

constructor TadxRecognizerFactory.Create(ComServer: TComServerObject;
  AutoClass: TAutoClass; const ClassID: TGUID; ModuleClass: TadxSmartTagModuleClass);
var
  Buffer: array [0..MAX_PATH + 1] of Char;
begin
  inherited Create(ComServer, AutoClass, ClassID, ciMultiInstance, tmApartment);
  FDataModuleClass := ModuleClass;
  {$IFDEF UNICODE}
  SetString(FFilePath, Buffer, Windows.GetModuleFileName(HInstance, Buffer, Length(Buffer)));
  {$ELSE}
  SetString(FFilePath, Buffer, Windows.GetModuleFileName(HInstance, Buffer, SizeOf(Buffer)));
  {$ENDIF}
  FFilePath := ExtractFilePath(FFilePath);
end;

procedure TadxRecognizerFactory.UpdateRegistry(Register: Boolean);
begin
  // Case #913
  if not RegisterToHKCU then inherited UpdateRegistry(Register);
  with TRegistry.Create do
    try
      try
        if Register then CreateKey(GetRegistryKey)
        else
          if not DeleteKey(GetRegistryKey) then
            raise SysUtils.Exception.Create(adxST_ErrorCantDelete);
      except
        on E: SysUtils.Exception do begin
          MessageDlg(E.Message, mtError, [mbOK], 0);
          raise;
        end;
      end;
    finally
      Free;
    end;
end;

function TadxRecognizerFactory.GetRegistryKey: string;
begin
  Result := Format(adxSmartRegKey + GUIDToString(ClassID), ['Recognizers']);
end;

{ TadxSmartTagActionFactory }

function TadxActionFactory.GetRegistryKey: string;
begin
  Result := Format(adxSmartRegKey + GUIDToString(ClassID), ['Actions']);
end;

{ TadxSmartRecognizer }

function GetOfficeVersion: string;
const
  RegKey: string = '\%s.Application\CurVer';
begin
  Result := '10';
  with TRegistry.Create(KEY_READ) do
    try
      RootKey := HKEY_CLASSES_ROOT;
      if OpenKey(Format(RegKey, ['Excel']), False) then begin
        Result := ReadString('');
        CloseKey;
        while Pos('.', Result) > 0 do Delete(Result, 1, Pos('.', Result));
      end
      else
        if OpenKey(Format(RegKey, ['Word']), False) then begin
          Result := ReadString('');
          CloseKey;
          while Pos('.', Result) > 0 do Delete(Result, 1, Pos('.', Result));
        end;
    finally
      Free;
    end;
end;

procedure TadxRecognizerObject.Initialize;
begin
  inherited Initialize;
  if FModule = nil then FModule := Factory.FDataModuleClass.Create(nil);
  if GetOfficeVersion = '10' then
    if Assigned(FModule) and Assigned(FModule.FOnInitialize) then
      try
        FModule.FOnInitialize(Self, '');
      except
        on E: Exception do FModule.DoError(E);
      end;
  {$IFDEF ADX_TRIAL}
  {$I Trial_st_2.inc}
  {$ENDIF}
end;

procedure TadxRecognizerObject.BeforeDestruction;
begin
  if Assigned(FModule) and Assigned(FModule.FOnFinalize) then
    try
      FModule.FOnFinalize(Self);
    except
      on E: Exception do FModule.DoError(E);
    end;
  inherited BeforeDestruction;
end;

{ ISmartRecognizer }

function TadxRecognizerObject.Get_ProgId: WideString;
begin
  Result := Factory.ProgID;
end;

function TadxRecognizerObject.Get_Name(LocaleID: SYSINT): WideString;
begin
  Result := FModule.FSmartTagNames.Values[IntToStr(LocaleID)];
  if Result = '' then
    Result := FModule.FSmartTagNames.Values['0'];
end;

function TadxRecognizerObject.Get_Desc(LocaleID: SYSINT): WideString;
begin
  Result := FModule.FSmartTagDescs.Values[IntToStr(LocaleID)];
  if Result = '' then
    Result := FModule.FSmartTagDescs.Values['0'];
end;

function TadxRecognizerObject.Get_SmartTagCount: SYSINT;
begin
  {$IFDEF ADX_TRIAL}
  Result := 0;
  if FModule.FSmartTags.Count > 0 then Result := 1;
  {$ELSE}
  Result := FModule.FSmartTags.Count;
  {$ENDIF}
end;

function TadxRecognizerObject.Get_SmartTagName(SmartTagID: SYSINT): WideString;
begin
  Result := '';
  if (SmartTagID > 0) and (SmartTagID <= FModule.FSmartTags.Count) then
    Result := FModule.NamespaceURI + '#' + TadxSmartTag(FModule.FSmartTags[SmartTagID - 1]).Name;
end;

function TadxRecognizerObject.Get_SmartTagDownloadURL(SmartTagID: SYSINT): WideString;
begin
  Result := '';
  if (SmartTagID > 0) and (SmartTagID <= FModule.FSmartTags.Count) then
    Result := TadxSmartTag(FModule.FSmartTags[SmartTagID - 1]).DownloadURL;
end;

function Pos2(const SubStr, S: string; Offset: Integer): Integer;
var
  i, x: Integer;
  Len, LenSubStr: Integer;
begin
  if Offset = 1 then Result := Pos(SubStr, S)
  else begin
    i := Offset;
    LenSubStr := Length(SubStr);
    Len := Length(S) - LenSubStr + 1;
    while i <= Len do begin
      if S[i] = SubStr[1] then begin
        x := 1;
        while (x < LenSubStr) and (S[i + x] = SubStr[x + 1]) do Inc(x);
        if x = LenSubStr then begin
          Result := i;
          Exit;
        end;
      end;
      Inc(i);
    end;
    Result := 0;
  end;
end;

var
  RS: ISmartTagRecognizerSite;
  RS2: ISmartTagRecognizerSite2;
  SmartTag: TadxSmartTag;

procedure CommitProc(const Index, Len: Integer);
var
  PropertyBag: ISmartTagProperties;
begin
  PropertyBag := RS.GetNewPropertyBag;
  if Assigned(SmartTag.FOnRecognized) then
    try
      SmartTag.FOnRecognized(SmartTag, PropertyBag);
    except
      on E: Exception do FModule.DoError(E);
    end;
  RS.CommitSmartTag(FModule.NamespaceURI + '#' + SmartTag.Name, Index, Len, PropertyBag);
end;

procedure CommitProc2(const Index, Len: Integer);
var
  PropertyBag: ISmartTagProperties;
begin
  PropertyBag := RS2.GetNewPropertyBag;
  if Assigned(SmartTag.FOnRecognized) then
    try
      SmartTag.FOnRecognized(SmartTag, PropertyBag);
    except
      on E: Exception do FModule.DoError(E);
    end;
  RS2.CommitSmartTag2(FModule.NamespaceURI + '#' + SmartTag.Name, Index, Len, PropertyBag);
end;

procedure TadxRecognizerObject.Recognize(const Text: WideString;
  DataType: IF_TYPE; LocaleID: SYSINT;
  const RecognizerSite: ISmartTagRecognizerSite);

var
  i, j, Index: Integer;
  LocalText, Word, MaskText: WideString;
  PropertyBag: ISmartTagProperties;
begin
  LocalText := LowerCase(Text);
{$IFDEF ADX_TRIAL}
  if FModule.FSmartTags.Count > 0 then begin
    i := 0;
{$ELSE}
  for i := 0 to FModule.FSmartTags.Count - 1 do begin
{$ENDIF}
    SmartTag := TadxSmartTag(FModule.FSmartTags[i]);
    if SmartTag.Kind = ktList then
      for j := 0 to SmartTag.RecognizedWords.Count - 1 do begin
        Word := WideString(LowerCase(SmartTag.RecognizedWords[j]));
        {$IFDEF UNICODE}
        Index := PosEx(Word, LocalText, 1);
        {$ELSE}
        Index := Pos2(Word, LocalText, 1);
        {$ENDIF}
        while Index > 0 do begin
          PropertyBag := RecognizerSite.GetNewPropertyBag;
          if Assigned(SmartTag.FOnRecognized) then
            try
              SmartTag.FOnRecognized(SmartTag, PropertyBag);
            except
              on E: Exception do FModule.DoError(E);
            end;
          RecognizerSite.CommitSmartTag(FModule.NamespaceURI + '#' + SmartTag.Name, Index, Length(Word), PropertyBag);
          {$IFDEF UNICODE}
          Index := PosEx(Word, LocalText, Index + Length(Word));
          {$ELSE}
          Index := Pos2(Word, LocalText, Index + Length(Word));
          {$ENDIF}
        end;
      end
    else
      if (SmartTag.Kind = ktMask) and (SmartTag.RecognizedMask <> '') then begin
        // $0D character (MS Word)
        if DataType = IF_TYPE_PARA then LocalText := Trim(LocalText);
        MaskText := FormatMaskText(SmartTag.RecognizedMask, LocalText);
        if MaskText = LocalText then begin
          PropertyBag := RecognizerSite.GetNewPropertyBag;
          if Assigned(SmartTag.FOnRecognized) then
            try
              SmartTag.FOnRecognized(SmartTag, PropertyBag);
            except
              on E: Exception do FModule.DoError(E);
            end;
          RecognizerSite.CommitSmartTag(FModule.NamespaceURI + '#' + SmartTag.Name, 1, Length(MaskText), PropertyBag);
        end;
      end
      else
        if Assigned(SmartTag.FOnRecognize) then
          try
            RS := RecognizerSite;
            try
              SmartTag.FOnRecognize(SmartTag, Text, DataType, LocaleID, @CommitProc, '', nil);
            finally
              RS := nil;
            end;
          except
            on E: Exception do FModule.DoError(E);
          end;
  end;
end;

{ ISmartTagRecognizer2 }

procedure TadxRecognizerObject.Recognize2(const Text: WideString;
  DataType: IF_TYPE; LocaleID: SYSINT;
  const RecognizerSite2: ISmartTagRecognizerSite2;
  const ApplicationName: WideString;
  const TokenList: ISmartTagTokenList);

var
  i, j, Index: Integer;
  LocalText, Word, MaskText: WideString;
  PropertyBag: ISmartTagProperties;
begin
  LocalText := LowerCase(Text);
{$IFDEF ADX_TRIAL}
  if FModule.FSmartTags.Count > 0 then begin
    i := 0;
{$ELSE}
  for i := 0 to FModule.FSmartTags.Count - 1 do begin
{$ENDIF}
    SmartTag := TadxSmartTag(FModule.FSmartTags[i]);
    if SmartTag.Kind = ktList then
      for j := 0 to SmartTag.RecognizedWords.Count - 1 do begin
        Word := WideString(LowerCase(SmartTag.RecognizedWords[j]));
        {$IFDEF UNICODE}
        Index := PosEx(Word, LocalText, 1);
        {$ELSE}
        Index := Pos2(Word, LocalText, 1);
        {$ENDIF}
        while Index > 0 do begin
          PropertyBag := RecognizerSite2.GetNewPropertyBag;
          if Assigned(SmartTag.FOnRecognized) then
            try
              SmartTag.FOnRecognized(SmartTag, PropertyBag);
            except
              on E: Exception do FModule.DoError(E);
            end;
          RecognizerSite2.CommitSmartTag(FModule.NamespaceURI + '#' + SmartTag.Name, Index, Length(Word), PropertyBag);
          {$IFDEF UNICODE}
          Index := PosEx(Word, LocalText, Index + Length(Word));
          {$ELSE}
          Index := Pos2(Word, LocalText, Index + Length(Word));
          {$ENDIF}
        end;
      end
    else
      if (SmartTag.Kind = ktMask) and (SmartTag.RecognizedMask <> '') then begin
        // $0D character (MS Word)
        if DataType = IF_TYPE_PARA then LocalText := Trim(LocalText);
        MaskText := FormatMaskText(SmartTag.RecognizedMask, LocalText);
        if MaskText = LocalText then begin
          PropertyBag := RecognizerSite2.GetNewPropertyBag;
          if Assigned(SmartTag.FOnRecognized) then
            try
              SmartTag.FOnRecognized(SmartTag, PropertyBag);
            except
              on E: Exception do FModule.DoError(E);
            end;
          RecognizerSite2.CommitSmartTag(FModule.NamespaceURI + '#' + SmartTag.Name, 1, Length(MaskText), PropertyBag);
        end;
      end
      else
        if Assigned(SmartTag.FOnRecognize) then
          try
            RS2 := RecognizerSite2;
            try
              SmartTag.FOnRecognize(SmartTag, Text, DataType, LocaleID, @CommitProc2, ApplicationName, TokenList);
            finally
              RS2 := nil;
            end;
          except
            on E: Exception do FModule.DoError(E);
          end;
  end;
end;

function TadxRecognizerObject.Get_PropertyPage(SmartTagID: SYSINT; LocaleID: SYSINT): WordBool;
begin
  Result := False;
  if (SmartTagID > 0) and (SmartTagID <= FModule.FSmartTags.Count) then
    Result := Assigned(TadxSmartTag(FModule.FSmartTags[SmartTagID - 1]).FOnPropertyPage);
end;

procedure TadxRecognizerObject.DisplayPropertyPage(SmartTagID: SYSINT; LocaleID: SYSINT);
var
  ST: TadxSmartTag;
begin
  if (SmartTagID > 0) and (SmartTagID <= FModule.FSmartTags.Count) then begin
    ST := TadxSmartTag(FModule.FSmartTags[SmartTagID - 1]);
    if Assigned(ST.FOnPropertyPage) then
      try
        ST.FOnPropertyPage(ST, LocaleID);
      except
        on E: Exception do FModule.DoError(E);
      end;
  end;
end;

procedure TadxRecognizerObject.SmartTagInitialize(const ApplicationName: WideString);
begin
  if Assigned(FModule) and Assigned(FModule.FOnInitialize) then
    try
      FModule.FOnInitialize(Self, ApplicationName);
    except
      on E: Exception do FModule.DoError(E);
    end;
end;

function TadxRecognizerObject.Invoke(DispID: Integer; const IID: TGUID;
  LocaleID: Integer; Flags: Word; var Params; VarResult, ExcepInfo,
  ArgErr: Pointer): HResult;
type
  TVariantArray = array of OleVariant;
var
  i: integer;
  TempRet: Variant;
  vVarArray : TVariantArray;
  vPVarArgIn: PVariantArg;
  vPDispParams: PDispParams;
  vFistArrItem, vLastArrItem: integer;
begin
  try
    if VarResult = nil then VarResult := @TempRet;
    vPDispParams := PDispParams(@Params);
    SetLength(vVarArray, vPDispParams.cArgs);
    vFistArrItem := Low(vVarArray); vLastArrItem := High(vVarArray);
    if vPDispParams.cNamedArgs > 0 then
      for i := vFistArrItem to vLastArrItem do begin
        vPVarArgIn := @vPDispParams.rgvarg[i];
        vVarArray[vPDispParams.rgdispidNamedArgs[i]] := POleVariant(vPVarArgIn)^;
      end
    else
      for i := vFistArrItem to vLastArrItem do begin
        vPVarArgIn := @vPDispParams.rgvarg[i];
        vVarArray[vLastArrItem - i] := POleVariant(vPVarArgIn)^;
      end;
    Result := S_OK;
    case DispID of
      -1: Result := DISPID_UNKNOWN;
      { ISmartTagRecognizer }
      1: POleVariant(VarResult)^ := Get_ProgId;
      2: POleVariant(VarResult)^ := Get_Name(vVarArray[0] {SYSINT});
      3: POleVariant(VarResult)^ := Get_Desc(vVarArray[0] {SYSINT});
      4: POleVariant(VarResult)^ := Get_SmartTagCount;
      5: POleVariant(VarResult)^ := Get_SmartTagName(vVarArray[0] {SYSINT});
      6: POleVariant(VarResult)^ := Get_SmartTagDownloadURL(vVarArray[0] {SYSINT});
      7: Recognize(vVarArray[0] {const WideString}, vVarArray[1] {IF_TYPE}, vVarArray[2] {SYSINT},
                   IUnknown(TVarData(vVarArray[3]).VPointer) as ISmartTagRecognizerSite {const ISmartTagRecognizerSite});
      { ISmartTagRecognizer2 }
      8: Recognize2(vVarArray[0] {const WideString}, vVarArray[1] {IF_TYPE}, vVarArray[2] {SYSINT},
                    IUnknown(TVarData(vVarArray[3]).VPointer) as ISmartTagRecognizerSite2 {const ISmartTagRecognizerSite2},
                    vVarArray[4] {const WideString},
                    IUnknown(TVarData(vVarArray[5]).VPointer) as ISmartTagTokenList {const ISmartTagTokenList});
      9: POleVariant(VarResult)^ := Get_PropertyPage(vVarArray[0] {SYSINT}, vVarArray[1] {SYSINT});
      10: DisplayPropertyPage(vVarArray[0] {SYSINT}, vVarArray[1] {SYSINT});
      16: SmartTagInitialize(vVarArray[0] {const WideString});
      else Result := DISPID_UNKNOWN;
    end;
    if vPDispParams.cNamedArgs > 0 then
      for i := vFistArrItem to vLastArrItem do begin
        vPVarArgIn := @vPDispParams.rgvarg[i];
        if (vPVarArgIn.vt and varByRef) <> varByRef then Continue;
        POleVariant(vPVarArgIn)^ := vVarArray[vPDispParams.rgdispidNamedArgs[i]];
      end
    else
      for i := vFistArrItem to vLastArrItem do begin
        vPVarArgIn := @vPDispParams.rgvarg[i];
        if (vPVarArgIn.vt and varByRef) <> varByRef then Continue;
        POleVariant(vPVarArgIn)^ := vVarArray[vLastArrItem - i];
      end;
    SetLength(vVarArray, 0);
  except
    if ExcepInfo <> nil then begin
      FillChar(ExcepInfo^, SizeOf(TExcepInfo), 0);
      with TExcepInfo(ExcepInfo^) do begin
        bstrSource := StringToOleStr(ClassName);
        if ExceptObject is Exception then
          bstrDescription := StringToOleStr(Exception(ExceptObject).Message);
        scode := E_FAIL;
      end;
    end;
    Result := DISP_E_EXCEPTION;
  end;
end;

function TadxRecognizerObject.GetFactory: TadxRecognizerFactory;
begin
  Result := (inherited Factory) as TadxRecognizerFactory;
end;

{ TadxSmartAction }

procedure TadxActionObject.Initialize;
begin
  inherited Initialize;
  if FModule = nil then FModule := Factory.FDataModuleClass.Create(nil);
  if GetOfficeVersion = '10' then
    if Assigned(FModule) and Assigned(FModule.FOnActionInitialize) then
      try
        FModule.FOnActionInitialize(Self, '');
      except
        on E: Exception do FModule.DoError(E);
      end;
end;

procedure TadxActionObject.BeforeDestruction;
begin
  if Assigned(FModule) and Assigned(FModule.FOnActionFinalize) then
    try
      FModule.FOnActionFinalize(Self);
    except
      on E: Exception do FModule.DoError(E);
    end;
  inherited BeforeDestruction;
end;

{ ISmartTagAction }

function TadxActionObject.Get_ProgId: WideString;
begin
  Result := Factory.ProgID;
end;

function TadxActionObject.Get_Name(LocaleID: SYSINT): WideString;
begin
  Result := FModule.FSmartTagNames.Values[IntToStr(LocaleID)];
  if Result = '' then
    Result := FModule.FSmartTagNames.Values['0'];
end;

function TadxActionObject.Get_Desc(LocaleID: SYSINT): WideString;
begin
  Result := FModule.FSmartTagDescs.Values[IntToStr(LocaleID)];
  if Result = '' then
    Result := FModule.FSmartTagDescs.Values['0'];
end;

function TadxActionObject.Get_SmartTagCount: SYSINT;
begin
  {$IFDEF ADX_TRIAL}
  Result := 0;
  if FModule.FSmartTags.Count > 0 then Result := 1;
  {$ELSE}
  Result := FModule.FSmartTags.Count;
  {$ENDIF}
end;

function TadxActionObject.Get_SmartTagName(SmartTagID: SYSINT): WideString;
begin
  Result := '';
  if (SmartTagID > 0) and (SmartTagID <= FModule.FSmartTags.Count) then
    Result := FModule.NamespaceURI + '#' + TadxSmartTag(FModule.FSmartTags[SmartTagID - 1]).Name;
end;

function TadxActionObject.Get_SmartTagCaption(SmartTagID, LocaleID: SYSINT): WideString;
begin
  Result := '';
  if (SmartTagID > 0) and (SmartTagID <= FModule.FSmartTags.Count) then
    Result := TadxSmartTag(FModule.FSmartTags[SmartTagID - 1]).Captions[LocaleID];
end;

function TadxActionObject.Get_VerbCount(const SmartTagName: WideString): SYSINT;
{$IFNDEF ADX_TRIAL}
var
  i: Integer;
  LocalSmartTag: TadxSmartTag;
{$ENDIF}
begin
  {$IFDEF ADX_TRIAL}
  Result := 0;
  if FModule.FSmartTags.Count > 0 then begin
    if TadxSmartTag(FModule.FSmartTags[0]).Actions.Count > 0 then begin
      Result := 1;
    end;
  end;
  {$ELSE}
  for i := 0 to FModule.FSmartTags.Count - 1 do begin
    LocalSmartTag := TadxSmartTag(FModule.FSmartTags[i]);
    if SmartTagName = FModule.NamespaceURI + '#' + LocalSmartTag.Name then begin
      if Assigned(LocalSmartTag.FOnActionNeeded) then
        try
          LocalSmartTag.FOnActionNeeded(LocalSmartTag);
        except
          on E: Exception do FModule.DoError(E);
        end;
      Result := LocalSmartTag.Actions.Count;
      Break;
    end;
  end;
  {$ENDIF}
end;

function TadxActionObject.Get_VerbID(const SmartTagName: WideString; VerbIndex: SYSINT): SYSINT;
var
  i: Integer;
begin
  Result := 0;
  {$IFDEF ADX_TRIAL}
  if FModule.FSmartTags.Count > 0 then begin
    i := 0;
  {$ELSE}
  for i := 0 to FModule.FSmartTags.Count - 1 do begin
  {$ENDIF}
    if SmartTagName = FModule.NamespaceURI + '#' + TadxSmartTag(FModule.FSmartTags[i]).Name then begin
      TadxSmartTag(FModule.FSmartTags[i]).Actions[VerbIndex - 1].FVerbID := i * 100 + VerbIndex;
      Result := TadxSmartTag(FModule.FSmartTags[i]).Actions[VerbIndex - 1].FVerbID;
  {$IFNDEF ADX_TRIAL}
      Break;
  {$ENDIF}
    end;
  end;
end;

function TadxActionObject.Get_VerbCaptionFromID(VerbID: SYSINT;
  const ApplicationName: WideString; LocaleID: SYSINT): WideString;
var
  i, j: Integer;
begin
  Result := '';
  {$IFDEF ADX_TRIAL}
  if FModule.FSmartTags.Count > 0 then begin
    i := 0;
  {$ELSE}
  for i := 0 to FModule.FSmartTags.Count - 1 do begin
  {$ENDIF}
    for j := 0 to TadxSmartTag(FModule.FSmartTags[i]).Actions.Count - 1 do
      if TadxSmartTag(FModule.FSmartTags[i]).Actions[j].FVerbID = VerbID then begin
        Result := TadxSmartTag(FModule.FSmartTags[i]).Actions[j].Captions[LocaleID];
        Exit;
      end;
  end;
end;

function TadxActionObject.Get_VerbNameFromID(VerbID: SYSINT): WideString;
var
  i, j: Integer;
begin
  Result := '';
  {$IFDEF ADX_TRIAL}
  if FModule.FSmartTags.Count > 0 then begin
    i := 0;
  {$ELSE}
  for i := 0 to FModule.FSmartTags.Count - 1 do begin
  {$ENDIF}
    for j := 0 to TadxSmartTag(FModule.FSmartTags[i]).Actions.Count - 1 do
      if TadxSmartTag(FModule.FSmartTags[i]).Actions[j].FVerbID = VerbID then begin
        Result := TadxSmartTag(FModule.FSmartTags[i]).Actions[j].Name;
        Exit;
      end;
  end;
end;

procedure TadxActionObject.InvokeVerb(VerbID: SYSINT;
  const ApplicationName: WideString; const Target: IDispatch;
  const Properties: ISmartTagProperties; const Text, Xml: WideString);
begin
  InvokeVerb2(VerbID, ApplicationName, Target, Properties, Text, Xml, 0);
end;

{ ISmartTagAction2 }

function TadxActionObject.Get_VerbCaptionFromID2(VerbID: SYSINT; const ApplicationName: WideString;
  LocaleID: SYSINT; const Properties: ISmartTagProperties;
  const Text: WideString; const Xml: WideString;
  const Target: IDispatch): WideString; safecall;
begin
  Result := Get_VerbCaptionFromID(VerbID, ApplicationName, LocaleID);
end;

procedure TadxActionObject.InvokeVerb2(VerbID: SYSINT; const ApplicationName: WideString;
  const Target: IDispatch; const Properties: ISmartTagProperties;
  const Text: WideString; const Xml: WideString; LocaleID: SYSINT); safecall;
var
  i, j: Integer;
  Action: TadxSmartTagAction;
begin
  Action := nil;
  {$IFDEF ADX_TRIAL}
  if FModule.FSmartTags.Count > 0 then begin
    i := 0;
  {$ELSE}
  for i := 0 to FModule.FSmartTags.Count - 1 do begin
  {$ENDIF}
    for j := 0 to TadxSmartTag(FModule.FSmartTags[i]).Actions.Count - 1 do
      if TadxSmartTag(FModule.FSmartTags[i]).Actions[j].FVerbID = VerbID then begin
        Action := TadxSmartTag(FModule.FSmartTags[i]).Actions[j];
        Break;
      end;
  {$IFNDEF ADX_TRIAL}
    if Assigned(Action) then Break;
  {$ENDIF}
  end;
  if Assigned(Action) and Assigned(Action.FOnClick) then begin
    try
      Action.FOnClick(Action, ApplicationName, Target, Text, Xml, LocaleID);
    except
      on E: Exception do FModule.DoError(E);
    end;
  end;
  if Assigned(Action) and Assigned(Action.FOnClickEx) then begin
    try
      Action.FOnClickEx(Action, ApplicationName, Target, Text, Xml, LocaleID, Properties);
    except
      on E: Exception do FModule.DoError(E);
    end;
  end;
end;

function TadxActionObject.Get_IsCaptionDynamic(VerbID: SYSINT; const ApplicationName: WideString;
  LocaleID: SYSINT): WordBool; safecall;
begin
  Result := True;
end;

function TadxActionObject.Get_ShowSmartTagIndicator(VerbID: SYSINT; const ApplicationName: WideString;
  LocaleID: SYSINT): WordBool; safecall;
begin
  Result := True;
end;

procedure TadxActionObject.SmartTagInitialize(const ApplicationName: WideString); safecall;
begin
  if Assigned(FModule) and Assigned(FModule.FOnActionInitialize) then
    try
      FModule.FOnActionInitialize(Self, ApplicationName);
    except
      on E: Exception do FModule.DoError(E);
    end;
end;

{ IDispatch }

function TadxActionObject.Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
  Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult;
type
  TVariantArray = array of OleVariant;
var
  i: integer;
  TempRet: Variant;
  vVarArray : TVariantArray;
  vPVarArgIn: PVariantArg;
  vPDispParams: PDispParams;
  vFistArrItem, vLastArrItem: integer;
begin
  try
    if VarResult = nil then VarResult := @TempRet;
    vPDispParams := PDispParams(@Params);
    SetLength(vVarArray, vPDispParams.cArgs);
    vFistArrItem := Low(vVarArray); vLastArrItem := High(vVarArray);
    if vPDispParams.cNamedArgs > 0 then
      for i := vFistArrItem to vLastArrItem do begin
        vPVarArgIn := @vPDispParams.rgvarg[i];
        vVarArray[vPDispParams.rgdispidNamedArgs[i]] := POleVariant(vPVarArgIn)^;
      end
    else
      for i := vFistArrItem to vLastArrItem do begin
        vPVarArgIn := @vPDispParams.rgvarg[i];
        vVarArray[vLastArrItem - i] := POleVariant(vPVarArgIn)^;
      end;
    Result := S_OK;
    case DispID of
      -1: Result := DISPID_UNKNOWN;
      { ISmartTagAction }
      1: POleVariant(VarResult)^ := Get_ProgId;
      2: POleVariant(VarResult)^ := Get_Name(vVarArray[0] {SYSINT});
      3: POleVariant(VarResult)^ := Get_Desc(vVarArray[0] {SYSINT});
      4: POleVariant(VarResult)^ := Get_SmartTagCount;
      5: POleVariant(VarResult)^ := Get_SmartTagName(vVarArray[0] {SYSINT});
      6: POleVariant(VarResult)^ := Get_SmartTagCaption(vVarArray[0] {SYSINT},
                                                        vVarArray[1] {SYSINT});
      7: POleVariant(VarResult)^ := Get_VerbCount(vVarArray[0] {const WideString});
      8: POleVariant(VarResult)^ := Get_VerbID(vVarArray[0] {const WideString},
                                               vVarArray[1] {SYSINT});
      9: POleVariant(VarResult)^ := Get_VerbCaptionFromID(vVarArray[0] {SYSINT},
                                                          vVarArray[1] {const WideString},
                                                          vVarArray[2] {SYSINT});
      10: POleVariant(VarResult)^ := Get_VerbNameFromID(vVarArray[0] {SYSINT});
      11: InvokeVerb(vVarArray[0] {SYSINT}, vVarArray[1] {const WideString},
                     IUnknown(TVarData(vVarArray[2]).VPointer) as IDispatch {const IDispatch},
                     IUnknown(TVarData(vVarArray[3]).VPointer) as ISmartTagProperties {const ISmartTagProperties},
                     vVarArray[4] {const WideString},
                     vVarArray[5] {const WideString});
      { ISmartTagAction2 }
      12: POleVariant(VarResult)^ := Get_VerbCaptionFromID2(vVarArray[0] {SYSINT},
                                                            vVarArray[1] {const WideString},
                                                            vVarArray[2] {SYSINT},
                                                            IUnknown(TVarData(vVarArray[3]).VPointer) as ISmartTagProperties {const ISmartTagProperties},
                                                            vVarArray[4] {const WideString},
                                                            vVarArray[5] {const WideString},
                                                            IUnknown(TVarData(vVarArray[6]).VPointer) as IDispatch {const IDispatch});
      13: InvokeVerb2(vVarArray[0] {SYSINT}, vVarArray[1] {const WideString},
                      IUnknown(TVarData(vVarArray[2]).VPointer) as IDispatch {const IDispatch},
                      IUnknown(TVarData(vVarArray[3]).VPointer) as ISmartTagProperties {const ISmartTagProperties},
                      vVarArray[4] {const WideString},
                      vVarArray[5] {const WideString},
                      vVarArray[6] {SYSINT});
      14: POleVariant(VarResult)^ := Get_IsCaptionDynamic(vVarArray[0] {SYSINT},
                                                          vVarArray[1] {const WideString},
                                                          vVarArray[2] {SYSINT});
      15: POleVariant(VarResult)^ := Get_ShowSmartTagIndicator(vVarArray[0] {SYSINT},
                                                               vVarArray[1] {const WideString},
                                                               vVarArray[2] {SYSINT});
      16: SmartTagInitialize(vVarArray[0] {const WideString});
      else Result := DISPID_UNKNOWN;
    end;
    if vPDispParams.cNamedArgs > 0 then
      for i := vFistArrItem to vLastArrItem do begin
        vPVarArgIn := @vPDispParams.rgvarg[i];
        if (vPVarArgIn.vt and varByRef) <> varByRef then Continue;
        POleVariant(vPVarArgIn)^ := vVarArray[vPDispParams.rgdispidNamedArgs[i]];
      end
    else
      for i := vFistArrItem to vLastArrItem do begin
        vPVarArgIn := @vPDispParams.rgvarg[i];
        if (vPVarArgIn.vt and varByRef) <> varByRef then Continue;
        POleVariant(vPVarArgIn)^ := vVarArray[vLastArrItem - i];
      end;
    SetLength(vVarArray, 0);
  except
    if ExcepInfo <> nil then begin
      FillChar(ExcepInfo^, SizeOf(TExcepInfo), 0);
      with TExcepInfo(ExcepInfo^) do begin
        bstrSource := StringToOleStr(ClassName);
        if ExceptObject is Exception then
          bstrDescription := StringToOleStr(Exception(ExceptObject).Message);
        scode := E_FAIL;
      end;
    end;
    Result := DISP_E_EXCEPTION;
  end;
end;

function TadxActionObject.GetFactory: TadxActionFactory;
begin
  Result := (inherited Factory) as TadxActionFactory;
end;

{ TadxSmartTagModule }

constructor TadxSmartTagModule.Create(AOwner: TComponent);
begin
  FSmartTags := TList.Create;
  FSmartTagNames := TStringList.Create;
  FSmartTagNames.Values['0'] := 'My Name';
  FSmartTagDescs := TStringList.Create;
  FSmartTagDescs.Values['0'] := 'My Description';
  inherited Create(AOwner);
end;

destructor TadxSmartTagModule.Destroy;
begin
  FSmartTagDescs.Free;
  FSmartTagNames.Free;
  FSmartTags.Free;
  inherited Destroy;
end;

procedure TadxSmartTagModule.DoError(const E: Exception);
var
  Handled: boolean;
begin
  Handled := False;
  if Assigned(FOnError) then FOnError(E, Handled);
  if not Handled then
    MessageDlg(Format('%s error: the smart tag library has fired an exception.'#13#10 +
     '%s', [SmartTagName, E.Message]), mtError, [mbOK], 0);
end;

procedure TadxSmartTagModule.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty('Names', ReadNames, WriteNames, True);
  Filer.DefineProperty('Descriptions', ReadDescs, WriteDescs, True);
end;

procedure TadxSmartTagModule.ReadNames(Reader: TReader);
begin
  Reader.ReadListBegin;
  with FSmartTagNames do begin
    BeginUpdate;
    try
      Clear;
      while not Reader.EndOfList do Add(Reader.ReadString);
    finally
      EndUpdate;
    end;
  end;
  Reader.ReadListEnd;
end;

procedure TadxSmartTagModule.WriteNames(Writer: TWriter);
var
  i: Integer;
begin
  Writer.WriteListBegin;
  for i := 0 to FSmartTagNames.Count - 1 do
    Writer.WriteString(FSmartTagNames[i]);
  Writer.WriteListEnd;
end;

procedure TadxSmartTagModule.ReadDescs(Reader: TReader);
begin
  Reader.ReadListBegin;
  with FSmartTagDescs do begin
    BeginUpdate;
    try
      Clear;
      while not Reader.EndOfList do Add(Reader.ReadString);
    finally
      EndUpdate;
    end;
  end;
  Reader.ReadListEnd;
end;

procedure TadxSmartTagModule.WriteDescs(Writer: TWriter);
var
  i: Integer;
begin
  Writer.WriteListBegin;
  for i := 0 to FSmartTagDescs.Count - 1 do
    Writer.WriteString(FSmartTagDescs[i]);
  Writer.WriteListEnd;
end;

function TadxSmartTagModule.GetSmartTagName: WideString;
begin
  Result := FSmartTagNames.Values['0'];
end;

procedure TadxSmartTagModule.SetSmartTagName(const Value: WideString);
begin
  if Value = '' then
    raise Exception.Create(Format(adxST_ErrorCantBeEmpty, ['SmartTagName']));
  FSmartTagNames.Values['0'] := Value;
end;

function TadxSmartTagModule.GetSmartTagDesc: WideString;
begin
  Result := FSmartTagDescs.Values['0'];
end;

procedure TadxSmartTagModule.SetSmartTagDesc(const Value: WideString);
begin
  if Value = '' then
    raise Exception.Create(Format(adxST_ErrorCantBeEmpty, ['SmartTagDesc']));
  FSmartTagDescs.Values['0'] := Value;
end;

function TadxSmartTagModule.GetSmartTagNames(LocaleID: Integer): WideString;
begin
  Result := FSmartTagNames.Values[IntToStr(LocaleID)];
  if Result = '' then
    Result := FSmartTagNames.Values['0'];
end;

procedure TadxSmartTagModule.SetSmartTagNames(LocaleID: Integer; const Value: WideString);
begin
  if (LocaleID = 0) and (Value = '') then
    raise Exception.Create(Format(adxST_ErrorCantBeEmpty, ['SmartTagName']));
  FSmartTagNames.Values[IntToStr(LocaleID)] := Value;
end;

function TadxSmartTagModule.GetSmartTagDescs(LocaleID: Integer): WideString;
begin
  Result := FSmartTagDescs.Values[IntToStr(LocaleID)];
  if Result = '' then
    Result := FSmartTagDescs.Values['0'];
end;

procedure TadxSmartTagModule.SetSmartTagDescs(LocaleID: Integer; const Value: WideString);
begin
  if (LocaleID = 0) and (Value = '') then
    raise Exception.Create(Format(adxST_ErrorCantBeEmpty, ['SmartTagDesc']));
  FSmartTagDescs.Values[IntToStr(LocaleID)] := Value;
end;

{ TadxSmartTagAction }

constructor TadxSmartTagAction.Create(Collection: TCollection);
begin
  FCaptions := TStringList.Create;
  FCaptions.Values['0'] := 'My Caption';
  inherited Create(Collection);
end;

destructor TadxSmartTagAction.Destroy;
begin
  FCaptions.Free;
  inherited Destroy;
end;

procedure TadxSmartTagAction.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty('Captions', ReadCaptions, WriteCaptions, True);
end;

procedure TadxSmartTagAction.ReadCaptions(Reader: TReader);
begin
  Reader.ReadListBegin;
  with FCaptions do begin
    BeginUpdate;
    try
      Clear;
      while not Reader.EndOfList do Add(Reader.ReadString);
    finally
      EndUpdate;
    end;
  end;
  Reader.ReadListEnd;
end;

procedure TadxSmartTagAction.WriteCaptions(Writer: TWriter);
var
  i: Integer;
begin
  Writer.WriteListBegin;
  for i := 0 to FCaptions.Count - 1 do
    Writer.WriteString(FCaptions[i]);
  Writer.WriteListEnd;
end;

function TadxSmartTagAction.GetCaption: WideString;
begin
  Result := FCaptions.Values['0'];
end;

procedure TadxSmartTagAction.SetCaption(const Value: WideString);
begin
  if Value = '' then
    raise Exception.Create(Format(adxST_ErrorCantBeEmpty, ['Caption']));
  FCaptions.Values['0'] := Value;
end;

function TadxSmartTagAction.GetCaptions(LocaleID: Integer): WideString;
begin
  Result := FCaptions.Values[IntToStr(LocaleID)];
  if Result = '' then
    Result := FCaptions.Values['0'];
end;

procedure TadxSmartTagAction.SetCaptions(LocaleID: Integer; const Value: WideString);
begin
  if (LocaleID = 0) and (Value = '') then
    raise Exception.Create(Format(adxST_ErrorCantBeEmpty, ['Caption']));
  FCaptions.Values[IntToStr(LocaleID)] := Value;
end;

procedure TadxSmartTagAction.SetName(const Value: WideString);
var
  i: Integer;
begin
  for i := 0 to Collection.Count - 1 do
    if (TadxSmartTagActions(Collection)[i].Name = Value) and (Self <> Collection.Items[i]) then
      raise Exception.Create(adxST_ErrorNameUnique);
  FName := Value;
end;

function TadxSmartTagAction.GetDisplayName: string;
begin
  Result := FName;
end;

procedure TadxSmartTagAction.SetDisplayName(const Value: string);
begin
  SetName(Value);
  inherited SetDisplayName(Value);
end;

{ TadxSmartTagActions }

function TadxSmartTagActions.Add: TadxSmartTagAction;
begin
  Result := TadxSmartTagAction(inherited Add);
end;

function TadxSmartTagActions.FindItemID(ID: Integer): TadxSmartTagAction;
begin
  Result := TadxSmartTagAction(inherited FindItemID(ID));
end;

function TadxSmartTagActions.Insert(Index: Integer): TadxSmartTagAction;
begin
  Result := TadxSmartTagAction(inherited Insert(Index));
end;

function TadxSmartTagActions.GetAttrCount: Integer;
begin
  Result := 2;
end;

function TadxSmartTagActions.GetAttr(Index: Integer): string;
begin
  case Index of
    0: Result := 'Name';
    1: Result := 'Caption';
  else
    Result := '';
  end;
end;

function TadxSmartTagActions.GetItemAttr(Index, ItemIndex: Integer): string;
begin
  case Index of
    0: Result := Items[ItemIndex].Name;
    1: Result := Items[ItemIndex].Caption;
  else
    Result := '';
  end;
end;

procedure TadxSmartTagActions.SetItemName(Item: TCollectionItem);
var
  i, j: Integer;
  ItemName: string;
  CurItem: TadxSmartTagAction;
begin
  j := 1;
  while True do begin
    ItemName := Format('SmartTagAction%d', [j]);
    i := 0;
    while i < Count do begin
      CurItem := Items[i] as TadxSmartTagAction;
      if (CurItem <> Item) and (CompareText(CurItem.Name, ItemName) = 0) then begin
        Inc(j);
        Break;
      end;
      Inc(i);
    end;
    if i >= Count then begin
      (Item as TadxSmartTagAction).Name := ItemName;
      Break;
    end;
  end;
end;

function TadxSmartTagActions.GetItem(Index: Integer): TadxSmartTagAction;
begin
  Result := TadxSmartTagAction(inherited Items[Index]);
end;

procedure TadxSmartTagActions.SetItem(Index: Integer; Value: TadxSmartTagAction);
begin
  inherited Items[Index] := Value;
end;

{ TadxSmartTag }

constructor TadxSmartTag.Create(AOwner: TComponent);
begin
  if AOwner = nil then
    raise Exception.Create(Format('The %s class cannot be contained in the %s class.', [ClassName, 'nil']));
  if not (AOwner is TadxSmartTagModule) then
    raise Exception.Create(Format('The %s class cannot be contained in the %s class.', [ClassName, AOwner.ClassName]));
  FCaptions := TStringList.Create;
  FCaptions.Values['0'] := 'My Caption';
  inherited Create(AOwner);
  FOwner := AOwner as TadxSmartTagModule;
  FKind := ktList;
  FRecognizedWords := TStringList.Create;
  FActions := TadxSmartTagActions.Create(Self, TadxSmartTagAction);
  FOwner.FSmartTags.Add(Self);
end;

destructor TadxSmartTag.Destroy;
begin
  if Assigned(FOwner) and Assigned(FOwner.FSmartTags) then
    FOwner.FSmartTags.Remove(Self);
  FOwner := nil;
  FActions.Free;
  FRecognizedWords.Free;
  FCaptions.Free;
  inherited Destroy;
end;

procedure TadxSmartTag.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty('Captions', ReadCaptions, WriteCaptions, True);
end;

procedure TadxSmartTag.ReadCaptions(Reader: TReader);
begin
  Reader.ReadListBegin;
  with FCaptions do begin
    BeginUpdate;
    try
      Clear;
      while not Reader.EndOfList do Add(Reader.ReadString);
    finally
      EndUpdate;
    end;
  end;
  Reader.ReadListEnd;
end;

procedure TadxSmartTag.WriteCaptions(Writer: TWriter);
var
  i: Integer;
begin
  Writer.WriteListBegin;
  for i := 0 to FCaptions.Count - 1 do
    Writer.WriteString(FCaptions[i]);
  Writer.WriteListEnd;
end;

function TadxSmartTag.GetCaption: WideString;
begin
  Result := FCaptions.Values['0'];
end;

procedure TadxSmartTag.SetCaption(const Value: WideString);
begin
  if Value = '' then
    raise Exception.Create(Format(adxST_ErrorCantBeEmpty, ['Caption']));
  FCaptions.Values['0'] := Value;
end;

function TadxSmartTag.GetCaptions(LocaleID: Integer): WideString;
begin
  Result := FCaptions.Values[IntToStr(LocaleID)];
  if Result = '' then
    Result := FCaptions.Values['0'];
end;

procedure TadxSmartTag.SetCaptions(LocaleID: Integer; const Value: WideString);
begin
  if (LocaleID = 0) and (Value = '') then
    raise Exception.Create(Format(adxST_ErrorCantBeEmpty, ['Caption']));
  FCaptions.Values[IntToStr(LocaleID)] := Value;
end;

procedure TadxSmartTag.SetRecognizedWords(const Value: TStrings);
begin
  FRecognizedWords.Assign(Value);
end;

initialization

finalization
  if Assigned(FModule) then FreeAndNil(FModule);

end.

