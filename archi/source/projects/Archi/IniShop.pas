unit IniShop;

{ $Id: IniShop.pas,v 1.57 2016/04/27 09:33:30 lukyanets Exp $ }

interface

 uses
      Dialogs,
      l3Base,
      l3Date,
      l3IniFile,
      DT_Types;

 Type

  PIniRecord = ^TIniRecord;
  TIniRecord = class(Tl3Base)
   private
     fIsLoaded : boolean;
     fSecondVersionDate: TDateTime;
    f_MailNotifyByModalDialog: Boolean;
    f_OpenIniPath: string;
    f_SaveIniPath: string;
   public
    {System of windows}
     fMaxOnStart           : Boolean;
     fExplorerShow         : Boolean;
     fExplorerWidth        : Integer;
    {Search preference}
     fNewSrchOnly          : Boolean;
     fGarantStyleQuery     : Boolean;
     fPrefDNType           : Integer;
    {Text Editor}
     fZoom                 : Longint;
     fShowSpecSymbol       : Boolean;
     //fShowPreview          : Boolean;
     fShowDocumentParts    : Boolean;
     fShowWebStyle         : Boolean;
     fShowFoundWordLighting : Boolean;

     fSubShowMask          : Longint;
     fRelSubShowMask       : Longint;
     fStyleTbl             : String;
     fInsertDict           : String;
     fSubLogFile           : String;

     fRecordFill           : Boolean;
     fPage                 : Integer;
     fAlonePage            : Integer;
     fWidth                : Integer;
     fHeight               : Integer;

     fMaximize             : Boolean;
     fAlonePageHeight      : Integer;

     fBlockExplorerWidth   : Integer;

     fAutoSave             : Boolean;
     fAutoSaveInterval     : Integer;

     fCheckScanImage       : Boolean;

     fSrchSubID            : Integer;

     fVerLinkAddrDoc       : Integer;
     fVerLinkAddrSub       : Integer;

     fVerChangerAddrDoc    : Integer;
     fVerChangerAddrSub    : Integer;


     {UserSupport}
     fDocOnDiskDir         : String;
     {INTERFACE}
     fShowIDinCaption      : Boolean;
     fCreateDocKind        : Integer;
     fShowHRuller          : Boolean;

     fSychroNameWSpr       : Boolean;

     fNVDFromServer        : Boolean;
     fNextVersionDate      : TDateTime;
     fAnouncedDate: TDateTime;

     fMultiLingual         : Boolean;

     fAllowSelNonLeaf      : Boolean;
     {}
     fLastExitDateTime     : TStDateTimeRec;
     fNeedRunTehProc       : Boolean;

     fDebugInfo            : Boolean;

     fDocSetTypeFilter     : TUserTypeSet;
     fSysDocSetTypeFilter  : TDocTypeSet;

     {paths}
     fPathToLogFile         : TPathStr;
     fPathToDeletedFileList : TPathStr;
     fPathToLocalSaveDir    : TPathStr;

     {Server}
     fUseOldStorage         : Boolean;

     {Орфография}
     f_DontCheckThreeLetter : Boolean;
     f_OrphoDotIsSeparator    : Boolean;


     function GetAnnoDate : TDateTime;
   public
    procedure SetIniRecord;
    procedure SaveIniRecord;
    constructor Create; override;

    function ExecuteSaveDialog(const aDialog: TSaveDialog): Boolean;
    function ExecuteOpenDialog(const aDialog: TOpenDialog): Boolean;

   {System of windows}
    property MaxOnStart         : Boolean
     read  fMaxOnStart
     write fMaxOnStart;

    property ExplorerShow       : Boolean
     read fExplorerShow
     write fExplorerShow;

    property ExplorerWidth      : Integer
     read fExplorerWidth
     write fExplorerWidth;

   {Search preference}
    property NewSrchOnly        : Boolean
     read fNewSrchOnly
     write fNewSrchOnly;

    property PrefDNType         : Integer
     read  fPrefDNType
     write fPrefDNType;

   {Text Editor}
    property Zoom               : Longint
     read fZoom
     write fZoom;

    property ShowSpecSymbol     : Boolean
     read fShowSpecSymbol
     write fShowSpecSymbol;

    {property ShowPreview        : Boolean
     read fShowPreview
     write fShowPreview;}

    property ShowDocumentParts  : Boolean
     read fShowDocumentParts
     write fShowDocumentParts;

    property ShowWebStyle       : Boolean
     read fShowWebStyle
     write fShowWebStyle;

    property ShowFoundWordLighting : Boolean
     read fShowFoundWordLighting
     write fShowFoundWordLighting;

    property SubShowMask        : Longint
     read fSubShowMask
     write fSubShowMask;

    property RelSubShowMask     : Longint
     read fRelSubShowMask
     write fRelSubShowMask;

    property StyleTbl           : String
     read fStyleTbl
     write fStyleTbl;

    property InsertDict         : String
     read fInsertDict
     write fInsertDict;

    property SubLogFile         : String
     read fSubLogFile
     write fSubLogFile;

    property RecordFill         : Boolean
     read fRecordFill
     write fRecordFill;

    property Page               : Integer
     read fPage
     write fPage;

    property AlonePage          : Integer
     read fAlonePage
     write fAlonePage;

    property Width              : Integer
     read fWidth
     write fWidth;

    property Height             : Integer
     read fHeight
     write fHeight;

    property Maximize           : Boolean
     read fMaximize
     write fMaximize;

    property AlonePageHeight    : Integer
     read fAlonePageHeight
     write fAlonePageHeight;

    property BlockExplorerWidth : Integer
     read fBlockExplorerWidth
     write fBlockExplorerWidth;

    property AutoSave           : Boolean
     read fAutoSave
     write fAutoSave;

    property AutoSaveInterval   : Integer
     read fAutoSaveInterval
     write fAutoSaveInterval;

    property CheckScanImage     : Boolean
     read fCheckScanImage
     write fCheckScanImage;

    property VerLinkAddrDoc     : Integer
     read fVerLinkAddrDoc
     write fVerLinkAddrSub;

    property VerLinkAddrSub     : Integer
     read fVerLinkAddrSub
     write fVerLinkAddrSub;

    property VerChangerAddrDoc  : Integer
     read fVerChangerAddrDoc
     write fVerChangerAddrDoc;

    property VerChangerAddrSub  : Integer
     read fVerChangerAddrSub
     write fVerChangerAddrSub;

    property SrchSubID          : Integer
     read fSrchSubID
     write fSrchSubID;

    {UserSupport}
    property DocOnDiskDir       : String
     read fDocOnDiskDir
     write fDocOnDiskDir;

    {INTERFACE}
    property GarantStyleQuery   : Boolean
     read fGarantStyleQuery
     write fGarantStyleQuery;

    property ShowIDinCaption    : Boolean
     read fShowIDinCaption
     write fShowIDinCaption;

    property CreateDocKind      : Integer
     read fCreateDocKind
     write fCreateDocKind;

    property ShowHRuller        : Boolean
     read fShowHRuller
     write fShowHRuller;

    property SychroNameWSpr     : Boolean
     read fSychroNameWSpr
     write fSychroNameWSpr;

    property MultiLingual       : Boolean
     read fMultiLingual
     write fMultiLingual;

    property AllowSelNonLeaf    : Boolean
     read fAllowSelNonLeaf
     write fAllowSelNonLeaf;


    property NVDFromServer      : Boolean  // next version date from server
     read fNVDFromServer
     write fNVDFromServer;

    property NextVersionDate    : TDateTime
     read fNextVersionDate
     write fNextVersionDate;

    property AnouncedDate: TDateTime
     read fAnouncedDate
     write fAnouncedDate;

    property SecondVersionDate  : TDateTime
     read fSecondVersionDate
     write fSecondVersionDate;

    {}
    property LastExitDateTime   : TStDateTimeRec
     read fLastExitDateTime
     write fLastExitDateTime;

    property NeedRunTehProc     : Boolean
     read fNeedRunTehProc
     write fNeedRunTehProc;

    property DebugInfo          : Boolean
     read fDebugInfo
     write fDebugInfo;

    property DocSetTypeFilter    : TUserTypeSet
     read fDocSetTypeFilter
     write fDocSetTypeFilter;

    property SysDocSetTypeFilter : TDocTypeSet
     read fSysDocSetTypeFilter
     write fSysDocSetTypeFilter;

    property PathToLogFile : TPathStr
     read fPathToLogFile
     write fPathToLogFile;

    property PathToLocalSaveDir : TPathStr
     read fPathToLocalSaveDir
     write fPathToLocalSaveDir;

    property PathToDeletedFileList : TPathStr
     read fPathToDeletedFileList
     write fPathToDeletedFileList;

    property UseOldStorage     : Boolean
     read fUseOldStorage
     write fUseOldStorage;

    {common}
    property AnnoDate : TDateTime
     read GetAnnoDate;

    property DontCheckThreeLetterWords: Boolean
     read  f_DontCheckThreeLetter
     write f_DontCheckThreeLetter;

    property OrphoDotIsSeparator: Boolean
      read f_OrphoDotIsSeparator
      write f_OrphoDotIsSeparator;

    property MailNotifyByModalDialog: Boolean
      read f_MailNotifyByModalDialog
      write f_MailNotifyByModalDialog;

    property SaveIniPath: string
      read f_SaveIniPath
      write f_SaveIniPath;
    property OpenIniPath: string
      read f_OpenIniPath
      write f_OpenIniPath;
   end;

 Const
  PrefSectName         = 'Preferences';
  StatSectName         = 'Statistic';
  DocWinDefault        = 'DocWinDefault';
  FormPlacement        = 'FormPlacement';

  FindHistorySectName  = 'DictFindHistory';
  DictFormPlaceName    = 'DictFormPlace';
  DictMDIFormPlaceName = 'DictMDIFormPlace';

  SrchDlgFormPlaceName = 'SrchDlgFormPlace';

  TextSearchSectName   = 'TextSearch';
  FindSectName         = 'FindList';
  ReplaceSectName      = 'ReplaceList';


