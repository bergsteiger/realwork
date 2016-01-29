unit VCMSandBoxRes;

interface

uses
 l3IntfUses
 , vcmApplication
 , l3StringIDEx
;

type
 TvcmApplicationRef = TVCMSandBoxRes;
  {* Ссылка на приложение для DesignTime редакторов }
 
 TVCMSandBoxRes = class(TvcmApplication)
  {* Тестовое приложение VCM }
 end;//TVCMSandBoxRes
 
implementation

uses
 l3ImplUses
 , moDocument
 , moList
 , l3MessageID
 , evExtFormat
 , StdRes
;

end.
