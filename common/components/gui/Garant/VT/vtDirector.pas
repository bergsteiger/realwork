unit vtDirector;
{* Компонент для итерации по файлам и директориям. }

{ Библиотека "VoBa Tool"    }
{ Автор: Бабанин В.Б ©      }
{ Модуль: vtDirector -      }
{ Начат: 28.09.1999 10:18   }
{ $Id: vtDirector.pas,v 1.3 2004/09/15 16:20:48 lulin Exp $ }

// $Log: vtDirector.pas,v $
// Revision 1.3  2004/09/15 16:20:48  lulin
// - bug fix: AllEverestComponents7 не собирался из-за Str_Man'а.
// - bug fix: AllEverestComponents7 не загружался из-за шаблонов.
//
// Revision 1.2  2003/04/19 11:24:49  law
// - new file: vtDefine.inc.
//
// Revision 1.1  2001/09/05 06:33:27  law
// - rename unit: Director -> vtDirector.
// - rename component: TDirector -> TvtDirector.
//
// Revision 1.8  2001/08/31 11:02:36  law
// - rename unit: MyUtil -> l3FileUtils.
//
// Revision 1.7  2001/04/05 08:52:17  law
// - cleanup: использование модулей WinTypes и WinProcs заменен на Windows.
//
// Revision 1.6  2000/12/15 15:36:28  law
// - вставлены директивы Log.
//

{$I vtDefine.inc }

interface

uses
  Windows,
  Classes,
  Messages,
  Sysutils,

  l3InterfacedComponent
  ;

Type
  TSrchFileAttr = (foNormalFiles, foReadOnlyFiles, foArchiveFiles,
                   foHiddenFiles, foSystemFiles,
                   foVolumeID, foDirectory, foOnlyDir);
   {* Атрибут файла. }
  TExploreDirAttr =(foNormalDir, foReadOnlyDir, foArchiveDir,
                    foHiddenDir, foSystemDir, foSubDir);
   {* Атрибут директории. }
  TSrchFileAttrSet = set of TSrchFileAttr;
   {* Атрибуты файла. }                
  TExploreDirAttrSet = set of TExploreDirAttr;
   {* Атрибуты директории. }
  TFileFilter = String;
   {* Маска файла. }

  TvtDirNavigator = class(Tl3InterfacedComponent)
   {* Компонент для итерации по файлам и директориям. }
   private
    FSrchFileAttr   : TSrchFileAttrSet;
    FExploreDirAttr : TExploreDirAttrSet;

    FInitialDirectory : TFileName;
    FCurrentDirectory : TFileName;
    FFoundFileName    : TFileName;
    FStopStatus       : Boolean;
    FIncludeFile      : TFileFilter;
    FExcludeFile      : TFileFilter;
    FDirectoryFilter  : TFileFilter;
    FLowDate          : Longint;
    FHiDate           : Longint;


    FOnFound        : TNotifyEvent;
    FOnSearchStatus : TNotifyEvent;

    SearchFilesMask   : Byte;
    SearchDirMask     : Byte;
    ExcludedFilesMask : Byte;
    ExcludedDirMask   : Byte;


    Procedure SetInitialDir(Value : TFileName);

    Procedure SetStopStatus(Value : Boolean);
    Procedure SetIncFileFilter(Const Value : TFileFilter);
    Procedure SetExcFileFilter(Const Value : TFileFilter);
    Procedure SetDirectoryFilter(Const Value : TFileFilter);
    {Procedure SetCurrentDirectory(Value : TFileName);}
    {Procedure SetSelectedFileName (Value : TFileName);}
    Procedure SetSrchFileAttr(Value : TSrchFileAttrSet);
    Procedure SetExploreDirAttr(Value :TExploreDirAttrSet);
    Procedure SetLowDate(Value : TDateTime);
    Procedure SetHiDate(Value : TDateTime);
    Function  GetLowDate : TDateTime;
    Function  GetHiDate : TDateTime;

  protected
    Procedure MakeFilesMask;
    Procedure MakeDirMask;
    property  StopStatus : Boolean write SetStopStatus default True;
  public
  // public methods
    constructor Create(AOwner : TComponent = nil);
      override;
      {-}
    Procedure   Execute;
      {* - начать итерацию. }
    Procedure   Stop;
      {* - закончить итерацию. }
  public
  // public properties
    property  Stopped : Boolean read FStopStatus;
      {* - процесс остановлен? }
    property  CurrentDirectory : TFileName read FCurrentDirectory;
      {* - текущая директория. }
    property  FoundFileName : TFileName read FFoundFileName;
      {* - текущий найденный файл. }
  published
  // published properties
    property InitialDir : TFileName read FInitialDirectory write SetInitialDir;
      {* - начальная директория. }
    property IncludeFileFilter : TFileFilter read FIncludeFile write SetIncFileFilter;
      {* - маска включения. }
    property ExcludeFileFilter : TFileFilter read FExcludeFile write SetExcFileFilter;
      {* - маска исключения. }
    property DirectoryFilter: TFileFilter read FDirectoryFilter write SetDirectoryFilter;
      {* - маска директории. }
    property LowDate : TDateTime read GetLowDate write SetLowDate;
      {* - минимальная дата файла. }
    property HiDate : TDateTime read GetHiDate write SetHiDate;
      {* - максимальная дата файла. }

    property SrchFileAttr   : TSrchFileAttrSet read FSrchFileAttr write SetSrchFileAttr;
      {* - атрибуты файла для включения. }
    Property ExploreDirAttr : TExploreDirAttrSet read FExploreDirAttr write SetExploreDirAttr;
      {* - атрибуты директории для включения. }

    property OnFound: TNotifyEvent read FOnFound write FOnFound;
      {* - событие, вызываемое на каждый найденный файл. }
    property OnSearchStatus : TNotifyEvent read FOnSearchStatus write FOnSearchStatus;
      {* - событие, вызываемое при смене Stopped. }
 end;//TvtDirNavigator

 Function GetFilterByNum(FilterNum           : Byte;
                         Const TestFilterStr : String;
                         Var SingleFilter    : String): Boolean;
   {-}
 Function ValidFilter(Const TestedFilter : string) : Boolean;
   {-}
 Function ValidFilterSet(Const TestFilterStr : string) : Boolean;
   {-}