function IniRec : TIniRecord;
procedure SaveIniRec;

function CreateFamilyBaseIni: TCfgList;

implementation

uses
 SysUtils,
 l3MinMax, l3DateSt, l3FileUtils,
 //DictsSup,
 DocAttrUtils,
 daSchemeConsts,
 DT_Const, DT_Serv, vtDialogs;

var
 gIniRec : TIniRecord = nil;

function CreateFamilyBaseIni: TCfgList;
begin
 Result := TCfgList.Create(ConcatDirName(GlobalHtServer.FamilyTbl.FamilyPath(CurrentFamily), 'base.ini'));
end;

function Int2UserTypeSet(aValue : Integer) : TUserTypeSet;
 begin
  Result := [];
  l3move(AValue, Result, SizeOf(TUserTypeSet));
 end;

function UserTypeSet2Int(aValue : TUserTypeSet) : Integer;
 begin
  Result := 0;
  l3move(AValue, Result, SizeOf(TUserTypeSet));
 end;

function Int2DocTypeSet(aValue : Integer) : TDocTypeSet;
 begin
  Result := [];
  l3move(AValue, Result, SizeOf(TDocTypeSet));
 end;

function DocTypeSet2Int(aValue : TDocTypeSet) : Integer;
 begin
  Result := 0;
  l3move(AValue, Result, SizeOf(TDocTypeSet));
 end;

