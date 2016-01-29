unit ArchiAppRes;
// Заглушка для тестов Арчи (нужна для компиляции!!!)

interface

{$IfNDef NoVCM}
uses
  vcmApplication
  ;
type
 TArchiAppRes = {final} class(TvcmApplication)
 end;

 TvcmApplicationRef = TArchiAppRes;
{$EndIf  NoVCM} 

implementation

end.