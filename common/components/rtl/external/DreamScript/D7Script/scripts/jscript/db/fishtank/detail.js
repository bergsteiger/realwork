//USEUNIT Buttons
//USEUNIT ExtCtrls
//USEUNIT main
function OpenButClick(Sender)
{
var Dialog = TOpenDialog.Create(null);
    Dialog.Filename = '*.bmp';
    if (Dialog.Execute)
    {
      MainForm.Table1.Edit;
      Image1.Picture.LoadFromFile(Dialog.Filename);
      MainForm.dbimage1.Picture.Assign(Image1.Picture);
      MainForm.Table1.Post;
      showmessage('Image Loaded');
    }
    Dialog.Free;

}

function SaveButClick(Sender)
{
var Dialog = TSaveDialog.Create(null);
    Dialog.Filename = '*.bmp';
    if (Dialog.Execute)
    {
      Image1.Picture.SaveToFile(Dialog.Filename);
      showmessage('Image Saved');
    }
    Dialog.Free;

}

function CloseButClick(Sender)
{
  Close;
}