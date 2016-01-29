//USEUNIT Db
//USEUNIT DBTables
//USEUNIT Menus
//USEUNIT ExtCtrls
//USEUNIT DBCtrls
//USEUNIT DBGrids
//USEUNIT ComCtrls
//USEUNIT Buttons
//USEUNIT StdCtrls
//USEUNIT About
//USEUNIT Filter1
var  OrdersFilterAmount = 0;

//-------------------------------------------------------------------

function rgDataSetClick(Sender)
{
var st="";
  with (CustomerSource)
  {
    if (Dataset.Filtered)
      st = Dataset.Filter;
    switch (rgDataset.ItemIndex)
    {
      case 0:  Dataset = SQLCustomer; break;
      case 1:  Dataset = Customer; break;
    }
    Dataset.Refresh;
    if (st != "")
    {
      Dataset.Filter = st;
       Dataset.Filtered = true;
    }

  }
}

//-------------------------------------------------------------------

function SpeedButton1Click(Sender)
{
  fmFilterFrm.Show;
}

//-------------------------------------------------------------------

function cbFilterOrdersClick(Sender)
{
  SQLOrders.Filtered = cbFilterOrders.Checked;
  if (cbFilterOrders.Checked)
    Edit1Change(null);
}

//-------------------------------------------------------------------

function About1Click(Sender)
{
  Formabout.ShowModal;
}

//-------------------------------------------------------------------

function Edit1Change(Sender)
{
  if ((cbFilterOrders.checked) && (Edit1.Text != ""))
  {
    OrdersFilterAmount = StrToFloat(fmCustView.Edit1.Text);
    SQLOrders.Filter = "AmountPaid >="+ fmCustView.Edit1.Text
    SQLOrders.Refresh;
  }
}

//-------------------------------------------------------------------

function DBGrid1Enter(Sender)
{
  DBNavigator1.DataSource = DBGrid1.DataSource;
}

//-------------------------------------------------------------------

function DBGrid2Enter(Sender)
{
  DBNavigator1.DataSource = DBGrid2.DataSource;
}

