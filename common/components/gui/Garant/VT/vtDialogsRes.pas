unit vtDialogsRes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VT$Core"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/VT/vtDialogsRes.pas"
// Начат: 03.03.2010 16:43
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::VT$Core::Dialogs::vtDialogsRes
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\VT\vtDefine.inc}

interface

uses
  l3StringIDEx
  ;

var
  { Локализуемые строки TvtMiscMessages }
 str_vtDefaultOpenDlgFilter : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtDefaultOpenDlgFilter'; rValue : 'Все файлы|*.*');
  { 'Все файлы|*.*' }

{$If not defined(Nemesis)}
var
  { Локализуемые строки MsgDlg }
 str_vtMsgDlgWarning : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMsgDlgWarning'; rValue : 'Warning');
  { 'Warning' }
 str_vtMsgDlgError : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMsgDlgError'; rValue : 'Error');
  { 'Error' }
 str_vtMsgDlgInformation : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMsgDlgInformation'; rValue : 'Information');
  { 'Information' }
 str_vtMsgDlgConfirm : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMsgDlgConfirm'; rValue : 'Confirm');
  { 'Confirm' }
{$IfEnd} //not Nemesis

{$If defined(Nemesis)}
var
  { Локализуемые строки MsgDlgNemesis }
 str_vtMsgDlgWarning : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMsgDlgWarning'; rValue : 'Предупреждение');
  { 'Предупреждение' }
 str_vtMsgDlgError : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMsgDlgError'; rValue : 'Ошибка');
  { 'Ошибка' }
 str_vtMsgDlgInformation : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMsgDlgInformation'; rValue : 'Информация');
  { 'Информация' }
 str_vtMsgDlgConfirm : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMsgDlgConfirm'; rValue : 'Подтверждение');
  { 'Подтверждение' }
{$IfEnd} //Nemesis

var
  { Локализуемые строки Custom }
 str_vtMsgDlgCustom : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMsgDlgCustom'; rValue : '');
  { '' }

var
  { Локализуемые строки MsgDlgButtons }
 str_vtMsgDlgYes : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMsgDlgYes'; rValue : '&Да');
  { '&Да' }
 str_vtMsgDlgNo : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMsgDlgNo'; rValue : '&Нет');
  { '&Нет' }
 str_vtMsgDlgOK : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMsgDlgOK'; rValue : 'OK');
  { 'OK' }
 str_vtMsgDlgCancel : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMsgDlgCancel'; rValue : '&Отмена');
  { '&Отмена' }
 str_vtMsgDlgAbort : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMsgDlgAbort'; rValue : '&Прервать');
  { '&Прервать' }
 str_vtMsgDlgRetry : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMsgDlgRetry'; rValue : 'Пов&торить');
  { 'Пов&торить' }
 str_vtMsgDlgIgnore : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMsgDlgIgnore'; rValue : '&Игнорировать');
  { '&Игнорировать' }
 str_vtMsgDlgAll : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMsgDlgAll'; rValue : '&Все');
  { '&Все' }
 str_vtMsgDlgNoToAll : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMsgDlgNoToAll'; rValue : '&Нет для всех');
  { '&Нет для всех' }
 str_vtMsgDlgYesToAll : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMsgDlgYesToAll'; rValue : '&Да для всех');
  { '&Да для всех' }
 str_vtMsgDlgHelp : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMsgDlgHelp'; rValue : '&Справка');
  { '&Справка' }

implementation

uses
  l3MessageID
  ;


initialization
// Инициализация str_vtDefaultOpenDlgFilter
 str_vtDefaultOpenDlgFilter.Init;
{$If not defined(Nemesis)}
// Инициализация str_vtMsgDlgWarning
 str_vtMsgDlgWarning.Init;
{$IfEnd} //not Nemesis
{$If not defined(Nemesis)}
// Инициализация str_vtMsgDlgError
 str_vtMsgDlgError.Init;
{$IfEnd} //not Nemesis
{$If not defined(Nemesis)}
// Инициализация str_vtMsgDlgInformation
 str_vtMsgDlgInformation.Init;
{$IfEnd} //not Nemesis
{$If not defined(Nemesis)}
// Инициализация str_vtMsgDlgConfirm
 str_vtMsgDlgConfirm.Init;
{$IfEnd} //not Nemesis
{$If defined(Nemesis)}
// Инициализация str_vtMsgDlgWarning
 str_vtMsgDlgWarning.Init;
{$IfEnd} //Nemesis
{$If defined(Nemesis)}
// Инициализация str_vtMsgDlgError
 str_vtMsgDlgError.Init;
{$IfEnd} //Nemesis
{$If defined(Nemesis)}
// Инициализация str_vtMsgDlgInformation
 str_vtMsgDlgInformation.Init;
{$IfEnd} //Nemesis
{$If defined(Nemesis)}
// Инициализация str_vtMsgDlgConfirm
 str_vtMsgDlgConfirm.Init;
{$IfEnd} //Nemesis
// Инициализация str_vtMsgDlgCustom
 str_vtMsgDlgCustom.Init;
// Инициализация str_vtMsgDlgYes
 str_vtMsgDlgYes.Init;
// Инициализация str_vtMsgDlgNo
 str_vtMsgDlgNo.Init;
// Инициализация str_vtMsgDlgOK
 str_vtMsgDlgOK.Init;
// Инициализация str_vtMsgDlgCancel
 str_vtMsgDlgCancel.Init;
// Инициализация str_vtMsgDlgAbort
 str_vtMsgDlgAbort.Init;
// Инициализация str_vtMsgDlgRetry
 str_vtMsgDlgRetry.Init;
// Инициализация str_vtMsgDlgIgnore
 str_vtMsgDlgIgnore.Init;
// Инициализация str_vtMsgDlgAll
 str_vtMsgDlgAll.Init;
// Инициализация str_vtMsgDlgNoToAll
 str_vtMsgDlgNoToAll.Init;
// Инициализация str_vtMsgDlgYesToAll
 str_vtMsgDlgYesToAll.Init;
// Инициализация str_vtMsgDlgHelp
 str_vtMsgDlgHelp.Init;

end.