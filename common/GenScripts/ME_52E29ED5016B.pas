unit tfwIteratableParent;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3PureMixIns
 , tfwScriptingInterfaces
;

type
 TtfwIteratableParent = class(Tl3ProtoObject)
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
 end;//TtfwIteratableParent
 
implementation

uses
 l3ImplUses
;

end.
