#USEUNIT dcscript
#USEUNIT StdCtrls
sub Button1Click # Sender
{
$Form1->DCScripter1->Script->Assign($Form1->Memo1->Lines);
$Form1->DCScripter1->CallNoParamsMethod("script");
}