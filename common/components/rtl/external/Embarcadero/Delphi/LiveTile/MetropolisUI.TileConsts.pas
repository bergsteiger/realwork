{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{ Copyright(c) 2012-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit MetropolisUI.TileConsts;

interface

const
  // XML data for narrow (square) and wide tiles (do not translate). Multiple lines only when required (string constants cannot exceed 255 chars).
  TileSquareBlock01 = '<binding template="TileSquareBlock"><text id="1">T1</text><text id="2">Text Field 2</text></binding>';
  TileSquareText01 = '<binding template="TileSquareText01"><text id="1">Text Header 1</text><text id="2">Text Field 2</text><text id="3">Text Field 3</text><text id="4">Text Field 4</text></binding>';
  TileSquareText02 = '<binding template="TileSquareText02"><text id="1">Text Header 1</text><text id="2">Text Field 2</text></binding>';
  TileSquareText03 = '<binding template="TileSquareText03"><text id="1">Text Field 1</text><text id="2">Text Field 2</text><text id="3">Text Field 3</text><text id="4">Text Field 4</text></binding>';
  TileSquareText04 = 'binding template="TileSquareText04"><text id="1">Text Field 1</text></binding>';
  TileSquareImage = '<binding template="TileSquareImage"><image id="1" alt="alt text" src="image1.png"/></binding>';
  TileSquarePeekImageAndText01 = '<binding template="TileSquarePeekImageAndText01"><image id="1" alt="alt text" src="image1.png"/><text id="1">Text Header 1</text><text id="2">Text Field 2</text><text id="3">Text Field 3</text><text id="4">Text Field 4</text></binding>';
  TileSquarePeekImageAndText02 = '<binding template="TileSquarePeekImageAndText02"><image id="1" alt="alt text" src="image1.png"/><text id="1">Text Header 1</text><text id="2">Text Field 2</text></binding>';
  TileSquarePeekImageAndText03 = '<binding template="TileSquarePeekImageAndText03"><image id="1" alt="alt text" src="image1.png"/><text id="1">Text Field 1</text><text id="2">Text Field 2</text><text id="3">Text Field 3</text><text id="4">Text Field 4</text></binding>';
  TileSquarePeekImageAndText04 = '<binding template="TileSquarePeekImageAndText04"><image id="1" alt="alt text" src="image1.png"/><text id="1">Text Field 1</text></binding>';
  // large
  TileWideText01 = '<binding template="TileWideText01"><text id="1">Text Header 1</text><text id="2">Text Field 2</text><text id="3">Text Field 3</text><text id="4">Text Field 4</text><text id="5">Text Field 5</text></binding>';
  TileWideText02 = '<binding template="TileWideText02"><text id="1">Text Header 1</text><text id="2">Text Field 2</text>' +
    '<text id="3">Text Field 3</text><text id="4">Text Field 4</text><text id="5">Text Field 5</text><text id="6">Text Field 6</text><text id="7">Text Field 7</text><text id="8">Text Field 8</text><text id="9">Text Field 9</text></binding>';
  TileWideText03 = '<binding template="TileWideText03"><text id="1">Text Header 1</text></binding>';
  TileWideText04 = '<binding template="TileWideText04"><text id="1">Text Field 1</text></binding>';
  TileWideText05 = '<binding template="TileWideText05"><text id="1">Text Field 1</text><text id="2">Text Field 2</text>' +
    '<text id="3">Text Field 3</text><text id="4">Text Field 4</text><text id="5">Text Field 5</text></binding>';
  TileWideText06 = '<binding template="TileWideText06"><text id="1">Text Field 1</text><text id="2">Text Field 2</text>' +
    '<text id="3">Text Field 3</text><text id="4">Text Field 4</text><text id="5">Text Field 5</text><text id="6">Text Field 6</text>' +
    '<text id="7">Text Field 7</text><text id="8">Text Field 8</text><text id="9">Text Field 9</text><text id="10">Text Field 10</text></binding>';
  TileWideText07 = '<binding template="TileWideText07"><text id="1">Text Header 1</text><text id="2">Text2</text><text id="3">Text Field 3</text>' +
    '<text id="4">Text4</text><text id="5">Text Field 5</text><text id="6">Text6</text><text id="7">Text Field 7</text><text id="8">Text8</text><text id="9">Text Field 9</text></binding>';
  TileWideText08 = '<binding template="TileWideText08"><text id="1">Text1</text><text id="2">Text Field 2</text><text id="3">Text3</text>' +
    '<text id="4">Text Field 4</text><text id="5">Text5</text><text id="6">Text Field 6</text><text id="7">Text7</text><text id="8">Text Field 8</text><text id="9">Text9</text><text id="10">Text Field 10</text></binding>';
  TileWideText09 = '<binding template="TileWideText09"><text id="1">Text Header 1</text><text id="2">Text Field 2</text></binding>';
  TileWideText10 = '<binding template="TileWideText10"><text id="1">Text Header 1</text><text id="2">Text2</text>' +
    '<text id="3">Text Field 3</text><text id="4">Text4</text><text id="5">Text Field 5</text><text id="6">Text6</text><text id="7">Text Field 7</text><text id="8">Text8</text><text id="9">Text Field 9</text></binding>';
  TileWideText11 = '<binding template="TileWideText11"><text id="1">Text1</text><text id="2">Text Field 2</text><text id="3">Text3</text>' +
    '<text id="4">Text Field 4</text><text id="5">Text5</text><text id="6">Text Field 6</text><text id="7">Text7</text><text id="8">Text Field 8</text><text id="9">Text9</text><text id="10">Text Field 10</text></binding>';
  TileWideImage = '<binding template="TileWideImage"><image id="1" src="image1.png" alt="alt text"/></binding>';
  TileWideImageCollection = '<binding template="TileWideImageCollection"><image id="1" src="image1.png" alt="alt text"/>' +
    '<image id="2" src="image2.png" alt="alt text"/><image id="3" src="image3.png" alt="alt text"/><image id="4" src="image4.png" alt="alt text"/><image id="5" src="image5.png" alt="alt text"/></binding>';
  TileWideImageAndText01 = '<binding template="TileWideImageAndText01"><image id="1" src="image1.png" alt="alt text"/><text id="1">Text Field 1</text></binding>';
  TileWideImageAndText02 = '<binding template="TileWideImageAndText02"><image id="1" src="image1.png" alt="alt text"/><text id="1">Text Field 1</text><text id="1">Text Field 2</text></binding>';
  TileWideBlockAndText01 = '<binding template="TileWideBlockAndText01"><text id="1">Text Field 1</text><text id="2">Text Field 2</text><text id="3">Text Field 3</text><text id="4">Text Field 4</text><text id="5">T5</text><text id="6">Text Field 6</text></binding>';
  TileWideBlockAndText02 = '<binding template="TileWideBlockAndText02"><text id="1">Text Field 1</text><text id="2">T2</text><text id="3">Text Field 3</text></binding>';
  TileWideSmallImageAndText01 = '<binding template="TileWideSmallImageAndText01"><image id="1" src="image1.png" alt="alt text"/><text id="1">Text Header 1</text></binding>';
  TileWideSmallImageAndText02 = '<binding template="TileWideSmallImageAndText02"><image id="1" src="image1.png" alt="alt text"/>' +
    '<text id="1">Text Header 1</text><text id="2">Text Field 2</text><text id="3">Text Field 3</text><text id="4">Text Field 4</text><text id="5">Text Field 5</text></binding>';
  TileWideSmallImageAndText03 = '<binding template="TileWideSmallImageAndText03"><image id="1" src="image1.png" alt="alt text"/><text id="1">Text Field 1</text></binding>';
  TileWideSmallImageAndText04 = '<binding template="TileWideSmallImageAndText04"><image id="1" src="image1.png" alt="alt text"/><text id="1">Text Header 1</text><text id="2">Text Field 2</text></binding>';
  TileWideSmallImageAndText05 = '<binding template="TileWideSmallImageAndText05"><image id="1" src="image1.png" alt="alt text"/><text id="1">Text Header 1</text><text id="2">Text Field 2</text></binding>';
  TileWidePeekImageCollection01 = '<binding template="TileWidePeekImageCollection01"><image id="1" src="image1.png" alt="alt text"/>' +
    '<image id="2" src="image2.png" alt="alt text"/><image id="3" src="image3.png" alt="alt text"/><image id="4" src="image4.png" alt="alt text"/>' +
    '<image id="5" src="image5.png" alt="alt text"/><text id="1">Text Header 1</text><text id="2">Text Field 2</text></binding>';
  TileWidePeekImageCollection02 = '<binding template="TileWidePeekImageCollection02"><image id="1" src="image1.png" alt="alt text"/>' +
    '<image id="2" src="image2.png" alt="alt text"/><image id="3" src="image3.png" alt="alt text"/><image id="4" src="image4.png" alt="alt text"/>' +
    '<image id="5" src="image5.png" alt="alt text"/><text id="1">Text Header 1</text><text id="2">Text Field 2</text><text id="3">Text Field 3</text><text id="4">Text Field 4</text><text id="5">Text Field 5</text></binding>';
  TileWidePeekImageCollection03 = '<binding template="TileWidePeekImageCollection03"><image id="1" src="image1.png" alt="alt text"/>' +
    '<image id="2" src="image2.png" alt="alt text"/><image id="3" src="image3.png" alt="alt text"/><image id="4" src="image4.png" alt="alt text"/><image id="5" src="image5.png" alt="alt text"/><text id="1">Text Header 1</text></binding>';
  TileWidePeekImageCollection04 = '<binding template="TileWidePeekImageCollection04"><image id="1" src="image1.png" alt="alt text"/>' +
    '<image id="2" src="image2.png" alt="alt text"/><image id="3" src="image3.png" alt="alt text"/><image id="4" src="image4.png" alt="alt text"/><image id="5" src="image5.png" alt="alt text"/><text id="1">Text Field 1</text></binding>';
  TileWidePeekImageCollection05 = '<binding template="TileWidePeekImageCollection05"><image id="1" src="image1.png" alt="alt text"/>' +
    '<image id="2" src="image2.png" alt="alt text"/><image id="3" src="image3.png" alt="alt text"/><image id="4" src="image4.png" alt="alt text"/>' +
    '<image id="5" src="image5.png" alt="alt text"/><image id="6" src="image6.png" alt="alt text"/><text id="1">Text Header 1</text><text id="2">Text Field 2</text></binding>';
  TileWidePeekImageCollection06 = '<binding template="TileWidePeekImageCollection06"><image id="1" src="image1.png" alt="alt text"/>' +
    '<image id="2" src="image2.png" alt="alt text"/><image id="3" src="image3.png" alt="alt text"/><image id="4" src="image4.png" alt="alt text"/>' +
    '<image id="5" src="image5.png" alt="alt text"/><image id="6" src="image6.png" alt="alt text"/><text id="1">Text Header 1</text></binding>';
  TileWidePeekImageAndText01 = '<binding template="TileWidePeekImageAndText01"><image id="1" src="image1.png" alt="alt text"/><text id="1">Text Field 1</text></binding>';
  TileWidePeekImageAndText02 = '<binding template="TileWidePeekImageAndText02"><image id="1" src="image1.png" alt="alt text"/>' +
    '<text id="1">Text Field 1</text><text id="2">Text Field 2</text><text id="3">Text Field 3</text><text id="4">Text Field 4</text><text id="5">Text Field 5</text></binding>';
  TileWidePeekImage01 = '<binding template="TileWidePeekImage01"><image id="1" src="image1.png" alt="alt text"/><text id="1">Text Header 1</text><text id="2">Text Field 2</text></binding>';
  TileWidePeekImage02 = '<binding template="TileWidePeekImage02"><image id="1" src="image1.png" alt="alt text"/>' +
    '<text id="1">Text Header 1</text><text id="2">Text Field 2</text><text id="3">Text Field 3</text><text id="4">Text Field 4</text><text id="5">Text Field 5</text></binding>';
  TileWidePeekImage03 = '<binding template="TileWidePeekImage03"><image id="1" src="image1.png" alt="alt text"/><text id="1">Text Header 1</text></binding>';
  TileWidePeekImage04 = '<binding template="TileWidePeekImage04"><image id="1" src="image1.png" alt="alt text"/><text id="1">Text Field 1</text></binding>';
  TileWidePeekImage05 = '<binding template="TileWidePeekImage05"><image id="1" src="image1.png" alt="alt text"/><image id="2" src="image2.png" alt="alt text"/><text id="1">Text Header 1</text><text id="2">Text Field 2</text></binding>';
  TileWidePeekImage06 = '<binding template="TileWidePeekImage06"><image id="1" src="image1.png" alt="alt text"/><image id="2" src="image2.png" alt="alt text"/><text id="1">Text Header 1</text></binding>';


implementation

end.
