object TPersHolder
  P.Name = 'XML'
  P.SyntaxBlocks = <
    item
      Name = 'Default'
      ID = 0
      FIText = 0
      BlockDelimiters = <>
    end
    item
      Name = 'SpecialTags'
      ID = 2
      ParentID = 0
      FIText = 8
      BlockDelimiters = <
        item
          LeftDelimiter = '<?'
          RightDelimiter = '?>'
          DelimitersArePartOfBlock = True
        end
        item
          LeftDelimiter = '<![CDATA['
          RightDelimiter = ']]>'
          DelimitersArePartOfBlock = True
        end>
    end
    item
      Name = 'Tags'
      ID = 1
      ParentID = 0
      FIText = 1
      FIIdentifier = 7
      UseComments = True
      UseMultiLineComments = True
      UseStrings = True
      UseSingleLineStrings = True
      BlockDelimiters = <
        item
          LeftDelimiter = '<'
          RightDelimiter = '>'
          DelimitersArePartOfBlock = True
        end>
      MultiLineCommentDelimiters = <
        item
          FontID = 5
          LeftDelimiter = '<!--'
          RightDelimiter = '-->'
        end>
      SingleLineStringDelimiters = <
        item
          FontID = 6
          LeftDelimiter = '"'
          RightDelimiter = '"'
        end>
    end>
  P.FontTable = <
    item
      FontID = 0
      GlobalAttrID = 'Whitespace'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end
    item
      FontID = 1
      GlobalAttrID = 'Html tags'
      BlockID = 1
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end
    item
      FontID = 5
      GlobalAttrID = 'Comment'
      BlockID = 1
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = [fsItalic]
    end
    item
      FontID = 6
      GlobalAttrID = 'String'
      BlockID = 1
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end
    item
      FontID = 7
      GlobalAttrID = 'Identifier'
      BlockID = 1
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clTeal
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end
    item
      FontID = 8
      GlobalAttrID = 'Html tags'
      BlockID = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end>
  P.SyntaxVersion = 3
end
