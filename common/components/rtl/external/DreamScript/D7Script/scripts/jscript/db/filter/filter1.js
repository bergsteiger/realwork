//USEUNIT StdCtrls
//USEUNIT Custview

//-------------------------------------------------------------------

function AddFieldName(Sender)
{
  if (Memo1.Text != "")
    Memo1.Text = Memo1.Text + " ";
  Memo1.Text = Memo1.Text + ListBox1.Items(ListBox1.ItemIndex);
}

//-------------------------------------------------------------------

function ListBox2DblClick(Sender)
{
  if (Memo1.Text != "")
    Memo1.Text = Memo1.Text + " "+ ListBox2.Items(ListBox2.ItemIndex);
}

//-------------------------------------------------------------------

function ApplyFilter(Sender)
{
  with (fmCustView.CustomerSource.Dataset)
  {
    if (ComboBox1.Text != "")
    {
      Filter = ComboBox1.Text;
      Filtered = true;
      fmCustView.Caption = "Customers - Filtered";
    }
    else
    {
      Filter = "";
      Filtered = false;
      fmCustView.Caption = "Customers - Unfiltered"
    }
  }
}

//-------------------------------------------------------------------

function Memo1Change(Sender)
{
var i;
  ComboBox1.Text = Memo1.Lines(0);
  for (i = 1; i<= Memo1.Lines.Count - 1;i++)
    ComboBox1.Text = ComboBox1.Text + " " + Memo1.Lines(i);
}

//-------------------------------------------------------------------

function cbCaseSensitiveClick(Sender)
{
  with (fmCustView.CustomerSource.Dataset)
    if (cbCaseSensitive.checked)
      FilterOptions &=  ~mkset(foCaseInSensitive);
    else
      FilterOptions |=  mkset(foCaseInSensitive);
}

//-------------------------------------------------------------------

function cbNoPartialCompareClick(Sender)
{
  with (fmCustView.CustomerSource.Dataset)
    if (cbCaseSensitive.checked)
      FilterOptions &=  ~mkset(foNoPartialCompare);
    else
      FilterOptions |=  mkset(foNoPartialCompare);
}

//-------------------------------------------------------------------

function SBtnClearClick(Sender)
{
var st;
  Memo1.Lines.Text = "";
  st = ComboBox1.Text;
  ComboBox1.Text = "";
  if (ComboBox1.Items.IndexOf(st) == -1)
    ComboBox1.Items.Add(st);
}

//-------------------------------------------------------------------

function ComboBox1Change(Sender)
{
  Memo1.Text = "";
  Memo1.Lines.Add(ComboBox1.Text);
}

//-------------------------------------------------------------------

function SBtnCloseClick(Sender)
{
  Close;
}

//-------------------------------------------------------------------

function FormShow(Sender)
{
var i=0;
  with (fmCustView.CustomerSource)
    for (i = 0; i<= Dataset.FieldCount - 1 ;i++)
      ListBox1.Items.Add(Dataset.Fields(i).FieldName);

  ComboBox1.Items.Add("LastInvoiceDate >= ' " + DateToStr(EncodeDate(1994, 9, 30))+"'");
  ComboBox1.Items.Add("Country = 'US' and LastInvoiceDate > '" +
    DateToStr(EncodeDate(1994, 6, 30)) + "'");
}
