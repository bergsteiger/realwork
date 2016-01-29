unit mmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
uses
 ArchiAdapter,
 GarDocsUnit,
 IOUnit,
 l3DateTimeBox
 ;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
 I: Integer;
 J: Integer;
 l_DLL: IArchiAdapterDll;
 l_Searcher: ISearcher;
 l_List : IGardocList;
 l_GD: TGardoc;
 l_Str: IString;
 l_Date: TDateTimeBox;
 //l_PubDate, l_MUDate: TStDate;
 //l_PubNum, l_MUNum : Il3CString;
begin
 l_DLL := TArchiAdapterDll.Make;
 if l_DLL <> nil then
 begin
  l_Searcher := l_DLL.GetSearcher;
  if l_Searcher <> nil then
  begin
   l3DateTimeToBox(Now, l_Date);
   l_Searcher.GetRecentlyCreatedSince(l_Date, l_List);
   if l_List <> nil then
   begin
    for I := 0 to l_List.Count - 1 do
    begin
     l_List.pm_GetItem(I, l_GD);
    end;
   end;
  end;
 end;
end;

end.
