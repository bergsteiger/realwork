unit vcmCustomHelpers;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3FormatActionInfoHelper
 , ActnList
;

type
 TvcmFormatActionInfoHelper = class(Tl3ProtoObject, Il3FormatActionInfoHelper)
  function Exists: Boolean;
   {* ��������� ������ ��������� ���������� ��� ��� }
  function Format(anAction: TCustomAction): AnsiString;
 end;//TvcmFormatActionInfoHelper
 
implementation

uses
 l3ImplUses
 , vcmModuleAction
 , vcmOperationAction
 , vcmEntityAction
;

end.
