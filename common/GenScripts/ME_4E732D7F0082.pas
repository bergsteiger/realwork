unit vtHideField;

interface

uses
 l3IntfUses
 , l3Interfaces
 , afwTextControl
 , afwInterfaces
 , evTypes
 , Classes
 , Graphics
 , ImgList
 , Controls
 , Types
 , Messages
 , afwTypes
 , l3InternalInterfaces
;

type
 ThfOption = (
  hfoCanHide
  , hfoHyperlink
 );//ThfOption
 
 ThfState = (
  hfsHide
  , hfsShow
 );//ThfState
 
 ThfOptions = set of ThfOption;
 
 ThfValidateStateEvent = procedure(aSender: TObject;
  var theState: ThfState) of object;
 
 ThfCommandEvent = function(aSender: TObject;
  aOperation: Tl3OperationCode): Boolean of object;
 
 TvtCustomHideField = class(TafwTextControl, IafwStyleTableSpy)
  procedure DoStateChanged;
  function CheckImage(aImages: TCustomImageList;
   aImageIndex: Integer): Boolean;
   {* ��������� ���������� �� imagelist � �� ������� �� �� ������� ��������� ������. }
  procedure DoHyperlink;
  procedure OnImageListChange(Sender: TObject);
  procedure ExchangeState;
   {* �������� ��������� }
  function GetHeaderLineRect: TRect;
   {* ������ ���������, ����������� ������������ � ������ }
  function GetHeaderLineHeight: Integer;
   {* ������ ����� ���������� ����������� � ������ }
  function GetImageRect: TRect;
   {* ���������� ��������� ������ }
  function GetImageTop: Integer;
   {* ������� ����� ������ }
  procedure Rebuild;
   {* ��������� ���� �� ����������, ����� ��������� ������ � ������������ }
  procedure MakeHideHeight;
   {* ���������� ������ ��� ���������� ��������� }
  function IsHandledShortcut(var Msg: TWMKeyDown): Boolean;
  procedure DoStyleTableChanged;
  procedure HideControl;
  procedure CMControlChange(var Message: TMessage);
  procedure WMEraseBkgnd(var Message: TWMEraseBkgnd);
  procedure CMTextChanged(var Message: TMessage);
  procedure CMFontChanged(var Message: TMessage);
  procedure WMKillFocus(var Message: TMessage);
  procedure WMSetFocus(var Message: TMessage);
  procedure WMSysKeyDown(var Msg: TWMSysKeyDown);
  procedure CNKeyDown(var Msg: TWMKeyDown);
  function OptionsStored: Boolean;
   {* "������� ������������, ��� �������� Options �����������" }
  procedure StyleTableChanged;
   {* ������� ������ ����������. }
 end;//TvtCustomHideField
 
 TvtHideField = class(TvtCustomHideField)
 end;//TvtHideField
 
implementation

uses
 l3ImplUses
 , vtHideFieldUtils
 , Windows
 , l3ScreenIC
 , l3String
 , l3Base
 , l3MinMax
 , afwFacade
 , evStyleInterface
 , TextPara_Const
 , evStyleTableSpy
 , evdTextStyle_Const
 , OvcCmd
 , OvcConst
 , l3Units
 , Forms
 , TtfwClassRef_Proxy
 , vtHideFieldWords
;

end.
