unit evdCustomXMLReader;

interface
Uses
 k2Reader,
 xpBase,
 xpParser;

type
  TevdCustomXMLReader = class(Tk2CustomFileReader)
    private
    // internal fields
      f_Parser : TXpParser;
    protected
        {-}
      procedure StartElement(oOwner : TObject; const sValue : DOMString); virtual;
        {-}
      procedure EndElement(oOwner : TObject; const sValue : DOMString); virtual;
        {-}
      procedure DoAttribute(oOwner : TObject; const sName, sValue : DOMString; bSpecified : Boolean); virtual;
        {-}
      procedure OpenStream;
        override;
        {-}
      procedure CloseStream(NeedUndo: Boolean);
        override;
        {-вызывается один раз в конце генерации}
      procedure Read;
        override;
        {-}
      procedure Cleanup;
        override;
      procedure DoCharData(oOwner : TObject; const sValue : DOMString); virtual;
        {-}
  end;//TevdXMLReader

implementation
Uses
 l3Base,
 l3Filer;

procedure TevdCustomXMLReader.Cleanup;
  //override;
  {-}
begin
 l3Free(f_Parser);
 inherited;
end;

procedure TevdCustomXMLReader.CloseStream(NeedUndo: Boolean);
  //override;
  {-вызывается один раз в конце генерации}
begin
 l3Free(f_Parser);
 inherited;
end;

procedure TevdCustomXMLReader.DoAttribute(oOwner : TObject; const sName, sValue : DOMString; bSpecified : Boolean);
begin

end;

procedure TevdCustomXMLReader.DoCharData(oOwner : TObject; const sValue : DOMString);
begin

end;

procedure TevdCustomXMLReader.EndElement(oOwner : TObject; const sValue : DOMString);
begin

end;

procedure TevdCustomXMLReader.OpenStream;
  //override;
  {-}
begin
 inherited;
 f_Parser := TXpParser.Create(nil);
 f_Parser.NormalizeData := false;
 f_Parser.OnStartElement := StartElement;
 f_Parser.OnEndElement := EndElement;
 f_Parser.OnAttribute := DoAttribute;
 f_Parser.OnCharData := DoCharData;
end;

procedure TevdCustomXMLReader.Read;
  //override;
  {-}
var
 l_S : Tl3FilerStream;
begin
 l_S := Tl3FilerStream.Create(Filer);
 try
  f_Parser.ParseStream(l_S);
 finally
  l3Free(l_S);
 end;//try..finally
end;

procedure TevdCustomXMLReader.StartElement(oOwner : TObject; const sValue : DOMString);
begin

end;

end.
