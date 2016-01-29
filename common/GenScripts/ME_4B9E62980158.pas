unit ddAppConfigStrings;

interface

uses
 l3IntfUses
 , ddAppConfigTypes
 , Controls
 , Classes
 , ddAppConfigConst
 , ddConfigStorages
 , StdCtrls
;

type
 TddStringConfigItem = class(TddVisualConfigItem)
  procedure DoOnChange(Sender: TObject);
  procedure Make(const aAlias: AnsiString;
   const aCaption: AnsiString;
   const aDefault: AnsiString;
   aMasterItem: TddBaseConfigItem);
  function ConstructControl(var aLeft: Integer;
   var aMaxLeft: Integer;
   var aTop: Integer;
   aParent: TWinControl): TControl;
  function ControlHeight(aParent: TWinControl): Integer;
  procedure GetValueFromControl;
  procedure SetValueToControl(aDefault: Boolean);
 end;//TddStringConfigItem
 
 TddFillType = (
  dd_ftAsIs
  , dd_ftFull
  , dd_ftShort
 );//TddFillType
 
 TddBrowseConfigItem = class(TddStringConfigItem)
  function MakeFullPath(const aValue: AnsiString): AnsiString;
  function MakeShortPath(const aValue: AnsiString): AnsiString;
  procedure OnBrowseClick(Sender: TObject);
  procedure OnTestClick(Sender: TObject);
  function CorrectValue(const aValue: AnsiString): AnsiString;
 end;//TddBrowseConfigItem
 
 TddFolderNameConfigItem = class(TddBrowseConfigItem)
  procedure Validate;
  procedure OnBrowseClick(Sender: TObject);
  procedure OnTestClick(Sender: TObject);
 end;//TddFolderNameConfigItem
 
 TddFileNameConfigItem = class(TddBrowseConfigItem)
  procedure OnBrowseClick(Sender: TObject);
  procedure OnTestClick(Sender: TObject);
 end;//TddFileNameConfigItem
 
 TddSoundFileNameConfigItem = class(TddFileNameConfigItem)
 end;//TddSoundFileNameConfigItem
 
 TddTextConfigItem = class(TddVisualConfigItem)
  procedure Make(const aAlias: AnsiString;
   const aCaption: AnsiString;
   const aDefault: AnsiString;
   aMasterItem: TddBaseConfigItem);
  procedure DoOnChange(Sender: TObject);
  function ConstructControl(var aLeft: Integer;
   var aMaxLeft: Integer;
   var aTop: Integer;
   aParent: TWinControl): TControl;
  function ControlHeight(aParent: TWinControl): Integer;
  procedure GetValueFromControl;
  procedure SetValueToControl(aDefault: Boolean);
 end;//TddTextConfigItem
 
implementation

uses
 l3ImplUses
 , ddAppConfigStringsRes
 , l3Base
 , l3String
 , SysUtils
 , StrUtils
 , l3Base64
 , l3FileUtils
 , Forms
 , FileCtrl
 , Dialogs
 , MMSystem
 , l3Utils
;

end.
