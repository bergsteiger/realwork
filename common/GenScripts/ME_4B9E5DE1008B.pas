unit ddAppConfigLists;

interface

uses
 l3IntfUses
 , ddAppConfigTypes
 , StdCtrls
 , ddAppConfigDataAdapters
 , Controls
 , ddAppConfigConst
 , Classes
 , ddConfigStorages
 , ddAppConfigUtils
;

type
 TddListConfigItem = class(TddVisualConfigItem)
  procedure AddButtonCLick(Sender: TObject);
  procedure DeleteButtonClick(Sender: TObject);
  procedure DownButtonClick(Sender: TObject);
  procedure EditButtonClick(Sender: TObject);
  procedure ListDblClick(Sender: TObject);
  procedure UpButtonCLick(Sender: TObject);
  procedure Make(const aAlias: AnsiString;
   const aCaption: AnsiString;
   aDataAdapter: TddBaseConfigDataAdapter;
   aMasterItem: TddBaseConfigItem);
  function ConstructControl(var aLeft: Integer;
   var aMaxLeft: Integer;
   var aTop: Integer;
   aParent: TWinControl): TControl;
  function ControlHeight(aParent: TWinControl): Integer;
  procedure GetValueFromControl;
  procedure SetValueToControl(aDefault: Boolean);
 end;//TddListConfigItem
 
 TddSimpleListConfigItem = class(TddListConfigItem)
  procedure Make(const aAlias: AnsiString;
   const aCaption: AnsiString;
   aMasterItem: TddBaseConfigItem); overload;
  procedure Make(const aAlias: AnsiString;
   const aCaption: AnsiString;
   aItems: TddItemLink;
   aMasterItem: TddBaseConfigItem); overload;
 end;//TddSimpleListConfigItem
 
 TddStringListConfigItem = class(TddListConfigItem)
  procedure Make(const aAlias: AnsiString;
   const aCaption: AnsiString;
   aMasterItem: TddBaseConfigItem);
 end;//TddStringListConfigItem
 
implementation

uses
 l3ImplUses
 , ddAppConfigListsRes
 , l3Base
 , l3String
 , vtGroupBox
 , SysUtils
 , Dialogs
;

end.
