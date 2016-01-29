unit l3FormatActionInfoHelper;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , ActnList
;

 (*
 Ml3FormatActionInfoHelper = interface
  {* �������� ������� Tl3FormatActionInfoHelper }
  function Format(anAction: TCustomAction): AnsiString;
 end;//Ml3FormatActionInfoHelper
 *)
 
type
 Il3FormatActionInfoHelper = interface
  {* ��������� ������� Tl3FormatActionInfoHelper }
  function Format(anAction: TCustomAction): AnsiString;
 end;//Il3FormatActionInfoHelper
 
 Tl3FormatActionInfoHelper = class(Tl3ProtoObject)
  function Exists: Boolean;
   {* ��������� ������ ��������� ���������� ��� ��� }
  function Format(anAction: TCustomAction): AnsiString;
 end;//Tl3FormatActionInfoHelper
 
implementation

uses
 l3ImplUses
;

end.
