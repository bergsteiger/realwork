unit bcInterfaces;

interface

uses
  l3Interfaces;

type
 IbcTopicDispatcher = interface
  ['{829744E3-876A-479F-8616-5CA1D9B6BAF4}']
  function GetTopic(const aBelNum: Tl3WString; aAddNum: Integer = 0): Longword;
 end;

 IbcBelanumReceiver = interface
  ['{93FA09F6-AFC5-43A2-AF13-D26D1FD2F50A}']
  procedure NewBelaNum(const aBelaNum: Il3CString);
 end;

const
 cAddNum4Rel = MaxInt;

implementation

end.
