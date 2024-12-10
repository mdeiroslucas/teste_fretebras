unit DBConnection;

interface

uses
  System.SysUtils,  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Phys.SQLite;

type
  TDBConnection = class
    constructor create;
    destructor destroy;
    private

    public
      FDConnection: TFDConnection;
  end;

implementation

{ TConexao }

constructor TDBConnection.create;
var
  fQuery: TFDQuery;
begin
  FDConnection  := TFDConnection.Create(nil);

  fQuery:= TFDQuery.Create(nil);

  try
    FDConnection.DriverName                     := 'SQLite';
//    FDConnection.Params.Values['Database']      := 'D:\Projetos_delphi\teste_fretecom\DB\teste_fretecom.db';

    FDConnection.Params.Values['Database']      := 'D:\DbSqlite\teste_fretecom.db';
    FDConnection.Params.Values['CharacterSet']  := 'UTF8';
    FDConnection.Params.Values['LockingMode']   := 'Normal';

    FDConnection.Connected := True;

    fQuery.Connection:= FDConnection;

//    fQuery.SQL.Text := 'SELECT name FROM sqlite_master WHERE type=''table''';  // Consulta SQL para listar tabelas

    fQuery.SQL.Text:='Select * from tipo_pessoa';

    fQuery.Open();

//    fQuery.Open('Select * from tipo_pessoa');

    fQuery.RecordCount;
  except
    on E: Exception do
      Writeln('Erro ao conectar com o banco de dados: ' + E.Message);
  end;
end;

destructor TDBConnection.destroy;
begin
  FDConnection.Connected := False;
  FDConnection.Free;
end;

end.
