{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Data.DBXMetaDataNames;

interface

type
  TDBXCatalogsColumns = class
  public
    
    /// <summary>  <p>Used to access the <c>CatalogName</c> column in the <c>Catalogs</c> metadata collection.</p>
    ///   <p>The data in this column specifies the catalog name.</p>
    /// </summary>
    const CatalogName = 'CatalogName';
  end;

  TDBXCatalogsIndex = class
  public
    
    /// <summary>  <p>Used to access the <c>CatalogName</c> column by ordinal in the <c>Catalogs</c> metadata collection.</p>
    ///   <p>The data in this column specifies the catalog name.</p>
    /// </summary>
    const CatalogName = 0;
    const Last = 0;
  end;

  TDBXColumnConstraintsColumns = class
  public
    
    /// <summary>  <p>Used to access the <c>CatalogName</c> column in the <c>ColumnConstraints</c> metadata collection.</p>
    ///   <p>The data in this column specifies the catalog name.</p>
    /// </summary>
    const CatalogName = 'CatalogName';
    
    /// <summary>  <p>Used to access the <c>SchemaName</c> column in the <c>ColumnConstraints</c> metadata collection.</p>
    ///   <p>The data in this column specifies the schema name.</p>
    /// </summary>
    const SchemaName = 'SchemaName';
    
    /// <summary>  <p>Used to access the <c>TableName</c> column in the <c>ColumnConstraints</c> metadata collection.</p>
    ///   <p>The data in this column specifies the table name.</p>
    /// </summary>
    const TableName = 'TableName';
    
    /// <summary>  <p>Used to access the <c>ConstraintName</c> column in the <c>ColumnConstraints</c> metadata collection.</p>
    ///   <p>The data in this column specifies the constraint name.</p>
    /// </summary>
    const ConstraintName = 'ConstraintName';
    
    /// <summary>  <p>Used to access the <c>ColumnName</c> column in the <c>ColumnConstraints</c> metadata collection.</p>
    ///   <p>The data in this column specifies the column name.</p>
    /// </summary>
    const ColumnName = 'ColumnName';
  end;

  TDBXColumnConstraintsIndex = class
  public
    
    /// <summary>  <p>Used to access the <c>CatalogName</c> column by ordinal in the <c>ColumnConstraints</c> metadata collection.</p>
    ///   <p>The data in this column specifies the catalog name.</p>
    /// </summary>
    const CatalogName = 0;
    
    /// <summary>  <p>Used to access the <c>SchemaName</c> column by ordinal in the <c>ColumnConstraints</c> metadata collection.</p>
    ///   <p>The data in this column specifies the schema name.</p>
    /// </summary>
    const SchemaName = 1;
    
    /// <summary>  <p>Used to access the <c>TableName</c> column by ordinal in the <c>ColumnConstraints</c> metadata collection.</p>
    ///   <p>The data in this column specifies the table name.</p>
    /// </summary>
    const TableName = 2;
    
    /// <summary>  <p>Used to access the <c>ConstraintName</c> column by ordinal in the <c>ColumnConstraints</c> metadata collection.</p>
    ///   <p>The data in this column specifies the constraint name.</p>
    /// </summary>
    const ConstraintName = 3;
    
    /// <summary>  <p>Used to access the <c>ColumnName</c> column by ordinal in the <c>ColumnConstraints</c> metadata collection.</p>
    ///   <p>The data in this column specifies the column name.</p>
    /// </summary>
    const ColumnName = 4;
    const Last = 4;
  end;

  TDBXColumnsColumns = class
  public
    
    /// <summary>  <p>Used to access the <c>CatalogName</c> column in the <c>Columns</c> metadata collection.</p>
    ///   <p>The data in this column specifies the catalog name.</p>
    /// </summary>
    const CatalogName = 'CatalogName';
    
    /// <summary>  <p>Used to access the <c>SchemaName</c> column in the <c>Columns</c> metadata collection.</p>
    ///   <p>The data in this column specifies the schema name.</p>
    /// </summary>
    const SchemaName = 'SchemaName';
    
    /// <summary>  <p>Used to access the <c>TableName</c> column in the <c>Columns</c> metadata collection.</p>
    ///   <p>The data in this column specifies the table name.</p>
    /// </summary>
    const TableName = 'TableName';
    
    /// <summary>  <p>Used to access the <c>ColumnName</c> column in the <c>Columns</c> metadata collection.</p>
    ///   <p>The data in this column specifies the column name.</p>
    /// </summary>
    const ColumnName = 'ColumnName';
    
    /// <summary>  <p>Used to access the <c>TypeName</c> column in the <c>Columns</c> metadata collection.</p>
    ///   <p>The data in this column specifies the database specific data type
    ///   name.</p>
    /// </summary>
    const TypeName = 'TypeName';
    
    /// <summary>  <p>Used to access the <c>Precision</c> column in the <c>Columns</c> metadata collection.</p>
    ///   <p>The data in this column specifies the precision of this type.</p>
    /// </summary>
    /// <remarks> <br></br>
    ///   For a string data type, this is the maximum number of characters. <br> </br>
    ///   For a decimal types, this is the maximum number digits including
    ///   digits from the scale.
    /// </remarks>
    const Precision = 'Precision';
    
    /// <summary>  <p>Used to access the <c>Scale</c> column in the <c>Columns</c> metadata collection.</p>
    ///   <p>The data in this column specifies the scale of a decimal type.</p>
    /// </summary>
    const Scale = 'Scale';
    
    /// <summary>  <p>Used to access the <c>Ordinal</c> column in the <c>Columns</c> metadata collection.</p>
    ///   <p>The data in this column specifies the position in the columns of the
    ///   table starting with 1.</p>
    /// </summary>
    const Ordinal = 'Ordinal';
    
    /// <summary>  <p>Used to access the <c>DefaultValue</c> column in the <c>Columns</c> metadata collection.</p>
    ///   <p>The data in this column specifies the default value.</p>
    /// </summary>
    const DefaultValue = 'DefaultValue';
    
    /// <summary>  <p>Used to access the <c>IsNullable</c> column in the <c>Columns</c> metadata collection.</p>
    ///   <p>The data in this column specifies that the column can accept NULL
    ///   values.</p>
    /// </summary>
    const IsNullable = 'IsNullable';
    
    /// <summary>  <p>Used to access the <c>IsAutoIncrement</c> column in the <c>Columns</c> metadata collection.</p>
    ///   <p>The data in this column specifies that the column is an autoincrement
    ///   value.</p>
    /// </summary>
    const IsAutoIncrement = 'IsAutoIncrement';
    
    /// <summary>  <p>Used to access the <c>MaxInline</c> column in the <c>Columns</c> metadata collection.</p>
    ///   <p>The data in this column specifies the maximal number of bytes to write
    ///   into row.</p>
    /// </summary>
    /// <remarks> The rest of the data is handled as a blob (BlackfishSQL
    ///   only).
    /// </remarks>
    const MaxInline = 'MaxInline';
    
    /// <summary>  <p>Used to access the <c>DbxDataType</c> column in the <c>Columns</c> metadata collection.</p>
    ///   <p>The data in this column specifies the DBX data type.</p>
    /// </summary>
    const DbxDataType = 'DbxDataType';
    
    /// <summary>  <p>Used to access the <c>IsFixedLength</c> column in the <c>Columns</c> metadata collection.</p>
    ///   <p>The data in this column specifies that the column holds fixed length
    ///   data.</p>
    /// </summary>
    const IsFixedLength = 'IsFixedLength';
    
    /// <summary>  <p>Used to access the <c>IsUnicode</c> column in the <c>Columns</c> metadata collection.</p>
    ///   <p>The data in this column specifies that the column can hold unicode
    ///   characters.</p>
    /// </summary>
    const IsUnicode = 'IsUnicode';
    
    /// <summary>  <p>Used to access the <c>IsLong</c> column in the <c>Columns</c> metadata collection.</p>
    ///   <p>The data in this column specifies that the column is a blob data
    ///   type.</p>
    /// </summary>
    const IsLong = 'IsLong';
    
    /// <summary>  <p>Used to access the <c>IsUnsigned</c> column in the <c>Columns</c> metadata collection.</p>
    ///   <p>The data in this column specifies that the column is an unsigned
    ///   numeric type.</p>
    /// </summary>
    const IsUnsigned = 'IsUnsigned';
  end;

  TDBXColumnsIndex = class
  public
    
    /// <summary>  <p>Used to access the <c>CatalogName</c> column by ordinal in the <c>Columns</c> metadata collection.</p>
    ///   <p>The data in this column specifies the catalog name.</p>
    /// </summary>
    const CatalogName = 0;
    
    /// <summary>  <p>Used to access the <c>SchemaName</c> column by ordinal in the <c>Columns</c> metadata collection.</p>
    ///   <p>The data in this column specifies the schema name.</p>
    /// </summary>
    const SchemaName = 1;
    
    /// <summary>  <p>Used to access the <c>TableName</c> column by ordinal in the <c>Columns</c> metadata collection.</p>
    ///   <p>The data in this column specifies the table name.</p>
    /// </summary>
    const TableName = 2;
    
    /// <summary>  <p>Used to access the <c>ColumnName</c> column by ordinal in the <c>Columns</c> metadata collection.</p>
    ///   <p>The data in this column specifies the column name.</p>
    /// </summary>
    const ColumnName = 3;
    
    /// <summary>  <p>Used to access the <c>TypeName</c> column by ordinal in the <c>Columns</c> metadata collection.</p>
    ///   <p>The data in this column specifies the database specific data type
    ///   name.</p>
    /// </summary>
    const TypeName = 4;
    
    /// <summary>  <p>Used to access the <c>Precision</c> column by ordinal in the <c>Columns</c> metadata collection.</p>
    ///   <p>The data in this column specifies the precision of this type.</p>
    /// </summary>
    /// <remarks> <br></br>
    ///   For a string data type, this is the maximum number of characters. <br></br>
    ///   For a decimal types, this is the maximum number digits including
    ///   digits from the scale.
    /// </remarks>
    const Precision = 5;
    
    /// <summary>  <p>Used to access the <c>Scale</c> column by ordinal in the <c>Columns</c> metadata collection.</p>
    ///   <p>The data in this column specifies the scale of a decimal type.</p>
    /// </summary>
    const Scale = 6;
    
    /// <summary>  <p>Used to access the <c>Ordinal</c> column by ordinal in the <c>Columns</c> metadata collection.</p>
    ///   <p>The data in this column specifies the position in the columns of the
    ///   table starting with 1.</p>
    /// </summary>
    const Ordinal = 7;
    
    /// <summary>  <p>Used to access the <c>DefaultValue</c> column by ordinal in the <c>Columns</c> metadata collection.</p>
    ///   <p>The data in this column specifies the default value.</p>
    /// </summary>
    const DefaultValue = 8;
    
    /// <summary>  <p>Used to access the <c>IsNullable</c> column by ordinal in the <c>Columns</c> metadata collection.</p>
    ///   <p>The data in this column specifies that the column can accept NULL
    ///   values.</p>
    /// </summary>
    const IsNullable = 9;
    
    /// <summary>  <p>Used to access the <c>IsAutoIncrement</c> column by ordinal in the <c>Columns</c> metadata collection.</p>
    ///   <p>The data in this column specifies that the column is an autoincrement
    ///   value.</p>
    /// </summary>
    const IsAutoIncrement = 10;
    
    /// <summary>  <p>Used to access the <c>MaxInline</c> column by ordinal in the <c>Columns</c> metadata collection.</p>
    ///   <p>The data in this column specifies the maximal number of bytes to write
    ///   into row.</p>
    /// </summary>
    /// <remarks> The rest of the data is handled as a blob (BlackfishSQL
    ///   only).
    /// </remarks>
    const MaxInline = 11;
    
    /// <summary>  <p>Used to access the <c>DbxDataType</c> column by ordinal in the <c>Columns</c> metadata collection.</p>
    ///   <p>The data in this column specifies the DBX data type.</p>
    /// </summary>
    const DbxDataType = 12;
    
    /// <summary>  <p>Used to access the <c>IsFixedLength</c> column by ordinal in the <c>Columns</c> metadata collection.</p>
    ///   <p>The data in this column specifies that the column holds fixed length
    ///   data.</p>
    /// </summary>
    const IsFixedLength = 13;
    
    /// <summary>  <p>Used to access the <c>IsUnicode</c> column by ordinal in the <c>Columns</c> metadata collection.</p>
    ///   <p>The data in this column specifies that the column can hold unicode
    ///   characters.</p>
    /// </summary>
    const IsUnicode = 14;
    
    /// <summary>  <p>Used to access the <c>IsLong</c> column by ordinal in the <c>Columns</c> metadata collection.</p>
    ///   <p>The data in this column specifies that the column is a blob data
    ///   type.</p>
    /// </summary>
    const IsLong = 15;
    
    /// <summary>  <p>Used to access the <c>IsUnsigned</c> column by ordinal in the <c>Columns</c> metadata collection.</p>
    ///   <p>The data in this column specifies that the column is an unsigned
    ///   numeric type.</p>
    /// </summary>
    const IsUnsigned = 16;
    const Last = 16;
  end;

  TDBXDataTypesColumns = class
  public
    
    /// <summary>  <p>Used to access the <c>TypeName</c> column in the <c>DataTypes</c> metadata collection.</p>
    ///   <p>The data in this column specifies the database specific data type
    ///   name.</p>
    /// </summary>
    const TypeName = 'TypeName';
    
    /// <summary>  <p>Used to access the <c>DbxDataType</c> column in the <c>DataTypes</c> metadata collection.</p>
    ///   <p>The data in this column specifies the DBX data type.</p>
    /// </summary>
    const DbxDataType = 'DbxDataType';
    
    /// <summary>  <p>Used to access the <c>ColumnSize</c> column in the <c>DataTypes</c> metadata collection.</p>
    ///   <p>The data in this column specifies the length of this type.</p>
    /// </summary>
    /// <remarks> <br></br>
    ///   For a string data type, this is the maximum number of characters. <br></br>
    ///   For a floating point number, this is the number of significant bits in
    ///   the mantissa. <br></br>
    ///   For other numeric types, this is the maximum number of significant
    ///   digits. <br></br>
    ///   For a date, time, and timestamp types, this is the length of the
    ///   string representation.
    /// </remarks>
    const ColumnSize = 'ColumnSize';
    
    /// <summary>  <p>Used to access the <c>CreateFormat</c> column in the <c>DataTypes</c> metadata collection.</p>
    ///   <p>The data in this column specifies the create format as used in CREATE
    ///   TABLE.</p>
    /// </summary>
    const CreateFormat = 'CreateFormat';
    
    /// <summary>  <p>Used to access the <c>CreateParameters</c> column in the <c>DataTypes</c> metadata collection.</p>
    ///   <p>The data in this column specifies the parameters for the create
    ///   format.</p>
    /// </summary>
    const CreateParameters = 'CreateParameters';
    
    /// <summary>  <p>Used to access the <c>DataType</c> column in the <c>DataTypes</c> metadata collection.</p>
    ///   <p>The data in this column specifies the name of the language type
    ///   representing this data type.</p>
    /// </summary>
    const DataType = 'DataType';
    
    /// <summary>  <p>Used to access the <c>IsAutoIncrementable</c> column in the <c>DataTypes</c> metadata collection.</p>
    ///   <p>The data in this column specifies that the data type can be used as
    ///   for an autoincrement column.</p>
    /// </summary>
    const IsAutoIncrementable = 'IsAutoIncrementable';
    
    /// <summary>  <p>Used to access the <c>IsBestMatch</c> column in the <c>DataTypes</c> metadata collection.</p>
    ///   <p>The data in this column specifies that the data type is the best match
    ///   for the language type.</p>
    /// </summary>
    const IsBestMatch = 'IsBestMatch';
    
    /// <summary>  <p>Used to access the <c>IsCaseSensitive</c> column in the <c>DataTypes</c> metadata collection.</p>
    ///   <p>The data in this column specifies that the data type is case
    ///   sensitive.</p>
    /// </summary>
    const IsCaseSensitive = 'IsCaseSensitive';
    
    /// <summary>  <p>Used to access the <c>IsFixedLength</c> column in the <c>DataTypes</c> metadata collection.</p>
    ///   <p>The data in this column specifies that the data type is fixed
    ///   length.</p>
    /// </summary>
    const IsFixedLength = 'IsFixedLength';
    
    /// <summary>  <p>Used to access the <c>IsFixedPrecisionScale</c> column in the <c>DataTypes</c> metadata collection.</p>
    ///   <p>The data in this column specifies that the data type is an exact
    ///   numeric.</p>
    /// </summary>
    const IsFixedPrecisionScale = 'IsFixedPrecisionScale';
    
    /// <summary>  <p>Used to access the <c>IsLong</c> column in the <c>DataTypes</c> metadata collection.</p>
    ///   <p>The data in this column specifies that the data type is a blob
    ///   type.</p>
    /// </summary>
    const IsLong = 'IsLong';
    
    /// <summary>  <p>Used to access the <c>IsNullable</c> column in the <c>DataTypes</c> metadata collection.</p>
    ///   <p>The data in this column specifies that the data type can be assigned a
    ///   value of NULL.</p>
    /// </summary>
    const IsNullable = 'IsNullable';
    
    /// <summary>  <p>Used to access the <c>IsSearchable</c> column in the <c>DataTypes</c> metadata collection.</p>
    ///   <p>The data in this column specifies that the data type can be searched
    ///   in the SQL database.</p>
    /// </summary>
    const IsSearchable = 'IsSearchable';
    
    /// <summary>  <p>Used to access the <c>IsSearchableWithLike</c> column in the <c>DataTypes</c> metadata collection.</p>
    ///   <p>The data in this column specifies that the data type can be search
    ///   with the SQL LIKE operator.</p>
    /// </summary>
    const IsSearchableWithLike = 'IsSearchableWithLike';
    
    /// <summary>  <p>Used to access the <c>IsUnsigned</c> column in the <c>DataTypes</c> metadata collection.</p>
    ///   <p>The data in this column specifies that the data type is an unsigned
    ///   numeric.</p>
    /// </summary>
    const IsUnsigned = 'IsUnsigned';
    
    /// <summary>  <p>Used to access the <c>MaximumScale</c> column in the <c>DataTypes</c> metadata collection.</p>
    ///   <p>The data in this column specifies the maximum possible scale
    ///   value.</p>
    /// </summary>
    const MaximumScale = 'MaximumScale';
    
    /// <summary>  <p>Used to access the <c>MinimumScale</c> column in the <c>DataTypes</c> metadata collection.</p>
    ///   <p>The data in this column specifies the minimum possible scale
    ///   value.</p>
    /// </summary>
    const MinimumScale = 'MinimumScale';
    
    /// <summary>  <p>Used to access the <c>IsConcurrencyType</c> column in the <c>DataTypes</c> metadata collection.</p>
    ///   <p>The data in this column specifies that the data type has special
    ///   update semantics.</p>
    /// </summary>
    const IsConcurrencyType = 'IsConcurrencyType';
    
    /// <summary>  <p>Used to access the <c>MaximumVersion</c> column in the <c>DataTypes</c> metadata collection.</p>
    ///   <p>The data in this column specifies the last database product version
    ///   where this type was avaliable.</p>
    /// </summary>
    const MaximumVersion = 'MaximumVersion';
    
    /// <summary>  <p>Used to access the <c>MinimumVersion</c> column in the <c>DataTypes</c> metadata collection.</p>
    ///   <p>The data in this column specifies the first database product version
    ///   where this type was available.</p>
    /// </summary>
    const MinimumVersion = 'MinimumVersion';
    
    /// <summary>  <p>Used to access the <c>IsLiteralSupported</c> column in the <c>DataTypes</c> metadata collection.</p>
    ///   <p>The data in this column specifies that the data type can be
    ///   represented as a SQL literal.</p>
    /// </summary>
    const IsLiteralSupported = 'IsLiteralSupported';
    
    /// <summary>  <p>Used to access the <c>LiteralPrefix</c> column in the <c>DataTypes</c> metadata collection.</p>
    ///   <p>The data in this column specifies the prefix of a SQL literal.</p>
    /// </summary>
    const LiteralPrefix = 'LiteralPrefix';
    
    /// <summary>  <p>Used to access the <c>LiteralSuffix</c> column in the <c>DataTypes</c> metadata collection.</p>
    ///   <p>The data in this column specifies the suffix of a SQL literal.</p>
    /// </summary>
    const LiteralSuffix = 'LiteralSuffix';
    
    /// <summary>  <p>Used to access the <c>IsUnicode</c> column in the <c>DataTypes</c> metadata collection.</p>
    ///   <p>The data in this column specifies that the data type can hold unicode
    ///   character data.</p>
    /// </summary>
    const IsUnicode = 'IsUnicode';
    
    /// <summary>  <p>Used to access the <c>ProviderDbType</c> column in the <c>DataTypes</c> metadata collection.</p>
    ///   <p>The data in this column specifies the same as the
    ///   <c>DbxDataType</c> column.</p>
    /// </summary>
    /// <remarks> <br></br>
    ///   Reserved for .NET applications.
    /// </remarks>
    const ProviderDbType = 'ProviderDbType';
  end;

  TDBXDataTypesIndex = class
  public
    
    /// <summary>  <p>Used to access the <c>TypeName</c> column by ordinal in the <c>DataTypes</c> metadata collection.</p>
    ///   <p>The data in this column specifies the database specific data type
    ///   name.</p>
    /// </summary>
    const TypeName = 0;
    
    /// <summary>  <p>Used to access the <c>DbxDataType</c> column by ordinal in the <c>DataTypes</c> metadata collection.</p>
    ///   <p>The data in this column specifies the DBX data type.</p>
    /// </summary>
    const DbxDataType = 1;
    
    /// <summary>  <p>Used to access the <c>ColumnSize</c> column by ordinal in the <c>DataTypes</c> metadata collection.</p>
    ///   <p>The data in this column specifies the length of this type.</p>
    /// </summary>
    /// <remarks> <br></br>
    ///   For a string data type, this is the maximum number of characters. <br></br>
    ///   For a floating point number, this is the number of significant bits in
    ///   the mantissa. <br></br>
    ///   For other numeric types, this is the maximum number of significant
    ///   digits. <br></br>
    ///   For a date, time, and timestamp types, this is the length of the
    ///   string representation.
    /// </remarks>
    const ColumnSize = 2;
    
    /// <summary>  <p>Used to access the <c>CreateFormat</c> column by ordinal in the <c>DataTypes</c> metadata collection.</p>
    ///   <p>The data in this column specifies the create format as used in CREATE
    ///   TABLE.</p>
    /// </summary>
    const CreateFormat = 3;
    
    /// <summary>  <p>Used to access the <c>CreateParameters</c> column by ordinal in the <c>DataTypes</c> metadata collection.</p>
    ///   <p>The data in this column specifies the parameters for the create
    ///   format.</p>
    /// </summary>
    const CreateParameters = 4;
    
    /// <summary>  <p>Used to access the <c>DataType</c> column by ordinal in the <c>DataTypes</c> metadata collection.</p>
    ///   <p>The data in this column specifies the name of the language type
    ///   representing this data type.</p>
    /// </summary>
    const DataType = 5;
    
    /// <summary>  <p>Used to access the <c>IsAutoIncrementable</c> column by ordinal in the <c>DataTypes</c> metadata collection.</p>
    ///   <p>The data in this column specifies that the data type can be used as
    ///   for an autoincrement column.</p>
    /// </summary>
    const IsAutoIncrementable = 6;
    
    /// <summary>  <p>Used to access the <c>IsBestMatch</c> column by ordinal in the <c>DataTypes</c> metadata collection.</p>
    ///   <p>The data in this column specifies that the data type is the best match
    ///   for the language type.</p>
    /// </summary>
    const IsBestMatch = 7;
    
    /// <summary>  <p>Used to access the <c>IsCaseSensitive</c> column by ordinal in the <c>DataTypes</c> metadata collection.</p>
    ///   <p>The data in this column specifies that the data type is case
    ///   sensitive.</p>
    /// </summary>
    const IsCaseSensitive = 8;
    
    /// <summary>  <p>Used to access the <c>IsFixedLength</c> column by ordinal in the <c>DataTypes</c> metadata collection.</p>
    ///   <p>The data in this column specifies that the data type is fixed
    ///   length.</p>
    /// </summary>
    const IsFixedLength = 9;
    
    /// <summary>  <p>Used to access the <c>IsFixedPrecisionScale</c> column by ordinal in the <c>DataTypes</c> metadata collection.</p>
    ///   <p>The data in this column specifies that the data type is an exact
    ///   numeric.</p>
    /// </summary>
    const IsFixedPrecisionScale = 10;
    
    /// <summary>  <p>Used to access the <c>IsLong</c> column by ordinal in the <c>DataTypes</c> metadata collection.</p>
    ///   <p>The data in this column specifies that the data type is a blob
    ///   type.</p>
    /// </summary>
    const IsLong = 11;
    
    /// <summary>  <p>Used to access the <c>IsNullable</c> column by ordinal in the <c>DataTypes</c> metadata collection.</p>
    ///   <p>The data in this column specifies that the data type can be assigned a
    ///   value of NULL.</p>
    /// </summary>
    const IsNullable = 12;
    
    /// <summary>  <p>Used to access the <c>IsSearchable</c> column by ordinal in the <c>DataTypes</c> metadata collection.</p>
    ///   <p>The data in this column specifies that the data type can be searched
    ///   in the SQL database.</p>
    /// </summary>
    const IsSearchable = 13;
    
    /// <summary>  <p>Used to access the <c>IsSearchableWithLike</c> column by ordinal in the <c>DataTypes</c> metadata collection.</p>
    ///   <p>The data in this column specifies that the data type can be search
    ///   with the SQL LIKE operator.</p>
    /// </summary>
    const IsSearchableWithLike = 14;
    
    /// <summary>  <p>Used to access the <c>IsUnsigned</c> column by ordinal in the <c>DataTypes</c> metadata collection.</p>
    ///   <p>The data in this column specifies that the data type is an unsigned
    ///   numeric.</p>
    /// </summary>
    const IsUnsigned = 15;
    
    /// <summary>  <p>Used to access the <c>MaximumScale</c> column by ordinal in the <c>DataTypes</c> metadata collection.</p>
    ///   <p>The data in this column specifies the maximum possible scale
    ///   value.</p>
    /// </summary>
    const MaximumScale = 16;
    
    /// <summary>  <p>Used to access the <c>MinimumScale</c> column by ordinal in the <c>DataTypes</c> metadata collection.</p>
    ///   <p>The data in this column specifies the minimum possible scale
    ///   value.</p>
    /// </summary>
    const MinimumScale = 17;
    
    /// <summary>  <p>Used to access the <c>IsConcurrencyType</c> column by ordinal in the <c>DataTypes</c> metadata collection.</p>
    ///   <p>The data in this column specifies that the data type has special
    ///   update semantics.</p>
    /// </summary>
    const IsConcurrencyType = 18;
    
    /// <summary>  <p>Used to access the <c>MaximumVersion</c> column by ordinal in the <c>DataTypes</c> metadata collection.</p>
    ///   <p>The data in this column specifies the last database product version
    ///   where this type was avaliable.</p>
    /// </summary>
    const MaximumVersion = 19;
    
    /// <summary>  <p>Used to access the <c>MinimumVersion</c> column by ordinal in the <c>DataTypes</c> metadata collection.</p>
    ///   <p>The data in this column specifies the first database product version
    ///   where this type was available.</p>
    /// </summary>
    const MinimumVersion = 20;
    
    /// <summary>  <p>Used to access the <c>IsLiteralSupported</c> column by ordinal in the <c>DataTypes</c> metadata collection.</p>
    ///   <p>The data in this column specifies that the data type can be
    ///   represented as a SQL literal.</p>
    /// </summary>
    const IsLiteralSupported = 21;
    
    /// <summary>  <p>Used to access the <c>LiteralPrefix</c> column by ordinal in the <c>DataTypes</c> metadata collection.</p>
    ///   <p>The data in this column specifies the prefix of a SQL literal.</p>
    /// </summary>
    const LiteralPrefix = 22;
    
    /// <summary>  <p>Used to access the <c>LiteralSuffix</c> column by ordinal in the <c>DataTypes</c> metadata collection.</p>
    ///   <p>The data in this column specifies the suffix of a SQL literal.</p>
    /// </summary>
    const LiteralSuffix = 23;
    
    /// <summary>  <p>Used to access the <c>IsUnicode</c> column by ordinal in the <c>DataTypes</c> metadata collection.</p>
    ///   <p>The data in this column specifies that the data type can hold unicode
    ///   character data.</p>
    /// </summary>
    const IsUnicode = 24;
    
    /// <summary>  <p>Used to access the <c>ProviderDbType</c> column by ordinal in the <c>DataTypes</c> metadata collection.</p>
    ///   <p>The data in this column specifies the same as the
    ///   <c>DbxDataType</c> column.</p>
    /// </summary>
    /// <remarks> <br></br>
    ///   Reserved for .NET applications.
    /// </remarks>
    const ProviderDbType = 25;
    const Last = 25;
  end;

  TDBXForeignKeyColumnsColumns = class
  public
    
    /// <summary>  <p>Used to access the <c>CatalogName</c> column in the <c>ForeignKeyColumns</c> metadata collection.</p>
    ///   <p>The data in this column specifies the catalog name of the table with
    ///   the foreign key.</p>
    /// </summary>
    const CatalogName = 'CatalogName';
    
    /// <summary>  <p>Used to access the <c>SchemaName</c> column in the <c>ForeignKeyColumns</c> metadata collection.</p>
    ///   <p>The data in this column specifies the schema name of the table with
    ///   the foreign key.</p>
    /// </summary>
    const SchemaName = 'SchemaName';
    
    /// <summary>  <p>Used to access the <c>TableName</c> column in the <c>ForeignKeyColumns</c> metadata collection.</p>
    ///   <p>The data in this column specifies the name of the table with the
    ///   foreign key.</p>
    /// </summary>
    const TableName = 'TableName';
    
    /// <summary>  <p>Used to access the <c>ForeignKeyName</c> column in the <c>ForeignKeyColumns</c> metadata collection.</p>
    ///   <p>The data in this column specifies the foreign key name.</p>
    /// </summary>
    const ForeignKeyName = 'ForeignKeyName';
    
    /// <summary>  <p>Used to access the <c>ColumnName</c> column in the <c>ForeignKeyColumns</c> metadata collection.</p>
    ///   <p>The data in this column specifies a column which refers to a column of
    ///   in another table.</p>
    /// </summary>
    const ColumnName = 'ColumnName';
    
    /// <summary>  <p>Used to access the <c>PrimaryCatalogName</c> column in the <c>ForeignKeyColumns</c> metadata collection.</p>
    ///   <p>The data in this column specifies the catalog name of the table being
    ///   referred to.</p>
    /// </summary>
    const PrimaryCatalogName = 'PrimaryCatalogName';
    
    /// <summary>  <p>Used to access the <c>PrimarySchemaName</c> column in the <c>ForeignKeyColumns</c> metadata collection.</p>
    ///   <p>The data in this column specifies the schema name of the table being
    ///   referred to.</p>
    /// </summary>
    const PrimarySchemaName = 'PrimarySchemaName';
    
    /// <summary>  <p>Used to access the <c>PrimaryTableName</c> column in the <c>ForeignKeyColumns</c> metadata collection.</p>
    ///   <p>The data in this column specifies the name of the table being referred
    ///   to.</p>
    /// </summary>
    const PrimaryTableName = 'PrimaryTableName';
    
    /// <summary>  <p>Used to access the <c>PrimaryKeyName</c> column in the <c>ForeignKeyColumns</c> metadata collection.</p>
    ///   <p>The data in this column specifies the name of the key being referred
    ///   to.</p>
    /// </summary>
    /// <remarks> <br></br>
    ///   This is usually the primary key.
    /// </remarks>
    const PrimaryKeyName = 'PrimaryKeyName';
    
    /// <summary>  <p>Used to access the <c>PrimaryColumnName</c> column in the <c>ForeignKeyColumns</c> metadata collection.</p>
    ///   <p>The data in this column specifies the column which is being referred
    ///   to.</p>
    /// </summary>
    const PrimaryColumnName = 'PrimaryColumnName';
    
    /// <summary>  <p>Used to access the <c>Ordinal</c> column in the <c>ForeignKeyColumns</c> metadata collection.</p>
    ///   <p>The data in this column specifies the position of the column reference
    ///   in the foreign key.</p>
    /// </summary>
    const Ordinal = 'Ordinal';
  end;

  TDBXForeignKeyColumnsIndex = class
  public
    
    /// <summary>  <p>Used to access the <c>CatalogName</c> column by ordinal in the <c>ForeignKeyColumns</c> metadata collection.</p>
    ///   <p>The data in this column specifies the catalog name of the table with
    ///   the foreign key.</p>
    /// </summary>
    const CatalogName = 0;
    
    /// <summary>  <p>Used to access the <c>SchemaName</c> column by ordinal in the <c>ForeignKeyColumns</c> metadata collection.</p>
    ///   <p>The data in this column specifies the schema name of the table with
    ///   the foreign key.</p>
    /// </summary>
    const SchemaName = 1;
    
    /// <summary>  <p>Used to access the <c>TableName</c> column by ordinal in the <c>ForeignKeyColumns</c> metadata collection.</p>
    ///   <p>The data in this column specifies the name of the table with the
    ///   foreign key.</p>
    /// </summary>
    const TableName = 2;
    
    /// <summary>  <p>Used to access the <c>ForeignKeyName</c> column by ordinal in the <c>ForeignKeyColumns</c> metadata collection.</p>
    ///   <p>The data in this column specifies the foreign key name.</p>
    /// </summary>
    const ForeignKeyName = 3;
    
    /// <summary>  <p>Used to access the <c>ColumnName</c> column by ordinal in the <c>ForeignKeyColumns</c> metadata collection.</p>
    ///   <p>The data in this column specifies a column which refers to a column of
    ///   in another table.</p>
    /// </summary>
    const ColumnName = 4;
    
    /// <summary>  <p>Used to access the <c>PrimaryCatalogName</c> column by ordinal in the <c>ForeignKeyColumns</c> metadata collection.</p>
    ///   <p>The data in this column specifies the catalog name of the table being
    ///   referred to.</p>
    /// </summary>
    const PrimaryCatalogName = 5;
    
    /// <summary>  <p>Used to access the <c>PrimarySchemaName</c> column by ordinal in the <c>ForeignKeyColumns</c> metadata collection.</p>
    ///   <p>The data in this column specifies the schema name of the table being
    ///   referred to.</p>
    /// </summary>
    const PrimarySchemaName = 6;
    
    /// <summary>  <p>Used to access the <c>PrimaryTableName</c> column by ordinal in the <c>ForeignKeyColumns</c> metadata collection.</p>
    ///   <p>The data in this column specifies the name of the table being referred
    ///   to.</p>
    /// </summary>
    const PrimaryTableName = 7;
    
    /// <summary>  <p>Used to access the <c>PrimaryKeyName</c> column by ordinal in the <c>ForeignKeyColumns</c> metadata collection.</p>
    ///   <p>The data in this column specifies the name of the key being referred
    ///   to.</p>
    /// </summary>
    /// <remarks> <br></br>
    ///   This is usually the primary key.
    /// </remarks>
    const PrimaryKeyName = 8;
    
    /// <summary>  <p>Used to access the <c>PrimaryColumnName</c> column by ordinal in the <c>ForeignKeyColumns</c> metadata collection.</p>
    ///   <p>The data in this column specifies the column which is being referred
    ///   to.</p>
    /// </summary>
    const PrimaryColumnName = 9;
    
    /// <summary>  <p>Used to access the <c>Ordinal</c> column by ordinal in the <c>ForeignKeyColumns</c> metadata collection.</p>
    ///   <p>The data in this column specifies the position of the column reference
    ///   in the foreign key.</p>
    /// </summary>
    const Ordinal = 10;
    const Last = 10;
  end;

  TDBXForeignKeysColumns = class
  public
    
    /// <summary>  <p>Used to access the <c>CatalogName</c> column in the <c>ForeignKeys</c> metadata collection.</p>
    ///   <p>The data in this column specifies the catalog name.</p>
    /// </summary>
    const CatalogName = 'CatalogName';
    
    /// <summary>  <p>Used to access the <c>SchemaName</c> column in the <c>ForeignKeys</c> metadata collection.</p>
    ///   <p>The data in this column specifies the schema name.</p>
    /// </summary>
    const SchemaName = 'SchemaName';
    
    /// <summary>  <p>Used to access the <c>TableName</c> column in the <c>ForeignKeys</c> metadata collection.</p>
    ///   <p>The data in this column specifies the table name.</p>
    /// </summary>
    const TableName = 'TableName';
    
    /// <summary>  <p>Used to access the <c>ForeignKeyName</c> column in the <c>ForeignKeys</c> metadata collection.</p>
    ///   <p>The data in this column specifies the foreign key name.</p>
    /// </summary>
    const ForeignKeyName = 'ForeignKeyName';
  end;

  TDBXForeignKeysIndex = class
  public
    
    /// <summary>  <p>Used to access the <c>CatalogName</c> column by ordinal in the <c>ForeignKeys</c> metadata collection.</p>
    ///   <p>The data in this column specifies the catalog name.</p>
    /// </summary>
    const CatalogName = 0;
    
    /// <summary>  <p>Used to access the <c>SchemaName</c> column by ordinal in the <c>ForeignKeys</c> metadata collection.</p>
    ///   <p>The data in this column specifies the schema name.</p>
    /// </summary>
    const SchemaName = 1;
    
    /// <summary>  <p>Used to access the <c>TableName</c> column by ordinal in the <c>ForeignKeys</c> metadata collection.</p>
    ///   <p>The data in this column specifies the table name.</p>
    /// </summary>
    const TableName = 2;
    
    /// <summary>  <p>Used to access the <c>ForeignKeyName</c> column by ordinal in the <c>ForeignKeys</c> metadata collection.</p>
    ///   <p>The data in this column specifies the foreign key name.</p>
    /// </summary>
    const ForeignKeyName = 3;
    const Last = 3;
  end;

  TDBXIndexColumnsColumns = class
  public
    
    /// <summary>  <p>Used to access the <c>CatalogName</c> column in the <c>IndexColumns</c> metadata collection.</p>
    ///   <p>The data in this column specifies the catalog name.</p>
    /// </summary>
    const CatalogName = 'CatalogName';
    
    /// <summary>  <p>Used to access the <c>SchemaName</c> column in the <c>IndexColumns</c> metadata collection.</p>
    ///   <p>The data in this column specifies the schema name.</p>
    /// </summary>
    const SchemaName = 'SchemaName';
    
    /// <summary>  <p>Used to access the <c>TableName</c> column in the <c>IndexColumns</c> metadata collection.</p>
    ///   <p>The data in this column specifies the table name.</p>
    /// </summary>
    const TableName = 'TableName';
    
    /// <summary>  <p>Used to access the <c>IndexName</c> column in the <c>IndexColumns</c> metadata collection.</p>
    ///   <p>The data in this column specifies the index name.</p>
    /// </summary>
    const IndexName = 'IndexName';
    
    /// <summary>  <p>Used to access the <c>ColumnName</c> column in the <c>IndexColumns</c> metadata collection.</p>
    ///   <p>The data in this column specifies a column in the index.</p>
    /// </summary>
    const ColumnName = 'ColumnName';
    
    /// <summary>  <p>Used to access the <c>Ordinal</c> column in the <c>IndexColumns</c> metadata collection.</p>
    ///   <p>The data in this column specifies the position of the column in the
    ///   index starting with 1.</p>
    /// </summary>
    const Ordinal = 'Ordinal';
    
    /// <summary>  <p>Used to access the <c>IsAscending</c> column in the <c>IndexColumns</c> metadata collection.</p>
    ///   <p>The data in this column specifies that the index column is a
    ///   descending index column.</p>
    /// </summary>
    const IsAscending = 'IsAscending';
  end;

  TDBXIndexColumnsIndex = class
  public
    
    /// <summary>  <p>Used to access the <c>CatalogName</c> column by ordinal in the <c>IndexColumns</c> metadata collection.</p>
    ///   <p>The data in this column specifies the catalog name.</p>
    /// </summary>
    const CatalogName = 0;
    
    /// <summary>  <p>Used to access the <c>SchemaName</c> column by ordinal in the <c>IndexColumns</c> metadata collection.</p>
    ///   <p>The data in this column specifies the schema name.</p>
    /// </summary>
    const SchemaName = 1;
    
    /// <summary>  <p>Used to access the <c>TableName</c> column by ordinal in the <c>IndexColumns</c> metadata collection.</p>
    ///   <p>The data in this column specifies the table name.</p>
    /// </summary>
    const TableName = 2;
    
    /// <summary>  <p>Used to access the <c>IndexName</c> column by ordinal in the <c>IndexColumns</c> metadata collection.</p>
    ///   <p>The data in this column specifies the index name.</p>
    /// </summary>
    const IndexName = 3;
    
    /// <summary>  <p>Used to access the <c>ColumnName</c> column by ordinal in the <c>IndexColumns</c> metadata collection.</p>
    ///   <p>The data in this column specifies a column in the index.</p>
    /// </summary>
    const ColumnName = 4;
    
    /// <summary>  <p>Used to access the <c>Ordinal</c> column by ordinal in the <c>IndexColumns</c> metadata collection.</p>
    ///   <p>The data in this column specifies the position of the column in the
    ///   index starting with 1.</p>
    /// </summary>
    const Ordinal = 5;
    
    /// <summary>  <p>Used to access the <c>IsAscending</c> column by ordinal in the <c>IndexColumns</c> metadata collection.</p>
    ///   <p>The data in this column specifies that the index column is a
    ///   descending index column.</p>
    /// </summary>
    const IsAscending = 6;
    const Last = 6;
  end;

  TDBXIndexesColumns = class
  public
    
    /// <summary>  <p>Used to access the <c>CatalogName</c> column in the <c>Indexes</c> metadata collection.</p>
    ///   <p>The data in this column specifies the catalog name.</p>
    /// </summary>
    const CatalogName = 'CatalogName';
    
    /// <summary>  <p>Used to access the <c>SchemaName</c> column in the <c>Indexes</c> metadata collection.</p>
    ///   <p>The data in this column specifies the schema name.</p>
    /// </summary>
    const SchemaName = 'SchemaName';
    
    /// <summary>  <p>Used to access the <c>TableName</c> column in the <c>Indexes</c> metadata collection.</p>
    ///   <p>The data in this column specifies the table name.</p>
    /// </summary>
    const TableName = 'TableName';
    
    /// <summary>  <p>Used to access the <c>IndexName</c> column in the <c>Indexes</c> metadata collection.</p>
    ///   <p>The data in this column specifies the index name.</p>
    /// </summary>
    const IndexName = 'IndexName';
    
    /// <summary>  <p>Used to access the <c>ConstraintName</c> column in the <c>Indexes</c> metadata collection.</p>
    ///   <p>The data in this column specifies the constraint name, may be
    ///   NULL.</p>
    /// </summary>
    const ConstraintName = 'ConstraintName';
    
    /// <summary>  <p>Used to access the <c>IsPrimary</c> column in the <c>Indexes</c> metadata collection.</p>
    ///   <p>The data in this column specifies that the index is the primary key of
    ///   the table.</p>
    /// </summary>
    const IsPrimary = 'IsPrimary';
    
    /// <summary>  <p>Used to access the <c>IsUnique</c> column in the <c>Indexes</c> metadata collection.</p>
    ///   <p>The data in this column specifies that the index is an unique index of
    ///   the table.</p>
    /// </summary>
    const IsUnique = 'IsUnique';
    
    /// <summary>  <p>Used to access the <c>IsAscending</c> column in the <c>Indexes</c> metadata collection.</p>
    ///   <p>The data in this column specifies that the index is a descending index
    ///   (Interbase only).</p>
    /// </summary>
    const IsAscending = 'IsAscending';

    /// <summary> <p>Used to access the <c>IndexQualifier</c> column in the <c>Indexes</c> metadata collection</p>
    ///   <p>The data in this column specifies the identifier that is used to qualify the index name
    ///   doing a Drop Index (ODBC only).  See SQLStatistics for more details.</p>
    /// </summary>
    const IndexQualifier = 'IndexQualifier';

    /// <summary> <p>Used to access the <c>Type</c> column in the <c>Indexes</c> metadata collection</p>
    ///   <p>The data in this column specifies the type of information being returned (ODBC only).
    ///   See SQLStatistics for more details.</p>
    /// </summary>
    const TypeName = 'Type';

    /// <summary> <p>Used to access the <c>OrdinalPosition</c> column in the <c>Indexes</c> metadata collection</p>
    ///   <p>The data in this column specifies the column sequence number in the index (ODBC only).
    ///   See SQLStatistics for more details.</p>
    /// </summary>
    const OrdinalPosition = 'OrdinalPosition';

    /// <summary> <p>Used to access the <c>ColumnName</c> column in the <c>Indexes</c> metadata collection</p>
    ///   <p>The data in this column specifies the column name (ODBC only).
    ///   See SQLStatistics for more details.</p>
    /// </summary>
    const ColumnName = 'ColumnName';

    /// <summary> <p>Used to access the <c>AscDesc</c> column in the <c>Indexes</c> metadata collection</p>
    ///   <p>The data in this column specifies the sort sequence for the column (ODBC only).
    ///   See SQLStatistics for more details.</p>
    /// </summary>
    const AscDesc = 'AscDesc';

    /// <summary> <p>Used to access the <c>Cardinality</c> column in the <c>Indexes</c> metadata collection</p>
    ///   <p>The data in this column specifies the cardinality of the index (ODBC only).
    ///   See SQLStatistics for more details.</p>
    /// </summary>
    const Cardinality = 'Cardinality';

    /// <summary> <p>Used to access the <c>Pages</c> column in the <c>Indexes</c> metadata collection</p>
    ///   <p>The data in this column specifies the number of pages used to store the index (ODBC only).
    ///   See SQLStatistics for more details.</p>
    /// </summary>
    const Pages = 'Pages';

    /// <summary> <p>Used to access the <c>FilterCondition</c> column in the <c>Indexes</c> metadata collection</p>
    ///   <p>The data in this column specifies the filter condition of the index if there is one (ODBC only).
    ///   See SQLStatistics for more details.</p>
    /// </summary>
    const FilterCondition = 'FilterCondition';
  end;

  TDBXIndexesIndex = class
  public
    
    /// <summary>  <p>Used to access the <c>CatalogName</c> column by ordinal in the <c>Indexes</c> metadata collection.</p>
    ///   <p>The data in this column specifies the catalog name.</p>
    /// </summary>
    const CatalogName = 0;
    
    /// <summary>  <p>Used to access the <c>SchemaName</c> column by ordinal in the <c>Indexes</c> metadata collection.</p>
    ///   <p>The data in this column specifies the schema name.</p>
    /// </summary>
    const SchemaName = 1;
    
    /// <summary>  <p>Used to access the <c>TableName</c> column by ordinal in the <c>Indexes</c> metadata collection.</p>
    ///   <p>The data in this column specifies the table name.</p>
    /// </summary>
    const TableName = 2;
    
    /// <summary>  <p>Used to access the <c>IndexName</c> column by ordinal in the <c>Indexes</c> metadata collection.</p>
    ///   <p>The data in this column specifies the index name.</p>
    /// </summary>
    const IndexName = 3;
    
    /// <summary>  <p>Used to access the <c>ConstraintName</c> column by ordinal in the <c>Indexes</c> metadata collection.</p>
    ///   <p>The data in this column specifies the constraint name, may be
    ///   NULL.</p>
    /// </summary>
    const ConstraintName = 4;
    
    /// <summary>  <p>Used to access the <c>IsPrimary</c> column by ordinal in the <c>Indexes</c> metadata collection.</p>
    ///   <p>The data in this column specifies that the index is the primary key of
    ///   the table.</p>
    /// </summary>
    const IsPrimary = 5;
    
    /// <summary>  <p>Used to access the <c>IsUnique</c> column by ordinal in the <c>Indexes</c> metadata collection.</p>
    ///   <p>The data in this column specifies that the index is an unique index of
    ///   the table.</p>
    /// </summary>
    const IsUnique = 6;
    
    /// <summary>  <p>Used to access the <c>IsAscending</c> column by ordinal in the <c>Indexes</c> metadata collection.</p>
    ///   <p>The data in this column specifies that the index is a descending index
    ///   (Interbase only).</p>
    /// </summary>
    const IsAscending = 7;
    const Last = 7;
  end;

  TDBXMetaDataCollectionIndex = class
  public
    
    /// <summary> <p>This metadata collection represents the data types supported by a specific database.</p>
    ///  <p>The columns are:</p>
    ///  <table cellspacing="0" cellpadding="4" border="1">
    ///    <tr><th align="left">Column Name</th><th align="left">Data Type</th><th align="left">Description</th></tr>
    ///    <tr><td>TypeName</td><td>AsString</td><td>The database specific data type name.</td></tr>
    ///    <tr><td>DbxDataType</td><td>AsInt32</td><td>The DBX data type.</td></tr>
    ///    <tr><td>ColumnSize</td><td>Int64</td><td>The length of this type.
    ///    <br></br> For a string data type, this is the maximum number of characters. <br></br> For a floating point number, this is the number of significant bits in the mantissa. <br></br> For other numeric types, this is the maximum number of significant digits. <br></br> For a date, time, and timestamp types, this is the length of the string representation.</td></tr>
    ///    <tr><td>CreateFormat</td><td>AsString</td><td>The create format as used in CREATE TABLE.</td></tr>
    ///    <tr><td>CreateParameters</td><td>AsString</td><td>The parameters for the create format.</td></tr>
    ///    <tr><td>DataType</td><td>AsString</td><td>The name of the language type representing this data type.</td></tr>
    ///    <tr><td>IsAutoIncrementable</td><td>AsBoolean</td><td>Can be used as for an autoincrement column.</td></tr>
    ///    <tr><td>IsBestMatch</td><td>AsBoolean</td><td>Is the best match for the language type.</td></tr>
    ///    <tr><td>IsCaseSensitive</td><td>AsBoolean</td><td>Is case sensitive.</td></tr>
    ///    <tr><td>IsFixedLength</td><td>AsBoolean</td><td>Is fixed length.</td></tr>
    ///    <tr><td>IsFixedPrecisionScale</td><td>AsBoolean</td><td>Is an exact numeric.</td></tr>
    ///    <tr><td>IsLong</td><td>AsBoolean</td><td>Is a blob type.</td></tr>
    ///    <tr><td>IsNullable</td><td>AsBoolean</td><td>Can be assigned a value of NULL.</td></tr>
    ///    <tr><td>IsSearchable</td><td>AsBoolean</td><td>Can be searched in the SQL database.</td></tr>
    ///    <tr><td>IsSearchableWithLike</td><td>AsBoolean</td><td>Can be search with the SQL LIKE operator.</td></tr>
    ///    <tr><td>IsUnsigned</td><td>AsBoolean</td><td>Is an unsigned numeric.</td></tr>
    ///    <tr><td>MaximumScale</td><td>Int16</td><td>The maximum possible scale value.</td></tr>
    ///    <tr><td>MinimumScale</td><td>Int16</td><td>The minimum possible scale value.</td></tr>
    ///    <tr><td>IsConcurrencyType</td><td>AsBoolean</td><td>Has special update semantics.</td></tr>
    ///    <tr><td>MaximumVersion</td><td>AsString</td><td>The last database product version where this type was avaliable.</td></tr>
    ///    <tr><td>MinimumVersion</td><td>AsString</td><td>The first database product version where this type was available.</td></tr>
    ///    <tr><td>IsLiteralSupported</td><td>AsBoolean</td><td>Can be represented as a SQL literal.</td></tr>
    ///    <tr><td>LiteralPrefix</td><td>AsString</td><td>The prefix of a SQL literal.</td></tr>
    ///    <tr><td>LiteralSuffix</td><td>AsString</td><td>The suffix of a SQL literal.</td></tr>
    ///    <tr><td>IsUnicode</td><td>AsBoolean</td><td>Can hold unicode character data.</td></tr>
    ///    <tr><td>ProviderDbType</td><td>AsInt32</td><td>The same as the <c>DbxDataType</c> column. <br></br> Reserved for .NET applications.</td></tr>
    ///  </table>
    /// </summary>
    const DataTypes = 1;
    
    /// <summary> <p>This metadata collection represents catalogs in a database.</p>
    ///  <p>The columns are:</p>
    ///  <table cellspacing="0" cellpadding="4" border="1">
    ///    <tr><th align="left">Column Name</th><th align="left">Data Type</th><th align="left">Description</th></tr>
    ///    <tr><td>CatalogName</td><td>AsString</td><td>The catalog name.</td></tr>
    ///  </table>
    /// </summary>
    const Catalogs = 2;
    
    /// <summary> <p>This metadata collection represents schemas in a database.</p>
    ///  <p>The columns are:</p>
    ///  <table cellspacing="0" cellpadding="4" border="1">
    ///    <tr><th align="left">Column Name</th><th align="left">Data Type</th><th align="left">Description</th></tr>
    ///    <tr><td>CatalogName</td><td>AsString</td><td>The catalog name.</td></tr>
    ///    <tr><td>SchemaName</td><td>AsString</td><td>The schema name.</td></tr>
    ///  </table>
    /// </summary>
    const Schemas = 3;
    
    /// <summary> <p>This metadata collection represents tables in a database.</p>
    ///  <p>The columns are:</p>
    ///  <table cellspacing="0" cellpadding="4" border="1">
    ///    <tr><th align="left">Column Name</th><th align="left">Data Type</th><th align="left">Description</th></tr>
    ///    <tr><td>CatalogName</td><td>AsString</td><td>The catalog name.</td></tr>
    ///    <tr><td>SchemaName</td><td>AsString</td><td>The schema name.</td></tr>
    ///    <tr><td>TableName</td><td>AsString</td><td>The table name.</td></tr>
    ///    <tr><td>TableType</td><td>AsString</td><td>The table type: TABLE, VIEW, SYNONYM, SYSTEM_TABLE.</td></tr>
    ///  </table>
    /// </summary>
    const Tables = 4;
    
    /// <summary> <p>This metadata collection represents tables in a database.</p>
    ///  <p>The columns are:</p>
    ///  <table cellspacing="0" cellpadding="4" border="1">
    ///    <tr><th align="left">Column Name</th><th align="left">Data Type</th><th align="left">Description</th></tr>
    ///    <tr><td>CatalogName</td><td>AsString</td><td>The catalog name.</td></tr>
    ///    <tr><td>SchemaName</td><td>AsString</td><td>The schema name.</td></tr>
    ///    <tr><td>ViewName</td><td>AsString</td><td>The view name.</td></tr>
    ///    <tr><td>Definition</td><td>AsString</td><td>The SQL which was used to create the view.</td></tr>
    ///  </table>
    /// </summary>
    const Views = 5;
    
    /// <summary> <p>This metadata collection represents synonyms in a database.</p>
    ///  <p>The columns are:</p>
    ///  <table cellspacing="0" cellpadding="4" border="1">
    ///    <tr><th align="left">Column Name</th><th align="left">Data Type</th><th align="left">Description</th></tr>
    ///    <tr><td>CatalogName</td><td>AsString</td><td>The catalog name.</td></tr>
    ///    <tr><td>SchemaName</td><td>AsString</td><td>The schema name.</td></tr>
    ///    <tr><td>SynonymName</td><td>AsString</td><td>The synonym name.</td></tr>
    ///    <tr><td>TableCatalogName</td><td>AsString</td><td>The catalog name of the table this synonym refers to.</td></tr>
    ///    <tr><td>TableSchemaName</td><td>AsString</td><td>The schema name of the table this synonym refers to.</td></tr>
    ///    <tr><td>TableName</td><td>AsString</td><td>The name of the table this synonym refers to.</td></tr>
    ///  </table>
    /// </summary>
    const Synonyms = 6;
    
    /// <summary> <p>This metadata collection represents table columns in a database.</p>
    ///  <p>The columns are:</p>
    ///  <table cellspacing="0" cellpadding="4" border="1">
    ///    <tr><th align="left">Column Name</th><th align="left">Data Type</th><th align="left">Description</th></tr>
    ///    <tr><td>CatalogName</td><td>AsString</td><td>The catalog name.</td></tr>
    ///    <tr><td>SchemaName</td><td>AsString</td><td>The schema name.</td></tr>
    ///    <tr><td>TableName</td><td>AsString</td><td>The table name.</td></tr>
    ///    <tr><td>ColumnName</td><td>AsString</td><td>The column name.</td></tr>
    ///    <tr><td>TypeName</td><td>AsString</td><td>The database specific data type name.</td></tr>
    ///    <tr><td>Precision</td><td>AsInt32</td><td>The precision of this type.
    ///    <br></br> For a string data type, this is the maximum number of characters. <br></br> For a decimal types, this is the maximum number digits including digits from the scale.</td></tr>
    ///    <tr><td>Scale</td><td>AsInt32</td><td>The scale of a decimal type.</td></tr>
    ///    <tr><td>Ordinal</td><td>AsInt32</td><td>The position in the columns of the table starting with 1.</td></tr>
    ///    <tr><td>DefaultValue</td><td>AsString</td><td>The default value.</td></tr>
    ///    <tr><td>IsNullable</td><td>AsBoolean</td><td>Can accept NULL values.</td></tr>
    ///    <tr><td>IsAutoIncrement</td><td>AsBoolean</td><td>Is an autoincrement value.</td></tr>
    ///    <tr><td>MaxInline</td><td>AsInt32</td><td>The maximal number of bytes to write into row. The rest of the data is handled as a blob (BlackfishSQL only).</td></tr>
    ///    <tr><td>DbxDataType</td><td>AsInt32</td><td>The DBX data type.</td></tr>
    ///    <tr><td>IsFixedLength</td><td>AsBoolean</td><td>Holds fixed length data.</td></tr>
    ///    <tr><td>IsUnicode</td><td>AsBoolean</td><td>Can hold unicode characters.</td></tr>
    ///    <tr><td>IsLong</td><td>AsBoolean</td><td>Is a blob data type.</td></tr>
    ///    <tr><td>IsUnsigned</td><td>AsBoolean</td><td>Is an unsigned numeric type.</td></tr>
    ///  </table>
    /// </summary>
    const Columns = 7;
    
    /// <summary> <p>This metadata collection is only used internally.</p>
    ///  <p>The columns are:</p>
    ///  <table cellspacing="0" cellpadding="4" border="1">
    ///    <tr><th align="left">Column Name</th><th align="left">Data Type</th><th align="left">Description</th></tr>
    ///    <tr><td>CatalogName</td><td>AsString</td><td>The catalog name.</td></tr>
    ///    <tr><td>SchemaName</td><td>AsString</td><td>The schema name.</td></tr>
    ///    <tr><td>TableName</td><td>AsString</td><td>The table name.</td></tr>
    ///    <tr><td>ConstraintName</td><td>AsString</td><td>The constraint name.</td></tr>
    ///    <tr><td>ColumnName</td><td>AsString</td><td>The column name.</td></tr>
    ///  </table>
    /// </summary>
    const ColumnConstraints = 8;
    
    /// <summary> <p>This metadata collection represents table indexes in a database.</p>
    ///  <p>The columns are:</p>
    ///  <table cellspacing="0" cellpadding="4" border="1">
    ///    <tr><th align="left">Column Name</th><th align="left">Data Type</th><th align="left">Description</th></tr>
    ///    <tr><td>CatalogName</td><td>AsString</td><td>The catalog name.</td></tr>
    ///    <tr><td>SchemaName</td><td>AsString</td><td>The schema name.</td></tr>
    ///    <tr><td>TableName</td><td>AsString</td><td>The table name.</td></tr>
    ///    <tr><td>IndexName</td><td>AsString</td><td>The index name.</td></tr>
    ///    <tr><td>ConstraintName</td><td>AsString</td><td>The constraint name, may be NULL.</td></tr>
    ///    <tr><td>IsPrimary</td><td>AsBoolean</td><td>Is the primary key of the table.</td></tr>
    ///    <tr><td>IsUnique</td><td>AsBoolean</td><td>Is an unique index of the table.</td></tr>
    ///    <tr><td>IsAscending</td><td>AsBoolean</td><td>Is a descending index (Interbase only).</td></tr>
    ///  </table>
    /// </summary>
    const Indexes = 9;
    
    /// <summary> <p>This metadata collection represents index columns in a database.</p>
    ///  <p>The columns are:</p>
    ///  <table cellspacing="0" cellpadding="4" border="1">
    ///    <tr><th align="left">Column Name</th><th align="left">Data Type</th><th align="left">Description</th></tr>
    ///    <tr><td>CatalogName</td><td>AsString</td><td>The catalog name.</td></tr>
    ///    <tr><td>SchemaName</td><td>AsString</td><td>The schema name.</td></tr>
    ///    <tr><td>TableName</td><td>AsString</td><td>The table name.</td></tr>
    ///    <tr><td>IndexName</td><td>AsString</td><td>The index name.</td></tr>
    ///    <tr><td>ColumnName</td><td>AsString</td><td>A column in the index.</td></tr>
    ///    <tr><td>Ordinal</td><td>AsInt32</td><td>The position of the column in the index starting with 1.</td></tr>
    ///    <tr><td>IsAscending</td><td>AsBoolean</td><td>Is a descending index column.</td></tr>
    ///  </table>
    /// </summary>
    const IndexColumns = 10;
    
    /// <summary> <p>This metadata collection represents foreign keys in a database.</p>
    ///  <p>The columns are:</p>
    ///  <table cellspacing="0" cellpadding="4" border="1">
    ///    <tr><th align="left">Column Name</th><th align="left">Data Type</th><th align="left">Description</th></tr>
    ///    <tr><td>CatalogName</td><td>AsString</td><td>The catalog name.</td></tr>
    ///    <tr><td>SchemaName</td><td>AsString</td><td>The schema name.</td></tr>
    ///    <tr><td>TableName</td><td>AsString</td><td>The table name.</td></tr>
    ///    <tr><td>ForeignKeyName</td><td>AsString</td><td>The foreign key name.</td></tr>
    ///  </table>
    /// </summary>
    const ForeignKeys = 11;
    
    /// <summary> <p>This metadata collection represents foreign key columns in a database.</p>
    ///  <p>The columns are:</p>
    ///  <table cellspacing="0" cellpadding="4" border="1">
    ///    <tr><th align="left">Column Name</th><th align="left">Data Type</th><th align="left">Description</th></tr>
    ///    <tr><td>CatalogName</td><td>AsString</td><td>The catalog name of the table with the foreign key.</td></tr>
    ///    <tr><td>SchemaName</td><td>AsString</td><td>The schema name of the table with the foreign key.</td></tr>
    ///    <tr><td>TableName</td><td>AsString</td><td>The name of the table with the foreign key.</td></tr>
    ///    <tr><td>ForeignKeyName</td><td>AsString</td><td>The foreign key name.</td></tr>
    ///    <tr><td>ColumnName</td><td>AsString</td><td>A column which refers to a column of in another table.</td></tr>
    ///    <tr><td>PrimaryCatalogName</td><td>AsString</td><td>The catalog name of the table being referred to.</td></tr>
    ///    <tr><td>PrimarySchemaName</td><td>AsString</td><td>The schema name of the table being referred to.</td></tr>
    ///    <tr><td>PrimaryTableName</td><td>AsString</td><td>The name of the table being referred to.</td></tr>
    ///    <tr><td>PrimaryKeyName</td><td>AsString</td><td>The name of the key being referred to.
    ///    <br></br> This is usually the primary key.</td></tr>
    ///    <tr><td>PrimaryColumnName</td><td>AsString</td><td>The column which is being referred to.</td></tr>
    ///    <tr><td>Ordinal</td><td>AsInt32</td><td>The position of the column reference in the foreign key.</td></tr>
    ///  </table>
    /// </summary>
    const ForeignKeyColumns = 12;
    
    /// <summary> <p>This metadata collection represents procedures in a database.</p>
    ///  <p>The columns are:</p>
    ///  <table cellspacing="0" cellpadding="4" border="1">
    ///    <tr><th align="left">Column Name</th><th align="left">Data Type</th><th align="left">Description</th></tr>
    ///    <tr><td>CatalogName</td><td>AsString</td><td>The catalog name.</td></tr>
    ///    <tr><td>SchemaName</td><td>AsString</td><td>The schema name.</td></tr>
    ///    <tr><td>ProcedureName</td><td>AsString</td><td>The procedure name.</td></tr>
    ///    <tr><td>ProcedureType</td><td>AsString</td><td>The procedure type: FUNCTION or PROCEDURE.</td></tr>
    ///  </table>
    /// </summary>
    const Procedures = 13;
    
    /// <summary> <p>This metadata collection represents procedure source code in a database.</p>
    ///  <p>The columns are:</p>
    ///  <table cellspacing="0" cellpadding="4" border="1">
    ///    <tr><th align="left">Column Name</th><th align="left">Data Type</th><th align="left">Description</th></tr>
    ///    <tr><td>CatalogName</td><td>AsString</td><td>The catalog name.</td></tr>
    ///    <tr><td>SchemaName</td><td>AsString</td><td>The schema name.</td></tr>
    ///    <tr><td>ProcedureName</td><td>AsString</td><td>The procedure name.</td></tr>
    ///    <tr><td>ProcedureType</td><td>AsString</td><td>The procedure type: FUNCTION or PROCEDURE.</td></tr>
    ///    <tr><td>Definition</td><td>AsString</td><td>The source of the SQL procedure.</td></tr>
    ///    <tr><td>ExternalDefinition</td><td>AsString</td><td>A reference to an procedure external to the database.</td></tr>
    ///  </table>
    /// </summary>
    const ProcedureSources = 14;
    
    /// <summary> <p>This metadata collection represents procedure parameters in a database.</p>
    ///  <p>The columns are:</p>
    ///  <table cellspacing="0" cellpadding="4" border="1">
    ///    <tr><th align="left">Column Name</th><th align="left">Data Type</th><th align="left">Description</th></tr>
    ///    <tr><td>CatalogName</td><td>AsString</td><td>The catalog name.</td></tr>
    ///    <tr><td>SchemaName</td><td>AsString</td><td>The schema name.</td></tr>
    ///    <tr><td>ProcedureName</td><td>AsString</td><td>The procedure name.</td></tr>
    ///    <tr><td>ParameterName</td><td>AsString</td><td>The parameter name.</td></tr>
    ///    <tr><td>ParameterMode</td><td>AsString</td><td>The parameter mode: IN, OUT, INOUT, RESULT.</td></tr>
    ///    <tr><td>TypeName</td><td>AsString</td><td>The database specific data type name.</td></tr>
    ///    <tr><td>Precision</td><td>AsInt32</td><td>The precision of this type.
    ///    <br></br> For a string data type, this is the maximum number of characters. <br></br> For a decimal types, this is the maximum number digits including digits from the scale.</td></tr>
    ///    <tr><td>Scale</td><td>AsInt32</td><td>The scale of a decimal type.</td></tr>
    ///    <tr><td>Ordinal</td><td>AsInt32</td><td>The position in the rows of the table starting with 1.</td></tr>
    ///    <tr><td>IsNullable</td><td>AsBoolean</td><td>Can accept NULL values.</td></tr>
    ///    <tr><td>DbxDataType</td><td>AsInt32</td><td>The DBX data type.</td></tr>
    ///    <tr><td>IsFixedLength</td><td>AsBoolean</td><td>Holds fixed length data.</td></tr>
    ///    <tr><td>IsUnicode</td><td>AsBoolean</td><td>Can hold unicode characters.</td></tr>
    ///    <tr><td>IsLong</td><td>AsBoolean</td><td>Is blob data type.</td></tr>
    ///    <tr><td>IsUnsigned</td><td>AsBoolean</td><td>Is unsigned numeric type.</td></tr>
    ///  </table>
    /// </summary>
    const ProcedureParameters = 15;
    
    /// <summary> <p>This metadata collection represents packages in a database.</p>
    ///  <p>The columns are:</p>
    ///  <table cellspacing="0" cellpadding="4" border="1">
    ///    <tr><th align="left">Column Name</th><th align="left">Data Type</th><th align="left">Description</th></tr>
    ///    <tr><td>CatalogName</td><td>AsString</td><td>The catalog name.</td></tr>
    ///    <tr><td>SchemaName</td><td>AsString</td><td>The schema name.</td></tr>
    ///    <tr><td>PackageName</td><td>AsString</td><td>The package name.</td></tr>
    ///  </table>
    /// </summary>
    const Packages = 16;
    
    /// <summary> <p>This metadata collection represents package procedures in a database.</p>
    ///  <p>The columns are:</p>
    ///  <table cellspacing="0" cellpadding="4" border="1">
    ///    <tr><th align="left">Column Name</th><th align="left">Data Type</th><th align="left">Description</th></tr>
    ///    <tr><td>CatalogName</td><td>AsString</td><td>The catalog name.</td></tr>
    ///    <tr><td>SchemaName</td><td>AsString</td><td>The schema name.</td></tr>
    ///    <tr><td>PackageName</td><td>AsString</td><td>The package name.</td></tr>
    ///    <tr><td>ProcedureName</td><td>AsString</td><td>The procedure name from the package.</td></tr>
    ///    <tr><td>ProcedureType</td><td>AsString</td><td>The procedure type: FUNCTION, PROCEDURE.</td></tr>
    ///  </table>
    /// </summary>
    const PackageProcedures = 17;
    
    /// <summary> <p>This metadata collection represents package procedure parameters in a database.</p>
    ///  <p>The columns are:</p>
    ///  <table cellspacing="0" cellpadding="4" border="1">
    ///    <tr><th align="left">Column Name</th><th align="left">Data Type</th><th align="left">Description</th></tr>
    ///    <tr><td>CatalogName</td><td>AsString</td><td>The catalog name.</td></tr>
    ///    <tr><td>SchemaName</td><td>AsString</td><td>The schema name.</td></tr>
    ///    <tr><td>PackageName</td><td>AsString</td><td>The package name.</td></tr>
    ///    <tr><td>ProcedureName</td><td>AsString</td><td>The procedure name from the package.</td></tr>
    ///    <tr><td>ParameterName</td><td>AsString</td><td>The parameter name.</td></tr>
    ///    <tr><td>ParameterMode</td><td>AsString</td><td>The parameter mode: IN, OUT, INOUT, RESULT.</td></tr>
    ///    <tr><td>TypeName</td><td>AsString</td><td>The database specific data type name.</td></tr>
    ///    <tr><td>Precision</td><td>AsInt32</td><td>The precision of this type.
    ///    <br></br> For a string data type, this is the maximum number of characters. <br></br> For a decimal types, this is the maximum number digits including digits from the scale.</td></tr>
    ///    <tr><td>Scale</td><td>AsInt32</td><td>The scale of a decimal type.</td></tr>
    ///    <tr><td>Ordinal</td><td>AsInt32</td><td>The position in the rows of the table starting with 1.</td></tr>
    ///    <tr><td>IsNullable</td><td>AsBoolean</td><td>Can accept NULL values.</td></tr>
    ///    <tr><td>DbxDataType</td><td>AsInt32</td><td>The DBX data type.</td></tr>
    ///    <tr><td>IsFixedLength</td><td>AsBoolean</td><td>Holds fixed length data.</td></tr>
    ///    <tr><td>IsUnicode</td><td>AsBoolean</td><td>Can hold unicode characters.</td></tr>
    ///    <tr><td>IsLong</td><td>AsBoolean</td><td>Is blob data type.</td></tr>
    ///    <tr><td>IsUnsigned</td><td>AsBoolean</td><td>Is unsigned numeric type.</td></tr>
    ///  </table>
    /// </summary>
    const PackageProcedureParameters = 18;
    
    /// <summary> <p>This metadata collection represents package source code in a database.</p>
    ///  <p>The columns are:</p>
    ///  <table cellspacing="0" cellpadding="4" border="1">
    ///    <tr><th align="left">Column Name</th><th align="left">Data Type</th><th align="left">Description</th></tr>
    ///    <tr><td>CatalogName</td><td>AsString</td><td>The catalog name.</td></tr>
    ///    <tr><td>SchemaName</td><td>AsString</td><td>The schema name.</td></tr>
    ///    <tr><td>PackageName</td><td>AsString</td><td>The package name.</td></tr>
    ///    <tr><td>Definition</td><td>AsString</td><td>The package source code.</td></tr>
    ///  </table>
    /// </summary>
    const PackageSources = 19;
    
    /// <summary> <p>This metadata collection represents users in a database.</p>
    ///  <p>The columns are:</p>
    ///  <table cellspacing="0" cellpadding="4" border="1">
    ///    <tr><th align="left">Column Name</th><th align="left">Data Type</th><th align="left">Description</th></tr>
    ///    <tr><td>UserName</td><td>AsString</td><td>A user name.</td></tr>
    ///  </table>
    /// </summary>
    const Users = 20;
    
    /// <summary> <p>This metadata collection represents roles in a database.</p>
    ///  <p>The columns are:</p>
    ///  <table cellspacing="0" cellpadding="4" border="1">
    ///    <tr><th align="left">Column Name</th><th align="left">Data Type</th><th align="left">Description</th></tr>
    ///    <tr><td>RoleName</td><td>AsString</td><td>A role name.</td></tr>
    ///  </table>
    /// </summary>
    const Roles = 21;
    
    /// <summary> <p>This metadata collection represents reserved words in a database.</p>
    ///  <p>The columns are:</p>
    ///  <table cellspacing="0" cellpadding="4" border="1">
    ///    <tr><th align="left">Column Name</th><th align="left">Data Type</th><th align="left">Description</th></tr>
    ///    <tr><td>ReservedWord</td><td>AsString</td><td>An identifier reserved for the SQL syntax.
    ///    <br></br> These identifiers should not be used as object names such as tables and columns. Some databases allows their use if they are quoted.</td></tr>
    ///  </table>
    /// </summary>
    const ReservedWords = 22;
  end;

  TDBXMetaDataCollectionName = class
  public
    
    /// <summary> <p>This metadata collection represents the data types supported by a specific database.</p>
    ///  <p>The columns are:</p>
    ///  <table cellspacing="0" cellpadding="4" border="1">
    ///    <tr><th align="left">Column Name</th><th align="left">Data Type</th><th align="left">Description</th></tr>
    ///    <tr><td>TypeName</td><td>AsString</td><td>The database specific data type name.</td></tr>
    ///    <tr><td>DbxDataType</td><td>AsInt32</td><td>The DBX data type.</td></tr>
    ///    <tr><td>ColumnSize</td><td>Int64</td><td>The length of this type.
    ///    <br></br> For a string data type, this is the maximum number of characters. <br></br> For a floating point number, this is the number of significant bits in the mantissa. <br></br> For other numeric types, this is the maximum number of significant digits. <br></br> For a date, time, and timestamp types, this is the length of the string representation.</td></tr>
    ///    <tr><td>CreateFormat</td><td>AsString</td><td>The create format as used in CREATE TABLE.</td></tr>
    ///    <tr><td>CreateParameters</td><td>AsString</td><td>The parameters for the create format.</td></tr>
    ///    <tr><td>DataType</td><td>AsString</td><td>The name of the language type representing this data type.</td></tr>
    ///    <tr><td>IsAutoIncrementable</td><td>AsBoolean</td><td>Can be used as for an autoincrement column.</td></tr>
    ///    <tr><td>IsBestMatch</td><td>AsBoolean</td><td>Is the best match for the language type.</td></tr>
    ///    <tr><td>IsCaseSensitive</td><td>AsBoolean</td><td>Is case sensitive.</td></tr>
    ///    <tr><td>IsFixedLength</td><td>AsBoolean</td><td>Is fixed length.</td></tr>
    ///    <tr><td>IsFixedPrecisionScale</td><td>AsBoolean</td><td>Is an exact numeric.</td></tr>
    ///    <tr><td>IsLong</td><td>AsBoolean</td><td>Is a blob type.</td></tr>
    ///    <tr><td>IsNullable</td><td>AsBoolean</td><td>Can be assigned a value of NULL.</td></tr>
    ///    <tr><td>IsSearchable</td><td>AsBoolean</td><td>Can be searched in the SQL database.</td></tr>
    ///    <tr><td>IsSearchableWithLike</td><td>AsBoolean</td><td>Can be search with the SQL LIKE operator.</td></tr>
    ///    <tr><td>IsUnsigned</td><td>AsBoolean</td><td>Is an unsigned numeric.</td></tr>
    ///    <tr><td>MaximumScale</td><td>Int16</td><td>The maximum possible scale value.</td></tr>
    ///    <tr><td>MinimumScale</td><td>Int16</td><td>The minimum possible scale value.</td></tr>
    ///    <tr><td>IsConcurrencyType</td><td>AsBoolean</td><td>Has special update semantics.</td></tr>
    ///    <tr><td>MaximumVersion</td><td>AsString</td><td>The last database product version where this type was avaliable.</td></tr>
    ///    <tr><td>MinimumVersion</td><td>AsString</td><td>The first database product version where this type was available.</td></tr>
    ///    <tr><td>IsLiteralSupported</td><td>AsBoolean</td><td>Can be represented as a SQL literal.</td></tr>
    ///    <tr><td>LiteralPrefix</td><td>AsString</td><td>The prefix of a SQL literal.</td></tr>
    ///    <tr><td>LiteralSuffix</td><td>AsString</td><td>The suffix of a SQL literal.</td></tr>
    ///    <tr><td>IsUnicode</td><td>AsBoolean</td><td>Can hold unicode character data.</td></tr>
    ///    <tr><td>ProviderDbType</td><td>AsInt32</td><td>The same as the <c>DbxDataType</c> column. <br></br> Reserved for .NET applications.</td></tr>
    ///  </table>
    /// </summary>
    const DataTypes = 'DataTypes';
    
    /// <summary> <p>This metadata collection represents catalogs in a database.</p>
    ///  <p>The columns are:</p>
    ///  <table cellspacing="0" cellpadding="4" border="1">
    ///    <tr><th align="left">Column Name</th><th align="left">Data Type</th><th align="left">Description</th></tr>
    ///    <tr><td>CatalogName</td><td>AsString</td><td>The catalog name.</td></tr>
    ///  </table>
    /// </summary>
    const Catalogs = 'Catalogs';
    
    /// <summary> <p>This metadata collection represents schemas in a database.</p>
    ///  <p>The columns are:</p>
    ///  <table cellspacing="0" cellpadding="4" border="1">
    ///    <tr><th align="left">Column Name</th><th align="left">Data Type</th><th align="left">Description</th></tr>
    ///    <tr><td>CatalogName</td><td>AsString</td><td>The catalog name.</td></tr>
    ///    <tr><td>SchemaName</td><td>AsString</td><td>The schema name.</td></tr>
    ///  </table>
    /// </summary>
    const Schemas = 'Schemas';
    
    /// <summary> <p>This metadata collection represents tables in a database.</p>
    ///  <p>The columns are:</p>
    ///  <table cellspacing="0" cellpadding="4" border="1">
    ///    <tr><th align="left">Column Name</th><th align="left">Data Type</th><th align="left">Description</th></tr>
    ///    <tr><td>CatalogName</td><td>AsString</td><td>The catalog name.</td></tr>
    ///    <tr><td>SchemaName</td><td>AsString</td><td>The schema name.</td></tr>
    ///    <tr><td>TableName</td><td>AsString</td><td>The table name.</td></tr>
    ///    <tr><td>TableType</td><td>AsString</td><td>The table type: TABLE, VIEW, SYNONYM, SYSTEM_TABLE.</td></tr>
    ///  </table>
    /// </summary>
    const Tables = 'Tables';
    
    /// <summary> <p>This metadata collection represents tables in a database.</p>
    ///  <p>The columns are:</p>
    ///  <table cellspacing="0" cellpadding="4" border="1">
    ///    <tr><th align="left">Column Name</th><th align="left">Data Type</th><th align="left">Description</th></tr>
    ///    <tr><td>CatalogName</td><td>AsString</td><td>The catalog name.</td></tr>
    ///    <tr><td>SchemaName</td><td>AsString</td><td>The schema name.</td></tr>
    ///    <tr><td>ViewName</td><td>AsString</td><td>The view name.</td></tr>
    ///    <tr><td>Definition</td><td>AsString</td><td>The SQL which was used to create the view.</td></tr>
    ///  </table>
    /// </summary>
    const Views = 'Views';
    
    /// <summary> <p>This metadata collection represents synonyms in a database.</p>
    ///  <p>The columns are:</p>
    ///  <table cellspacing="0" cellpadding="4" border="1">
    ///    <tr><th align="left">Column Name</th><th align="left">Data Type</th><th align="left">Description</th></tr>
    ///    <tr><td>CatalogName</td><td>AsString</td><td>The catalog name.</td></tr>
    ///    <tr><td>SchemaName</td><td>AsString</td><td>The schema name.</td></tr>
    ///    <tr><td>SynonymName</td><td>AsString</td><td>The synonym name.</td></tr>
    ///    <tr><td>TableCatalogName</td><td>AsString</td><td>The catalog name of the table this synonym refers to.</td></tr>
    ///    <tr><td>TableSchemaName</td><td>AsString</td><td>The schema name of the table this synonym refers to.</td></tr>
    ///    <tr><td>TableName</td><td>AsString</td><td>The name of the table this synonym refers to.</td></tr>
    ///  </table>
    /// </summary>
    const Synonyms = 'Synonyms';
    
    /// <summary> <p>This metadata collection represents table columns in a database.</p>
    ///  <p>The columns are:</p>
    ///  <table cellspacing="0" cellpadding="4" border="1">
    ///    <tr><th align="left">Column Name</th><th align="left">Data Type</th><th align="left">Description</th></tr>
    ///    <tr><td>CatalogName</td><td>AsString</td><td>The catalog name.</td></tr>
    ///    <tr><td>SchemaName</td><td>AsString</td><td>The schema name.</td></tr>
    ///    <tr><td>TableName</td><td>AsString</td><td>The table name.</td></tr>
    ///    <tr><td>ColumnName</td><td>AsString</td><td>The column name.</td></tr>
    ///    <tr><td>TypeName</td><td>AsString</td><td>The database specific data type name.</td></tr>
    ///    <tr><td>Precision</td><td>AsInt32</td><td>The precision of this type.
    ///    <br></br> For a string data type, this is the maximum number of characters. <br></br> For a decimal types, this is the maximum number digits including digits from the scale.</td></tr>
    ///    <tr><td>Scale</td><td>AsInt32</td><td>The scale of a decimal type.</td></tr>
    ///    <tr><td>Ordinal</td><td>AsInt32</td><td>The position in the columns of the table starting with 1.</td></tr>
    ///    <tr><td>DefaultValue</td><td>AsString</td><td>The default value.</td></tr>
    ///    <tr><td>IsNullable</td><td>AsBoolean</td><td>Can accept NULL values.</td></tr>
    ///    <tr><td>IsAutoIncrement</td><td>AsBoolean</td><td>Is an autoincrement value.</td></tr>
    ///    <tr><td>MaxInline</td><td>AsInt32</td><td>The maximal number of bytes to write into row. The rest of the data is handled as a blob (BlackfishSQL only).</td></tr>
    ///    <tr><td>DbxDataType</td><td>AsInt32</td><td>The DBX data type.</td></tr>
    ///    <tr><td>IsFixedLength</td><td>AsBoolean</td><td>Holds fixed length data.</td></tr>
    ///    <tr><td>IsUnicode</td><td>AsBoolean</td><td>Can hold unicode characters.</td></tr>
    ///    <tr><td>IsLong</td><td>AsBoolean</td><td>Is a blob data type.</td></tr>
    ///    <tr><td>IsUnsigned</td><td>AsBoolean</td><td>Is an unsigned numeric type.</td></tr>
    ///  </table>
    /// </summary>
    const Columns = 'Columns';
    
    /// <summary> <p>This metadata collection is only used internally.</p>
    ///  <p>The columns are:</p>
    ///  <table cellspacing="0" cellpadding="4" border="1">
    ///    <tr><th align="left">Column Name</th><th align="left">Data Type</th><th align="left">Description</th></tr>
    ///    <tr><td>CatalogName</td><td>AsString</td><td>The catalog name.</td></tr>
    ///    <tr><td>SchemaName</td><td>AsString</td><td>The schema name.</td></tr>
    ///    <tr><td>TableName</td><td>AsString</td><td>The table name.</td></tr>
    ///    <tr><td>ConstraintName</td><td>AsString</td><td>The constraint name.</td></tr>
    ///    <tr><td>ColumnName</td><td>AsString</td><td>The column name.</td></tr>
    ///  </table>
    /// </summary>
    const ColumnConstraints = 'ColumnConstraints';
    
    /// <summary> <p>This metadata collection represents table indexes in a database.</p>
    ///  <p>The columns are:</p>
    ///  <table cellspacing="0" cellpadding="4" border="1">
    ///    <tr><th align="left">Column Name</th><th align="left">Data Type</th><th align="left">Description</th></tr>
    ///    <tr><td>CatalogName</td><td>AsString</td><td>The catalog name.</td></tr>
    ///    <tr><td>SchemaName</td><td>AsString</td><td>The schema name.</td></tr>
    ///    <tr><td>TableName</td><td>AsString</td><td>The table name.</td></tr>
    ///    <tr><td>IndexName</td><td>AsString</td><td>The index name.</td></tr>
    ///    <tr><td>ConstraintName</td><td>AsString</td><td>The constraint name, may be NULL.</td></tr>
    ///    <tr><td>IsPrimary</td><td>AsBoolean</td><td>Is the primary key of the table.</td></tr>
    ///    <tr><td>IsUnique</td><td>AsBoolean</td><td>Is an unique index of the table.</td></tr>
    ///    <tr><td>IsAscending</td><td>AsBoolean</td><td>Is a descending index (Interbase only).</td></tr>
    ///  </table>
    /// </summary>
    const Indexes = 'Indexes';
    
    /// <summary> <p>This metadata collection represents index columns in a database.</p>
    ///  <p>The columns are:</p>
    ///  <table cellspacing="0" cellpadding="4" border="1">
    ///    <tr><th align="left">Column Name</th><th align="left">Data Type</th><th align="left">Description</th></tr>
    ///    <tr><td>CatalogName</td><td>AsString</td><td>The catalog name.</td></tr>
    ///    <tr><td>SchemaName</td><td>AsString</td><td>The schema name.</td></tr>
    ///    <tr><td>TableName</td><td>AsString</td><td>The table name.</td></tr>
    ///    <tr><td>IndexName</td><td>AsString</td><td>The index name.</td></tr>
    ///    <tr><td>ColumnName</td><td>AsString</td><td>A column in the index.</td></tr>
    ///    <tr><td>Ordinal</td><td>AsInt32</td><td>The position of the column in the index starting with 1.</td></tr>
    ///    <tr><td>IsAscending</td><td>AsBoolean</td><td>Is a descending index column.</td></tr>
    ///  </table>
    /// </summary>
    const IndexColumns = 'IndexColumns';
    
    /// <summary> <p>This metadata collection represents foreign keys in a database.</p>
    ///  <p>The columns are:</p>
    ///  <table cellspacing="0" cellpadding="4" border="1">
    ///    <tr><th align="left">Column Name</th><th align="left">Data Type</th><th align="left">Description</th></tr>
    ///    <tr><td>CatalogName</td><td>AsString</td><td>The catalog name.</td></tr>
    ///    <tr><td>SchemaName</td><td>AsString</td><td>The schema name.</td></tr>
    ///    <tr><td>TableName</td><td>AsString</td><td>The table name.</td></tr>
    ///    <tr><td>ForeignKeyName</td><td>AsString</td><td>The foreign key name.</td></tr>
    ///  </table>
    /// </summary>
    const ForeignKeys = 'ForeignKeys';
    
    /// <summary> <p>This metadata collection represents foreign key columns in a database.</p>
    ///  <p>The columns are:</p>
    ///  <table cellspacing="0" cellpadding="4" border="1">
    ///    <tr><th align="left">Column Name</th><th align="left">Data Type</th><th align="left">Description</th></tr>
    ///    <tr><td>CatalogName</td><td>AsString</td><td>The catalog name of the table with the foreign key.</td></tr>
    ///    <tr><td>SchemaName</td><td>AsString</td><td>The schema name of the table with the foreign key.</td></tr>
    ///    <tr><td>TableName</td><td>AsString</td><td>The name of the table with the foreign key.</td></tr>
    ///    <tr><td>ForeignKeyName</td><td>AsString</td><td>The foreign key name.</td></tr>
    ///    <tr><td>ColumnName</td><td>AsString</td><td>A column which refers to a column of in another table.</td></tr>
    ///    <tr><td>PrimaryCatalogName</td><td>AsString</td><td>The catalog name of the table being referred to.</td></tr>
    ///    <tr><td>PrimarySchemaName</td><td>AsString</td><td>The schema name of the table being referred to.</td></tr>
    ///    <tr><td>PrimaryTableName</td><td>AsString</td><td>The name of the table being referred to.</td></tr>
    ///    <tr><td>PrimaryKeyName</td><td>AsString</td><td>The name of the key being referred to.
    ///    <br></br> This is usually the primary key.</td></tr>
    ///    <tr><td>PrimaryColumnName</td><td>AsString</td><td>The column which is being referred to.</td></tr>
    ///    <tr><td>Ordinal</td><td>AsInt32</td><td>The position of the column reference in the foreign key.</td></tr>
    ///  </table>
    /// </summary>
    const ForeignKeyColumns = 'ForeignKeyColumns';
    
    /// <summary> <p>This metadata collection represents procedures in a database.</p>
    ///  <p>The columns are:</p>
    ///  <table cellspacing="0" cellpadding="4" border="1">
    ///    <tr><th align="left">Column Name</th><th align="left">Data Type</th><th align="left">Description</th></tr>
    ///    <tr><td>CatalogName</td><td>AsString</td><td>The catalog name.</td></tr>
    ///    <tr><td>SchemaName</td><td>AsString</td><td>The schema name.</td></tr>
    ///    <tr><td>ProcedureName</td><td>AsString</td><td>The procedure name.</td></tr>
    ///    <tr><td>ProcedureType</td><td>AsString</td><td>The procedure type: FUNCTION or PROCEDURE.</td></tr>
    ///  </table>
    /// </summary>
    const Procedures = 'Procedures';
    
    /// <summary> <p>This metadata collection represents procedure source code in a database.</p>
    ///  <p>The columns are:</p>
    ///  <table cellspacing="0" cellpadding="4" border="1">
    ///    <tr><th align="left">Column Name</th><th align="left">Data Type</th><th align="left">Description</th></tr>
    ///    <tr><td>CatalogName</td><td>AsString</td><td>The catalog name.</td></tr>
    ///    <tr><td>SchemaName</td><td>AsString</td><td>The schema name.</td></tr>
    ///    <tr><td>ProcedureName</td><td>AsString</td><td>The procedure name.</td></tr>
    ///    <tr><td>ProcedureType</td><td>AsString</td><td>The procedure type: FUNCTION or PROCEDURE.</td></tr>
    ///    <tr><td>Definition</td><td>AsString</td><td>The source of the SQL procedure.</td></tr>
    ///    <tr><td>ExternalDefinition</td><td>AsString</td><td>A reference to an procedure external to the database.</td></tr>
    ///  </table>
    /// </summary>
    const ProcedureSources = 'ProcedureSources';
    
    /// <summary> <p>This metadata collection represents procedure parameters in a database.</p>
    ///  <p>The columns are:</p>
    ///  <table cellspacing="0" cellpadding="4" border="1">
    ///    <tr><th align="left">Column Name</th><th align="left">Data Type</th><th align="left">Description</th></tr>
    ///    <tr><td>CatalogName</td><td>AsString</td><td>The catalog name.</td></tr>
    ///    <tr><td>SchemaName</td><td>AsString</td><td>The schema name.</td></tr>
    ///    <tr><td>ProcedureName</td><td>AsString</td><td>The procedure name.</td></tr>
    ///    <tr><td>ParameterName</td><td>AsString</td><td>The parameter name.</td></tr>
    ///    <tr><td>ParameterMode</td><td>AsString</td><td>The parameter mode: IN, OUT, INOUT, RESULT.</td></tr>
    ///    <tr><td>TypeName</td><td>AsString</td><td>The database specific data type name.</td></tr>
    ///    <tr><td>Precision</td><td>AsInt32</td><td>The precision of this type.
    ///    <br></br> For a string data type, this is the maximum number of characters. <br></br> For a decimal types, this is the maximum number digits including digits from the scale.</td></tr>
    ///    <tr><td>Scale</td><td>AsInt32</td><td>The scale of a decimal type.</td></tr>
    ///    <tr><td>Ordinal</td><td>AsInt32</td><td>The position in the rows of the table starting with 1.</td></tr>
    ///    <tr><td>IsNullable</td><td>AsBoolean</td><td>Can accept NULL values.</td></tr>
    ///    <tr><td>DbxDataType</td><td>AsInt32</td><td>The DBX data type.</td></tr>
    ///    <tr><td>IsFixedLength</td><td>AsBoolean</td><td>Holds fixed length data.</td></tr>
    ///    <tr><td>IsUnicode</td><td>AsBoolean</td><td>Can hold unicode characters.</td></tr>
    ///    <tr><td>IsLong</td><td>AsBoolean</td><td>Is blob data type.</td></tr>
    ///    <tr><td>IsUnsigned</td><td>AsBoolean</td><td>Is unsigned numeric type.</td></tr>
    ///  </table>
    /// </summary>
    const ProcedureParameters = 'ProcedureParameters';
    
    /// <summary> <p>This metadata collection represents packages in a database.</p>
    ///  <p>The columns are:</p>
    ///  <table cellspacing="0" cellpadding="4" border="1">
    ///    <tr><th align="left">Column Name</th><th align="left">Data Type</th><th align="left">Description</th></tr>
    ///    <tr><td>CatalogName</td><td>AsString</td><td>The catalog name.</td></tr>
    ///    <tr><td>SchemaName</td><td>AsString</td><td>The schema name.</td></tr>
    ///    <tr><td>PackageName</td><td>AsString</td><td>The package name.</td></tr>
    ///  </table>
    /// </summary>
    const Packages = 'Packages';
    
    /// <summary> <p>This metadata collection represents package procedures in a database.</p>
    ///  <p>The columns are:</p>
    ///  <table cellspacing="0" cellpadding="4" border="1">
    ///    <tr><th align="left">Column Name</th><th align="left">Data Type</th><th align="left">Description</th></tr>
    ///    <tr><td>CatalogName</td><td>AsString</td><td>The catalog name.</td></tr>
    ///    <tr><td>SchemaName</td><td>AsString</td><td>The schema name.</td></tr>
    ///    <tr><td>PackageName</td><td>AsString</td><td>The package name.</td></tr>
    ///    <tr><td>ProcedureName</td><td>AsString</td><td>The procedure name from the package.</td></tr>
    ///    <tr><td>ProcedureType</td><td>AsString</td><td>The procedure type: FUNCTION, PROCEDURE.</td></tr>
    ///  </table>
    /// </summary>
    const PackageProcedures = 'PackageProcedures';
    
    /// <summary> <p>This metadata collection represents package procedure parameters in a database.</p>
    ///  <p>The columns are:</p>
    ///  <table cellspacing="0" cellpadding="4" border="1">
    ///    <tr><th align="left">Column Name</th><th align="left">Data Type</th><th align="left">Description</th></tr>
    ///    <tr><td>CatalogName</td><td>AsString</td><td>The catalog name.</td></tr>
    ///    <tr><td>SchemaName</td><td>AsString</td><td>The schema name.</td></tr>
    ///    <tr><td>PackageName</td><td>AsString</td><td>The package name.</td></tr>
    ///    <tr><td>ProcedureName</td><td>AsString</td><td>The procedure name from the package.</td></tr>
    ///    <tr><td>ParameterName</td><td>AsString</td><td>The parameter name.</td></tr>
    ///    <tr><td>ParameterMode</td><td>AsString</td><td>The parameter mode: IN, OUT, INOUT, RESULT.</td></tr>
    ///    <tr><td>TypeName</td><td>AsString</td><td>The database specific data type name.</td></tr>
    ///    <tr><td>Precision</td><td>AsInt32</td><td>The precision of this type.
    ///    <br></br> For a string data type, this is the maximum number of characters. <br></br> For a decimal types, this is the maximum number digits including digits from the scale.</td></tr>
    ///    <tr><td>Scale</td><td>AsInt32</td><td>The scale of a decimal type.</td></tr>
    ///    <tr><td>Ordinal</td><td>AsInt32</td><td>The position in the rows of the table starting with 1.</td></tr>
    ///    <tr><td>IsNullable</td><td>AsBoolean</td><td>Can accept NULL values.</td></tr>
    ///    <tr><td>DbxDataType</td><td>AsInt32</td><td>The DBX data type.</td></tr>
    ///    <tr><td>IsFixedLength</td><td>AsBoolean</td><td>Holds fixed length data.</td></tr>
    ///    <tr><td>IsUnicode</td><td>AsBoolean</td><td>Can hold unicode characters.</td></tr>
    ///    <tr><td>IsLong</td><td>AsBoolean</td><td>Is blob data type.</td></tr>
    ///    <tr><td>IsUnsigned</td><td>AsBoolean</td><td>Is unsigned numeric type.</td></tr>
    ///  </table>
    /// </summary>
    const PackageProcedureParameters = 'PackageProcedureParameters';
    
    /// <summary> <p>This metadata collection represents package source code in a database.</p>
    ///  <p>The columns are:</p>
    ///  <table cellspacing="0" cellpadding="4" border="1">
    ///    <tr><th align="left">Column Name</th><th align="left">Data Type</th><th align="left">Description</th></tr>
    ///    <tr><td>CatalogName</td><td>AsString</td><td>The catalog name.</td></tr>
    ///    <tr><td>SchemaName</td><td>AsString</td><td>The schema name.</td></tr>
    ///    <tr><td>PackageName</td><td>AsString</td><td>The package name.</td></tr>
    ///    <tr><td>Definition</td><td>AsString</td><td>The package source code.</td></tr>
    ///  </table>
    /// </summary>
    const PackageSources = 'PackageSources';
    
    /// <summary> <p>This metadata collection represents users in a database.</p>
    ///  <p>The columns are:</p>
    ///  <table cellspacing="0" cellpadding="4" border="1">
    ///    <tr><th align="left">Column Name</th><th align="left">Data Type</th><th align="left">Description</th></tr>
    ///    <tr><td>UserName</td><td>AsString</td><td>A user name.</td></tr>
    ///  </table>
    /// </summary>
    const Users = 'Users';
    
    /// <summary> <p>This metadata collection represents roles in a database.</p>
    ///  <p>The columns are:</p>
    ///  <table cellspacing="0" cellpadding="4" border="1">
    ///    <tr><th align="left">Column Name</th><th align="left">Data Type</th><th align="left">Description</th></tr>
    ///    <tr><td>RoleName</td><td>AsString</td><td>A role name.</td></tr>
    ///  </table>
    /// </summary>
    const Roles = 'Roles';
    
    /// <summary> <p>This metadata collection represents reserved words in a database.</p>
    ///  <p>The columns are:</p>
    ///  <table cellspacing="0" cellpadding="4" border="1">
    ///    <tr><th align="left">Column Name</th><th align="left">Data Type</th><th align="left">Description</th></tr>
    ///    <tr><td>ReservedWord</td><td>AsString</td><td>An identifier reserved for the SQL syntax.
    ///    <br></br> These identifiers should not be used as object names such as tables and columns. Some databases allows their use if they are quoted.</td></tr>
    ///  </table>
    /// </summary>
    const ReservedWords = 'ReservedWords';
  end;

  TDBXPackageProcedureParametersColumns = class
  public
    
    /// <summary>  <p>Used to access the <c>CatalogName</c> column in the <c>PackageProcedureParameters</c> metadata collection.</p>
    ///   <p>The data in this column specifies the catalog name.</p>
    /// </summary>
    const CatalogName = 'CatalogName';
    
    /// <summary>  <p>Used to access the <c>SchemaName</c> column in the <c>PackageProcedureParameters</c> metadata collection.</p>
    ///   <p>The data in this column specifies the schema name.</p>
    /// </summary>
    const SchemaName = 'SchemaName';
    
    /// <summary>  <p>Used to access the <c>PackageName</c> column in the <c>PackageProcedureParameters</c> metadata collection.</p>
    ///   <p>The data in this column specifies the package name.</p>
    /// </summary>
    const PackageName = 'PackageName';
    
    /// <summary>  <p>Used to access the <c>ProcedureName</c> column in the <c>PackageProcedureParameters</c> metadata collection.</p>
    ///   <p>The data in this column specifies the procedure name from the
    ///   package.</p>
    /// </summary>
    const ProcedureName = 'ProcedureName';
    
    /// <summary>  <p>Used to access the <c>ParameterName</c> column in the <c>PackageProcedureParameters</c> metadata collection.</p>
    ///   <p>The data in this column specifies the parameter name.</p>
    /// </summary>
    const ParameterName = 'ParameterName';
    
    /// <summary>  <p>Used to access the <c>ParameterMode</c> column in the <c>PackageProcedureParameters</c> metadata collection.</p>
    ///   <p>The data in this column specifies the parameter mode: IN, OUT, INOUT,
    ///   RESULT.</p>
    /// </summary>
    const ParameterMode = 'ParameterMode';
    
    /// <summary>  <p>Used to access the <c>TypeName</c> column in the <c>PackageProcedureParameters</c> metadata collection.</p>
    ///   <p>The data in this column specifies the database specific data type
    ///   name.</p>
    /// </summary>
    const TypeName = 'TypeName';
    
    /// <summary>  <p>Used to access the <c>Precision</c> column in the <c>PackageProcedureParameters</c> metadata collection.</p>
    ///   <p>The data in this column specifies the precision of this type.</p>
    /// </summary>
    /// <remarks> <br></br>
    ///   For a string data type, this is the maximum number of characters. <br></br>
    ///   For a decimal types, this is the maximum number digits including
    ///   digits from the scale.
    /// </remarks>
    const Precision = 'Precision';
    
    /// <summary>  <p>Used to access the <c>Scale</c> column in the <c>PackageProcedureParameters</c> metadata collection.</p>
    ///   <p>The data in this column specifies the scale of a decimal type.</p>
    /// </summary>
    const Scale = 'Scale';
    
    /// <summary>  <p>Used to access the <c>Ordinal</c> column in the <c>PackageProcedureParameters</c> metadata collection.</p>
    ///   <p>The data in this column specifies the position in the rows of the
    ///   table starting with 1.</p>
    /// </summary>
    const Ordinal = 'Ordinal';
    
    /// <summary>  <p>Used to access the <c>IsNullable</c> column in the <c>PackageProcedureParameters</c> metadata collection.</p>
    ///   <p>The data in this column specifies that the package procedure parameter
    ///   can accept NULL values.</p>
    /// </summary>
    const IsNullable = 'IsNullable';
    
    /// <summary>  <p>Used to access the <c>DbxDataType</c> column in the <c>PackageProcedureParameters</c> metadata collection.</p>
    ///   <p>The data in this column specifies the DBX data type.</p>
    /// </summary>
    const DbxDataType = 'DbxDataType';
    
    /// <summary>  <p>Used to access the <c>IsFixedLength</c> column in the <c>PackageProcedureParameters</c> metadata collection.</p>
    ///   <p>The data in this column specifies that the package procedure parameter
    ///   holds fixed length data.</p>
    /// </summary>
    const IsFixedLength = 'IsFixedLength';
    
    /// <summary>  <p>Used to access the <c>IsUnicode</c> column in the <c>PackageProcedureParameters</c> metadata collection.</p>
    ///   <p>The data in this column specifies that the package procedure parameter
    ///   can hold unicode characters.</p>
    /// </summary>
    const IsUnicode = 'IsUnicode';
    
    /// <summary>  <p>Used to access the <c>IsLong</c> column in the <c>PackageProcedureParameters</c> metadata collection.</p>
    ///   <p>The data in this column specifies that the package procedure parameter
    ///   is blob data type.</p>
    /// </summary>
    const IsLong = 'IsLong';
    
    /// <summary>  <p>Used to access the <c>IsUnsigned</c> column in the <c>PackageProcedureParameters</c> metadata collection.</p>
    ///   <p>The data in this column specifies that the package procedure parameter
    ///   is unsigned numeric type.</p>
    /// </summary>
    const IsUnsigned = 'IsUnsigned';
  end;

  TDBXPackageProcedureParametersIndex = class
  public
    
    /// <summary>  <p>Used to access the <c>CatalogName</c> column by ordinal in the <c>PackageProcedureParameters</c> metadata collection.</p>
    ///   <p>The data in this column specifies the catalog name.</p>
    /// </summary>
    const CatalogName = 0;
    
    /// <summary>  <p>Used to access the <c>SchemaName</c> column by ordinal in the <c>PackageProcedureParameters</c> metadata collection.</p>
    ///   <p>The data in this column specifies the schema name.</p>
    /// </summary>
    const SchemaName = 1;
    
    /// <summary>  <p>Used to access the <c>PackageName</c> column by ordinal in the <c>PackageProcedureParameters</c> metadata collection.</p>
    ///   <p>The data in this column specifies the package name.</p>
    /// </summary>
    const PackageName = 2;
    
    /// <summary>  <p>Used to access the <c>ProcedureName</c> column by ordinal in the <c>PackageProcedureParameters</c> metadata collection.</p>
    ///   <p>The data in this column specifies the procedure name from the
    ///   package.</p>
    /// </summary>
    const ProcedureName = 3;
    
    /// <summary>  <p>Used to access the <c>ParameterName</c> column by ordinal in the <c>PackageProcedureParameters</c> metadata collection.</p>
    ///   <p>The data in this column specifies the parameter name.</p>
    /// </summary>
    const ParameterName = 4;
    
    /// <summary>  <p>Used to access the <c>ParameterMode</c> column by ordinal in the <c>PackageProcedureParameters</c> metadata collection.</p>
    ///   <p>The data in this column specifies the parameter mode: IN, OUT, INOUT,
    ///   RESULT.</p>
    /// </summary>
    const ParameterMode = 5;
    
    /// <summary>  <p>Used to access the <c>TypeName</c> column by ordinal in the <c>PackageProcedureParameters</c> metadata collection.</p>
    ///   <p>The data in this column specifies the database specific data type
    ///   name.</p>
    /// </summary>
    const TypeName = 6;
    
    /// <summary>  <p>Used to access the <c>Precision</c> column by ordinal in the <c>PackageProcedureParameters</c> metadata collection.</p>
    ///   <p>The data in this column specifies the precision of this type.</p>
    /// </summary>
    /// <remarks> <br></br>
    ///   For a string data type, this is the maximum number of characters. <br></br>
    ///   For a decimal types, this is the maximum number digits including
    ///   digits from the scale.
    /// </remarks>
    const Precision = 7;
    
    /// <summary>  <p>Used to access the <c>Scale</c> column by ordinal in the <c>PackageProcedureParameters</c> metadata collection.</p>
    ///   <p>The data in this column specifies the scale of a decimal type.</p>
    /// </summary>
    const Scale = 8;
    
    /// <summary>  <p>Used to access the <c>Ordinal</c> column by ordinal in the <c>PackageProcedureParameters</c> metadata collection.</p>
    ///   <p>The data in this column specifies the position in the rows of the
    ///   table starting with 1.</p>
    /// </summary>
    const Ordinal = 9;
    
    /// <summary>  <p>Used to access the <c>IsNullable</c> column by ordinal in the <c>PackageProcedureParameters</c> metadata collection.</p>
    ///   <p>The data in this column specifies that the package procedure parameter
    ///   can accept NULL values.</p>
    /// </summary>
    const IsNullable = 10;
    
    /// <summary>  <p>Used to access the <c>DbxDataType</c> column by ordinal in the <c>PackageProcedureParameters</c> metadata collection.</p>
    ///   <p>The data in this column specifies the DBX data type.</p>
    /// </summary>
    const DbxDataType = 11;
    
    /// <summary>  <p>Used to access the <c>IsFixedLength</c> column by ordinal in the <c>PackageProcedureParameters</c> metadata collection.</p>
    ///   <p>The data in this column specifies that the package procedure parameter
    ///   holds fixed length data.</p>
    /// </summary>
    const IsFixedLength = 12;
    
    /// <summary>  <p>Used to access the <c>IsUnicode</c> column by ordinal in the <c>PackageProcedureParameters</c> metadata collection.</p>
    ///   <p>The data in this column specifies that the package procedure parameter
    ///   can hold unicode characters.</p>
    /// </summary>
    const IsUnicode = 13;
    
    /// <summary>  <p>Used to access the <c>IsLong</c> column by ordinal in the <c>PackageProcedureParameters</c> metadata collection.</p>
    ///   <p>The data in this column specifies that the package procedure parameter
    ///   is blob data type.</p>
    /// </summary>
    const IsLong = 14;
    
    /// <summary>  <p>Used to access the <c>IsUnsigned</c> column by ordinal in the <c>PackageProcedureParameters</c> metadata collection.</p>
    ///   <p>The data in this column specifies that the package procedure parameter
    ///   is unsigned numeric type.</p>
    /// </summary>
    const IsUnsigned = 15;
    const Last = 15;
  end;

  TDBXPackageProceduresColumns = class
  public
    
    /// <summary>  <p>Used to access the <c>CatalogName</c> column in the <c>PackageProcedures</c> metadata collection.</p>
    ///   <p>The data in this column specifies the catalog name.</p>
    /// </summary>
    const CatalogName = 'CatalogName';
    
    /// <summary>  <p>Used to access the <c>SchemaName</c> column in the <c>PackageProcedures</c> metadata collection.</p>
    ///   <p>The data in this column specifies the schema name.</p>
    /// </summary>
    const SchemaName = 'SchemaName';
    
    /// <summary>  <p>Used to access the <c>PackageName</c> column in the <c>PackageProcedures</c> metadata collection.</p>
    ///   <p>The data in this column specifies the package name.</p>
    /// </summary>
    const PackageName = 'PackageName';
    
    /// <summary>  <p>Used to access the <c>ProcedureName</c> column in the <c>PackageProcedures</c> metadata collection.</p>
    ///   <p>The data in this column specifies the procedure name from the
    ///   package.</p>
    /// </summary>
    const ProcedureName = 'ProcedureName';
    
    /// <summary>  <p>Used to access the <c>ProcedureType</c> column in the <c>PackageProcedures</c> metadata collection.</p>
    ///   <p>The data in this column specifies the procedure type: FUNCTION,
    ///   PROCEDURE.</p>
    /// </summary>
    const ProcedureType = 'ProcedureType';
  end;

  TDBXPackageProceduresIndex = class
  public
    
    /// <summary>  <p>Used to access the <c>CatalogName</c> column by ordinal in the <c>PackageProcedures</c> metadata collection.</p>
    ///   <p>The data in this column specifies the catalog name.</p>
    /// </summary>
    const CatalogName = 0;
    
    /// <summary>  <p>Used to access the <c>SchemaName</c> column by ordinal in the <c>PackageProcedures</c> metadata collection.</p>
    ///   <p>The data in this column specifies the schema name.</p>
    /// </summary>
    const SchemaName = 1;
    
    /// <summary>  <p>Used to access the <c>PackageName</c> column by ordinal in the <c>PackageProcedures</c> metadata collection.</p>
    ///   <p>The data in this column specifies the package name.</p>
    /// </summary>
    const PackageName = 2;
    
    /// <summary>  <p>Used to access the <c>ProcedureName</c> column by ordinal in the <c>PackageProcedures</c> metadata collection.</p>
    ///   <p>The data in this column specifies the procedure name from the
    ///   package.</p>
    /// </summary>
    const ProcedureName = 3;
    
    /// <summary>  <p>Used to access the <c>ProcedureType</c> column by ordinal in the <c>PackageProcedures</c> metadata collection.</p>
    ///   <p>The data in this column specifies the procedure type: FUNCTION,
    ///   PROCEDURE.</p>
    /// </summary>
    const ProcedureType = 4;
    const Last = 4;
  end;

  TDBXPackagesColumns = class
  public
    
    /// <summary>  <p>Used to access the <c>CatalogName</c> column in the <c>Packages</c> metadata collection.</p>
    ///   <p>The data in this column specifies the catalog name.</p>
    /// </summary>
    const CatalogName = 'CatalogName';
    
    /// <summary>  <p>Used to access the <c>SchemaName</c> column in the <c>Packages</c> metadata collection.</p>
    ///   <p>The data in this column specifies the schema name.</p>
    /// </summary>
    const SchemaName = 'SchemaName';
    
    /// <summary>  <p>Used to access the <c>PackageName</c> column in the <c>Packages</c> metadata collection.</p>
    ///   <p>The data in this column specifies the package name.</p>
    /// </summary>
    const PackageName = 'PackageName';
  end;

  TDBXPackagesIndex = class
  public
    
    /// <summary>  <p>Used to access the <c>CatalogName</c> column by ordinal in the <c>Packages</c> metadata collection.</p>
    ///   <p>The data in this column specifies the catalog name.</p>
    /// </summary>
    const CatalogName = 0;
    
    /// <summary>  <p>Used to access the <c>SchemaName</c> column by ordinal in the <c>Packages</c> metadata collection.</p>
    ///   <p>The data in this column specifies the schema name.</p>
    /// </summary>
    const SchemaName = 1;
    
    /// <summary>  <p>Used to access the <c>PackageName</c> column by ordinal in the <c>Packages</c> metadata collection.</p>
    ///   <p>The data in this column specifies the package name.</p>
    /// </summary>
    const PackageName = 2;
    const Last = 2;
  end;

  TDBXPackageSourcesColumns = class
  public
    
    /// <summary>  <p>Used to access the <c>CatalogName</c> column in the <c>PackageSources</c> metadata collection.</p>
    ///   <p>The data in this column specifies the catalog name.</p>
    /// </summary>
    const CatalogName = 'CatalogName';
    
    /// <summary>  <p>Used to access the <c>SchemaName</c> column in the <c>PackageSources</c> metadata collection.</p>
    ///   <p>The data in this column specifies the schema name.</p>
    /// </summary>
    const SchemaName = 'SchemaName';
    
    /// <summary>  <p>Used to access the <c>PackageName</c> column in the <c>PackageSources</c> metadata collection.</p>
    ///   <p>The data in this column specifies the package name.</p>
    /// </summary>
    const PackageName = 'PackageName';
    
    /// <summary>  <p>Used to access the <c>Definition</c> column in the <c>PackageSources</c> metadata collection.</p>
    ///   <p>The data in this column specifies the package source code.</p>
    /// </summary>
    const Definition = 'Definition';
  end;

  TDBXPackageSourcesIndex = class
  public
    
    /// <summary>  <p>Used to access the <c>CatalogName</c> column by ordinal in the <c>PackageSources</c> metadata collection.</p>
    ///   <p>The data in this column specifies the catalog name.</p>
    /// </summary>
    const CatalogName = 0;
    
    /// <summary>  <p>Used to access the <c>SchemaName</c> column by ordinal in the <c>PackageSources</c> metadata collection.</p>
    ///   <p>The data in this column specifies the schema name.</p>
    /// </summary>
    const SchemaName = 1;
    
    /// <summary>  <p>Used to access the <c>PackageName</c> column by ordinal in the <c>PackageSources</c> metadata collection.</p>
    ///   <p>The data in this column specifies the package name.</p>
    /// </summary>
    const PackageName = 2;
    
    /// <summary>  <p>Used to access the <c>Definition</c> column by ordinal in the <c>PackageSources</c> metadata collection.</p>
    ///   <p>The data in this column specifies the package source code.</p>
    /// </summary>
    const Definition = 3;
    const Last = 3;
  end;

  TDBXProcedureParametersColumns = class
  public
    
    /// <summary>  <p>Used to access the <c>CatalogName</c> column in the <c>ProcedureParameters</c> metadata collection.</p>
    ///   <p>The data in this column specifies the catalog name.</p>
    /// </summary>
    const CatalogName = 'CatalogName';
    
    /// <summary>  <p>Used to access the <c>SchemaName</c> column in the <c>ProcedureParameters</c> metadata collection.</p>
    ///   <p>The data in this column specifies the schema name.</p>
    /// </summary>
    const SchemaName = 'SchemaName';
    
    /// <summary>  <p>Used to access the <c>ProcedureName</c> column in the <c>ProcedureParameters</c> metadata collection.</p>
    ///   <p>The data in this column specifies the procedure name.</p>
    /// </summary>
    const ProcedureName = 'ProcedureName';
    
    /// <summary>  <p>Used to access the <c>ParameterName</c> column in the <c>ProcedureParameters</c> metadata collection.</p>
    ///   <p>The data in this column specifies the parameter name.</p>
    /// </summary>
    const ParameterName = 'ParameterName';
    
    /// <summary>  <p>Used to access the <c>ParameterMode</c> column in the <c>ProcedureParameters</c> metadata collection.</p>
    ///   <p>The data in this column specifies the parameter mode: IN, OUT, INOUT,
    ///   RESULT.</p>
    /// </summary>
    const ParameterMode = 'ParameterMode';
    
    /// <summary>  <p>Used to access the <c>TypeName</c> column in the <c>ProcedureParameters</c> metadata collection.</p>
    ///   <p>The data in this column specifies the database specific data type
    ///   name.</p>
    /// </summary>
    const TypeName = 'TypeName';
    
    /// <summary>  <p>Used to access the <c>Precision</c> column in the <c>ProcedureParameters</c> metadata collection.</p>
    ///   <p>The data in this column specifies the precision of this type.</p>
    /// </summary>
    /// <remarks> <br></br>
    ///   For a string data type, this is the maximum number of characters. <br></br>
    ///   For a decimal types, this is the maximum number digits including
    ///   digits from the scale.
    /// </remarks>
    const Precision = 'Precision';
    
    /// <summary>  <p>Used to access the <c>Scale</c> column in the <c>ProcedureParameters</c> metadata collection.</p>
    ///   <p>The data in this column specifies the scale of a decimal type.</p>
    /// </summary>
    const Scale = 'Scale';
    
    /// <summary>  <p>Used to access the <c>Ordinal</c> column in the <c>ProcedureParameters</c> metadata collection.</p>
    ///   <p>The data in this column specifies the position in the rows of the
    ///   table starting with 1.</p>
    /// </summary>
    const Ordinal = 'Ordinal';
    
    /// <summary>  <p>Used to access the <c>IsNullable</c> column in the <c>ProcedureParameters</c> metadata collection.</p>
    ///   <p>The data in this column specifies that the procedure parameter can
    ///   accept NULL values.</p>
    /// </summary>
    const IsNullable = 'IsNullable';
    
    /// <summary>  <p>Used to access the <c>DbxDataType</c> column in the <c>ProcedureParameters</c> metadata collection.</p>
    ///   <p>The data in this column specifies the DBX data type.</p>
    /// </summary>
    const DbxDataType = 'DbxDataType';
    
    /// <summary>  <p>Used to access the <c>IsFixedLength</c> column in the <c>ProcedureParameters</c> metadata collection.</p>
    ///   <p>The data in this column specifies that the procedure parameter holds
    ///   fixed length data.</p>
    /// </summary>
    const IsFixedLength = 'IsFixedLength';
    
    /// <summary>  <p>Used to access the <c>IsUnicode</c> column in the <c>ProcedureParameters</c> metadata collection.</p>
    ///   <p>The data in this column specifies that the procedure parameter can
    ///   hold unicode characters.</p>
    /// </summary>
    const IsUnicode = 'IsUnicode';
    
    /// <summary>  <p>Used to access the <c>IsLong</c> column in the <c>ProcedureParameters</c> metadata collection.</p>
    ///   <p>The data in this column specifies that the procedure parameter is blob
    ///   data type.</p>
    /// </summary>
    const IsLong = 'IsLong';
    
    /// <summary>  <p>Used to access the <c>IsUnsigned</c> column in the <c>ProcedureParameters</c> metadata collection.</p>
    ///   <p>The data in this column specifies that the procedure parameter is
    ///   unsigned numeric type.</p>
    /// </summary>
    const IsUnsigned = 'IsUnsigned';
  end;

  TDBXProcedureParametersIndex = class
  public
    
    /// <summary>  <p>Used to access the <c>CatalogName</c> column by ordinal in the <c>ProcedureParameters</c> metadata collection.</p>
    ///   <p>The data in this column specifies the catalog name.</p>
    /// </summary>
    const CatalogName = 0;
    
    /// <summary>  <p>Used to access the <c>SchemaName</c> column by ordinal in the <c>ProcedureParameters</c> metadata collection.</p>
    ///   <p>The data in this column specifies the schema name.</p>
    /// </summary>
    const SchemaName = 1;
    
    /// <summary>  <p>Used to access the <c>ProcedureName</c> column by ordinal in the <c>ProcedureParameters</c> metadata collection.</p>
    ///   <p>The data in this column specifies the procedure name.</p>
    /// </summary>
    const ProcedureName = 2;
    
    /// <summary>  <p>Used to access the <c>ParameterName</c> column by ordinal in the <c>ProcedureParameters</c> metadata collection.</p>
    ///   <p>The data in this column specifies the parameter name.</p>
    /// </summary>
    const ParameterName = 3;
    
    /// <summary>  <p>Used to access the <c>ParameterMode</c> column by ordinal in the <c>ProcedureParameters</c> metadata collection.</p>
    ///   <p>The data in this column specifies the parameter mode: IN, OUT, INOUT,
    ///   RESULT.</p>
    /// </summary>
    const ParameterMode = 4;
    
    /// <summary>  <p>Used to access the <c>TypeName</c> column by ordinal in the <c>ProcedureParameters</c> metadata collection.</p>
    ///   <p>The data in this column specifies the database specific data type
    ///   name.</p>
    /// </summary>
    const TypeName = 5;
    
    /// <summary>  <p>Used to access the <c>Precision</c> column by ordinal in the <c>ProcedureParameters</c> metadata collection.</p>
    ///   <p>The data in this column specifies the precision of this type.</p>
    /// </summary>
    /// <remarks> <br></br>
    ///   For a string data type, this is the maximum number of characters. <br></br>
    ///   For a decimal types, this is the maximum number digits including
    ///   digits from the scale.
    /// </remarks>
    const Precision = 6;
    
    /// <summary>  <p>Used to access the <c>Scale</c> column by ordinal in the <c>ProcedureParameters</c> metadata collection.</p>
    ///   <p>The data in this column specifies the scale of a decimal type.</p>
    /// </summary>
    const Scale = 7;
    
    /// <summary>  <p>Used to access the <c>Ordinal</c> column by ordinal in the <c>ProcedureParameters</c> metadata collection.</p>
    ///   <p>The data in this column specifies the position in the rows of the
    ///   table starting with 1.</p>
    /// </summary>
    const Ordinal = 8;
    
    /// <summary>  <p>Used to access the <c>IsNullable</c> column by ordinal in the <c>ProcedureParameters</c> metadata collection.</p>
    ///   <p>The data in this column specifies that the procedure parameter can
    ///   accept NULL values.</p>
    /// </summary>
    const IsNullable = 9;
    
    /// <summary>  <p>Used to access the <c>DbxDataType</c> column by ordinal in the <c>ProcedureParameters</c> metadata collection.</p>
    ///   <p>The data in this column specifies the DBX data type.</p>
    /// </summary>
    const DbxDataType = 10;
    
    /// <summary>  <p>Used to access the <c>IsFixedLength</c> column by ordinal in the <c>ProcedureParameters</c> metadata collection.</p>
    ///   <p>The data in this column specifies that the procedure parameter holds
    ///   fixed length data.</p>
    /// </summary>
    const IsFixedLength = 11;
    
    /// <summary>  <p>Used to access the <c>IsUnicode</c> column by ordinal in the <c>ProcedureParameters</c> metadata collection.</p>
    ///   <p>The data in this column specifies that the procedure parameter can
    ///   hold unicode characters.</p>
    /// </summary>
    const IsUnicode = 12;
    
    /// <summary>  <p>Used to access the <c>IsLong</c> column by ordinal in the <c>ProcedureParameters</c> metadata collection.</p>
    ///   <p>The data in this column specifies that the procedure parameter is blob
    ///   data type.</p>
    /// </summary>
    const IsLong = 13;
    
    /// <summary>  <p>Used to access the <c>IsUnsigned</c> column by ordinal in the <c>ProcedureParameters</c> metadata collection.</p>
    ///   <p>The data in this column specifies that the procedure parameter is
    ///   unsigned numeric type.</p>
    /// </summary>
    const IsUnsigned = 14;
    const Last = 14;
  end;

  TDBXProceduresColumns = class
  public
    
    /// <summary>  <p>Used to access the <c>CatalogName</c> column in the <c>Procedures</c> metadata collection.</p>
    ///   <p>The data in this column specifies the catalog name.</p>
    /// </summary>
    const CatalogName = 'CatalogName';
    
    /// <summary>  <p>Used to access the <c>SchemaName</c> column in the <c>Procedures</c> metadata collection.</p>
    ///   <p>The data in this column specifies the schema name.</p>
    /// </summary>
    const SchemaName = 'SchemaName';
    
    /// <summary>  <p>Used to access the <c>ProcedureName</c> column in the <c>Procedures</c> metadata collection.</p>
    ///   <p>The data in this column specifies the procedure name.</p>
    /// </summary>
    const ProcedureName = 'ProcedureName';
    
    /// <summary>  <p>Used to access the <c>ProcedureType</c> column in the <c>Procedures</c> metadata collection.</p>
    ///   <p>The data in this column specifies the procedure type: FUNCTION or
    ///   PROCEDURE.</p>
    /// </summary>
    const ProcedureType = 'ProcedureType';
  end;

  TDBXProceduresIndex = class
  public
    
    /// <summary>  <p>Used to access the <c>CatalogName</c> column by ordinal in the <c>Procedures</c> metadata collection.</p>
    ///   <p>The data in this column specifies the catalog name.</p>
    /// </summary>
    const CatalogName = 0;
    
    /// <summary>  <p>Used to access the <c>SchemaName</c> column by ordinal in the <c>Procedures</c> metadata collection.</p>
    ///   <p>The data in this column specifies the schema name.</p>
    /// </summary>
    const SchemaName = 1;
    
    /// <summary>  <p>Used to access the <c>ProcedureName</c> column by ordinal in the <c>Procedures</c> metadata collection.</p>
    ///   <p>The data in this column specifies the procedure name.</p>
    /// </summary>
    const ProcedureName = 2;
    
    /// <summary>  <p>Used to access the <c>ProcedureType</c> column by ordinal in the <c>Procedures</c> metadata collection.</p>
    ///   <p>The data in this column specifies the procedure type: FUNCTION or
    ///   PROCEDURE.</p>
    /// </summary>
    const ProcedureType = 3;
    const Last = 3;
  end;

  TDBXProcedureSourcesColumns = class
  public
    
    /// <summary>  <p>Used to access the <c>CatalogName</c> column in the <c>ProcedureSources</c> metadata collection.</p>
    ///   <p>The data in this column specifies the catalog name.</p>
    /// </summary>
    const CatalogName = 'CatalogName';
    
    /// <summary>  <p>Used to access the <c>SchemaName</c> column in the <c>ProcedureSources</c> metadata collection.</p>
    ///   <p>The data in this column specifies the schema name.</p>
    /// </summary>
    const SchemaName = 'SchemaName';
    
    /// <summary>  <p>Used to access the <c>ProcedureName</c> column in the <c>ProcedureSources</c> metadata collection.</p>
    ///   <p>The data in this column specifies the procedure name.</p>
    /// </summary>
    const ProcedureName = 'ProcedureName';
    
    /// <summary>  <p>Used to access the <c>ProcedureType</c> column in the <c>ProcedureSources</c> metadata collection.</p>
    ///   <p>The data in this column specifies the procedure type: FUNCTION or
    ///   PROCEDURE.</p>
    /// </summary>
    const ProcedureType = 'ProcedureType';
    
    /// <summary>  <p>Used to access the <c>Definition</c> column in the <c>ProcedureSources</c> metadata collection.</p>
    ///   <p>The data in this column specifies the source of the SQL procedure.</p>
    /// </summary>
    const Definition = 'Definition';
    
    /// <summary>  <p>Used to access the <c>ExternalDefinition</c> column in the <c>ProcedureSources</c> metadata collection.</p>
    ///   <p>The data in this column specifies a reference to an procedure external
    ///   to the database.</p>
    /// </summary>
    const ExternalDefinition = 'ExternalDefinition';
  end;

  TDBXProcedureSourcesIndex = class
  public
    
    /// <summary>  <p>Used to access the <c>CatalogName</c> column by ordinal in the <c>ProcedureSources</c> metadata collection.</p>
    ///   <p>The data in this column specifies the catalog name.</p>
    /// </summary>
    const CatalogName = 0;
    
    /// <summary>  <p>Used to access the <c>SchemaName</c> column by ordinal in the <c>ProcedureSources</c> metadata collection.</p>
    ///   <p>The data in this column specifies the schema name.</p>
    /// </summary>
    const SchemaName = 1;
    
    /// <summary>  <p>Used to access the <c>ProcedureName</c> column by ordinal in the <c>ProcedureSources</c> metadata collection.</p>
    ///   <p>The data in this column specifies the procedure name.</p>
    /// </summary>
    const ProcedureName = 2;
    
    /// <summary>  <p>Used to access the <c>ProcedureType</c> column by ordinal in the <c>ProcedureSources</c> metadata collection.</p>
    ///   <p>The data in this column specifies the procedure type: FUNCTION or
    ///   PROCEDURE.</p>
    /// </summary>
    const ProcedureType = 3;
    
    /// <summary>  <p>Used to access the <c>Definition</c> column by ordinal in the <c>ProcedureSources</c> metadata collection.</p>
    ///   <p>The data in this column specifies the source of the SQL procedure.</p>
    /// </summary>
    const Definition = 4;
    
    /// <summary>  <p>Used to access the <c>ExternalDefinition</c> column by ordinal in the <c>ProcedureSources</c> metadata collection.</p>
    ///   <p>The data in this column specifies a reference to an procedure external
    ///   to the database.</p>
    /// </summary>
    const ExternalDefinition = 5;
    const Last = 5;
  end;

  TDBXReservedWordsColumns = class
  public
    
    /// <summary>  <p>Used to access the <c>ReservedWord</c> column in the <c>ReservedWords</c> metadata collection.</p>
    ///   <p>The data in this column specifies an identifier reserved for the SQL
    ///   syntax.</p>
    /// </summary>
    /// <remarks> <br></br>
    ///   These identifiers should not be used as object names such as tables
    ///   and columns. Some databases allows their use if they are quoted.
    /// </remarks>
    const ReservedWord = 'ReservedWord';
  end;

  TDBXReservedWordsIndex = class
  public
    
    /// <summary>  <p>Used to access the <c>ReservedWord</c> column by ordinal in the <c>ReservedWords</c> metadata collection.</p>
    ///   <p>The data in this column specifies an identifier reserved for the SQL
    ///   syntax.</p>
    /// </summary>
    /// <remarks> <br></br>
    ///   These identifiers should not be used as object names such as tables
    ///   and columns. Some databases allows their use if they are quoted.
    /// </remarks>
    const ReservedWord = 0;
    const Last = 0;
  end;

  TDBXRolesColumns = class
  public
    
    /// <summary>  <p>Used to access the <c>RoleName</c> column in the <c>Roles</c> metadata collection.</p>
    ///   <p>The data in this column specifies a role name.</p>
    /// </summary>
    const RoleName = 'RoleName';
  end;

  TDBXRolesIndex = class
  public
    
    /// <summary>  <p>Used to access the <c>RoleName</c> column by ordinal in the <c>Roles</c> metadata collection.</p>
    ///   <p>The data in this column specifies a role name.</p>
    /// </summary>
    const RoleName = 0;
    const Last = 0;
  end;

  TDBXSchemasColumns = class
  public
    
    /// <summary>  <p>Used to access the <c>CatalogName</c> column in the <c>Schemas</c> metadata collection.</p>
    ///   <p>The data in this column specifies the catalog name.</p>
    /// </summary>
    const CatalogName = 'CatalogName';
    
    /// <summary>  <p>Used to access the <c>SchemaName</c> column in the <c>Schemas</c> metadata collection.</p>
    ///   <p>The data in this column specifies the schema name.</p>
    /// </summary>
    const SchemaName = 'SchemaName';
  end;

  TDBXSchemasIndex = class
  public
    
    /// <summary>  <p>Used to access the <c>CatalogName</c> column by ordinal in the <c>Schemas</c> metadata collection.</p>
    ///   <p>The data in this column specifies the catalog name.</p>
    /// </summary>
    const CatalogName = 0;
    
    /// <summary>  <p>Used to access the <c>SchemaName</c> column by ordinal in the <c>Schemas</c> metadata collection.</p>
    ///   <p>The data in this column specifies the schema name.</p>
    /// </summary>
    const SchemaName = 1;
    const Last = 1;
  end;

  TDBXSynonymsColumns = class
  public
    
    /// <summary>  <p>Used to access the <c>CatalogName</c> column in the <c>Synonyms</c> metadata collection.</p>
    ///   <p>The data in this column specifies the catalog name.</p>
    /// </summary>
    const CatalogName = 'CatalogName';
    
    /// <summary>  <p>Used to access the <c>SchemaName</c> column in the <c>Synonyms</c> metadata collection.</p>
    ///   <p>The data in this column specifies the schema name.</p>
    /// </summary>
    const SchemaName = 'SchemaName';
    
    /// <summary>  <p>Used to access the <c>SynonymName</c> column in the <c>Synonyms</c> metadata collection.</p>
    ///   <p>The data in this column specifies the synonym name.</p>
    /// </summary>
    const SynonymName = 'SynonymName';
    
    /// <summary>  <p>Used to access the <c>TableCatalogName</c> column in the <c>Synonyms</c> metadata collection.</p>
    ///   <p>The data in this column specifies the catalog name of the table this
    ///   synonym refers to.</p>
    /// </summary>
    const TableCatalogName = 'TableCatalogName';
    
    /// <summary>  <p>Used to access the <c>TableSchemaName</c> column in the <c>Synonyms</c> metadata collection.</p>
    ///   <p>The data in this column specifies the schema name of the table this
    ///   synonym refers to.</p>
    /// </summary>
    const TableSchemaName = 'TableSchemaName';
    
    /// <summary>  <p>Used to access the <c>TableName</c> column in the <c>Synonyms</c> metadata collection.</p>
    ///   <p>The data in this column specifies the name of the table this synonym
    ///   refers to.</p>
    /// </summary>
    const TableName = 'TableName';
  end;

  TDBXSynonymsIndex = class
  public
    
    /// <summary>  <p>Used to access the <c>CatalogName</c> column by ordinal in the <c>Synonyms</c> metadata collection.</p>
    ///   <p>The data in this column specifies the catalog name.</p>
    /// </summary>
    const CatalogName = 0;
    
    /// <summary>  <p>Used to access the <c>SchemaName</c> column by ordinal in the <c>Synonyms</c> metadata collection.</p>
    ///   <p>The data in this column specifies the schema name.</p>
    /// </summary>
    const SchemaName = 1;
    
    /// <summary>  <p>Used to access the <c>SynonymName</c> column by ordinal in the <c>Synonyms</c> metadata collection.</p>
    ///   <p>The data in this column specifies the synonym name.</p>
    /// </summary>
    const SynonymName = 2;
    
    /// <summary>  <p>Used to access the <c>TableCatalogName</c> column by ordinal in the <c>Synonyms</c> metadata collection.</p>
    ///   <p>The data in this column specifies the catalog name of the table this
    ///   synonym refers to.</p>
    /// </summary>
    const TableCatalogName = 3;
    
    /// <summary>  <p>Used to access the <c>TableSchemaName</c> column by ordinal in the <c>Synonyms</c> metadata collection.</p>
    ///   <p>The data in this column specifies the schema name of the table this
    ///   synonym refers to.</p>
    /// </summary>
    const TableSchemaName = 4;
    
    /// <summary>  <p>Used to access the <c>TableName</c> column by ordinal in the <c>Synonyms</c> metadata collection.</p>
    ///   <p>The data in this column specifies the name of the table this synonym
    ///   refers to.</p>
    /// </summary>
    const TableName = 5;
    const Last = 5;
  end;

  TDBXTablesColumns = class
  public
    
    /// <summary>  <p>Used to access the <c>CatalogName</c> column in the <c>Tables</c> metadata collection.</p>
    ///   <p>The data in this column specifies the catalog name.</p>
    /// </summary>
    const CatalogName = 'CatalogName';
    
    /// <summary>  <p>Used to access the <c>SchemaName</c> column in the <c>Tables</c> metadata collection.</p>
    ///   <p>The data in this column specifies the schema name.</p>
    /// </summary>
    const SchemaName = 'SchemaName';
    
    /// <summary>  <p>Used to access the <c>TableName</c> column in the <c>Tables</c> metadata collection.</p>
    ///   <p>The data in this column specifies the table name.</p>
    /// </summary>
    const TableName = 'TableName';
    
    /// <summary>  <p>Used to access the <c>TableType</c> column in the <c>Tables</c> metadata collection.</p>
    ///   <p>The data in this column specifies the table type: TABLE, VIEW,
    ///   SYNONYM, SYSTEM_TABLE.</p>
    /// </summary>
    const TableType = 'TableType';
  end;

  TDBXTablesIndex = class
  public
    
    /// <summary>  <p>Used to access the <c>CatalogName</c> column by ordinal in the <c>Tables</c> metadata collection.</p>
    ///   <p>The data in this column specifies the catalog name.</p>
    /// </summary>
    const CatalogName = 0;
    
    /// <summary>  <p>Used to access the <c>SchemaName</c> column by ordinal in the <c>Tables</c> metadata collection.</p>
    ///   <p>The data in this column specifies the schema name.</p>
    /// </summary>
    const SchemaName = 1;
    
    /// <summary>  <p>Used to access the <c>TableName</c> column by ordinal in the <c>Tables</c> metadata collection.</p>
    ///   <p>The data in this column specifies the table name.</p>
    /// </summary>
    const TableName = 2;
    
    /// <summary>  <p>Used to access the <c>TableType</c> column by ordinal in the <c>Tables</c> metadata collection.</p>
    ///   <p>The data in this column specifies the table type: TABLE, VIEW,
    ///   SYNONYM, SYSTEM_TABLE.</p>
    /// </summary>
    const TableType = 3;
    const Last = 3;
  end;

  TDBXUsersColumns = class
  public
    
    /// <summary>  <p>Used to access the <c>UserName</c> column in the <c>Users</c> metadata collection.</p>
    ///   <p>The data in this column specifies a user name.</p>
    /// </summary>
    const UserName = 'UserName';
  end;

  TDBXUsersIndex = class
  public
    
    /// <summary>  <p>Used to access the <c>UserName</c> column by ordinal in the <c>Users</c> metadata collection.</p>
    ///   <p>The data in this column specifies a user name.</p>
    /// </summary>
    const UserName = 0;
    const Last = 0;
  end;

  TDBXViewsColumns = class
  public
    
    /// <summary>  <p>Used to access the <c>CatalogName</c> column in the <c>Views</c> metadata collection.</p>
    ///   <p>The data in this column specifies the catalog name.</p>
    /// </summary>
    const CatalogName = 'CatalogName';
    
    /// <summary>  <p>Used to access the <c>SchemaName</c> column in the <c>Views</c> metadata collection.</p>
    ///   <p>The data in this column specifies the schema name.</p>
    /// </summary>
    const SchemaName = 'SchemaName';
    
    /// <summary>  <p>Used to access the <c>ViewName</c> column in the <c>Views</c> metadata collection.</p>
    ///   <p>The data in this column specifies the view name.</p>
    /// </summary>
    const ViewName = 'ViewName';
    
    /// <summary>  <p>Used to access the <c>Definition</c> column in the <c>Views</c> metadata collection.</p>
    ///   <p>The data in this column specifies the SQL which was used to create the
    ///   view.</p>
    /// </summary>
    const Definition = 'Definition';
  end;

  TDBXViewsIndex = class
  public
    
    /// <summary>  <p>Used to access the <c>CatalogName</c> column by ordinal in the <c>Views</c> metadata collection.</p>
    ///   <p>The data in this column specifies the catalog name.</p>
    /// </summary>
    const CatalogName = 0;
    
    /// <summary>  <p>Used to access the <c>SchemaName</c> column by ordinal in the <c>Views</c> metadata collection.</p>
    ///   <p>The data in this column specifies the schema name.</p>
    /// </summary>
    const SchemaName = 1;
    
    /// <summary>  <p>Used to access the <c>ViewName</c> column by ordinal in the <c>Views</c> metadata collection.</p>
    ///   <p>The data in this column specifies the view name.</p>
    /// </summary>
    const ViewName = 2;
    
    /// <summary>  <p>Used to access the <c>Definition</c> column by ordinal in the <c>Views</c> metadata collection.</p>
    ///   <p>The data in this column specifies the SQL which was used to create the
    ///   view.</p>
    /// </summary>
    const Definition = 3;
    const Last = 3;
  end;

implementation

end.
