unit vtPngImgListCEditor;

interface
uses
 DesignEditors;

type
 TPILEditor = class(TDefaultEditor)
 public
  procedure Edit; override;
 end;

 TNFPILEditor = class(TDefaultEditor)
 public
  procedure Edit; override;
 end;

implementation
uses Forms, vtPngImgList, vtPngImgListEditor, vtNFPngImgListEditor;

procedure TPILEditor.Edit;
var
 F : TvtPngImageListEditForm;
begin
 F := TvtPngImageListEditForm.Create(Application);
 try
  F.PngImgList := TvtPngImageList(Component);
  F.ShowModal;
  Designer.Modified;
 finally
  F.Free;
 end;
end;

procedure TNFPILEditor.Edit;
var
 F : TvtNFPngImageListEditForm;
begin
 F := TvtNFPngImageListEditForm.Create(Application);
 try
  F.PngImgList := TvtNonFixedPngImageList(Component);
  F.ShowModal;
  Designer.Modified;
 finally
  F.Free;
 end;
end;


end.
