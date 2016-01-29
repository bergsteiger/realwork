{$A8,B-,C-,D+,E-,F-,G+,H+,I+,J+,K-,L+,M-,N+,O-,P+,Q+,R+,S-,T-,U-,V-,W+,X+,Y+,Z1}
{$MINSTACKSIZE $00004000}
{$MAXSTACKSIZE $00100000}
{$IMAGEBASE $00400000}
{$APPTYPE GUI}
{$WARN SYMBOL_DEPRECATED ON}
{$WARN SYMBOL_LIBRARY ON}
{$WARN SYMBOL_PLATFORM ON}
{$WARN UNIT_LIBRARY ON}
{$WARN UNIT_PLATFORM ON}
{$WARN UNIT_DEPRECATED ON}
{$WARN HRESULT_COMPAT ON}
{$WARN HIDING_MEMBER ON}
{$WARN HIDDEN_VIRTUAL ON}
{$WARN GARBAGE ON}
{$WARN BOUNDS_ERROR ON}
{$WARN ZERO_NIL_COMPAT ON}
{$WARN STRING_CONST_TRUNCED ON}
{$WARN FOR_LOOP_VAR_VARPAR ON}
{$WARN TYPED_CONST_VARPAR ON}
{$WARN ASG_TO_TYPED_CONST ON}
{$WARN CASE_LABEL_RANGE ON}
{$WARN FOR_VARIABLE ON}
{$WARN CONSTRUCTING_ABSTRACT ON}
{$WARN COMPARISON_FALSE ON}
{$WARN COMPARISON_TRUE ON}
{$WARN COMPARING_SIGNED_UNSIGNED ON}
{$WARN COMBINING_SIGNED_UNSIGNED ON}
{$WARN UNSUPPORTED_CONSTRUCT ON}
{$WARN FILE_OPEN ON}
{$WARN FILE_OPEN_UNITSRC ON}
{$WARN BAD_GLOBAL_SYMBOL ON}
{$WARN DUPLICATE_CTOR_DTOR ON}
{$WARN INVALID_DIRECTIVE ON}
{$WARN PACKAGE_NO_LINK ON}
{$WARN PACKAGED_THREADVAR ON}
{$WARN IMPLICIT_IMPORT ON}
{$WARN HPPEMIT_IGNORED ON}
{$WARN NO_RETVAL ON}
{$WARN USE_BEFORE_DEF ON}
{$WARN FOR_LOOP_VAR_UNDEF ON}
{$WARN UNIT_NAME_MISMATCH ON}
{$WARN NO_CFG_FILE_FOUND ON}
{$WARN MESSAGE_DIRECTIVE ON}
{$WARN IMPLICIT_VARIANTS ON}
{$WARN UNICODE_TO_LOCALE ON}
{$WARN LOCALE_TO_UNICODE ON}
{$WARN IMAGEBASE_MULTIPLE ON}
{$WARN SUSPICIOUS_TYPECAST ON}
{$WARN PRIVATE_PROPACCESSOR ON}
{$WARN UNSAFE_TYPE OFF}
{$WARN UNSAFE_CODE OFF}
{$WARN UNSAFE_CAST OFF}
unit MainForm;

