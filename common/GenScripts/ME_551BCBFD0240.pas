unit l3FormatObjectInfoHelper;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3RTTI
;

 (*
 Ml3FormatObjectInfoHelper = interface
  {* Контракт сервиса Tl3FormatObjectInfoHelper }
  function Format(anObject: TObject;
   aShortInfo: Boolean;
   anObjectPropFound: TRTTIInfoObjectPropertyFoundCallBack): AnsiString;
 end;//Ml3FormatObjectInfoHelper
 *)
 
type
 Il3FormatObjectInfoHelper = interface
  {* Интерфейс сервиса Tl3FormatObjectInfoHelper }
  function Format(anObject: TObject;
   aShortInfo: Boolean;
   anObjectPropFound: TRTTIInfoObjectPropertyFoundCallBack): AnsiString;
 end;//Il3FormatObjectInfoHelper
 
 Tl3FormatObjectInfoHelper = class(Tl3ProtoObject)
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
  function Format(anObject: TObject;
   aShortInfo: Boolean;
   anObjectPropFound: TRTTIInfoObjectPropertyFoundCallBack): AnsiString;
 end;//Tl3FormatObjectInfoHelper
 
implementation

uses
 l3ImplUses
 , l3FormatActionInfoHelper
 , Controls
 , ActnList
 , TypInfo
 , l3HugeMessageDlgWithWikiHelper
 , SysUtils
;

end.
