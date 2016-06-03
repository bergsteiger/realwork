unit Diction_Strange_Controls;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Diction_Strange_Controls.pas"
// Стереотип: "VCMControls"
// Элемент модели: "Strange" MUID: (4C850F97017C)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 en_Lang = 'Lang';
 en_capLang = '';
 op_Russian = 'Russian';
 op_capRussian = '';
 op_English = 'English';
 op_capEnglish = '';
 op_French = 'French';
 op_capFrench = '';
 op_Deutch = 'Deutch';
 op_capDeutch = '';
 op_Italian = 'Italian';
 op_capItalian = '';
 op_Spanish = 'Spanish';
 op_capSpanish = '';
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
