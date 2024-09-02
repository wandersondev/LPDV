unit untDmLPDV;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, SQLDB, PQConnection, Dialogs;

type

  { TDM }

  TDM = class(TDataModule)
    Conexao: TSQLConnector;
    qryEmpresas: TSQLQuery;
    qryTerminais: TSQLQuery;
    Transacao: TSQLTransaction;
    procedure DataModuleCreate(Sender: TObject);
  private
    Const DADOS_CONEXAO = 'Conexao.ini';
  public
    function CriaQuery :TSQLQuery;
  end;

var
  DM: TDM;

implementation

uses untformdatabase, untcriaforms;

{$R *.lfm}

{ TDM }

procedure TDM.DataModuleCreate(Sender: TObject);
var
  frm: TCriaForm;
begin
  with TStringList.Create do
       try
         if(FileExists(DADOS_CONEXAO))then
         begin
              LoadFromFile(DADOS_CONEXAO);
              with Conexao do
              try
                DatabaseName := Values['BANCO'];
                HostName     := Values['IP'];
                ConnectorType:= Values['TIPO'];
                UserName     := Values['USUARIO'];
                Password     := Values['SENHA'];
                Connected    := True;
              except
                ShowMessage('erro ao conectar com o banco de daddos. Verifique os dados da conexão: '+ DADOS_CONEXAO);
                frm := TCriaForm.Create;
                frm.CreateForm('TFormDataBase');
                Halt;
              end;
         end;
       finally
         Free;
       end;
end;

function TDM.CriaQuery: TSQLQuery;
begin
     Result:= TSQLQuery.Create(Nil);
     Result.Options    := Result.Options + [sqoAutoCommit, sqoKeepOpenOnCommit];
     Result.DataBase   := Conexao;
     Result.Transaction:= Transacao;
end;

end.

