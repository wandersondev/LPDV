unit untDmLPDV;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, SQLDB;

type

  { TDmLPDV }

  TDmLPDV = class(TDataModule)
    Conexao: TSQLConnector;
    qryEmpresas: TSQLQuery;
    qryTerminais: TSQLQuery;
    Transacao: TSQLTransaction;
  private

  public

  end;

var
  DmLPDV: TDmLPDV;

implementation
     uses untcriaforms;
{$R *.lfm}

end.

