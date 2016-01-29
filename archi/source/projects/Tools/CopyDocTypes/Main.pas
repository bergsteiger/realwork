unit Main;

{ $Id: Main.pas,v 1.9 2015/04/01 11:54:38 lukyanets Exp $ }

// $Log: Main.pas,v $
// Revision 1.9  2015/04/01 11:54:38  lukyanets
// »золируем утилиты
//
// Revision 1.8  2014/10/16 10:41:39  lukyanets
// Ѕолее контролируемо создаем конфиги
//
// Revision 1.7  2005/05/27 14:44:37  lulin
// - базовый контрол переехал в быблиотеку L3.
//
// Revision 1.6  2004/12/23 11:47:16  lulin
// - rename unit: User_Cfg -> l3IniFile.
//
// Revision 1.5  2004/10/12 09:50:57  step
// оптимизирована TDocTypeModifier.Execute
//
// Revision 1.4  2004/10/06 15:37:44  step
// добавлена индексаци€
//
// Revision 1.3  2004/10/06 13:55:12  lulin
// - теперь метод Im3DB.Start имеет два ќЅя«ј“≈Ћ№Ќџ’ параметра - режимы открыти€ частей. ¬ результате этого заработала утилита, котора€ расставл€ет IndexID.
//
// Revision 1.2  2004/09/27 11:53:05  lulin
// - добавлены забытые inherited вызовы.
// - убраны лишние вызовы Clear.
//
// Revision 1.1  2004/08/25 15:17:36  step
// переименование файлов и мелкие исправлени€
//

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,
  l3Base,
  Dt_Serv, Dt_Const, StdCtrls, Contnrs,
  m4DB, m4DBInterfaces, m3DB, m3DBInterfaces, OvcBase,  W95Meter,
  afwControlPrim, afwBaseControl, afwControl;

type
  TDocTypeModifier = class;

  TMainForm = class(TForm)
    btStart: TButton;
    btStop: TButton;
    FileMeter: TW95Meter;
    FilesMeter: TW95Meter;
    lbFile: TLabel;
    lbFiles: TLabel;
    procedure btStartClick(Sender: TObject);
    procedure btStopClick(Sender: TObject);
    procedure FileMeterSetStr(const aStr: String);
    procedure FilesMeterSetStr(const aStr: String);
  private
    f_DocTypeModifier: TDocTypeModifier;
    procedure Yield(aSender: TObject);
  public

  end;

  TDocsData = class(Tl3Base) // отображение AbsNum --> Typ
  private
   f_List: TBucketList;
   f_DocBaseFile: string;
   procedure Init;
  protected
   procedure Release; override;
  public
   constructor Create; reintroduce;
   function TypeOf(aDocId: LongWord): TDocType;
   function DocBaseFile: string; // заодно - полное им€ bserv001
  end;

  TDocTypeModifier = class(Tl3Base)
  private
   f_DocTypes: TDocsData;
   f_DocBase: Im4DB;
  protected
   procedure Release; override;
  public
   constructor Create(aForm: TMainForm); reintroduce;
   procedure Execute;
  end;


var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
 l3IniFile, Dt_Doc, Dt_Query, l3FileUtils, m3StorageInterfaces, Dt_Types,
 ncsDefaultProviderHolder;

{ TDocsData }

constructor TDocsData.Create;
begin
 inherited Create;

 InitStationAndServerConfig('Archi.Ini');
 TncsDefaultProviderHolder.CreateProvider;

 f_List := TBucketList.Create(bl256);

 Init;
end;

function TDocsData.DocBaseFile: string;
begin
 Result := f_DocBaseFile;
end;

procedure TDocsData.Init;
var
 l_Query: TSelectionQuery;
begin
 f_List.Clear;

 DocumentServer.Family := CurrentFamily;
 l_Query := TSelectionQuery.Create(DocumentServer.FileTbl);
 try
  l_Query.SortedBy([fId_Fld]);
  l_Query.Open([fId_Fld, fType_Fld]);
  while not l_Query.Eof do
  begin
   f_List.Add(Pointer(l_Query.FieldAsLongWord[fId_Fld]),
              Pointer(l_Query.FieldAsByte[fType_Fld]));

   l_Query.Next;
  end;
  l_Query.Close;
 finally
  FreeandNil(l_Query);
 end;

 // полное им€ bserv001
 f_DocBaseFile := ConcatDirName(ExtractFileDir(DocumentServer.FileTbl.TblFullName), 'bserv001');
end;

procedure TDocsData.Release;
begin
 TncsDefaultProviderHolder.DestroyProvider;
 DoneConfigs;

 l3Free(f_List);

 inherited;
end;

function TDocsData.TypeOf(aDocId: LongWord): TDocType;
var
 l_Type: Pointer;
begin
 if f_List.Find(Pointer(aDocId), l_Type) then
  Result := TDocType(Byte(l_Type))
 else
  Result := dtNone;
end;

{ TDocTypeModifier }

constructor TDocTypeModifier.Create(aForm: TMainForm);
begin
 f_DocTypes := TDocsData.Create;
 f_DocBase := Tm4DB.Make(f_DocTypes.DocBaseFile, False,
                         aForm.Yield,
                         aForm.FileMeter.ProgressProc_ev,
                         aForm.FilesMeter.ProgressProc_ev); // bserv001
end;

procedure TDocTypeModifier.Execute;
 function DoDoc(const aDoc: Im3DBDocumentPart): Bool;
 var
  l_DocumentInfo: Tm3DBDocumentInfo;
  l_IndexID     : LongInt;
 begin
  l_DocumentInfo := aDoc.Info;
  l_IndexID := Ord(f_DocTypes.TypeOf(aDoc.Document.ID));
  if l_DocumentInfo.rIndexID <> l_IndexID then
  begin
   l_DocumentInfo.rIndexID := l_IndexID;
   aDoc.Info := l_DocumentInfo;
  end;
  Result := True;
 end;

begin
 f_DocBase.Start(m3_saReadWrite, m3_saReadWrite);
 try
  f_DocBase.AllFiles.IterateF(m3L2DocumentAction(@DoDoc));
  f_DocBase.BuildIndex;
 finally
  f_DocBase.Finish;
 end;
end;

procedure TDocTypeModifier.Release;
begin
 l3Free(f_DocTypes);
 f_DocBase := nil;

 inherited;
end;

procedure TMainForm.btStartClick(Sender: TObject);
begin
 btStart.Enabled := false;
 try
  btStop.Enabled := true;
  try
   f_DocTypeModifier := TDocTypeModifier.Create(Self);
   try
    f_DocTypeModifier.Execute;
   finally
    l3Free(f_DocTypeModifier);
   end;
  finally
   btStop.Enabled := false;
  end;
 finally
  btStart.Enabled := true;
 end;
end;

procedure TMainForm.Yield(aSender: TObject);
begin
 Application.ProcessMessages;
end;

procedure TMainForm.btStopClick(Sender: TObject);
begin
 if (f_DocTypeModifier <> nil) then
 begin
  f_DocTypeModifier.f_DocBase.Stop;
  btStop.Enabled := false;
 end;
end;

procedure TMainForm.FileMeterSetStr(const aStr: String);
begin
 lbFile.Caption := aStr;
end;

procedure TMainForm.FilesMeterSetStr(const aStr: String);
begin
 lbFiles.Caption := aStr;
end;

end.

