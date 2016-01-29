//USEUNIT DBGrids
//USEUNIT Db
//USEUNIT DBTables
//USEUNIT StdCtrls
var SDreamCaption = 'Dream Scripter - the power of Active scripting';

function WordButClick(Sender)
{
  v = CreateOleObject('Word.Application');
  if (v == 0)
  {
    showmessage("Can't start MSWord");
    return;
  }
  with (v)
  {
    Visible = true;
    WordBasic.filenew('normal');
    WordBasic.editselectall;
    selection.Font.name = 'Times New Roman';
    selection.Font.size = 20;
    WordBasic.Insert(SDreamCaption);
    for (i = 0 ; i < 3 ; i++)
      WordBasic.Insert(chr(13) + chr(10));

    selection.Font.size = 10;
    myTable = ActiveDocument.Tables.Add(Selection.Range, Table1.RecordCount,Table1.FieldCount )
    Table1.First;
    for (i = 0 ; i < Table1.RecordCount;i++ )
    {
      for (j = 0 ; j < Table1.FieldCount; j++ )
      {
        myTable.Cell(i+1,j+1).Range.InsertAfter(Table1.Fields(j).AsString);

      }
      Table1.Next;
    }

  }
}

function ExcelButClick(Sender)
{

  v = CreateOleObject('Excel.Application');
  if (v == 0)
  {
    showmessage("Can't start MSExcel");
    return;
  }

  v.visible = true;
  v.WorkBooks.Add;
  v.ActiveSheet.Cells(1,1).Font.Size = 20;
  v.ActiveSheet.Cells(1,1) = SDreamCaption;
  Table1.First;
  s='';
  while (!Table1.eof)
  {
    for (j = 0 ; j < Table1.FieldCount; j++ )
      s = s + Table1.Fields(j).AsString +chr(9);
    s = s+ chr(13)+chr(10);
    Table1.Next;

  }
  v.ActiveSheet.Cells(3,1).Select;
  Clipboard.AsText = s;
  v.ActiveSheet.Paste;
  v.ActiveSheet.Cells(3,1).Select;
}