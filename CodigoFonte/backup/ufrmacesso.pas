unit ufrmacesso;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Buttons, StdCtrls,
  ExtCtrls, untfuncoes, untformcadastroempresas, untDmLPDV;

type

  { Tfrmacesso }

  Tfrmacesso = class(TForm)
    BtnEntrar: TBitBtn;
    BtnCancelar: TBitBtn;
    EdtUsuario: TEdit;
    EdtSenha: TEdit;
    LbUsuario: TLabel;
    LbSenha: TLabel;
    procedure BtnEntrarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  frmacesso: Tfrmacesso;

implementation

{$R *.lfm}

{ Tfrmacesso }

procedure Tfrmacesso.FormShow(Sender: TObject);
begin
   with DM.CriaQuery do
   try
     Close;
     SQL.Text:= 'select * from empresas';
     Open;
     if IsEmpty then
     with Tformcadastroempresas.Create(Self) do
     try
        ShowModal;
      finally
       Free;
     end;
     Close;
     SQL.Text:='select * from usuarios';
     Open;
     if IsEmpty  then
     MessageDlg('Atenção','Digite a senha do administrador ',mtInformation,[mbOK],0);
   finally
     Free;
   end;
end;

procedure Tfrmacesso.BtnEntrarClick(Sender: TObject);
begin
  With DM.CriaQuery do
  try
     Close;
     SQL.Text:='select * from usuarios';
     Open;
     if IsEmpty  then
     begin
       close;
       SQL.Text:='INSERT INTO usuarios( empresas_id, usuarios_tipo_id, usuario, senha)'+
                                   'VALUES ( :empresas_id, :usuarios_tipo_id, :usuario, :senha);';

       ParamByName('empresas_id').AsInteger      := 1;
       ParamByName('usuarios_tipo_id').AsInteger := 1;
       ParamByName('usuario').AsString           := EdtUsuario.Text;
       ParamByName('senha').AsString             := Crypt( EdtSenha.Text);
       ExecSQL;
       ModalResult := mrOK;
     end else
     begin
       close;
       SQL.Text:='select * from usuarios where usuario = :usuario and senha = :senha';
       ParamByName('usuario').AsString:= EdtUsuario.Text;
       ParamByName('senha').AsString  := Crypt( EdtSenha.Text);
       Open;
       if IsEmpty then
       begin
       MessageDlg('Erro','Usuário e/ou senha inválido(a).',mtError,[mbOK],0);
       EdtUsuario.SetFocus;
       EdtUsuario.SelectAll;

       end else
           ModalResult:= mrOK;
     end;

  finally
    free;
  end;
end;

end.

