unit FMX.DUnit.Interfaces;

interface

type
 ImsLog = interface
 end;//ImsLog

 ImsEtalonsHolder = interface
 ['{1758A741-7AB3-404C-ADC0-FF6DDD815535}']
  procedure DeleteEtalonFile(const aLog: ImsLog);
  function RunDiff(const aLog: ImsLog): Boolean;
 end;//ImsEtalonsHolder

implementation

end.
