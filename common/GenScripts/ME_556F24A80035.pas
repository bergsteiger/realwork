unit l3ControlFontService;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3Interfaces
 , Controls
 , l3CProtoObject
;

type
 Tl3ControlFontInfo = class(Tl3CProtoObject, Il3FontInfo)
  procedure Create(aControl: TControl);
  function Make(aControl: TControl): Il3FontInfo;
  function Size: Integer;
   {* кегль. }
  function Name: TFontName;
   {* гаринитура. }
  function Bold: Boolean;
   {* жирный? }
  function Italic: Boolean;
   {* курсив? }
  function Underline: Boolean;
   {* подчеркнутый? }
  function Strikeout: Boolean;
   {* зачеркнытый. }
  function ForeColor: Tl3Color;
   {* цвет шрифта. }
  function BackColor: Tl3Color;
   {* цвет фона. }
  function Pitch: TFontPitch;
   {* кернинг. }
  function Index: Tl3FontIndex;
   {* индекс. }
 end;//Tl3ControlFontInfo
 
 (*
 Ml3ControlFontService = interface
  {* Контракт сервиса Tl3ControlFontService }
  function GetFont(aControl: TControl): Il3FontInfo;
 end;//Ml3ControlFontService
 *)
 
 Il3ControlFontService = interface
  {* Интерфейс сервиса Tl3ControlFontService }
  function GetFont(aControl: TControl): Il3FontInfo;
 end;//Il3ControlFontService
 
 Tl3ControlFontService = class(Tl3ProtoObject)
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
  function GetFont(aControl: TControl): Il3FontInfo;
 end;//Tl3ControlFontService
 
implementation

uses
 l3ImplUses
 , Graphics
;

type
 TControlFriend = class(TControl)
  {* Друг для TControl }
 end;//TControlFriend
 
end.
