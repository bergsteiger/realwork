unit tfwArray;

interface

uses
 l3IntfUses
 , tfwValueList
 , tfwScriptingInterfaces
 , l3PureMixIns
;

type
 TtfwArray = class(TtfwValueList, ItfwValueList)
  procedure Create;
  function Make: ItfwValueList;
  function First: _ItemType_;
   {* ������ �������. }
  function Last: _ItemType_;
   {* ��������� �������. }
  function Items: _ItemType_;
  function Empty: Boolean;
  function IndexOf(const anItem: _ItemType_): Integer;
  function Add(const anItem: _ItemType_): Integer;
  function Count: Integer;
   {* ����� ���������. }
  procedure Clear;
  procedure ForEach(aLambda: TtfwWordPrim;
   const aCtx: TtfwContext);
  procedure ForEachBack(aLambda: TtfwWordPrim;
   const aCtx: TtfwContext);
  procedure SetItem(anIndex: Integer;
   const aValue: TtfwStackValue);
  function ItemsCountInSlice: Integer;
 end;//TtfwArray
 
implementation

uses
 l3ImplUses
;

end.
