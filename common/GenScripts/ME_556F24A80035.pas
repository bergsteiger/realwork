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
   {* �����. }
  function Name: TFontName;
   {* ����������. }
  function Bold: Boolean;
   {* ������? }
  function Italic: Boolean;
   {* ������? }
  function Underline: Boolean;
   {* ������������? }
  function Strikeout: Boolean;
   {* �����������. }
  function ForeColor: Tl3Color;
   {* ���� ������. }
  function BackColor: Tl3Color;
   {* ���� ����. }
  function Pitch: TFontPitch;
   {* �������. }
  function Index: Tl3FontIndex;
   {* ������. }
 end;//Tl3ControlFontInfo
 
 (*
 Ml3ControlFontService = interface
  {* �������� ������� Tl3ControlFontService }
  function GetFont(aControl: TControl): Il3FontInfo;
 end;//Ml3ControlFontService
 *)
 
 Il3ControlFontService = interface
  {* ��������� ������� Tl3ControlFontService }
  function GetFont(aControl: TControl): Il3FontInfo;
 end;//Il3ControlFontService
 
 Tl3ControlFontService = class(Tl3ProtoObject)
  function Exists: Boolean;
   {* ��������� ������ ��������� ���������� ��� ��� }
  function GetFont(aControl: TControl): Il3FontInfo;
 end;//Tl3ControlFontService
 
implementation

uses
 l3ImplUses
 , Graphics
;

type
 TControlFriend = class(TControl)
  {* ���� ��� TControl }
 end;//TControlFriend
 
end.
