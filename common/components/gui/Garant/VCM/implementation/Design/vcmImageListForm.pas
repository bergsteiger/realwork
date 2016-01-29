unit vcmImageListForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Buttons, ImgList, ExtCtrls,
  DesignEditors;

type
  TvcmImageList = class(TForm)
    ListView: TListView;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure ListViewDblClick(Sender: TObject);
    procedure ListViewResize(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    class function Execute(anEditor : TPropertyEditor;
                           anImages : TCustomImageList): Boolean;
      {-}
  end;

implementation

{$R *.dfm}

// start class TvcmImageList

class function TvcmImageList.Execute(anEditor : TPropertyEditor;
                                     anImages : TCustomImageList): Boolean;
  {-}
var
 l_Index : Integer;
begin
 if (anImages = nil) OR (anEditor = nil) then
  Result := false
 else
  with Create(nil) do
   try
    with ListView do begin
     LargeImages := anImages;
     SmallImages := anImages;
     with Items do begin
      Clear;
      for l_Index := 0 to Pred(anImages.Count) do
       with Add do begin
        Caption := IntToStr(l_Index);
        ImageIndex := l_Index;
       end;//with Add
     end;//with Items
     try
      ItemIndex := StrToInt(anEditor.GetValue);
     except
      ItemIndex := -1;
     end;//try..except
    end;//with ListView
    Result := (ShowModal = mrOk);
    if Result then
     anEditor.SetValue(IntToStr(ListView.ItemIndex));
   finally
    Free;
   end;//try..finally
end;

procedure TvcmImageList.ListViewDblClick(Sender: TObject);
begin
 if (ListView.ItemIndex >= 0) then
  ModalResult := mrOk;
end;

procedure TvcmImageList.ListViewResize(Sender: TObject);
begin
 ListView.Arrange(arDefault);	
end;

end.
