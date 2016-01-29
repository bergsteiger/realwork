unit Com_Cnst;

{ $Id: COM_CNST.PAS,v 1.7 2015/01/14 13:45:50 voba Exp $ }

interface
 Uses Graphics,
      DT_Const;

const
 {Маска прав}

  // Снес дубликат
  // пользуемся DT_Const.acgXXX

  //romNameAttr  = DT_Const.acgNameAttr;
  //romText      = DT_Const.acgText;

  //romHyperLink = DT_Const.acgHyperLink;
  //romSub       = DT_Const.acgSub;
  //romBlock     = DT_Const.acgBlock;

  //romKeyWord   = DT_Const.acgKeyWord;
  //romClass     = DT_Const.acgClass;
  //romJurOp     = DT_Const.acgJurOp;
  //romAnno      = DT_Const.acgAnno;
  //romPublished = DT_Const.acgPublished;

  //romDocGroup  = $00010000; //DT_Const.acDocGroup;
  //romDelete    = $00020000; //DT_Const.acfDelete;

  //romNonDocEditMask = romDelete; //Права, которые не применяются при редактировании документа

 {Маска статусов}
  stDSP       = $0001;

 Const
  BaseNameLen = 50;
  //DocNameLen = 100;

 type
  TBaseFamRec = Record
                 Name : String[BaseNameLen];
                 ID   : Word;
                end;
  //TDocNameString = String[DocNameLen];

  TSaveFontRec = Record
                  Name  : String;
                  Size  : Longint;
                  Style : Longint;
                  Color : Longint;
                 end;
  TSaveEditParam = Record
                    FirstInd,
                    LeftInd,
                    ParaWide,
                    Justify : Longint;
                   end;

 Function FontStylesToInt(FSSet : TFontStyles) : Longint;
 Function IntToFontStyles(FSInt : Longint) : TFontStyles;

implementation

 Function FontStylesToInt(FSSet : TFontStyles) : Longint;
  Begin
   Result:=0;
   If fsBold in FSSet then Inc(Result);
   Result:=Result Shl 1;
   If fsItalic in FSSet then Inc(Result);
   Result:=Result Shl 1;
   If fsUnderline in FSSet then Inc(Result);
   Result:=Result Shl 1;
   If fsStrikeOut in FSSet then Inc(Result);
  end;

 Function IntToFontStyles(FSInt : Longint) : TFontStyles;
  Begin
   Result:=[];
   If (FSInt and 1) <> 0 then Include(Result,fsStrikeOut);
   FSInt:=FSInt SHR 1;
   If (FSInt and 1) <> 0 then Include(Result,fsUnderline);
   FSInt:=FSInt SHR 1;
   If (FSInt and 1) <> 0 then Include(Result,fsItalic);
   FSInt:=FSInt SHR 1;
   If (FSInt and 1) <> 0 then Include(Result,fsBold);


  end;

end.
