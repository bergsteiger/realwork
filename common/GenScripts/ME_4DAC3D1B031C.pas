unit WarningConst;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\WarningConst.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "WarningConst" MUID: (4DAC3D1B031C)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* Локализуемые строки WarningConst }
 str_wgJurorCommentHint: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'wgJurorCommentHint'; rValue : 'Документ с комментариями юристов');
  {* 'Документ с комментариями юристов' }
 str_wgTimeMachineOffHint: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'wgTimeMachineOffHint'; rValue : 'Машина времени будет выключена, а текст документа будет представлен в актуальной редакции');
  {* 'Машина времени будет выключена, а текст документа будет представлен в актуальной редакции' }
 str_wgNotShureWarningHint: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'wgNotShureWarningHint'; rValue : 'Период действия данной редакции документа не может быть определен однозначно');
  {* 'Период действия данной редакции документа не может быть определен однозначно' }
 str_wgReferenceHint: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'wgReferenceHint'; rValue : 'Ссылка на справку к документу');
  {* 'Ссылка на справку к документу' }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

initialization
 str_wgJurorCommentHint.Init;
 {* Инициализация str_wgJurorCommentHint }
 str_wgTimeMachineOffHint.Init;
 {* Инициализация str_wgTimeMachineOffHint }
 str_wgNotShureWarningHint.Init;
 {* Инициализация str_wgNotShureWarningHint }
 str_wgReferenceHint.Init;
 {* Инициализация str_wgReferenceHint }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
