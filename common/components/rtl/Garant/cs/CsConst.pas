unit CsConst;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "cs"
// Модуль: "w:/common/components/rtl/Garant/cs/CsConst.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi For Archi::cs::Core::CsConst
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\cs\CsDefine.inc}

interface

{$If not defined(Nemesis)}
uses
  daInterfaces
  ;

const
  { cProtocolVersion }
 c_CsVersion = 25;

const
  { cPredefinedClients }
 c_AllStations = '*';
  { адрес для широковещания }
 c_WrongClientId = daInterfaces.usWrongClient;
  { говорит об отказе в регистрации }
 c_DuplicateClient = daInterfaces.usDuplicateClient;
  { попытка войти повторно }
 c_DeadClient = daInterfaces.usDeadClient;
  { не отвечает на запросы }

const
  { коды ошибок обработки запросов }
 cs_errOk = 0;
 cs_errError = 1;
 cs_errConnClosedGracefully = 2;
 cs_errConnectTimeout = 3;
 cs_errSocketError = 4;
 cs_errConnAborted = 5;
 cs_errConnRefused = 6;
 cs_errWrongServerVersion = 7;
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
{$IfEnd} //not Nemesis
end.