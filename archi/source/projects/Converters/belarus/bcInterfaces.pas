unit bcInterfaces;

interface

uses
  l3Interfaces;

type
 IbcTopicDispatcher = interface
  ['{829744E3-876A-479F-8616-5CA1D9B6BAF4}']
  function GetTopic(const aBelNum: Tl3WString; aAddNum: Integer = 0; aOnlyIfExists: Boolean = True): Longword;
 end;

 IbcBelanumReceiver = interface
  ['{93FA09F6-AFC5-43A2-AF13-D26D1FD2F50A}']
  procedure NewBelaNum(const aBelaNum: Il3CString);
 end;

 IbcTopicCounterProvider = interface
  ['{F00D09A3-B182-45AB-9564-04E45EDE84F5}']
  function pm_GetTopicCount: Integer;
  property TopicCount: Integer read pm_GetTopicCount;
 end;

const
 cAddNum4Rel     = MaxInt;
 cTDTableName    = 'BELCONTD';
 cConfigFileName = 'belacon.dat';

type
 TbcCurTopicReportEvent = procedure (const aTopic: Il3CString) of object;

implementation

end.
