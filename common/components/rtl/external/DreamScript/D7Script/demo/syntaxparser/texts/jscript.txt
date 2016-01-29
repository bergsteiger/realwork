//USEUNIT DCGen
//USEUNIT ExtCtrls
//USEUNIT StdCtrls
var A =Array(OpenBut,SaveBut,CloseBut,FindBut);
var AFlat = false;
var AEnabled = true;
var Acount = 0;
var mes1 = "You have changed property %S of controls %S";
var mes2 = "You have pressed button: %S with tag %d";

function SetEnabled(A,count)
{
  for(i= 0; i< count;i++)
    A(i).Enabled = !A(i).Enabled;

}

function Button2Click(Sender)
{
  AFlat = !AFlat;
  SetFlatProp(A,AFlat);
  Showmessage(Format(mes1,["Flat","OpenBut,SaveBut,CloseBut,FindBut"] ) );
}

function Button1Click(Sender)
{
  AEnabled = ! AEnabled
  SetEnabledControls(A,AEnabled)
  Showmessage(Format(mes1,Array("Enabled","OpenBut,SaveBut,CloseBut,FindBut") ) )
}

function OpenButClick(Sender)
{
  Showmessage(Format(mes2,Array(Sender.Name,Sender.tag)));
}

function ChangeSet(Sender,Attr,ASet)
{

  if ( inset(Attr, Sender.Font.Style) )
    Sender.Font.Style &= ~ASet;
  else
    Sender.Font.Style |=  ASet;
}

function Label1Click(Sender)
{
  switch (Acount)
  {
    case 0: ChangeSet(Sender,fsBold,mkset(fsBold,fsItalic)) ; break;
    case 1: ChangeSet(Sender,fsItalic,mkset(fsItalic,fsUnderline)) ; break;
    case 2: ChangeSet(Sender,fsUnderline,mkset(fsUnderline,fsBold)); break;
  }
  Acount = Acount + 1
  if (Acount == 3)
    Acount = 0

}