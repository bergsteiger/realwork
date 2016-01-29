//USEUNIT Db
//USEUNIT DBTables
//USEUNIT Menus
//USEUNIT DBGrids
//USEUNIT DBCtrls
//USEUNIT StdCtrls
//USEUNIT About
var eKeyViol = 9729;
var eRequiredFieldMissing = 9732;
var eForeignKey = 9733;
var eDetailsExist = 9734;

//-------------------------------------------------------------------

function GridOrdersEnter(Sender)
{
  DBNavigator1.DataSource = OrdersSource;
}

//-------------------------------------------------------------------

function GridCustomersEnter(Sender)
{
  DBNavigator1.DataSource = CustomerSource;
}

//-------------------------------------------------------------------

function GridItemsEnter(Sender)
{
  DBNavigator1.DataSource = ItemsSource;
}

//-------------------------------------------------------------------

function GridCustomersExit(Sender)
{
  Customer.CheckBrowseMode;
}

//-------------------------------------------------------------------

function About1Click(Sender)
{
  FmAboutBox.ShowModal;
}

//-------------------------------------------------------------------

function CustomerPostError(DataSet, E, Action)
{
//  if (E.InheritsFrom(EDBEngineError))
    if (E.Errors(0).Errorcode == eKeyViol)
    {
      MessageDlg("Unable to post: Duplicate Customer ID.", mtWarning, mbOK, 0);
      Abort;
    }
}

//-------------------------------------------------------------------

function CustomerDeleteError(DataSet,E,Action)
{
//  if (E.InheritsFrom(EDBEngineError))
    if (E.Errors(0).Errorcode == eDetailsExist)
    {
      MessageDlg("To delete this record, first delete related orders and items.",
        mtWarning, MkSet(mbOK), 0);
      Abort;
    }
}

//-------------------------------------------------------------------

function CustomerCustNoChange(Sender)
{
  Orders.DisableControls;
  Items.DisableControls;
}

//-------------------------------------------------------------------

function CustomerAfterPost(DataSet)
{
  Orders.Refresh;
  Items.Refresh;
  Orders.EnableControls;
  Items.EnableControls;
}

//-------------------------------------------------------------------

function ItemsPostError(DataSet,E,Action)
{
// if (E.InheritsFrom(EDBEngineError))
  if (E.Errors(0).Errorcode == eForeignKey )
  {
    MessageDlg("Part number is invalid", mtWarning,MkSet(mbOK),0);
    Abort;
  }
}

//-------------------------------------------------------------------

function OrdersPostError(DataSet,E,Action)
{
var iDBIError
//  if (E.InheritsFrom(EDBEngineError))
  {
    iDBIError = E.Errors(0).Errorcode;
    switch (iDBIError)
    {
      case eRequiredFieldMissing:
        {
          MessageDlg("Please provide an Employee ID", mtWarning, MkSet(mbOK), 0);
          Abort;
          break;
        }
      case eKeyViol:
        {
          MessageDlg("Unable to post. Duplicate Order Number", mtWarning,
            (mbOK), 0);
          Abort;
          break;
        }
    }
  }
}

//-------------------------------------------------------------------

function OrdersDeleteError(DataSet,E, Action)
{
 // if (E.InheritsFrom(EDBEngineError))
    if (E.Errors(0).Errorcode == eDetailsExist)
    {
      if ( MessageDlg("Delete this order and related items?", mtConfirmation,
        MkSet(mbYes, mbNo), 0) == mrYes )
      {
        for (;Items.RecordCount > 0;)
          Items.Delete;
        Action = daRetry;
      }
      else
        Abort;
    }
}