{TIniRecord}
function IniRec : TIniRecord;
begin
 if gIniRec = nil then
  gIniRec := TIniRecord.Create;

 Result := gIniRec;
end;

procedure SaveIniRec;
begin
 if gIniRec <> nil then
  gIniRec.SaveIniRecord;
end;

constructor TIniRecord.Create;
begin
 Inherited;
 SetIniRecord;
end;

function TIniRecord.GetAnnoDate : TDateTime;
begin
 with CreateFamilyBaseIni do
 try
  Section := 'Annotation';
  Result := ReadParamDateTimeDef('AnnoDate', Now);
  if Result < Now then
   Result := Now;
 finally
  Free;
 end;
end;

procedure TIniRecord.SetIniRecord;
 begin
  If UserConfig = Nil then Exit;

  UserConfig.Section := PrefSectName;

  SaveIniPath := UserConfig.ReadParamStrDef ('SaveIniPath', GetCurrentDir);
  OpenIniPath := UserConfig.ReadParamStrDef ('OpenIniPath', GetCurrentDir);

  MaxOnStart        := UserConfig.ReadParamBoolDef('MaxOnStart', False);
  ShowSpecSymbol    := UserConfig.ReadParamBoolDef('EdShowSpecSymbol', False);
  //ShowPreview       := UserConfig.ReadParamBoolDef('ShowPreview', False);
  ShowDocumentParts := UserConfig.ReadParamBoolDef('ShowDocumentParts', False);
  ShowWebStyle      := UserConfig.ReadParamBoolDef('ShowWebStyle', False);
  ShowFoundWordLighting := UserConfig.ReadParamBoolDef('ShowFoundWordLighting', False);

  Zoom              := Max(UserConfig.ReadParamIntDef ('EdZoom', 100), 30);
  NewSrchOnly       := UserConfig.ReadParamBoolDef('NewSrchOnly', False);
  PrefDNType        := UserConfig.ReadParamIntDef ('PrefDNType', 0);
  SubShowMask       := UserConfig.ReadParamIntDef ('SubShowMask', 0);
  RelSubShowMask    := UserConfig.ReadParamIntDef ('RelSubShowMask', 0);

  ExplorerShow      := UserConfig.ReadParamBoolDef('ExplorerShow', True);
  ExplorerWidth     := UserConfig.ReadParamIntDef ('ExplorerWidth', 200);
  StyleTbl          := UserConfig.ReadParamFileNameDef ('StyleTable', '');
  InsertDict        := UserConfig.ReadParamFileNameDef ('InsertDict', '');
  GarantStyleQuery  := UserConfig.ReadParamBoolDef('GarantStyleQuery', True);
  ShowIDinCaption   := UserConfig.ReadParamBoolDef('ShowIDinCaption', True);

  CreateDocKind     := UserConfig.ReadParamIntDef('CreateDocKind', 1);

  ShowHRuller       := UserConfig.ReadParamBoolDef('ShowHRuller', True);
  SychroNameWSpr    := UserConfig.ReadParamBoolDef('SychroNameWSpr', False);

  MultiLingual      := UserConfig.ReadParamBoolDef('MultiLingual', False);
  AllowSelNonLeaf   := UserConfig.ReadParamBoolDef('AllowSelNonLeaf', False);

  DocOnDiskDir      := UserConfig.ReadParamStrDef ('DocOnDiskDir', '');

  SubLogFile        := UserConfig.ReadParamStrDef ('SubLogFile', '');

  NVDFromServer     := UserConfig.ReadParamBoolDef ('NVDFromServer', True);
  NextVersionDate   := UserConfig.ReadParamDateDef ('NextVersionDate', 0);

  DocSetTypeFilter  := Int2UserTypeSet(UserConfig.ReadParamIntDef ('DocSetTypeFilter', UserTypeSet2Int(cAllUserTypeSet)));
  SysDocSetTypeFilter := Int2DocTypeSet(UserConfig.ReadParamIntDef ('SysDocSetTypeFilter', DocTypeSet2Int(cAllDocTypeSet)));

  CheckScanImage     := UserConfig.ReadParamBoolDef('CheckScanImage', False);

  VerLinkAddrDoc    := UserConfig.ReadParamIntDef ('VerLinkAddrDoc', 0);
  VerLinkAddrSub    := UserConfig.ReadParamIntDef ('VerLinkAddrSub', 0);

  VerChangerAddrDoc := UserConfig.ReadParamIntDef ('VerChangerAddrDoc', 0);
  VerChangerAddrSub := UserConfig.ReadParamIntDef ('VerChangerAddrSub', 0);

  SrchSubID         := UserConfig.ReadParamIntDef ('SrchSubID', -1);

  DontCheckThreeLetterWords := UserConfig.ReadParamBoolDef('DontCheckThreeLetterWords', False);
  OrphoDotIsSeparator := UserConfig.ReadParamBoolDef('OrphoDotIsSeparator', False);

  MailNotifyByModalDialog := UserConfig.ReadParamBoolDef('MailNotifyByModalDialog', True);

  UserConfig.Section := DocWinDefault;

  RecordFill         := UserConfig.ReadParamBoolDef('RecordFill', False);
  Page               := UserConfig.ReadParamIntDef ('Page', 0);
  AlonePage          := UserConfig.ReadParamIntDef ('AlonePage', 0);
  Width              := UserConfig.ReadParamIntDef ('Width', 0);
  Height             := UserConfig.ReadParamIntDef ('Height', 0);
  Maximize           := UserConfig.ReadParamBoolDef('Maximize', False);
  AutoSave           := UserConfig.ReadParamBoolDef('AutoSave', False);
  AlonePageHeight    := UserConfig.ReadParamIntDef ('APHeight', 0);
  AutoSaveInterval   := UserConfig.ReadParamIntDef ('AutoSaveInterval', 5);
  BlockExplorerWidth := UserConfig.ReadParamIntDef ('BlockExplorerWidth', 0);

  UserConfig.Section := StatSectName;
  Try
   UserConfig.ReadParamRec ('LastExitDateTime', 'DD', fLastExitDateTime);
   NeedRunTehProc  := UserConfig.ReadParamBoolDef('NeedRunTehProc', True);
  except
   fLastExitDateTime := cEmptyDateTime;
   //LastExitDateTime := CurrentDateTime;
  end;

  // если сегодня пятница, а версия завтра или ранее
  // или если сегодня не пятница и версия сегодня или ранее
  // то переставляем версию на следующую субботу
  (*
  if IniRec.NextVersionDate <= Date then
   IniRec.NextVersionDate := vtGetNearestDayOfWeek(Saturday, false);

  if (DayOfWeek(Date) = 6 {Friday}) and
     (IniRec.NextVersionDate = Date + 1) then
   IniRec.NextVersionDate := IniRec.NextVersionDate + 7;
  *)
  LoadHiddenAttr;

  ServerConfig.Section := 'Options';
  UseOldStorage := ServerConfig.ReadParamBoolDef('OldStorage', True);
  fIsLoaded := True;
 end;

