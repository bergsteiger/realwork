unit D_TxSrch_Types;

{ $Id: D_TxSrch_Types.pas,v 1.2 2006/02/08 13:06:54 fireton Exp $}

{ $Log: D_TxSrch_Types.pas,v $
{ Revision 1.2  2006/02/08 13:06:54  fireton
{ - bug fix: не компилялось
{
{ Revision 1.1  2006/01/24 08:52:10  voba
{ no message
{}

interface

{$IFNDEF ARCHI}
 {$DEFINE NotArchiProject}
{$ENDIF}

type
  TtsSrchType = (srtText, srtStyle, srtSub {$IFNDEF NotArchiProject}, srtHLink {$ENDIF});


const
 cSrchTypeNames : array [TtsSrchType] of String = ('Текст', 'Стиль', 'Метка' {$IFNDEF NotArchiProject}, 'Ссылка' {$ENDIF});

type
  TtsSrchTypeSet = set of TtsSrchType;

  //TarRegularExpressionSearcher = TevRegularExpressionSearcher;

  TSearchDialogInitMode = (sdiNoChange, sdiSearch, sdiReplace, sdiSearchOnly);

const
 cSearchMode_NoChange : array [Boolean] of TSearchDialogInitMode = (sdiSearchOnly, sdiNoChange);
 cSearchMode_Search   : array [Boolean] of TSearchDialogInitMode = (sdiSearchOnly, sdiSearch);

 cSearchAllTypes : TtsSrchTypeSet = [srtText, srtStyle, srtSub {$IFNDEF NotArchiProject}, srtHLink {$ENDIF}];

implementation

end.
