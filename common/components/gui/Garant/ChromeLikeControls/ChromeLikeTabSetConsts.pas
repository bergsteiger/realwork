unit ChromeLikeTabSetConsts;

interface
uses
 Windows,
 Messages;

const
 WM_REMOVETAB = WM_USER + 1;
 WM_MOVINGBYTAB = WM_USER + 2;
cNonClientMouseDragCommand = 61458;

type
 TWMRemoveTab = packed record
   Msg: Cardinal;
   Tab: TObject;
   case Integer of
     0: (
       XPos: Smallint;
       YPos: Smallint);
     1: (
       Pos: TSmallPoint;
       Result: Longint);
 end;



implementation

end.