procedure TIniRecord.SaveIniRecord;
 begin
  If (UserConfig = Nil) or not fIsLoaded then Exit;

  UserConfig.Section := PrefSectName;

  UserConfig.WriteParamStr ('OpenIniPath', OpenIniPath);
  UserConfig.WriteParamStr ('SaveIniPath', SaveIniPath);

  UserConfig.WriteParamBool('MaxOnStart' ,      MaxOnStart);
  UserConfig.WriteParamBool('NewSrchOnly',      NewSrchOnly);
  UserConfig.WriteParamInt ('PrefDNType',       PrefDNType);
  UserConfig.WriteParamInt ('EdZoom',           Zoom);
  UserConfig.WriteParamBool('EdShowSpecSymbol', ShowSpecSymbol);
  //UserConfig.WriteParamBool('ShowPreview',      ShowPreview);
  UserConfig.WriteParamBool('ShowDocumentParts',ShowDocumentParts);
  UserConfig.WriteParamBool('ShowWebStyle',     ShowWebStyle);
  UserConfig.WriteParamBool('ShowFoundWordLighting', ShowFoundWordLighting);

  UserConfig.WriteParamInt ('SubShowMask',      SubShowMask);
  UserConfig.WriteParamInt ('RelSubShowMask',   RelSubShowMask);

  UserConfig.WriteParamBool('ExplorerShow',     ExplorerShow);
  UserConfig.WriteParamInt ('ExplorerWidth',    ExplorerWidth);
  UserConfig.WriteParamStr ('StyleTable',       StyleTbl);
  //UserConfig.WriteParamStr ('InsertDict',       InsertDict);
  UserConfig.WriteParamBool('GarantStyleQuery', GarantStyleQuery);
  UserConfig.WriteParamBool('ShowIDinCaption',  ShowIDinCaption);

  UserConfig.WriteParamInt('CreateDocKind', CreateDocKind);

  UserConfig.WriteParamBool('ShowHRuller',      ShowHRuller);
  UserConfig.WriteParamBool('SychroNameWSpr',   SychroNameWSpr);

  UserConfig.WriteParamBool('MultiLingual',     MultiLingual);

  UserConfig.WriteParamStr ('DocOnDiskDir',     DocOnDiskDir);

  UserConfig.WriteParamBool('NVDFromServer',    NVDFromServer);
  UserConfig.WriteParamDate('NextVersionDate',  NextVersionDate);

  //UserConfig.WriteParamStr ('SubLogFile',       SubLogFile);

  UserConfig.WriteParamInt('DocSetTypeFilter', UserTypeSet2Int(DocSetTypeFilter));
  UserConfig.WriteParamInt('SysDocSetTypeFilter', DocTypeSet2Int(SysDocSetTypeFilter));

  UserConfig.WriteParamBool('CheckScanImage' ,    CheckScanImage);

  UserConfig.WriteParamInt('VerLinkAddrDoc', VerLinkAddrDoc);
  UserConfig.WriteParamInt('VerLinkAddrSub', VerLinkAddrSub);

  UserConfig.WriteParamInt('VerChangerAddrDoc', VerChangerAddrDoc);
  UserConfig.WriteParamInt('VerChangerAddrSub', VerChangerAddrSub);

  UserConfig.WriteParamInt('SrchSubID', SrchSubID);

  UserConfig.WriteParamBool('DontCheckThreeLetterWords', DontCheckThreeLetterWords);
  UserConfig.WriteParamBool('OrphoDotIsSeparator', OrphoDotIsSeparator);
  UserConfig.WriteParamBool('MailNotifyByModalDialog', MailNotifyByModalDialog);

  UserConfig.Section := DocWinDefault;
  UserConfig.WriteParamBool('RecordFill',         RecordFill);
  UserConfig.WriteParamInt ('Page',               Page);
  UserConfig.WriteParamInt ('AlonePage',          AlonePage);
  UserConfig.WriteParamInt ('Width',              Width);
  UserConfig.WriteParamInt ('Height',             Height);
  UserConfig.WriteParamBool('Maximize' ,          Maximize);
  UserConfig.WriteParamBool('AutoSave' ,          AutoSave);
  UserConfig.WriteParamInt ('APHeight',           AlonePageHeight);
  UserConfig.WriteParamInt ('AutoSaveInterval',   AutoSaveInterval);
  UserConfig.WriteParamInt ('BlockExplorerWidth', BlockExplorerWidth);

  UserConfig.Section := StatSectName;
  LastExitDateTime := CurrentDateTime;
  UserConfig.WriteParamRec ('LastExitDateTime', 'DD', fLastExitDateTime);
  UserConfig.WriteParamBool('NeedRunTehProc', NeedRunTehProc);

  SaveHiddenAttr;
 end;

