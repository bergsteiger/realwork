//USEUNIT dcstdctl
//USEUNIT Db
//USEUNIT DBTables
//USEUNIT Buttons
//USEUNIT DBCtrls
//USEUNIT DBGrids
//USEUNIT ExtCtrls
//USEUNIT detail

//-------------------------------------------------------------------
function AssignImages()
{
  DetailForm.Image1.Picture.Assign(Dbimage1.Picture);
}

function ViewButClick(Sender)
{
 DetailForm.Visible = !(DetailForm.Visible);
 AssignImages();
}

//-------------------------------------------------------------------

function DataSource1DataChange(Sender, Field)
{
  AssignImages();
}
//-------------------------------------------------------------------

function CloseButClick(Sender)
{
  close;
}