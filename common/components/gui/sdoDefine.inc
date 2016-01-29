{$Include W:\common\components\gui\Garant\VCM\vcmDefine.inc}

{$If Defined(Nemesis)}
 {$If Defined(Admin) OR Defined(Monitorings)}
  {$Define NoTabs}
 {$IfEnd}
{$Else}
 {$Define NoTabs}
{$IfEnd}