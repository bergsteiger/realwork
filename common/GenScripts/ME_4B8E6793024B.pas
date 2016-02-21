unit vtDialogsRes;

// Модуль: "w:\common\components\gui\Garant\VT\vtDialogsRes.pas"
// Стереотип: "UtilityPack"

{$Include w:\common\components\gui\Garant\VT\vtDefine.inc}

interface

uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* Локализуемые строки TvtMiscMessages }
 str_vtDefaultOpenDlgFilter: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtDefaultOpenDlgFilter'; rValue : 'Все файлы|*.*');
  {* 'Все файлы|*.*' }
{$If NOT Defined(Nemesis)}
 {* Локализуемые строки MsgDlg }
 str_vtMsgDlgWarning: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMsgDlgWarning'; rValue : 'Warning');
  {* 'Warning' }
 str_vtMsgDlgError: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMsgDlgError'; rValue : 'Error');
  {* 'Error' }
 str_vtMsgDlgInformation: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMsgDlgInformation'; rValue : 'Information');
  {* 'Information' }
 str_vtMsgDlgConfirm: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMsgDlgConfirm'; rValue : 'Confirm');
  {* 'Confirm' }
{$IfEnd} // NOT Defined(Nemesis)
{$If Defined(Nemesis)}
 {* Локализуемые строки MsgDlgNemesis }
 str_vtMsgDlgWarning: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMsgDlgWarning'; rValue : 'Предупреждение');
  {* 'Предупреждение' }
 str_vtMsgDlgError: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMsgDlgError'; rValue : 'Ошибка');
  {* 'Ошибка' }
 str_vtMsgDlgInformation: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMsgDlgInformation'; rValue : 'Информация');
  {* 'Информация' }
 str_vtMsgDlgConfirm: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMsgDlgConfirm'; rValue : 'Подтверждение');
  {* 'Подтверждение' }
{$IfEnd} // Defined(Nemesis)
 {* Локализуемые строки Custom }
 str_vtMsgDlgCustom: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMsgDlgCustom'; rValue : '');
  {* '' }
 {* Локализуемые строки MsgDlgButtons }
 str_vtMsgDlgYes: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMsgDlgYes'; rValue : '&Да');
  {* '&Да' }
 str_vtMsgDlgNo: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMsgDlgNo'; rValue : '&Нет');
  {* '&Нет' }
 str_vtMsgDlgOK: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMsgDlgOK'; rValue : 'OK');
  {* 'OK' }
 str_vtMsgDlgCancel: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMsgDlgCancel'; rValue : '&Отмена');
  {* '&Отмена' }
 str_vtMsgDlgAbort: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMsgDlgAbort'; rValue : '&Прервать');
  {* '&Прервать' }
 str_vtMsgDlgRetry: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMsgDlgRetry'; rValue : 'Пов&торить');
  {* 'Пов&торить' }
 str_vtMsgDlgIgnore: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMsgDlgIgnore'; rValue : '&Игнорировать');
  {* '&Игнорировать' }
 str_vtMsgDlgAll: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMsgDlgAll'; rValue : '&Все');
  {* '&Все' }
 str_vtMsgDlgNoToAll: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMsgDlgNoToAll'; rValue : '&Нет для всех');
  {* '&Нет для всех' }
 str_vtMsgDlgYesToAll: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMsgDlgYesToAll'; rValue : '&Да для всех');
  {* '&Да для всех' }
 str_vtMsgDlgHelp: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMsgDlgHelp'; rValue : '&Справка');
  {* '&Справка' }

implementation

uses
 l3ImplUses
 , l3MessageID
;

initialization
 str_vtDefaultOpenDlgFilter.Init;
 {* Инициализация str_vtDefaultOpenDlgFilter }
{$If NOT Defined(Nemesis)}
 str_vtMsgDlgWarning.Init;
 {* Инициализация str_vtMsgDlgWarning }
{$IfEnd} // NOT Defined(Nemesis)
{$If NOT Defined(Nemesis)}
 str_vtMsgDlgError.Init;
 {* Инициализация str_vtMsgDlgError }
{$IfEnd} // NOT Defined(Nemesis)
{$If NOT Defined(Nemesis)}
 str_vtMsgDlgInformation.Init;
 {* Инициализация str_vtMsgDlgInformation }
{$IfEnd} // NOT Defined(Nemesis)
{$If NOT Defined(Nemesis)}
 str_vtMsgDlgConfirm.Init;
 {* Инициализация str_vtMsgDlgConfirm }
{$IfEnd} // NOT Defined(Nemesis)
{$If Defined(Nemesis)}
 str_vtMsgDlgWarning.Init;
 {* Инициализация str_vtMsgDlgWarning }
{$IfEnd} // Defined(Nemesis)
{$If Defined(Nemesis)}
 str_vtMsgDlgError.Init;
 {* Инициализация str_vtMsgDlgError }
{$IfEnd} // Defined(Nemesis)
{$If Defined(Nemesis)}
 str_vtMsgDlgInformation.Init;
 {* Инициализация str_vtMsgDlgInformation }
{$IfEnd} // Defined(Nemesis)
{$If Defined(Nemesis)}
 str_vtMsgDlgConfirm.Init;
 {* Инициализация str_vtMsgDlgConfirm }
{$IfEnd} // Defined(Nemesis)
 str_vtMsgDlgCustom.Init;
 {* Инициализация str_vtMsgDlgCustom }
 str_vtMsgDlgYes.Init;
 {* Инициализация str_vtMsgDlgYes }
 str_vtMsgDlgNo.Init;
 {* Инициализация str_vtMsgDlgNo }
 str_vtMsgDlgOK.Init;
 {* Инициализация str_vtMsgDlgOK }
 str_vtMsgDlgCancel.Init;
 {* Инициализация str_vtMsgDlgCancel }
 str_vtMsgDlgAbort.Init;
 {* Инициализация str_vtMsgDlgAbort }
 str_vtMsgDlgRetry.Init;
 {* Инициализация str_vtMsgDlgRetry }
 str_vtMsgDlgIgnore.Init;
 {* Инициализация str_vtMsgDlgIgnore }
 str_vtMsgDlgAll.Init;
 {* Инициализация str_vtMsgDlgAll }
 str_vtMsgDlgNoToAll.Init;
 {* Инициализация str_vtMsgDlgNoToAll }
 str_vtMsgDlgYesToAll.Init;
 {* Инициализация str_vtMsgDlgYesToAll }
 str_vtMsgDlgHelp.Init;
 {* Инициализация str_vtMsgDlgHelp }

end.
