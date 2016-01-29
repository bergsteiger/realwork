unit evExtSearch;

{ Библиотека "Эверест"    }
{ Автор: Люлин А.В. ©     }
{ Модуль: evExtSearch -   }
{ Начат: 14.09.2001 10:18 }
{ $Id: evExtSearch.pas,v 1.4 2005/03/02 09:08:36 lulin Exp $ }

// $Log: evExtSearch.pas,v $
// Revision 1.4  2005/03/02 09:08:36  lulin
// - bug fix: не компилировалось.
//
// Revision 1.3  2003/03/05 13:20:05  law
// - bug fix.
//
// Revision 1.2  2001/09/14 12:50:22  law
// - new behavior: добавлено значение текста по умолчанию.
//
// Revision 1.1  2001/09/14 12:30:34  law
// - new behavior: добавлена возможность поиска.
//

{$I evDefine.inc }

interface

uses
  Classes,
  Dialogs,
  
  l3Types,
  l3Base,
  l3InterfacedComponent,

  evCustomEditor,
  evEditor,
  evSearch
  ;

type
  TSearcher = class(TDataModule)
    FindDialog: TFindDialog;
    TextSearcher: TevBMTextSearcher;
    procedure FindDialogFind(Sender: TObject);
  private
    f_Editor : TevCustomEditor;
    { Private declarations }
  public
    { Public declarations }
    procedure Search(anEditor: TevCustomEditor);
      {-}
  end;

function Search(anEditor : TevCustomEditor): Bool;
  {-}
function SearchAgain(anEditor : TevCustomEditor): Bool;
  {-}
  
implementation

uses
  Forms,

  evTypes,
  evExcept
  ;

{$R *.dfm}

var
 l_Searcher : TSearcher;

function Search(anEditor : TevCustomEditor): Bool;
begin
 Result := true;
 if (l_Searcher = nil) then l_Searcher := TSearcher.Create(Application);
 l_Searcher.Search(anEditor);
end;

function SearchAgain(anEditor : TevCustomEditor): Bool;
begin
 Result := true;
 if (l_Searcher = nil) then
  Result := false
 else begin
  Result := true;
  with l_Searcher do begin
   f_Editor := anEditor;
   FindDialogFind(FindDialog)
  end;//with l_Searcher
 end;//
end;

// start class TSearcher

procedure TSearcher.Search(anEditor: TevCustomEditor);
  {-}
begin
 f_Editor := anEditor;
 FindDialog.FindText := f_Editor.Range.AsString;
 FindDialog.Execute;
end;

procedure TSearcher.FindDialogFind(Sender: TObject);
begin
 if (frMatchCase in FindDialog.Options) then
  TextSearcher.Options := [ev_soMatchCase]
 else
  TextSearcher.Options := [];
 TextSearcher.Text := FindDialog.FindText;
 try
  f_Editor.Find(TextSearcher, nil, []);
 except
  on EevSearchFailed do begin
   MessageDlg(TextSearcher.NotFoundMessage, mtWarning, [mbOK], 0);
  end;//on EevSearchFailed
 end;//try..except
end;

end.