{$I SaveDocsTest.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, ComCtrls, ToolEdit, Mask, Buttons,

  m3DBInterfaces;

type
  TTestForm = class(TForm)
    Panel1 : TPanel;
    btnGo : TButton;
    lblGlobalStatus: TLabel;
    ClearBaseBTN: TButton;
    Timer1: TTimer;

    procedure btnGoClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ClearBaseBTNClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    procedure DoBase(const aDB: Im3DB);
    procedure DoImport;
    function GetBaseName: String;
  end;

var
 TestForm : TTestForm;
 DataPath : String;
 BasePath : String;
 OddData  : Boolean = False;

implementation

uses
  m3DB,
  m3StorageInterfaces,
  l3FileUtils,
  l3Base,
  l3Interfaces,
  l3Stream,
  l3Types,
  m3SplittedFileStream;

{$R *.DFM}

procedure TTestForm.CancelButtonClick(Sender: TObject);
begin
 Close;
end;

procedure TTestForm.btnGoClick(Sender: TObject);
begin
 btnGo.Enabled := False;
 lblGlobalStatus.Caption := 'Выполняется импорт...';
 Application.ProcessMessages;
 DoImport;
end;

procedure TTestForm.DoBase(const aDB: Im3DB);

  procedure MakeCopy(const anIn : IStream; const anOut : IStream);
  var
   l_Read : Int64;
   l_Written : Int64;
  begin//MakeCopy
   if not (anIn.CopyTo(anOut, High(Int64), l_Read, l_Written) = S_OK) then
    Assert(false);
   Assert(l_Read = l_Written);
  end;//MakeCopy

var
 l_Index : Integer;

 function DocStream(anAccess : Tm3StoreAccess) : IStream;
 var
  l_Doc : Im3DBDocument;
 begin//DocStream
  l_Doc := aDB.GetDocument(l_Index);
  try
   Result := l_Doc.Open(anAccess);
  finally
   l_Doc := nil;
  end;//try..finally
  l_Index := l_Index + 2;
 end;//DocStream

 function DoFile(const aFileName: string): Boolean;
 var
  l_SOut : IStream;
  l_SIn  : Tl3NamedFileStream;
 begin//DoFile
  Result := true;
  l_SOut := DocStream(m3_saReadWrite);
  try
   l_SIn := Tl3NamedFileStream.Create(aFileName, l3_fmRead);
   try
    MakeCopy(l_SIn, l_SOut);
   finally
    FreeAndNil(l_SIn);
   end;//try..finally
  finally
   l_SOut := nil;
  end;//try..finally
 end;//DoFile

var
 l_Folder : String;
 
 procedure ProcessFilesF(var aProc : Pointer);
 const
  cMask = '*';
 begin//ProcessFilesF
  try
   ProcessFilesWithMask(l_Folder, cMask, TFileProcessingFunc(aProc));
  finally
   l3FreeLocalStub(aProc);
  end;//try..finally
 end;//ProcessFilesF

var
 i           : Integer;
 l_DB        : Im3DB;
 l_FPStub    : Pointer;
 l_DBName    : String;
 l_DBNameNew : String;
begin
 l_Folder := DataPath;
 l_Index := 1;
 for i := 0 to 1000 do
 begin
  l_FPStub := l3LocalStub(@DoFile);
  ProcessFilesF(l_FPStub);
 end; // for i := 0 to 1000 do
 aDB.Update;
end;

procedure TTestForm.DoImport;
var
 l_DB : Im3DB;
 l_DBName : String;
begin
 l_DBName := GetBaseName;
 l_DB := Tm3DB.Make(l_DBName);
 try
  l_DB.Start(m3_saReadWrite);
  try
   DoBase(l_DB);
  finally
   l_DB.Finish;
  end;//try..finally
 finally
  l_DB := nil;
 end;//try..finally
end;

procedure TTestForm.FormShow(Sender: TObject);
begin
 if ParamCount > 2 then
  Timer1.Enabled := True;
end;

procedure TTestForm.ClearBaseBTNClick(Sender: TObject);
var
 l_DB : Im3DB;
 l_DBName : String;
begin
 l_DBName := GetBaseName;
 l_DB := Tm3DB.Make(l_DBName);
 try
  l_DB.DeleteVersion;
  l_DB.DeleteMain;
 finally
  l_DB := nil;
 end;//try..finally
end;

function TTestForm.GetBaseName: String;
begin
 Result := BasePath;
end;

procedure TTestForm.Timer1Timer(Sender: TObject);
begin
 btnGoClick(Sender);
 Close;
end;

end.
