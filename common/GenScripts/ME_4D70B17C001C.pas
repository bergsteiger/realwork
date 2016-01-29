unit tstNSRCGenerator;

interface

uses
 l3IntfUses
 , ddNSRCGenerator
;

type
 ItstNSRCListener = interface
  procedure ExtractFileEvent(const aFileName: AnsiString);
   {* Событие выливки внешнего файла. }
 end;//ItstNSRCListener
 
 TtstNSRCGenerator = class(TddNSRCGenerator)
  {* Обертка над TddGenerator для чтения данных о внешних файлах и запоминания их в тесте для последующей проверки. }
  procedure LinkNSRCListener(const aListener: ItstNSRCListener);
  procedure UnlinkNSRCListener(const aListener: ItstNSRCListener);
 end;//TtstNSRCGenerator
 
implementation

uses
 l3ImplUses
;

end.