implementation

uses
  l3String
  ;

 Type
   EDirectoryError = Class(Exception);

 Function GetFilterByNum(FilterNum : Byte;Const TestFilterStr: String;
                         Var SingleFilter : String): Boolean;
  Var
   I      : Byte;
   Cnt    : Byte;
   FltLen : Word;
  Begin
   Cnt:=0;
   I:=0;
   FltLen := Length(TestFilterStr);
   If Cnt<FilterNum then
    For I :=1 to FltLen do
     If TestFilterStr[I]=';'
      then
       Begin
        Inc(Cnt);
        If Cnt=FilterNum then Break;
       end;
   Inc(I);
   If (Cnt=FilterNum) and ( I < FltLen)
    then
     Begin
      SingleFilter:=Copy(TestFilterStr, I, Succ(FltLen-I));
      I:=Pos(';',SingleFilter);
      If I > 0 then SetLength(SingleFilter, Pred(I));
      Result:=True;
     end
    else Result:=False;
  end;


 Function ValidFilter(Const TestedFilter : string) : Boolean;
  Const
   NonValidChars : SET OF Char =
     [#0..' ','[',']','\','/','|','=','+','>','<',',',';','.',':','§'];
  Var
   TestFilter : string;
   Letter     : Byte;
   Extension  : string;

  Begin
   TestFilter:= {Lowercase(}Copy(TestedFilter,1,11){)};
   If POS('.', TestFilter)> 1
    then
     Begin
      Extension:= Copy(TestFilter, POS('.', TestFilter)+1,3);
      Delete(TestFilter, POS('.', TestFilter),255);
     end
    else Extension := '';

   TestFilter := COPY(TestFilter,1,8);
   Letter := 1;
   Result := True;
   While (Letter <= LENGTH(TestFilter)) and Result do
    Begin
     Result := Not (TestFilter[Letter] in NonValidChars);
     INC(Letter);
    end;
   Letter := 1;
   While (Letter <= Length(Extension)) and Result do
    Begin
     Result := Not (Extension[1] in NonValidChars);
     INC(Letter);
    end;
   {If Not Result then
    Raise EDirectoryError.CreateResfmt(RS_InvalidFilterName, [TestedFilter]);
   }
  end;

 Function ValidFilterSet(Const TestFilterStr : string) : Boolean;
  Var
   Num : Byte;
   {$IfDef Win32}
     SF : String;
   {$Else}
     SF : String[12];
   {$EndIf}
  Begin
   Num:=0;
   Result:=True;
   While Result and GetFilterByNum(Num,TestFilterStr,SF) do
    Begin
     Result:=ValidFilter(SF);
     Inc(Num);
    end;
  end;


 Procedure ProcessMessages;

 {as there is no Tapplication available here}

  Var
   Msg: TMsg;

  Begin
   If PeekMessage(Msg, 0, 0, 0, PM_REMOVE) then
    Begin
     If Msg.Message <> WM_QUIT then
      Begin
       TranslateMessage(Msg);
       DispatchMessage(Msg);
      end
    end;
   end;


{TvtDirNavigator}
 Constructor TvtDirNavigator.Create;
  Begin
   Inherited Create(AOwner);
   FIncludeFile:='*.*';
   FExcludeFile:='';
   FDirectoryFilter:='*.*';
   SearchFilesMask := faArchive or faReadonly;
   ExcludedFilesMask :=0;
   SearchDirMask :=faDirectory;
   ExcludedDirMask :=0;
  end;

Procedure TvtDirNavigator.SetSrchFileAttr(Value : TSrchFileAttrSet);
 Begin
  FSrchFileAttr:=Value;
  MakeFilesMask;
 end;

Procedure TvtDirNavigator.SetExploreDirAttr(Value :TExploreDirAttrSet);
 Begin
  FExploreDirAttr:=Value;
  MakeDirMask;
 end;

Procedure TvtDirNavigator.MakeFilesMask;
 Begin
  ExcludedFilesMask:=0;
  SearchFilesMask:=0;
  If foReadOnlyFiles in FSrchFileAttr then Inc(SearchFilesMask,faReadOnly)
                                      else Inc(ExcludedFilesMask,faReadOnly);
  If foArchiveFiles  in FSrchFileAttr then Inc(SearchFilesMask,faArchive)
                                      else Inc(ExcludedFilesMask,faArchive);
  If foHiddenFiles   in FSrchFileAttr then Inc(SearchFilesMask,faHidden);
  If foSystemFiles   in FSrchFileAttr then Inc(SearchFilesMask,faSysFile);
  If foVolumeID      in FSrchFileAttr then Inc(SearchFilesMask,faVolumeID);
  If foDirectory     in FSrchFileAttr then Inc(SearchFilesMask,faDirectory)
   else If foOnlyDir in FSrchFileAttr then Inc(SearchFilesMask,faDirectory);
 end;


Procedure TvtDirNavigator.SetLowDate(Value : TDateTime);
 Begin
  If Value<>0
   then
     Try
      FLowDate:=DateTimeToFileDate(Value)
     except FLowDate:=0;
     end
   else FLowDate:=0;
 end;

Procedure TvtDirNavigator.SetHiDate(Value : TDateTime);
 Begin
  If Value<>0
   then
     Try
      FHiDate:=DateTimeToFileDate(Value)
     except FHiDate:=0;
    end
   else FHiDate:=0;
 end;

Function  TvtDirNavigator.GetLowDate : TDateTime;
 Begin
  Try
   Result:=FileDateToDateTime(FLowDate);
  Except Result:=0;
  end;
 end;

Function  TvtDirNavigator.GetHiDate : TDateTime;
 Begin
  Try
   Result:=FileDateToDateTime(FHiDate);
  Except Result:=0;
  end;
 end;

Procedure TvtDirNavigator.MakeDirMask;
 Begin
  SearchDirMask   :=faDirectory;
  ExcludedDirMask :=0;

  If foReadOnlyDir in FExploreDirAttr then Inc(SearchDirMask,faReadOnly)
                                      else Inc(ExcludedDirMask,faReadOnly);
  If foArchiveDir  in FExploreDirAttr then Inc(SearchDirMask,faArchive)
                                      else Inc(ExcludedDirMask,faArchive);
  If foHiddenDir   in FExploreDirAttr then Inc(SearchDirMask,faHidden);
  If foSystemDir   in FExploreDirAttr then Inc(SearchDirMask,faSysFile);
 end;

 Procedure TvtDirNavigator.Execute;
 {Var
  Filter : TFileFilter;
  }
 Procedure ReadDirectory(Directory_to_Read : TFileName);
  Var
   CurrentPath   : TFileName;
   FSrchError    : Integer;
   SearchInfo    : TSearchRec;
   CurFileFilter : TFileFilter;
   FN            : Byte;

  Procedure SearchFiles;
   Var
    FileSearchInfo : TSearchRec;
    MaskFileName : TFileName;

   Begin
    MaskFileName := CurrentPath+CurFileFilter;
    FSrchError := FindFirst(MaskFileName, SearchFilesMask,FileSearchInfo);
    try
     If FSrchError = 0
      then
       Repeat
        With FileSearchInfo do
         If (Name[1]<>'.')
            and (Attr and  ExcludedFilesMask = 0)
            and ((foNormalFiles in FSrchFileAttr) or
                 Not ((Attr=0) or (Attr=faDirectory)))
            and ((Attr and faDirectory=faDirectory) or
                 Not (foOnlyDir in FSrchFileAttr))
            and (((FLowDate=0) or (FLowDate<=Time)) and
                  ((FHiDate=0) or (FHiDate>Time)))
            and ((Length(FExcludeFile) = 0) or Not l3MaskCompare(Name, FExcludeFile))
             then
              Begin
               FFoundFileName:=CurrentPath+FileSearchInfo.Name;
               If Assigned(FOnFound) then FOnFound(Self);
              end;
          ProcessMessages;
         FSrchError := FindNext(FileSearchInfo);
       {$IFDEF WIN32}
       until (FSrchError <> 0) or Stopped;
       {$ELSE WIN32}
       until (FSrchError < 0) or Stopped;
       {$ENDIF WIN32}
    finally
     FindClose(FileSearchInfo);
    end;{try..finally}
   end;

   Begin {ReadDirectory}
    CurrentPath := Directory_To_Read;
    If CurrentPath = '' then GetDir(0, CurrentPath);
    If Not (CurrentPath[Length(CurrentPath)] IN ['\',':'])
     then CurrentPath:=CurrentPath+'\';
    FCurrentDirectory := CurrentPath;
    FSrchError := FindFirst(CurrentPath+FDirectoryFilter,
                              SearchDirMask, SearchInfo);
    try
     If FSrchError = 0 then
      Begin
       Repeat
        With SearchInfo do

         If (Name[1]<>'.')
             and (Attr and faDirectory=faDirectory)
          then
           Begin
            If (foSubDir in FExploreDirAttr)
               and (Attr and  ExcludedDirMask = 0)
               and ((foNormalDir in FExploreDirAttr)
                 or (Attr<>faDirectory))
             then ReadDirectory(CurrentPath+Name);
           end;
        ProcessMessages;
        FSrchError := FindNext(SearchInfo);
       {$IFDEF WIN32}
       until (FSrchError <> 0) or Stopped;
       {$ELSE WIN32}
       until (FSrchError < 0) or Stopped;
       {$ENDIF WIN32}
       If Stopped then Exit;
      end;
    finally
     FindClose(SearchInfo);
    end;
    FN:=0;
    While GetFilterByNum(FN, FIncludeFile,CurFileFilter) do
     Begin
      SearchFiles;
      Inc(FN);
     end;
   end;

 Begin {Execute}
  StopStatus := False;
 { Filter := DirectoryFilter;
  If Filter = '' then Filter := '*.*';
 }
  try
   ReadDirectory(FInitialDirectory);
  except
  end;

  StopStatus := True;
 end;

 Procedure TvtDirNavigator.Stop;
  Begin
   StopStatus := True;
  end;

 Procedure TvtDirNavigator.SetInitialDir(Value : TFileName);
  Begin
   {If FileExists(Value) then} FInitialDirectory:= Value;
  end;


Procedure TvtDirNavigator.SetStopStatus(Value : Boolean);
 Begin
  If FStopStatus <> Value then FStopStatus := Value;
  If Assigned(FOnSearchStatus) then FOnSearchStatus(Self);
 end;


Procedure TvtDirNavigator.SetIncFileFilter(Const Value : TFileFilter);
 Begin
  If Value=''
   then FIncludeFile:='*.*'
   else
    If ValidFilterSet(Value)
     then FIncludeFile:=AnsiUpperCase(Value);
 end;

Procedure TvtDirNavigator.SetExcFileFilter(Const Value : TFileFilter);
 Begin
  If Value=''
   then FExcludeFile:=''
   else
    If ValidFilterSet(Value)
     then FExcludeFile:=AnsiUpperCase(Value);
 end;


Procedure TvtDirNavigator.SetdirectoryFilter(Const Value : TFileFilter);
 Begin
  If Value=''
   then FDirectoryFilter:='*.*'
   else
    If ValidFilter(Value)
     then FDirectoryFilter:=Value;
 end;

end.


