unit ChromeLikeFormTabParamsList;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , l3TabbedContainersDispatcher
 , Forms
 , l3ProtoObject
;

type
 TChromeLikeFormTabParamsList = class(_l3InterfaceRefList_)
  procedure SetFormParams(aForm: TForm;
   const aParams: Il3TabParams);
  function GetFormParams(aForm: TForm): Il3TabParams;
  procedure DeleteFormParams(aForm: TForm);
  function FindFormTabParams(aForm: TForm): Il3FormTabParams;
  function MakeParamsItem(aForm: TForm;
   const aParams: Il3TabParams): Il3FormTabParams;
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
 end;//TChromeLikeFormTabParamsList
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

type
 TChromeLikeFormTabParamsItem = class(Tl3ProtoObject, Il3FormTabParams)
  procedure Create(aForm: TForm;
   const aParams: Il3TabParams);
  procedure Make(aForm: TForm;
   const aParams: Il3TabParams);
  function Params: Il3TabParams;
  function Form: TForm;
  procedure Update(const aParams: Il3TabParams);
 end;//TChromeLikeFormTabParamsItem
 
end.