function TIniRecord.ExecuteOpenDialog(const aDialog: TOpenDialog): Boolean;
begin
 if aDialog.InitialDir = '' then
  aDialog.InitialDir := OpenIniPath;
 Result := aDialog.Execute;
 if Result then
 begin
  OpenIniPath := ExtractFileDir(aDialog.Files[aDialog.Files.Count - 1]);
  aDialog.InitialDir := '';
 end;
end;

function TIniRecord.ExecuteSaveDialog(const aDialog: TSaveDialog): Boolean;
begin
 if aDialog.InitialDir = '' then
  aDialog.InitialDir := SaveIniPath;
 Result := aDialog.Execute;
 if Result then
 begin
  SaveIniPath := ExtractFileDir(aDialog.Files[aDialog.Files.Count - 1]);
  aDialog.InitialDir := '';
 end;
end;

function IniSaveOpenDialogExecutor(const aDlg : TOpenDialog; aFileDlgMode : TFileDlgMode): Boolean;
begin
 aDlg.Options := aDlg.Options + [ofNoChangeDir];
 case aFileDlgMode of
  fdmSave: Result := IniRec.ExecuteSaveDialog(aDlg as TSaveDialog);
  fdmOpen: Result := IniRec.ExecuteOpenDialog(aDlg);
 else
  Result := False;
  Assert(False);
 end;
end;

initialization
 vtSetSaveOpenDialogExecutor(IniSaveOpenDialogExecutor);

finalization
 if gIniRec <> nil then
  l3Free(gIniRec);
end.
