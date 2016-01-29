{$IfDef nsWatch}
var
 l_Watch : IWatch;
{$EndIf nsWatch}
begin
{$IfDef nsWatch}
 {$If Declared(_ID_)}
  l_Watch := DefDataAdapter.GetWatch(_Watch_);
 {$Else }
  l_Watch := DefDataAdapter.GetWatch(_ID_, _Watch_);
 {$IfEnd}
{$EndIf nsWatch}
