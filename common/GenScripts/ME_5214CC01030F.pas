unit ddAppConfigDataAdapters;

interface

uses
 l3IntfUses
 , ddAppConfigBase
 , ddConfigStorages
 , ddAppConfigTypes
 , ddAppConfigConst
 , l3ProtoPersistentRefList
 , Classes
;

type
 TddBaseConfigDataAdapter = class(TddAppConfigBase)
  procedure SetIsChangedToItems(aValue: Boolean);
  function AddItem: Integer;
  function AsObject: TObject;
  function DeleteItem(anIndex: Integer): Boolean;
  function DownItem(anIndex: Integer): Boolean;
  function EditItem(anIndex: Integer): Boolean;
  procedure Load(const aStorage: IddConfigStorage;
   const anAlias: AnsiString);
  procedure Save(const aStorage: IddConfigStorage;
   const anAlias: AnsiString);
  function UpItem(anIndex: Integer): Boolean;
 end;//TddBaseConfigDataAdapter
 
 TddSimpleListDataAdapter = class(TddBaseConfigDataAdapter)
  function MakeItem: TddAppConfigNode;
  procedure Make(const anAlias: AnsiString);
 end;//TddSimpleListDataAdapter
 
 TddStringDataAdapter = class(TddBaseConfigDataAdapter)
  function GetStrings: TStrings;
 end;//TddStringDataAdapter
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3String
 , l3Base
 , Math
 , ddAppConfigStrings
 , ddAppConfigUtils
 , Dialogs
;

end.
